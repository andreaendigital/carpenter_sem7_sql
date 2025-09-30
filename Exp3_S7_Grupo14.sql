-- =================================================================================
-- SCRIPT PARA HOLDING CARPENTER SPA
-- Este script crea la estructura de la base de datos, aplica reglas de negocio,
-- puebla tablas iniciales y genera los informes solicitados.
-- =================================================================================


DROP TABLE DOMINIO CASCADE CONSTRAINTS;
DROP TABLE TITULACION CASCADE CONSTRAINTS;
DROP TABLE PERSONAL CASCADE CONSTRAINTS;
DROP TABLE COMPANIA CASCADE CONSTRAINTS;
DROP TABLE COMUNA CASCADE CONSTRAINTS;
DROP TABLE REGION CASCADE CONSTRAINTS;
DROP TABLE ESTADO_CIVIL CASCADE CONSTRAINTS;
DROP TABLE GENERO CASCADE CONSTRAINTS;
DROP TABLE TITULO CASCADE CONSTRAINTS;
DROP TABLE IDIOMA CASCADE CONSTRAINTS;


-- =============================================
-- CASO 1: IMPLEMENTACIÓN DEL MODELO
-- Creación de tablas y restricciones primarias/foráneas.
-- El orden sigue la lógica de tablas fuertes (sin dependencias) a débiles.
-- =============================================

-- Tablas sin dependencias externas
CREATE TABLE REGION (
    id_region       NUMBER(2) GENERATED AS IDENTITY (START WITH 7 INCREMENT BY 2),
    nombre_region   VARCHAR2(25)  NOT NULL,
    CONSTRAINT REGION_PK PRIMARY KEY (id_region)
);

CREATE TABLE IDIOMA (
    id_idioma       NUMBER(3) GENERATED AS IDENTITY (START WITH 25 INCREMENT BY 3),
    nombre_idioma   VARCHAR2(30) NOT NULL,
    CONSTRAINT IDIOMA_PK PRIMARY KEY (id_idioma)
);

CREATE TABLE GENERO (
    id_genero           VARCHAR2(2),
    descripcion_genero  VARCHAR2(25) NOT NULL,
    CONSTRAINT GENERO_PK PRIMARY KEY (id_genero)
);

CREATE TABLE TITULO (
    id_titulo           VARCHAR2(3),
    descripcion_titulo  VARCHAR2(60) NOT NULL,
    CONSTRAINT TITULO_PK PRIMARY KEY (id_titulo)
);

CREATE TABLE ESTADO_CIVIL (
    id_estado_civil     VARCHAR2(2),
    descripcion_est_civil VARCHAR2(25) NOT NULL,
    CONSTRAINT ESTADO_CIVIL_PK PRIMARY KEY (id_estado_civil)
);

-- Tablas con dependencias
CREATE TABLE COMUNA (
    id_comuna       NUMBER(5),
    comuna_nombre   VARCHAR2(25) NOT NULL,
    cod_region      NUMBER(2) NOT NULL,
    CONSTRAINT COMUNA_PK PRIMARY KEY (id_comuna),
    CONSTRAINT COMUNA_FK_REGION FOREIGN KEY (cod_region) REFERENCES REGION(id_region)
);

CREATE TABLE COMPANIA (
    id_empresa      NUMBER(2),
    nombre_empresa  VARCHAR2(50) NOT NULL,
    calle           VARCHAR2(50) NOT NULL,
    numeracion      NUMBER(5) NOT NULL,
    renta_promedio  NUMBER(10) NOT NULL,
    pct_aumento     NUMBER(4,3),
    cod_comuna      NUMBER(5) NOT NULL,
    cod_region      NUMBER(2) NOT NULL,
    CONSTRAINT COMPANIA_PK PRIMARY KEY (id_empresa),
    CONSTRAINT COMPANIA_UN_NOMBRE UNIQUE (nombre_empresa),
    CONSTRAINT COMPANIA_FK_COMUNA FOREIGN KEY (cod_comuna) REFERENCES COMUNA(id_comuna)
);

