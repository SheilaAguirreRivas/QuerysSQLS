------------------------------------------------------------
--1) Crear un stored procedure para modificar los datos de un cliente
-- donde se le pasen todos los datos nuevos y se acceda por dni.
--se deberá modificar todos los datos menos el dni.


--CREATE PROCEDURE SP_MODIFICA_CLI
CREATE PROCEDURE Proc1 --  [dbo].[Proc1]
@idProvincia as int,
@idVendedor as int
As

Select v.idVendedor, pr.idProvincia as prov, me.idMovimiento as mov-- c.Nombre, p.Nombre as Pais, e.Nombre as cant
	FROM MovimientoEmpresa me
		INNER JOIN Vendedor v 
		on me.idVendedor = v.idVendedor
		INNER JOIN Provincia pr
		on me.idProvincia = pr.idProvincia
WHERE (pr.idProvincia = @idProvincia or @idProvincia IS NULL) AND (v.idVendedor = @idVendedor or @idVendedor IS NULL)

	Indicar que valor retornará la siguiente ejecución:
	EXEC Proc1 4546,67



alter procedure Proc1
@idProvincia as int,
@idVendedor as int
As
 Select v.idVendedor, pr.idProvincia as prov, me.idMovimiento as mov-- c.Nombre, p.Nombre as Pais, e.Nombre as cant
	FROM MovimientoEmpresa me
		INNER JOIN Vendedor v 
		on me.idVendedor = v.idVendedor
		INNER JOIN Provincia pr
		on me.idProvincia = pr.idProvincia
		order by mov asc
		
		SELECT DISTINCT v.idVendedor,me.idMovimiento
FROM MovimientoEmpresa me
RIGHT JOIN Vendedor v
ON me.idVendedor = v.idVendedor
WHERE me.idMovimiento IS NULL
----
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

select * from dbo.Cliente

-----------------------------------
--2) Tomar el SP anterior y agregarle que cuando los datos que se pasen sean nuevos, se de alta el cliente
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

--EJ: exec SP_MODIFICA_CLI 'PEPE','ZABALA','1','RUIZ DE LOS LLANOS 345','CABA','SUR'

--------------------------------
--1) Crear un stored procedure para modificar los datos de un cliente
-- donde se le pasen todos los datos nuevos y se acceda por dni.
--se deberá modificar todos los datos menos el id.

CREATE PROCEDURE SP_ALTA_MODIFICA_CLI
@IDCLIENTE as int, 
@CUIT as varchar(255), 
@RAZONSOCIAL as varchar(255), 
@TELEFONO as varchar(255), 
@DIRECCION as varchar(255), 
@CIUDAD as varchar(255),
@FECHA_ALTA as datetime
As
BEGIN
	UPDATE Alta_Modif
	SET
	[CUIT]=@CUIT, 
	[RAZONSOCIAL]=@RAZONSOCIAL, 
	[TELEFONO]=@TELEFONO, 
	[DIRECCION]=@DIRECCION, 
	[CIUDAD]=@CIUDAD,
	[FECHA_ALTA]=@FECHA_ALTA

	WHERE
	IDCLIENTE=@IDCLIENTE
END

--EXEC SP_ALTA_MODIFICA_CLI  12,	'20524854755_1',	'PEDRO MIRTOLA_1',	'254874121_1',	'PLUSVALIA 5248_1',	'TABLADA_1',	'2012-11-04 00:00:00.000'

SELECT * FROM Alta_Modif


-----------------------------------
--2) Tomar el SP anterior y agregarle que cuando los datos que se pasen sean nuevos se de alta el cliente
-- verificar los datos solamente por DNI

DECLARE @mivar int
Set @mivar = 34
select @mivar

