CREATE DATABASE OPERACIONESTC

---PROCESO ALMACENDO PARA OPERACIONES---
EXECUTE [EJECUTABLE]


CREATE PROCEDURE [EJECUTABLE]
AS BEGIN
EXEC PASS1
EXEC PASS2
EXEC PASS3
EXEC PASS4
EXEC PASS5
END;


select * from general
select * from checgeneral
select * from chec
select * from checpost

CREATE PROCEDURE PASS1
AS
BEGIN 

SELECT * INTO chec FROM checgeneral WHERE Tipo LIKE '%PRE-OPERACIONAL%' 
OR Tipo LIKE '%INSPECCION DEL VEHICULO%'
OR Tipo LIKE '%PRE-OPERACIONAL%'


SELECT * INTO checpost FROM checgeneral WHERE Tipo LIKE '%POST-OPERACIONAL%'
OR Tipo LIKE '%POST-OPERACIONAL%'
END; 
alter  PROCEDURE PASS2
AS BEGIN

ALTER TABLE chec
ADD Concatenar varchar(50);
ALTER TABLE chec
ADD [Fecha Delimitada] VARCHAR(20);
ALTER TABLE chec
ADD Hora VARCHAR(20);
ALTER TABLE chec
ADD [Fecha Delimitada Fin] VARCHAR(20);
ALTER TABLE chec
ADD [Hora Fin] VARCHAR(20);
ALTER TABLE chec
ADD [Coductor Identificación 2] VARCHAR(30);
ALTER TABLE general
ADD numeroconducto2 VARCHAR(30)
ALTER TABLE checpost
ADD Concatenar varchar(50);
ALTER TABLE checpost
ADD [Fecha Delimitada] VARCHAR(20);
ALTER TABLE checpost
ADD Hora VARCHAR(20);
ALTER TABLE checpost
ADD [Fecha Delimitada Fin] VARCHAR(20);
ALTER TABLE checpost
ADD [Hora Fin] VARCHAR(20);
ALTER TABLE checpost
ADD [Coductor Identificación 2] VARCHAR(30);
ALTER TABLE general
DROP COLUMN F78
ALTER TABLE general
DROP COLUMN F77
ALTER TABLE general
DROP COLUMN F76

END;


ALTER PROCEDURE PASS3
AS BEGIN
UPDATE chec
SET [Fecha Delimitada] =
      SUBSTRING([Fecha Chequeo], 1, CHARINDEX(' ', [Fecha Chequeo]) - 1),

    [Hora] = 
    SUBSTRING([Fecha Chequeo], CHARINDEX(' ', [Fecha Chequeo]) + 1, LEN([Fecha Chequeo]) - CHARINDEX(' ', [Fecha Chequeo]))

UPDATE chec 
SET [Fecha Delimitada] =  REPLACE([Fecha Delimitada],'.','');



UPDATE chec
SET [Fecha Delimitada Fin] =
      SUBSTRING([Fecha Creación], 1, CHARINDEX(' ', [Fecha Creación]) - 1),

    [Hora Fin] = 
    SUBSTRING([Fecha Creación], CHARINDEX(' ', [Fecha Creación]) + 1, LEN([Fecha Creación]) - CHARINDEX(' ', [Fecha Creación]))

UPDATE chec
SET [Fecha Delimitada Fin] = REPLACE([Fecha Delimitada Fin],'-','');

UPDATE chec
SET [Coductor Identificación 2] = LTRIM(RTRIM(STR([Coductor Identificación], 30, 0)));

UPDATE chec
SET Concatenar =
CONCAT(Vehículo,[Coductor Identificación 2],[Fecha Delimitada])

UPDATE chec
SET Concatenar = REPLACE(Concatenar,'-','')
END;
select * from checpost
------------------------------------------------------------------------------------------------------

ALTER PROCEDURE PASS4
AS BEGIN
UPDATE checpost
SET [Fecha Delimitada] =
      SUBSTRING([Fecha Chequeo], 1, CHARINDEX(' ', [Fecha Chequeo]) - 1),

    [Hora] = 
    SUBSTRING([Fecha Chequeo], CHARINDEX(' ', [Fecha Chequeo]) + 1, LEN([Fecha Chequeo]) - CHARINDEX(' ', [Fecha Chequeo]))