CREATE TABLE PERSONAL (
    rut_persona         NUMBER(8) NOT NULL,
    dv_persona          CHAR(1) NOT NULL,
    primer_nombre       VARCHAR2(25) NOT NULL,
    segundo_nombre      VARCHAR2(25),
    primer_apellido     VARCHAR2(25) NOT NULL,
    segundo_apellido    VARCHAR2(25) NOT NULL,
    fecha_contratacion  DATE NOT NULL,
    fecha_nacimiento    DATE NOT NULL,
    email               VARCHAR2(100),
    calle               VARCHAR2(50) NOT NULL,
    numeracion          NUMBER(5) NOT NULL,
    sueldo              NUMBER(8) NOT NULL,
    cod_comuna          NUMBER(5) NOT NULL,
    cod_region          NUMBER(2) NOT NULL,
    cod_genero          VARCHAR2(2),
    cod_estado_civil    VARCHAR2(2),
    cod_empresa         NUMBER(2) NOT NULL,
    encargado_rut       NUMBER(8),
    CONSTRAINT PERSONAL_PK PRIMARY KEY (rut_persona),
    CONSTRAINT PERSONAL_FK_COMPANIA FOREIGN KEY (cod_empresa) REFERENCES COMPANIA(id_empresa),
    CONSTRAINT PERSONAL_FK_COMUNA FOREIGN KEY (cod_comuna) REFERENCES COMUNA(id_comuna),
    CONSTRAINT PERSONAL_FK_ESTADO_CIVIL FOREIGN KEY (cod_estado_civil) REFERENCES ESTADO_CIVIL(id_estado_civil),
    CONSTRAINT PERSONAL_FK_GENERO FOREIGN KEY (cod_genero) REFERENCES GENERO(id_genero),
    CONSTRAINT PERSONAL_FK_ENCARGADO FOREIGN KEY (encargado_rut) REFERENCES PERSONAL(rut_persona)
);

-- Tablas de relación (débiles)
CREATE TABLE TITULACION (
    persona_rut         NUMBER(8) NOT NULL,
    cod_titulo          VARCHAR2(3) NOT NULL,
    fecha_titulacion    DATE NOT NULL,
    CONSTRAINT TITULACION_PK PRIMARY KEY (persona_rut, cod_titulo),
    CONSTRAINT TITULACION_FK_PERSONAL FOREIGN KEY (persona_rut) REFERENCES PERSONAL(rut_persona),
    CONSTRAINT TITULACION_FK_TITULO FOREIGN KEY (cod_titulo) REFERENCES TITULO(id_titulo)
);

CREATE TABLE DOMINIO (
    id_idioma           NUMBER(3) NOT NULL,
    persona_rut         NUMBER(8) NOT NULL,
    nivel               VARCHAR2(25) NOT NULL,
    CONSTRAINT DOMINIO_PK PRIMARY KEY (id_idioma, persona_rut),
    CONSTRAINT DOMINIO_FK_IDIOMA FOREIGN KEY (id_idioma) REFERENCES IDIOMA(id_idioma),
    CONSTRAINT DOMINIO_FK_PERSONAL FOREIGN KEY (persona_rut) REFERENCES PERSONAL(rut_persona)
);


-- =============================================
-- CASO 2: MODIFICACIÓN DEL MODELO
-- Aplicación de reglas de negocio adicionales mediante ALTER TABLE.
-- =============================================

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_UN_EMAIL UNIQUE (email);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_CK_DV CHECK (dv_persona IN ('0','1','2','3','4','5','6','7','8','9','K'));

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_CK_SUELDO CHECK (sueldo >= 450000);


-- =============================================
-- CASO 3: POBLAMIENTO DEL MODELO
-- Creación de secuencias e inserción de datos en las tablas especificadas.
-- =============================================

