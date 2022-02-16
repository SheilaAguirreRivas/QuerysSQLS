--Modificar mediante un cursor los clientes que son de Zona->Capital, poner Zona->Capital Federal 
USE [BD_INMOVILIARIA]
GO


DECLARE 
@nom AS VARCHAR(255),
@ape AS VARCHAR(255),
@dni AS VARCHAR(255),
@dir AS VARCHAR(255),
@ciu AS VARCHAR(255),
@zon AS VARCHAR(255)

DECLARE cursorCli CURSOR FOR
	Select Nombre,Apellido,DNI,Direccion,Ciudad,Zona 
			from Cliente where zona = 'Capital' FOR UPDATE

OPEN cursorCli
	FETCH cursorCli into @nom,@ape,@dni,@dir,@ciu,@zon

WHILE(@@fetch_status=0)
BEGIN
	UPDATE Cliente
		Set Zona = @zon + ' Federal'
	WHERE CURRENT OF cursorCli

	FETCH cursorCli into @nom,@ape,@dni,@dir,@ciu,@zon
END

CLOSE cursorCli
DEALLOCATE cursorCli


-----------------------------------------------
--2) Agregar la columna idCliente en la tabla Cliente y modificar su valor para que quede numerado 
--ALTER TABLE dbo.Cliente ADD idCliente int
--Hacerlo teniendo una variable @idCli de tipo INT que se incremente por cada fila que trae de un cursor

DECLARE 
@dni as varchar(255),
@idCli as INT
SET @idCli=1

DECLARE cursorCli CURSOR FOR
	Select dni from Cliente FOR UPDATE
OPEN cursorCli
	FETCH cursorCli into @dni

WHILE(@@fetch_status=0)
BEGIN
	UPDATE Cliente 
		Set idCliente = @idCli
	WHERE CURRENT OF cursorCli
	Set @idCli=@idCli+1

	FETCH cursorCli into @dni
END

CLOSE cursorCli
DEALLOCATE cursorCli


----------------------------------------------------
-- Modificar la tabla MovimientoEmpresa agregrale el campo idCliente
-- Modificar los datos para que tomen valores aleatorios del 1 al idCliente maximo
-- Teniendo en cuenta la siguiente funcion que retorna valores aleatorios para los clientes

SELECT ROUND((((Select Count(1) from Cliente) - 1 -1) * RAND() + 1), 0)

--ALTER TABLE dbo.MovimientoEmpresa ADD idCliente int


DECLARE 
@idmov as INT,
@idCli as INT

DECLARE cursorME CURSOR FOR
	Select idMovimiento from MovimientoEmpresa FOR UPDATE
OPEN cursorME
	FETCH cursorME into @idmov

WHILE(@@fetch_status=0)
BEGIN
	Set @idCli = (SELECT ROUND((((Select Count(1) from Cliente) - 1 -1) * RAND() + 1), 0))

	UPDATE MovimientoEmpresa
		Set idCliente = @idCli
	WHERE CURRENT OF cursorME

	FETCH cursorME into @idmov
END

CLOSE cursorME
DEALLOCATE cursorME



--Select * from MovimientoEmpresa