UPDATE checpost 
SET [Fecha Delimitada] =  REPLACE([Fecha Delimitada],'.','');


UPDATE checpost
SET [Fecha Delimitada Fin] =
      SUBSTRING([Fecha Creación], 1, CHARINDEX(' ', [Fecha Creación]) - 1),

    [Hora Fin] = 
    SUBSTRING([Fecha Creación], CHARINDEX(' ', [Fecha Creación]) + 1, LEN([Fecha Creación]) - CHARINDEX(' ', [Fecha Creación]))

UPDATE checpost
SET [Fecha Delimitada Fin] = REPLACE([Fecha Delimitada Fin],'-','');

UPDATE checpost
SET [Coductor Identificación 2] = LTRIM(RTRIM(STR([Coductor Identificación], 30, 0)));

UPDATE checpost
SET Concatenar =
CONCAT(Vehículo,[Coductor Identificación 2],[Fecha Delimitada])

UPDATE checpost
SET Concatenar = REPLACE(Concatenar,'-','')



UPDATE checpost
SET [Fecha Delimitada Fin] = REPLACE([Fecha Delimitada Fin],'/','-')
UPDATE checpost
SET [Fecha Delimitada Fin] = REPLACE([Fecha Delimitada Fin],'.','')

ALTER TABLE general
ALTER COLUMN Fecha DATE
ALTER TABLE general
ALTER COLUMN Fecha VARCHAR(50)

UPDATE general
SET [numeroconducto2] = LTRIM(RTRIM(STR([N° Documento Conductor], 30, 0)));

UPDATE general
SET VEHICULOFecha =
CONCAT(VEHICULO,[numeroconducto2],[Fecha])

UPDATE general
SET VEHICULOFecha = REPLACE(VEHICULOFecha,'-','')
END;
-------------------------------------------------------------
-----------------acamodarl el checpost---------------------
select * from checpost
select * from chec
---------------------cruzar
select * from general
CREATE PROCEDURE PASS5
AS BEGIN
ALTER TABLE general
ALTER COLUMN Firmado VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Firmado _3] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN Estado VARCHAR(50)
ALTER TABLE general
ALTER COLUMN Estado_2 VARCHAR(50)

UPDATE general
SET general.[Hora inicio Preoperacional] = chec.Hora
FROM general 
LEFT JOIN chec ON general.VEHICULOFecha = chec.Concatenar

UPDATE general
SET general.[Hora inicio Preoperacional] = chec.Hora
FROM general
LEFT JOIN chec ON general.VEHICULO = chec.Vehículo
WHERE [Hora inicio Preoperacional] IS NULL;

UPDATE general
SET general.[Hora de finalizacion de la preoperacional] = chec.[Hora Fin]
FROM general 
LEFT JOIN chec ON general.VEHICULOFecha = chec.Concatenar

UPDATE general
SET general.[Hora de finalizacion de la preoperacional] = chec.[Hora Fin]
FROM general 
LEFT JOIN chec ON general.VEHICULO = chec.Vehículo
WHERE [Hora de finalizacion de la preoperacional] IS NULL;

UPDATE general
SET general.[Hora inicio Pos operacional] = checpost.Hora
FROM general
LEFT JOIN checpost ON general.VEHICULOFecha = checpost.Concatenar

UPDATE general
SET general.[Hora inicio Pos operacional] = checpost.Hora
FROM general
LEFT JOIN checpost ON general.VEHICULO = checpost.Vehículo
WHERE [Hora inicio Pos operacional] IS NULL;

UPDATE general
SET general.[Hora de finalizacion de pos operacional] = checpost.[Hora Fin]
FROM general
LEFT JOIN checpost ON general.VEHICULOFecha = checpost.Concatenar

