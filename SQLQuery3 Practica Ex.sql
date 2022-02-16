--SELECT SIMPLE
---------------
--1) Traer todos campos de la tabla Vendedor
select * from dbo.Vendedor

--ORDER BY
---------------
--2) Traer las provincias ordenadas de manera descendente
select Provincia from Provincia order by Provincia desc

-------------------------------------
--BETWEEN
---------------
--3) Traer todos registros de la tabla MovimientoEmpresa que se hayan realizado en enero de 2004
select * from MovimientoEmpresa where FechaAlta between convert (datetime, '01/01/2004 00:00:00',103) and convert(datetime, '01/02/2004',103)
-------------------------------------
--TOP
---------------
--4) Traer los primeros tres registros de la tabla TipoInmueble pero solo mostrar el campo TipoInmueble
select top 3 TipoInmueble from TipoInmueble
-------------------------------------
--DISTINCT
---------------
--5) Obtener la FechaAlta y Superficie que no se repitan que fueron realizados el primer dia del 2004 ordenadas por superficie de manera ascendente
select distinct FechaAlta, Superficie from MovimientoEmpresa where FechaAlta= convert(datetime, '01/01/2004 00:00:00', 103) order by Superficie asc
-------------------------------------
--AND
---------------
--6) Traer los registros de la tabla MovimientoEmpresa que hayan sido realizados por el vendedor 1 y en la Provincia 2

select * from MovimientoEmpresa where idVendedor=1 and idProvincia=2
-------------------------------------
--OR
---------------
--7) Traer los registros de la tabla MovimientoEmpresa que hayan sido realizados por el vendedor 1 y el vendedor 2
select * from MovimientoEmpresa where idVendedor=1 or idVendedor=2
-------------------------------------
--IN
---------------
--8) Traer los registros de la tabla MovimientoEmpresa de las provincias 1, 2 y 3
select * from MovimientoEmpresa where idProvincia in (1,2,3)
-------------------------------------
--LIKE y comodin %
---------------
--9a) Traer los Vendedores que comiencen con la letra c
select * from Vendedor where Vendedor like ('c%')
--9b) Traer los Vendedores que contengan una letra c
select * from Vendedor where Vendedor like ('%c%')
--9c) Traer los Vendedores que terminen con la letra o
select * from Vendedor where Vendedor like ('%o')
--9d) Traer los Vendedores que no contengan la letra o
select * from Vendedor where Vendedor not like ('%o%')

-------------------------------------
--NULL
---------------
--10a) Setear en null la fecha de venta del ultimo movimiento de la tabla MovimientoEmpresa
UPDATE MovimientoEmpresa
SET FechaVenta=NULL
WHERE idMovimiento=(SELECT TOP 1 idMovimiento FROM MovimientoEmpresa ORDER BY idMovimiento DESC)
--'2004-06-19 00:00:00.000'
--10b) Seleccionar los movimientos de la tabla MovimientoEmpresa donde su fecha de venta sea null
SELECT * FROM MovimientoEmpresa WHERE FechaVenta IS NULL

-------------------------------------
--ALIAS en columna y en tabla
---------------
--11a) Seleccionar los primeros diez movimientos de la tabla MovimientoEmpresa y mostrar los campos
--idMovimiento,Superficie,PrecioVenta y FechaVenta modificados por un alias
SELECT top 10 idMovimiento as mov ,Superficie as sup, PrecioVenta as precio, FechaVenta as fecha FROM MovimientoEmpresa
--11b) Seleccionar los primeros diez idmovimientos de la tabla MovimientoEmpresa
--renombrando la tabla con un alias
SELECT top 10 me.idMovimiento as 'mov de me' FROM MovimientoEmpresa as me

-------------------------------------
--FUNCIONES
---------------
--12a) Getdate
---------------
SELECT GETDATE()

---------------
--12b) ISNULL
---------------
SELECT idMovimiento,Superficie,ISNULL(FechaVenta,'') FROM MovimientoEmpresa WHERE FechaVenta IS NULL
SELECT idMovimiento,Superficie,ISNULL(FechaVenta,getdate()) FROM MovimientoEmpresa WHERE FechaVenta IS NULL
SELECT idMovimiento,Superficie,ISNULL(FechaVenta,FechaAlta) FROM MovimientoEmpresa WHERE FechaVenta IS NULL
SELECT idMovimiento,Superficie,ISNULL(FechaVenta,'2004-01-01 00:00:00.000')as FechaVenta FROM MovimientoEmpresa WHERE FechaVenta IS NULL

---------------
--12c) ABS
---------------
SELECT ABS(-8) as [VALOR ABSOLUTO]

---------------
--12d) ROUND
---------------
SELECT ROUND(12.56457,0) as [REDONDEO SIN COMA]
SELECT ROUND(12.56457,1) as [REDONDEO CON UN SOLO DECIMAL]
SELECT ROUND(12.56457,2) as [REDONDEO CON DOS DECIMALES]
SELECT ABS(ROUND(-12.56457,0)) [MIX REDONDEO Y ABOLUTO]

---------------------------------
--12e) JUGANDO CON CADENAS DE CARACTERES
-----------------
SELECT 'HOLA '+'MUNDO' as 'CAMPO CONCATENADO'
SELECT {fn CONCAT('HOLA ','MUNDO')} as 'CAMPO CONCATENADO CON CONCAT'

SELECT LEFT('HOLA '+'MUNDO',2) as 'JUGANDO CON LEFT'
SELECT RIGHT('HOLA '+'MUNDO',2) as 'JUGANDO CON RIGHT'