ALTER PROCEDURE SP_ALTA_MODIFICA_CLI
@IDCLIENTE as int, 
@CUIT as varchar(255), 
@RAZONSOCIAL as varchar(255), 
@TELEFONO as varchar(255), 
@DIRECCION as varchar(255), 
@CIUDAD as varchar(255),
@FECHA_ALTA as datetime
As
IF((SELECT 1 FROM Alta_Modif WHERE CUIT = @CUIT)=1)
BEGIN
	UPDATE  Alta_Modif
	SET 
	IDCLIENTE=@IDCLIENTE,
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
	INSERT INTO Alta_Modif VALUES(@IDCLIENTE,@CUIT,@RAZONSOCIAL,@TELEFONO,@DIRECCION,@CIUDAD,@FECHA_ALTA)
END

--EJ: exec SP_ALTA_MODIFICA_CLI  1,	'20524854755_1',	'PEDRO MIRTOLA_1',	'254874121_1',	'PLUSVALIA 5248_1',	'TABLADA_1',	'2012-11-04 00:00:00.000'



-----------------------------------
CREATE PROCEDURE SP_MOVIMIENTOS_LUISA
AS

SELECT COUNT(idMovimiento) [Cant mov de Luisa] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where Vendedor='Luisa'

EXEC SP_MOVIMIENTOS_LUISA
-----------------------------------
--Movimiento segun el vendedor que se pida al ejecutar
CREATE PROCEDURE SP_MOVIMIENTOS_VEND
@NombreVend as varchar(255)
AS

SELECT COUNT(idMovimiento) [Cant mov de Vend] 

FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where Vendedor=@NombreVend

EXEC SP_MOVIMIENTOS_VEND 'Jesus'
--------------------------------------
CREATE PROCEDURE SP_CANT_VENTAS
@cant_vend as INT OUTPUT,
@FechaDesde as varchar(20),
@FechaHasta as varchar(20)
AS
IF((SELECT 1 FROM Cant_Ventas WHERE cant_vend = @cant_vend)=1)
BEGIN
	UPDATE Cant_Ventas
	SET
	
	FechaDesde = @FechaDesde,
	FechaHasta = @FechaHasta

	WHERE cant_vend = @cant_vend
END
	ELSE
BEGIN
	INSERT INTO Cant_Ventas VALUES(@cant_vend, @FechaDesde, @FechaHasta)
END



exec SP_CANT_VENTAS 2, '2004-04-19 12:00:00.000' , '2004-06-19 12:00:00.000'
select * from dbo.Cant_Ventas


-------------------------------------
ALTER PROCEDURE SP_CANT_VENTAS
@cant_vend as INT OUTPUT,
@FechaDesde as varchar(20),
@FechaHasta as varchar(20)
AS
BEGIN
	SELECT DISTINCT v.idVendedor,v.vendedor,me.idMovimiento--me van a aparecer las columnas
	FROM MovimientoEmpresa me
	RIGHT JOIN Vendedor v
	ON me.idVendedor = v.idVendedor
	WHERE me.idMovimiento IS NOT NULL
	and me.FechaVenta Between convert(datetime,@FechaDesde) and convert(datetime,@FechaHasta)
	
	SELECT @cant_vend = @@ROWCOUNT;--Devuelve el número de filas afectadas por la última instrucción.
	-- Si el número de filas es mayor de dos mil millones, useROWCOUNT_BIG. Se aplica a: SQL Server (SQL
	--  Server 2008 a versión actual),
END

IF((SELECT 1 FROM Cant_Ventas WHERE cant_vend = @cant_vend)=1)
BEGIN
	UPDATE Cant_Ventas
	SET
	
	FechaDesde = @FechaDesde,
	FechaHasta = @FechaHasta

	WHERE cant_vend = @cant_vend
END
	ELSE
BEGIN
	INSERT INTO Cant_Ventas VALUES(@cant_vend, @FechaDesde, @FechaHasta)
END

exec SP_CANT_VENTAS 4, '2004-04-19 12:00' , '2004-06-19 12:00'
select * from dbo.Cant_Ventas


---------------------------------
DECLARE @cant AS INT
EXEC SP_CANT_VENTAS @cant OUTPUT,'2004-04-19 12:00:00','2004-06-19 12:00:00.000'
select @cant as CantRegistros --otra columna aparte con ese nombre que va a mostrar la cant de ventas entre esas fechas

select *from dbo.MovimientoEmpresa