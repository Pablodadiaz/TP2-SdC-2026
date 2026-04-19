import requests
import ctypes
import os

print("Consultando API del Banco Mundial...\n")

# 1. Traer datos de la API (Usamos un rango de años como pedía el profe originalmente)
url = "https://api.worldbank.org/v2/en/country/all/indicator/SI.POV.GINI?format=json&date=2011:2022&per_page=32500&page=1&country=%22Argentina%22"
respuesta = requests.get(url)
datos = respuesta.json()

# 2. Buscar el primer valor del GINI que NO sea nulo
valor_gini = None
anio_encontrado = "Desconocido"

for registro in datos[1]:
    if registro['value'] is not None:
        valor_gini = registro['value']
        anio_encontrado = registro['date']
        break # Apenas encuentra un número válido, corta la búsqueda

# Medida de seguridad por si no encuentra nada en absoluto
if valor_gini is None:
    print("[Error] No se encontró ningún dato numérico en la API.")
    exit(1)

print(f"[Python] País:        Argentina")
print(f"[Python] Año:         {anio_encontrado}")
print(f"[Python] GINI float:  {valor_gini}")

# 3. Cargar la librería en C que compilamos
ruta_libreria = os.path.abspath('./libgini.so')
mi_libreria_c = ctypes.CDLL(ruta_libreria)

# 4. Configurar qué entra y qué sale de la función de C
mi_libreria_c.procesar_gini.argtypes = [ctypes.c_float]
mi_libreria_c.procesar_gini.restype = ctypes.c_int     

# 5. Llamar a la función en C
resultado_desde_c = mi_libreria_c.procesar_gini(valor_gini)

print(f"[Python] Resultado recibido desde C: {resultado_desde_c}")
