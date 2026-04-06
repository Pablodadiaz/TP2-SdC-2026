# main.py

import requests
import ctypes
import os

# ─────────────────────────────────────────
# 1. CARGAR LA BIBLIOTECA DE C
# ─────────────────────────────────────────

# Cargamos el .so que compilamos
# os.path.abspath asegura que Python encuentre el archivo
lib = ctypes.CDLL(os.path.abspath("./src/libgini.so"))

# Le decimos a ctypes qué tipo recibe y qué tipo devuelve la función
# Esto es IMPORTANTE: sin esto ctypes puede pasar los datos mal
lib.procesar_gini.argtypes = [ctypes.c_double]  # recibe un double
lib.procesar_gini.restype  = ctypes.c_long       # devuelve un long

# ─────────────────────────────────────────
# 2. OBTENER DATOS DE LA API
# ─────────────────────────────────────────

URL = (
    "https://api.worldbank.org/v2/en/country/all/indicator/SI.POV.GINI"
    "?format=json&date=2011:2020&per_page=32500&page=1"
)

print("Consultando API del Banco Mundial...")
respuesta = requests.get(URL)

# La API devuelve una lista de 2 elementos:
# [0] = metadata (info de paginación)
# [1] = lista de registros con los datos reales
datos = respuesta.json()
registros = datos[1]

# ─────────────────────────────────────────
# 3. FILTRAR ARGENTINA Y OBTENER GINI
# ─────────────────────────────────────────

gini_valor = None
anio_valor = None

for registro in registros:
    # Cada registro tiene: countryiso3code, date, value, etc.
    if registro["countryiso3code"] == "ARG" and registro["value"] is not None:
        gini_valor = registro["value"]   # esto es un float
        anio_valor = registro["date"]
        break  # tomamos el primer año disponible con dato

if gini_valor is None:
    print("No se encontró dato de GINI para Argentina")
    exit(1)

print(f"\n[Python] País:        Argentina")
print(f"[Python] Año:         {anio_valor}")
print(f"[Python] GINI float:  {gini_valor}")

# ─────────────────────────────────────────
# 4. LLAMAR A C (acá se usa el stack!)
# ─────────────────────────────────────────

print("\n--- Llamando función en C ---")
resultado = lib.procesar_gini(gini_valor)

print(f"\n[Python] Resultado recibido desde C: {resultado}")