SELECT LTRIM('     HOLA '+'MUNDO') as 'SACANDO ESPACIOS A LA IZQUIERDA'
SELECT RTRIM('HOLA '+'MUNDO          ') as 'SACANDO ESPACIOS A LA DERECHA'

SELECT SUBSTRING('HOLA',2,2) as 'USANDO SUBTRING'

---------------------------------
--13) UNION
-----------------
--13a)
SELECT 123 as campo1
UNION
SELECT 124 as campo1

--13b)
--Traer los movimientos menores a 100 y los mayores a 2700 de la tabla MovimientoEmpresa
Select idMovimiento from MovimientoEmpresa where idMovimiento<100
UNION
Select idMovimiento from MovimientoEmpresa where idMovimiento >2700


----------------------------------------------
-- 14) Hallar precio de venta menor
SELECT MIN(PrecioVenta) as PrecioVenta
FROM MovimientoEmpresa

-- 15) Hallar movimiento d�nde el precio de venta sea el mas grande
SELECT idMovimiento
FROM MovimientoEmpresa
WHERE PrecioVenta = (SELECT MAX(PrecioVenta)FROM MovimientoEmpresa)


--16) Hallar el precio de venta promedio sin coma
SELECT ROUND(AVG(PrecioVenta),0) as PromedioVenta FROM MovimientoEmpresa


--15) Mostrar el nro de movimiento y precio de venta menor y de venta mayor y 
--del promedio pero como �ste no tiene nro de mov poner el valor cero
--Ordenar por monto de manera ascendente

Select * FROM
(
	SELECT idMovimiento,PrecioVenta FROM MovimientoEmpresa WHERE PrecioVenta = (SELECT MIN(PrecioVenta)FROM MovimientoEmpresa)
	UNION
	SELECT 0,ROUND(AVG(PrecioVenta),0) as PromedioVenta FROM MovimientoEmpresa
	UNION
	SELECT idMovimiento,PrecioVenta FROM MovimientoEmpresa WHERE PrecioVenta = (SELECT MAX(PrecioVenta)FROM MovimientoEmpresa)
) as T1
ORDER BY T1.PrecioVenta asc
-----------------------------------------------------
--1) Mostrar los movimientos y los nombres de los vendedores
-------------------
SELECT me.idMovimiento,v.Vendedor 
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON v.idVendedor = me.idVendedor

-----------------------------------------------------
--2) Mostrar los movimientos de Luisa
-------------------
SELECT me.idMovimiento,v.Vendedor 
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON v.idVendedor = me.idVendedor

WHERE v.Vendedor = 'Luisa'

-----------------------------------------------------
--3) Eliminar a carmen de la tabla de vendedores
Delete from Vendedor where idVendedor=1

-----------------------------------------------------
--4) Traer los movimientos realizados de la tabla MovimientoEmpresa y mostrar los nombres de los vendedores tambien
SELECT me.idMovimiento,me.FechaAlta,v.Vendedor 
FROM MovimientoEmpresa me
LEFT JOIN Vendedor v
on me.idVendedor = v.idVendedor

--5) Mostrar los vendedores que no tengan movimientos
SELECT DISTINCT v.idVendedor,me.idMovimiento
FROM MovimientoEmpresa me
RIGHT JOIN Vendedor v
ON me.idVendedor = v.idVendedor
WHERE me.idMovimiento IS NULL

--6) Mostrar la cantidad de movimientos realizados por Luisa
SELECT COUNT(idMovimiento) [Cant mov de Luisa] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where Vendedor='Luisa'


--7)Traer los movimientos con su vendedor, provincia, operacion, 
--y tipo de inmueble asociado para todos los vendedores existentes en la tabla MovimientoEmpresa
--Que se realizaron en febrero de 2004
SELECT 
me.idMovimiento,
v.Vendedor,
p.Provincia,
tio.operacion,
tin.TipoInmueble
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
on me.idVendedor = v.idVendedor

INNER JOIN Provincia p
on p.idProvincia = me.idProvincia

INNER JOIN TipoOperacion tio
on tio.idOperacion = me.idOperacion

INNER JOIN TipoInmueble tin
on tin.idTipoInmueble = me.idTipoInmueble

Where me.FechaAlta BETWEEN   convert(datetime,'01/02/2004',103) AND convert(datetime,'01/03/2004',103)



--8)Traer los movimientos con su vendedor, provincia, operacion, 
--y tipo de inmueble asociado para todos los movimientos existentes aunque no existan en la tabla vendedores
--Que se realizaron en febrero de 2004
--En caso de que el vendedor diga null poner 'Carmen' y en caso de que la operacion diga Alquiler Temporal 
--mostrar solo la palabra temporal
SELECT 
me.idMovimiento,
ISNULL(v.Vendedor,'Carmen') as Vendedor,
p.Provincia,
CASE WHEN tio.operacion='Alquiler Temporal' THEN
	'Temporal'
ELSE
	tio.operacion
END
as Operacion,
tin.TipoInmueble
FROM MovimientoEmpresa me

LEFT JOIN Vendedor v
on me.idVendedor = v.idVendedor

INNER JOIN Provincia p
on p.idProvincia = me.idProvincia

INNER JOIN TipoOperacion tio
on tio.idOperacion = me.idOperacion

INNER JOIN TipoInmueble tin
on tin.idTipoInmueble = me.idTipoInmueble

Where me.FechaAlta BETWEEN   convert(datetime,'01/02/2004',103) AND convert(datetime,'01/03/2004',103)