UPDATE general
SET general.[Hora de finalizacion de pos operacional] = checpost.[Hora Fin]
FROM general
LEFT JOIN checpost ON general.VEHICULO = checpost.Vehículo
WHERE [Hora de finalizacion de pos operacional] IS NULL;



UPDATE general
SET general.[Firmado ] = chec.Firmado
FROM general
LEFT JOIN chec ON general.VEHICULOFecha = chec.Concatenar

UPDATE general
SET general.Firmado = chec.Firmado
FROM general
LEFT JOIN chec ON general.VEHICULO = chec.Vehículo
WHERE general.Firmado IS NULL;

UPDATE general
SET general.[Firmado _3] = checpost.Firmado
FROM general
LEFT JOIN checpost ON general.VEHICULOFecha = checpost.Concatenar

UPDATE general
SET general.[Firmado _3] = checpost.Firmado
FROM general
LEFT JOIN checpost ON general.VEHICULO = checpost.Vehículo
WHERE [Firmado _3] IS NULL;



UPDATE general
SET general.Estado = chec.Estado
FROM general
LEFT JOIN chec ON general.VEHICULOFecha = chec.Concatenar

UPDATE general
SET general.Estado = chec.Estado
FROM general
LEFT JOIN chec ON general.VEHICULO = chec.Vehículo
WHERE general.Estado IS NULL;


UPDATE general
SET general.Estado_2 = checpost.Estado
FROM general
LEFT JOIN checpost ON general.VEHICULOFecha = checpost.Concatenar

UPDATE general
SET general.Estado_2 = checpost.Estado
FROM general
LEFT JOIN checpost ON general.VEHICULO = checpost.Vehículo
WHERE general.Estado_2 IS NULL;




ALTER TABLE general
ALTER COLUMN [Hora inicio Preoperacional] DATETIME
ALTER TABLE general
ALTER COLUMN [Hora inicio Preoperacional] TIME
ALTER TABLE general
ALTER COLUMN [Hora inicio Preoperacional] VARCHAR(50)

ALTER TABLE general
ALTER COLUMN [Hora de finalizacion de la preoperacional] TIME
ALTER TABLE general
ALTER COLUMN [Hora de finalizacion de la preoperacional] VARCHAR(50)

ALTER TABLE general
ALTER COLUMN [Hora inicio Pos operacional] TIME
ALTER TABLE general
ALTER COLUMN [Hora inicio Pos operacional] VARCHAR(50)

ALTER TABLE general
ALTER COLUMN [Hora de finalizacion de pos operacional] TIME
ALTER TABLE general
ALTER COLUMN [Hora de finalizacion de pos operacional] VARCHAR(50)


UPDATE general
SET [Hora inicio Preoperacional] = REPLACE([Hora inicio Preoperacional],'.0000000',''),
    [Hora de finalizacion de la Preoperacional] = REPLACE([Hora de finalizacion de la Preoperacional],'.0000000',''),
	[Hora inicio Pos operacional] = REPLACE([Hora inicio Pos operacional],'.0000000',''),
	[Hora de finalizacion de pos operacional] = REPLACE([Hora de finalizacion de pos operacional],'.0000000','');


UPDATE general
SET [Total Tiempo] = 
    CONVERT(TIME, 
        DATEADD(SECOND, 
            DATEDIFF(SECOND, '00:00:00', [Hora de finalizacion de la preoperacional]) - DATEDIFF(SECOND, '00:00:00', [Hora inicio Preoperacional]), 
            '00:00:00')
			    );

UPDATE general
SET [Total Tiempo_1] = 
    CONVERT(TIME, 
        DATEADD(SECOND, 
            DATEDIFF(SECOND, '00:00:00', [Hora de finalizacion de pos operacional]) - DATEDIFF(SECOND, '00:00:00', [Hora inicio Pos operacional]), 
            '00:00:00')
			);