-- Creación de Objetos de Secuencia

DROP SEQUENCE SEQ_COMUNA;
DROP SEQUENCE SEQ_COMPANIA;

CREATE SEQUENCE SEQ_COMUNA
START WITH 1101
INCREMENT BY 6;

CREATE SEQUENCE SEQ_COMPANIA
START WITH 10
INCREMENT BY 5;

-- Poblamiento de Tablas (en orden de dependencia)

-- REGION (los IDs 7, 9, 11 se generan automáticamente)
INSERT INTO REGION (nombre_region) VALUES ('ARICA Y PARINACOTA');
INSERT INTO REGION (nombre_region) VALUES ('METROPOLITANA');
INSERT INTO REGION (nombre_region) VALUES ('LA ARAUCANIA');

-- IDIOMA (los IDs 25, 28, 31, 34, 37 se generan automáticamente)
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Ingles');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Chino');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Aleman');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Espanol');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Frances');

-- COMUNA (usa secuencia y los IDs de región ya creados)
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Arica', 7);     -- ID 1101
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Santiago', 9);  -- ID 1107
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Temuco', 11);    -- ID 1113

-- COMPANIA (usa secuencia y los IDs de comuna ya creados)
-- Nota: La data de la figura 2 no está ordenada. Se insertará en el orden provisto.
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'CCyRojas', 'Amapolas', 506, 1857000, 0.5, 1101, 7);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'SenTty', 'Los Alamos', 3490, 897000, 0.025, 1101, 7);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'Praxia LTDA', 'Las Camelias', 11098, 2157000, 0.025, 1107, 9);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'TIC spa', 'FLORES S.A.', 4357, 857000, NULL, 1107, 9);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'SANTANA LTDA', 'AVDA VIC. MACKENA', 106, 757000, 0.015, 1101, 7);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'FLORES Y ASOCIADOS', 'PEDRO LATORRE', 557, 589000, 0.015, 1107, 9);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'J.A. HOFFMAN', 'LATINA D.32', 509, 1857000, 0.025, 113, 9);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'CAGLIARI D.', 'ALAMEDA', 206, 1857000, NULL, 1107, 9);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'Rojas HNOS LTDA', 'SUCRE', 106, 957000, 0.005, 1113, 11);
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (SEQ_COMPANIA.NEXTVAL, 'FRIENDS P. S.A', 'SUECIA', 506, 857000, 0.015, 1113, 11);


-- =============================================
-- CASO 4: RECUPERACIÓN DE DATOS
-- Creación de informes según las especificaciones.
-- =============================================

-- INFORME 1: Simulación de Renta Promedio (según Figura 3)
-- Muestra la información de las empresas con la simulación de renta actual.
SELECT
    nombre_empresa                          AS "Nombre Empresa",
    calle || ' ' || numeracion              AS "Dirección",
    renta_promedio                          AS "Renta Promedio",
    ROUND(renta_promedio * (1 + pct_aumento)) AS "Simulación de Renta"
FROM
    COMPANIA
ORDER BY
    "Renta Promedio" DESC,
    "Nombre Empresa" ASC;


-- INFORME 2: Nueva Simulación con Aumento del 15% (según Figura 4)
-- Propone una mejora salarial añadiendo un 15% adicional al porcentaje de aumento.
SELECT
    id_empresa                                  AS "CODIGO",
    nombre_empresa                              AS "EMPRESA",
    renta_promedio                              AS "PROM RENTA ACTUAL",
    pct_aumento + 0.15                          AS "PCT AUMENTADO EN 15%",
    ROUND(renta_promedio * (1 + pct_aumento + 0.15)) AS "RENTA AUMENTADA"
FROM
    COMPANIA
ORDER BY
    "PROM RENTA ACTUAL" ASC,
    "EMPRESA" DESC;