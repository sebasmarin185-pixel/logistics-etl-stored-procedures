# Pipeline ETL de Datos Operativos mediante Procedimientos Almacenados en T-SQL

Este repositorio contiene un desarrollo completo en SQL para la implementación de un proceso ETL (Extracción, Transformación y Carga) estructurado de forma secuencial mediante procedimientos almacenados en una base de datos relacional. 

El sistema limpia marcas de tiempo complejas, realiza alteraciones de esquemas dinámicos para añadir llaves de agregación compuesta y ejecuta uniones lógicas para consolidar métricas de tiempos de conducción y cálculo de jornadas netas.

## Características Técnicas

* **Estructura modular:** Segmentación del proceso en cinco subprocesos secuenciales (`PASS1` a `PASS5`) coordinados desde un ejecutable maestro.
* **Transformación y Parsing:** Manipulación avanzada de cadenas mediante funciones lógicas de truncado y localización de índices para separar componentes compuestos de fecha y hora.
* **Consolidación de Registros (Cruce):** Ejecución de múltiples uniones lógicas por la izquierda combinando claves concatenadas para unificar auditorías preoperacionales y postoperacionales en una tabla general.
* **Limpieza de esquemas:** Normalización de campos nulos masivos y reemplazo dinámico de microsegundos huérfanos para estabilizar la conversión de tipos de datos a cadenas de texto de longitud fija.

## Tecnologías utilizadas

* Transact-SQL (T-SQL)
* SQL Server Database Architecture

## Estructura del Repositorio

* `main.sql`: Archivo fuente con la creación de la base de datos relacional y la lógica de los procedimientos almacenados maestros y secundarios.

Desarrollado por Sebastián Marín Galindo.