ALTER TABLE	general
ALTER COLUMN [Hora Programacion] TIME
ALTER TABLE general
ALTER COLUMN [INICIO] TIME
ALTER TABLE general
ALTER COLUMN FIN TIME
ALTER TABLE general
ALTER COLUMN [Tiempo Alimentación / No Operacionales] TIME
ALTER TABLE general
ALTER COLUMN [Jornada Neta] TIME 
ALTER TABLE general
ALTER COLUMN [Jornada Laboral] TIME 
ALTER TABLE general
ALTER COLUMN [CANTIDAD EXCESO] TIME 
ALTER TABLE general
ALTER COLUMN [Inicio Cliente] TIME 
ALTER TABLE general
ALTER COLUMN [Fin Cliente] TIME 
ALTER TABLE general
ALTER COLUMN [Jornada Base2] TIME 
ALTER TABLE general
ALTER COLUMN [Jornada Cliente] TIME 
ALTER TABLE general
ALTER COLUMN [DESFASE] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO 1] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO 2] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO 3] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO 4] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO 5] TIME 
ALTER TABLE general
ALTER COLUMN [JORNADA NETA TRABAJO] TIME 
ALTER TABLE general
ALTER COLUMN [TIEMPO ENTRE INICIO Y FIN] TIME 
ALTER TABLE general
ALTER COLUMN [Tiempo Muerto] TIME 
ALTER TABLE general
ALTER COLUMN [DURACION] TIME 
ALTER TABLE general
ALTER COLUMN [Tiempo de Conduccion] TIME 
ALTER TABLE general
ALTER COLUMN [RALENTI] TIME 
ALTER TABLE general
ALTER COLUMN [Tiempo Detenido] TIME 
ALTER TABLE general
ALTER COLUMN [DETENCION] TIME 
ALTER TABLE general
ALTER COLUMN [Total Tiempo] TIME 
ALTER TABLE general
ALTER COLUMN [Total Tiempo_1] TIME 


ALTER TABLE	general
ALTER COLUMN [Hora Programacion] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [INICIO] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN FIN VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Tiempo Alimentación / No Operacionales] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Jornada Neta] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Jornada Laboral] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [CANTIDAD EXCESO] VARCHAR(50) 
ALTER TABLE general
ALTER COLUMN [Inicio Cliente] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Fin Cliente] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Jornada Base2] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Jornada Cliente] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [DESFASE] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [TIEMPO 1] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [TIEMPO 2] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [TIEMPO 3] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [TIEMPO 4] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [TIEMPO 5] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [JORNADA NETA TRABAJO] VARCHAR(50) 
ALTER TABLE general
ALTER COLUMN [TIEMPO ENTRE INICIO Y FIN] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Tiempo Muerto] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [DURACION] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Tiempo de Conduccion] VARCHAR(50) 
ALTER TABLE general
ALTER COLUMN [RALENTI] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Tiempo Detenido] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [DETENCION] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Total Tiempo] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [Total Tiempo_1] VARCHAR(50)


UPDATE general
SET [Hora Programacion] = REPLACE([Hora Programacion],'.0000000',''),
    [INICIO] = REPLACE([INICIO],'.0000000',''),
	[FIN] = REPLACE([Fin],'.0000000',''),
	[Tiempo Alimentación / No Operacionales] = REPLACE([Tiempo Alimentación / No Operacionales],'.0000000',''),
	[Jornada Neta] = REPLACE([Jornada Neta],'.0000000',''),
	[Jornada Laboral] = REPLACE([Jornada Laboral],'.0000000',''),
	[CANTIDAD EXCESO] = REPLACE([CANTIDAD EXCESO],'.0000000',''),
	[Inicio Cliente] = REPLACE([Inicio Cliente],'.0000000',''),
	[Fin Cliente] = REPLACE([Fin Cliente],'.0000000',''),
	[Jornada Base2] = REPLACE([Jornada Base2],'.0000000',''),
	[Jornada Cliente] = REPLACE([Jornada Cliente],'.0000000',''),
	[DESFASE] = REPLACE([DESFASE],'.0000000',''),
	[TIEMPO 1] = REPLACE([TIEMPO 1],'.0000000',''),
	[TIEMPO 2] = REPLACE([TIEMPO 2],'.0000000',''),
	[TIEMPO 3] = REPLACE([TIEMPO 3],'.0000000',''),
	[TIEMPO 4] = REPLACE([TIEMPO 4],'.0000000',''),
	[TIEMPO 5] = REPLACE([TIEMPO 5],'.0000000',''),
	[JORNADA NETA TRABAJO] = REPLACE([JORNADA NETA TRABAJO],'.0000000',''),
	[TIEMPO ENTRE INICIO Y FIN] = REPLACE([TIEMPO ENTRE INICIO Y FIN],'.0000000',''),
	[Tiempo Muerto] = REPLACE([Tiempo Muerto],'.0000000',''),
	[DURACION] = REPLACE([DURACION],'.0000000',''),
	[Tiempo de Conduccion] = REPLACE([Tiempo de Conduccion],'.0000000',''),
	[RALENTI] = REPLACE([RALENTI],'.0000000',''),
	[Tiempo Detenido] = REPLACE([Tiempo Detenido],'.0000000',''),
	[DETENCION] = REPLACE([DETENCION],'.0000000',''),
	[Total Tiempo] = REPLACE([Total Tiempo],'.0000000',''),
    [Total Tiempo_1] = REPLACE([Total Tiempo_1],'.0000000','');



