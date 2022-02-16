--Hacer una funcion que calcule la cantida de transacciones de un vendedor 
CREATE FUNCTION dbo.CantidadTransacciones (@vendedor VARCHAR(250))
RETURNS INT
AS BEGIN
    DECLARE @cantVentas INT

	SET @cantVentas=
	(SELECT count(me.idMovimiento)
	FROM dbo.MovimientoEmpresa me
	INNER JOIN Vendedor v on me.idVendedor = v.idVendedor
	WHERE v.Vendedor = @vendedor)

    RETURN @cantVentas
END

select dbo.CantidadTransacciones('Luisa') CantTrans
---------------------------------------------------

--Hacer una funcion para calcular la comision mensual donde se ingrese el id del vendedor, el mes y el año
--y calcule la comision mensual teniendo en cuenta que gana un 20% de comision sólo si supera los 2 millones de pesos.

------------------------------------------------------------------------
CREATE FUNCTION dbo.Comisiones (@idVendedor VARCHAR(250),@Mes as int, @Anio as int)
RETURNS FLOAT
AS BEGIN
    DECLARE @comision FLOAT

	SET @comision=
	(
		
		select
		ISNULL(SUM(PrecioVenta) * 0.2,0)
		from MovimientoEmpresa 
		where month(FechaVenta)=@mes and year(FechaVenta)=@anio
		and idVendedor=@idVendedor
		group by Month(FechaVenta)
		having SUM(PrecioVenta)> 2000000

)
    RETURN @comision
END
--------------------------------------------------------------------
Select 
Month(me.FechaVenta) Mes,
Year(me.FechaVenta) Año, 
v.vendedor, 
isnull(dbo.Comisiones(me.idVendedor,Month(me.FechaVenta),Year(me.FechaVenta)),0) Comision
from MovimientoEmpresa me
inner join Vendedor v
on v.idVendedor = me.idVendedor
Group By Month(me.FechaVenta),
Year(me.FechaVenta), 
me.idVendedor,
v.vendedor