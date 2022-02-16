--------------------------------
--GROUP BY
--------------------------------

-- 1)Traer la cantidad de movimientos agrupado por provincia
SELECT COUNT(me.idMovimiento) [cant x prov],p.Provincia  

FROM MovimientoEmpresa me
INNER JOIN Provincia p
ON me.idProvincia = p.idProvincia

GROUP BY p.Provincia

select * from dbo.MovimientoEmpresa

select count(idMovimiento) from MovimientoEmpresa where idMovimiento=(select min(idMovimiento)from MovimientoEmpresa)
--
 

--

min(idMovimiento) as mov from MovimientoEmpresa

-- 2)Insertar a Carmen que habiamos eliminado anteriormente
Insert into Vendedor(idVendedor,Vendedor)values(1,'Ana')

-----------------------------
-- 3)Traer la cantidad de movimientos agrupados por Vendedores ordenados de mayor a menor
SELECT COUNT(me.idMovimiento) [mov x vend],v.Vendedor

FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor = v.idVendedor

GROUP BY v.Vendedor
ORDER BY COUNT(me.idMovimiento) desc

-- 4) Ahora solo mostrar aquellos que tengan mas de 460 movimientos de la consulta anterior
SELECT COUNT(me.idMovimiento) [mov x vend],v.Vendedor

FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor = v.idVendedor

GROUP BY v.Vendedor
HAVING COUNT(me.idMovimiento)>460
ORDER BY COUNT(me.idMovimiento) desc


-- 5) Contabilizar las ventas de aquellos vendedores que comiencen con la letra J
SELECT
ISNULL(SUM(PrecioVenta),0) as PrecioVenta,v.Vendedor
FROM MovimientoEmpresa me
RIGHT JOIN Vendedor v
ON me.idVendedor = v.idVendedor
WHERE v.Vendedor like 'J%'
GROUP BY v.Vendedor


-- 5) Sumar lo recuadado en Ventas Temporales realizadas por Carmen,Luisa y Jesus
SELECT
COUNT(1)
as CantVentas,
SUM(me.PrecioVenta) as TotVentaTemporal,v.Vendedor

FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON me.idVendedor = v.idVendedor

INNER JOIN TipoOperacion tio
ON me.idOperacion = tio.idOperacion

WHERE v.Vendedor IN('Carmen','Luisa','Jesus') AND tio.Operacion = 'Alquiler Temporal'

GROUP BY v.Vendedor

--------------------------------------