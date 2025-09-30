# Poblamiento y consultas en la base de datos con sentencias SQL

A partir de un caso planteado, tendrás que utilizar sentencias SQL (y Scripts) para diseñar una estructura de base de datos relacional, incluyendo la creación de tablas y definición de restricciones de integridad (constraints), así como el poblamiento de dichas tablas con datos relevantes mediante el uso de secuencias.   Además, deberás realizar algunos reportes de interés, para obtener información de análisis en un formato y orden específico. 

## Descripción del Proyecto :scroll:

Caso planteado: 

Carpenter SPA es un destacado holding que se compone de varias compañías del sector retail, que ha demostrado un sólido crecimiento desde su llegada al país hace una década. 
A lo largo de estos años, la empresa ha logrado consolidarse en el mercado chileno, ampliando progresivamente su presencia en diversas regiones del país.
En su compromiso con la mejora continua y la optimización de sus operaciones, Carpenter SPA reconoce la necesidad urgente de implementar un sistema de gestión que unifique a todo el personal de las distintas compañías que posee, el que permitirá no solo agilizar los procesos internos de cada compañía, sino también contribuir al fortalecimiento de su equipo humano, un factor clave para seguir expandiendo y consolidando su posición en el mercado nacional. 
La implementación de este sistema es esencial para asegurar un adecuado alineamiento entre los recursos humanos y los objetivos estratégicos de la empresa, permitiendo así un crecimiento sostenible y adaptado a las necesidades cambiantes del mercado.   
Hace algunos años, se intentó desarrollar una base de datos, para almacenar y gestionar toda la operación del capital humano de sus compañías, sin embargo, la implementación de la base de datos no se completó, quedando únicamente un modelo relacional del sistema de personal.   
En consecuencia, en esta etapa del desarrollo es necesario implementar la base de datos, desarrollando el script DDL para crear las tablas y el script SQL para poblar los datos solicitados, a partir del Modelo Relacional Normalizado (ver Figura 1) que quedó como evidencia de la primera fase del proyecto. 
Posteriormente deberás realizar reportes estadísticos orientados al análisis de datos para generar información relevante para la empresa, los que serán especificados por el “Departamento de Gestión del Personal” del Holding.

<img width="985" height="646" alt="Captura de pantalla 2025-09-29 203021" src="https://github.com/user-attachments/assets/e79f8cb9-1cff-47b4-9836-a578dfb5a27e" />


### ✨Requisitos   ✨

👉 Caso 1: Implementación del modelo 

Para la construcción del script de creación de las tablas del modelo relacional debes considerar lo siguiente:

•	Crear todas las tablas y columnas del Modelo Relacional de la Figura 1 en orden secuencial, es decir, desde las tablas fuertes a las más débiles. Utiliza el IDE: Oracle SQL Developer.

•	Crear las restricciones de Clave Primaria (PK), Clave Foránea (FK), Clave Única (UN) y Check (CK), de las tablas de acuerdo con el diagrama relacional y al análisis del modelo.

•	Considera que todas las restricciones (constraints) deben tener un nombre representativo según las tablas en las que pertenecen: PK, FK, CK, UN respectivamente. 

•	Asignar los tipos de datos y precisiones de las columnas de las tablas, de acuerdo con el modelo entregado, para posteriormente no tener problemas con el poblamiento de la base de datos.

Consideraciones para la creación de tablas:

Al crear las tablas, ten en cuenta:

•	Se sabe que identificador de los idiomas es un número que se inicia en 25 y se incrementa en 3 (usa identity).

•	El identificador de las regiones es un número que se inicia en 7 y se incrementa en 2 (usa identity).
 

👉 Caso 2: Modificación del modelo
Implementa, usando la sentencia ALTER TABLE, las restricciones necesarias para incorporar las siguientes reglas de negocio:

•	Aunque el email de una persona es opcional, no se debe repetir.

•	El dígito verificador del RUN del PERSONAL debe estar en el siguiente listado: 0,1,2,3,4,5,6,7,8,9,’K’.

•	Debes considerar que el sueldo mínimo del personal es de 450.000 pesos.


👉Caso 3: Poblamiento del modelo
Consideraciones para el poblado de las tablas (ver Figura 2):

Al poblar las tablas, ten en cuenta:

•	Se conocen que hay del orden de 350 comunas. Por lo tanto, para poblar la tabla correspondiente debes usar una identificación numérica que comience en 1101 y que se incremente en 6 (usa objeto secuencia).

•	Se sabe que el sistema debe administrar 7 compañías distintas, por un tema de seguridad el id_empresa debe iniciar en 10, y se debe incrementar en 5 unidades (usa objeto secuencia)
Solo debes poblar las siguientes 4 tablas y debes considerar que tu script se ejecutará en forma secuencial, es decir, debes ordenarlo según las restricciones de integridad y dependencia (fuerte a más débil): 

•	IDIOMA (en la creación de la tabla utiliza identity)

•	COMUNA (usa objeto sequence)

•	COMPANIA (usa objeto sequence)

•	REGION (en la creación de la tabla utiliza identity)
 

👉Caso 4: Recuperación de Datos
Posteriormente al poblamiento de los datos, debes recuperar toda la información que el Departamento de Gestión del Personal te solicite, generando informes usando la sentencia SELECT de manera adecuada.

⭐⭐ INFORME 1 ⭐⭐

El departamento encargado del personal, te solicita un informe con la información de todas las empresas pertenecientes a Holding Carpenter SPA. 
Se requiere que el informe incluya los siguientes datos: 

•	El nombre de la empresa

•	La dirección completa

•	La renta promedio de cada una

•	La simulación de la renta promedio aplicando el porcentaje de aumento correspondiente.

Asigna a cada columna el alias indicado en la Figura 3 y ordena la información en función de la columna " Renta Promedio " de mayor a menor. En caso de empate, organiza las filas alfabéticamente por " Nombre Empresa ". 


⭐⭐ INFORME 2 ⭐⭐

Para proponer una mejora salarial al personal de las empresas del holding, se requiere realizar una nueva simulación. Debes añadir un 15% adicional a los porcentajes actualmente registrados en la base de datos.
El listado debe incluir los siguientes datos: 

•	El ID de la empresa

•	El nombre de la empresa

•	La renta promedio actual

•	El porcentaje aumentado en 15%

•	La renta promedio incrementada, es decir, la renta aumentada tras aplicar el porcentaje adicional.

Recuerda asignar a cada columna el alias correspondiente según lo indicado en la imagen, ordenando la data por renta promedio actual ascendente, y posteriormente por el nombre de la empresa de forma descendente. 



## Solución planteada:


<img width="644" height="616" alt="Captura de pantalla 2025-09-29 225614" src="https://github.com/user-attachments/assets/667e5840-536f-4de3-85a9-a5a6168dbf2c" />


<img width="825" height="563" alt="Captura de pantalla 2025-09-29 230000" src="https://github.com/user-attachments/assets/df48cc02-69aa-4ea1-894a-84ec8f066e02" />


## Autora ⚡ 

- **Andrea Rosero** ⚡  - [Andrea Rosero](https://github.com/andreaendigital)
