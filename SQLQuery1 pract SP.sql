CREATE PROCEDURE SP_ME
@FechaAlta as datetime,
@Superficie as float,
@PrecioVenta as float,
@FechaVenta as datetime,
@idVendedor as int,
@idProvincia as int,
@idOperacion as int,
@idTipoInmueble as int
As
BEGIN
UPDATE MovimientoEmpresa
SET 
[FechaAlta] = @FechaAlta,
[PrecioVenta] = @PrecioVenta,
[FechaVenta] = @FechaVenta,
[idVendedor] = @idVendedor,
[idProvincia] = @idProvincia,
[idOperacion] = @idOperacion,
[idTipoInmueble] = @idTipoInmueble

WHERE
[Superficie] = @Superficie

INSERT INTO MovimientoEmpresa VALUES (@FechaAlta,  @Superficie, @PrecioVenta, @FechaVenta, @idVendedor, @idProvincia, @idOperacion, @idTipoInmueble)

END
ELSE
BEGIN
	INSERT INTO MovimientoEmpresa VALUES (@FechaAlta,  @Superficie, @PrecioVenta, @FechaVenta, @idVendedor, @idProvincia, @idOperacion, @idTipoInmueble)

END

execute SP_ME '2004-01-01 12:00:00.000',291,	234,'2004-06-19 12:00:00.000',  10290, 	3,	4,  5

SELECT * FROM DBO.MovimientoEmpresa
insert into use(Name,DOB,Addr,phn,Country,States,City)
values (@Name,@DOB , @Address1 , @phone , @Country, @States, @City)