UPDATE general
SET 
    VEHICULOFecha = COALESCE(VEHICULOFecha, ''),
    ConductorFecha = COALESCE(ConductorFecha, ''),
    ZONA = COALESCE(ZONA, ''),
    CIUDAD = COALESCE(CIUDAD, ''),
    Fecha = COALESCE(Fecha, ''),
    Dia = COALESCE(Dia, ''),
    [Conductor Llave] = COALESCE([Conductor Llave], ''),
    [N° Documento Conductor] = COALESCE([N° Documento Conductor], ''),
    Auxiiar = COALESCE(Auxiiar, ''),
    [N° Documento Auxiliar] = COALESCE([N° Documento Auxiliar], ''),
    VEHICULO = COALESCE(VEHICULO, ''),
    RUTA = COALESCE(RUTA, ''),
    OPERACIÓN = COALESCE(OPERACIÓN, ''),
    [Hora Programacion] = COALESCE([Hora Programacion], ''),
    INICIO = COALESCE(INICIO, ''),
    FIN = COALESCE(FIN, ''),
    [DISTANCIA RECORRIDA] = COALESCE([DISTANCIA RECORRIDA], ''),
    Servicios = COALESCE(Servicios, ''),
    [Tiempo Alimentación / No Operacionales] = COALESCE([Tiempo Alimentación / No Operacionales], ''),
    [Jornada Neta] = COALESCE([Jornada Neta], ''),
    [Jornada Laboral] = COALESCE([Jornada Laboral], ''),
    ITEM = COALESCE(ITEM, ''),
    [CANTIDAD EXCESO] = COALESCE([CANTIDAD EXCESO], ''),
    APROBACION = COALESCE(APROBACION, ''),
    [TIEMPO EN SEDE] = COALESCE([TIEMPO EN SEDE], ''),
    [Inicio Cliente] = COALESCE([Inicio Cliente], ''),
    [Fin Cliente] = COALESCE([Fin Cliente], ''),
    [Jornada Base2] = COALESCE([Jornada Base2], ''),
    [Jornada Cliente] = COALESCE([Jornada Cliente], ''),
    DESFASE = COALESCE(DESFASE, ''),
    [INICIO 1] = COALESCE([INICIO 1], ''),
    [FIN 1] = COALESCE([FIN 1], ''),
    [TIEMPO 1] = COALESCE([TIEMPO 1], ''),
    [INICIO 2] = COALESCE([INICIO 2], ''),
    [FIN 2] = COALESCE([FIN 2], ''),
    [TIEMPO 2] = COALESCE([TIEMPO 2], ''),
    [INICIO 3] = COALESCE([INICIO 3], ''),
    [FIN 3] = COALESCE([FIN 3], ''),
    [TIEMPO 3] = COALESCE([TIEMPO 3], ''),
    [INICIO 4] = COALESCE([INICIO 4], ''),
    [FIN 4] = COALESCE([FIN 4], ''),
    [TIEMPO 4] = COALESCE([TIEMPO 4], ''),
    [INICIO 5] = COALESCE([INICIO 5], ''),
    [FIN 5] = COALESCE([FIN 5], ''),
    [TIEMPO 5] = COALESCE([TIEMPO 5], ''),
    [JORNADA NETA TRABAJO] = COALESCE([JORNADA NETA TRABAJO], ''),
    [TIEMPO ENTRE INICIO Y FIN] = COALESCE([TIEMPO ENTRE INICIO Y FIN], ''),
    [Tiempo Muerto] = COALESCE([Tiempo Muerto], ''),
    DURACION = COALESCE(DURACION, ''),
    [Tiempo de Conduccion] = COALESCE([Tiempo de Conduccion], ''),
    RALENTI = COALESCE(RALENTI, ''),
    [Tiempo Detenido] = COALESCE([Tiempo Detenido], ''),
    [velocidad Promedio] = COALESCE([velocidad Promedio], ''),
    [Máxima velocidad] = COALESCE([Máxima velocidad], ''),
    DETENCION = COALESCE(DETENCION, ''),
    OBSERVACION = COALESCE(OBSERVACION, ''),
    [Hora inicio Preoperacional] = COALESCE([Hora inicio Preoperacional], ''),
    [Hora de finalizacion de la preoperacional] = COALESCE([Hora de finalizacion de la preoperacional], ''),
    [Total Tiempo] = COALESCE([Total Tiempo], ''),
    Estado = COALESCE(Estado, ''),
    [Firmado ] = COALESCE([Firmado ], ''),
    [Hora inicio Pos operacional] = COALESCE([Hora inicio Pos operacional], ''),
    [Hora de finalizacion de pos operacional] = COALESCE([Hora de finalizacion de pos operacional], ''),
    [Total Tiempo_1] = COALESCE([Total Tiempo_1], ''),
    Estado_2 = COALESCE(Estado_2, ''),
    [Firmado _3] = COALESCE([Firmado _3], ''),
    numeroconducto2 = COALESCE(numeroconducto2, '');





