------------------------------------------------------------
--1) Crear un stored procedure para modificar los datos de un cliente
-- donde se le pasen todos los datos nuevos y se acceda por dni.
--se deberá modificar todos los datos menos el dni.

--CREATE PROCEDURE SP_MODIFICA_CLI

CREATE PROCEDURE SP_MODIFICA_CLI
@Nombre as varchar(255), 
@Apellido as varchar(255), 
@DNI as varchar(255), 
@Direccion as varchar(255), 
@Ciudad as varchar(255), 
@Zona as varchar(255)
As

UPDATE CLIENTE
SET 
Nombre =  @Nombre,
Apellido= @Apellido, 
Direccion= @Direccion, 
Ciudad= @Ciudad, 
Zona = @Zona 

WHERE
DNI=@DNI


--EJ: exec SP_MODIFICA_CLI 'Ariel',	'Ardit',	'26542626',	'Wenceslao del Tata 2367',	'San Martin',	'Oeste'
-----------------------------------
--2) Tomar el SP anterior y agregarle que cuando los datos que se pasen sean nuevos se de alta el cliente
-- verificar los datos solamente por DNI

ALTER PROCEDURE SP_MODIFICA_CLI
@Nombre as varchar(255),
@Apellido as varchar(255),
@DNI as varchar(255),
@Direccion as varchar(255),
@Ciudad as varchar(255),
@Zona as varchar(255)
As


IF((SELECT 1 FROM CLIENTE WHERE DNI = @DNI)=1)
BEGIN
	UPDATE CLIENTE
	SET 
	Nombre =  @Nombre,
	Apellido= @Apellido, 
	Direccion= @Direccion, 
	Ciudad= @Ciudad, 
	Zona = @Zona 

	WHERE
	DNI=@DNI
END
ELSE
BEGIN
	INSERT INTO CLIENTE VALUES(@Nombre,@Apellido,@DNI,@Direccion,@Ciudad,@Zona)
END

--EJ: exec SP_ALTA_MODIFICA_CLI 'PEPE','ZABALA','26258410','RUIZ DE LOS LLANOS 345','CABA','SUR'
------------------------------------------------------------

--1) Crear un stored procedure para modificar los datos de un cliente
-- donde se le pasen todos los datos nuevos y se acceda por dni.
--se deberá modificar todos los datos menos el id.

ALTER PROCEDURE SP_MODIFICA_CLI
@ID_CLIENTE as bigint, 
@CUIT as varchar(255), 
@RAZONSOCIAL as varchar(255), 
@TELEFONO as varchar(255), 
@DIRECCION as varchar(255), 
@CIUDAD as varchar(255),
@FECHA_ALTA as datetime
As
BEGIN
	UPDATE CLIENTE
	SET
	[CUIT]=@CUIT, 
	[RAZONSOCIAL]=@RAZONSOCIAL, 
	[TELEFONO]=@TELEFONO, 
	[DIRECCION]=@DIRECCION, 
	[CIUDAD]=@CIUDAD,
	[FECHA_ALTA]=@FECHA_ALTA

	WHERE
	ID_CLIENTE=@ID_CLIENTE
END

EXEC SP_MODIFICA_CLI 
12,	'20524854755_1',	'PEDRO MIRTOLA_1',	'254874121_1',	
'PLUSVALIA 5248_1',	'TABLADA_1',	'2012-11-04 00:00:00.000'

SELECT * FROM CLIENTE

--EJ: exec SP_MODIFICA_CLI 'Ariel',	'Ardit',	'26542626',	'Wenceslao del Tata 2367',	'San Martin',	'Oeste'
-----------------------------------
--2) Tomar el SP anterior y agregarle que cuando los datos que se pasen sean nuevos se de alta el cliente
-- verificar los datos solamente por DNI

DECLARE @mivar int
Set @mivar = 34
select @mivar

CREATE PROCEDURE SP_ALTA_MODIFICA_CLI
@ID_CLIENTE as bigint, 
@CUIT as varchar(255), 
@RAZONSOCIAL as varchar(255), 
@TELEFONO as varchar(255), 
@DIRECCION as varchar(255), 
@CIUDAD as varchar(255),
@FECHA_ALTA as datetime
As
IF((SELECT 1 FROM CLIENTE WHERE CUIT = @CUIT)=1)
BEGIN
	UPDATE CLIENTE
	SET 
	[RAZONSOCIAL]=@RAZONSOCIAL, 
	[TELEFONO]=@TELEFONO, 
	[DIRECCION]=@DIRECCION, 
	[CIUDAD]=@CIUDAD,
	[FECHA_ALTA]=getdate()

	WHERE
	CUIT=@CUIT
END
ELSE
BEGIN
	INSERT INTO CLIENTE VALUES(@CUIT,@RAZONSOCIAL,@TELEFONO,@DIRECCION,@CIUDAD,@FECHA_ALTA)
END

--EJ: exec SP_ALTA_MODIFICA_CLI 'PEPE','ZABALA','26258410','RUIZ DE LOS LLANOS 345','CABA','SUR'

------------------------------------------
---------------------------------------------------------
CREATE PROCEDURE SP_MOVIMIENTOS_LUISA
AS

SELECT COUNT(idMovimiento) [Cant mov de Luisa] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where Vendedor='Luisa'

EXEC SP_MOVIMIENTOS_LUISA
-----------------------------------

CREATE PROCEDURE SP_MOVIMIENTOS_VEND
@NombreVend as varchar(255)
AS

SELECT COUNT(idMovimiento) [Cant mov de Luisa] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where Vendedor=@NombreVend

EXEC SP_MOVIMIENTOS_VEND 'Pedro'

-------------------------------------
CREATE PROCEDURE SP_CANT_VENTAS
@cant_vend as INT OUTPUT,
@FechaDesde as varchar(20),
@FechaHasta as varchar(20)
AS
BEGIN
	SELECT DISTINCT v.idVendedor,v.vendedor,me.idMovimiento
	FROM MovimientoEmpresa me
	RIGHT JOIN Vendedor v
	ON me.idVendedor = v.idVendedor
	WHERE me.idMovimiento IS NOT NULL
	and me.FechaVenta Between convert(datetime,@FechaDesde) and convert(datetime,@FechaHasta)
	
	SELECT @cant_vend = @@ROWCOUNT;
END


---------------------------------
DECLARE @cant AS INT
EXEC SP_CANT_VENTAS @cant OUTPUT,'2001-04-01 00:00:00','2004-05-01 00:00:00'
select @cant as cantregistros