ALTER TABLE general
ALTER COLUMN [INICIO 1] TIME
ALTER TABLE general
ALTER COLUMN [FIN 2] TIME
ALTER TABLE general
ALTER COLUMN [INICIO 2] TIME
ALTER TABLE general
ALTER COLUMN [FIN 1] TIME
ALTER TABLE general
ALTER COLUMN [INICIO 3] TIME
ALTER TABLE general
ALTER COLUMN [FIN 3] TIME
ALTER TABLE general
ALTER COLUMN [INICIO 4] TIME
ALTER TABLE general
ALTER COLUMN [FIN 4] TIME
ALTER TABLE general
ALTER COLUMN [INICIO 5] TIME
ALTER TABLE general
ALTER COLUMN [FIN 5] TIME

ALTER TABLE general
ALTER COLUMN [INICIO 1] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [FIN 2] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [INICIO 2] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [FIN 1] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [INICIO 3] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [FIN 3] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [INICIO 4] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [FIN 4] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [INICIO 5] VARCHAR(50)
ALTER TABLE general
ALTER COLUMN [FIN 5] VARCHAR(50)


UPDATE general
SET [INICIO 1] = REPLACE([INICIO 1],'.0000000',''),
    [FIN 2] = REPLACE([FIN 2],'.0000000',''),
	[INICIO 2] = REPLACE([INICIO 2],'.0000000',''),
	[FIN 1] = REPLACE([FIN 1],'.0000000',''),
	[INICIO 3] = REPLACE([INICIO 3],'.0000000',''),
	[FIN 3] = REPLACE([FIN 3],'.0000000',''),
	[INICIO 4] = REPLACE([INICIO 4],'.0000000',''),
	[FIN 4] = REPLACE([FIN 4],'.0000000',''),
	[INICIO 5] = REPLACE([INICIO 5],'.0000000',''),
	[FIN 5] = REPLACE([FIN 5],'.0000000','');


END;






	select * from general
