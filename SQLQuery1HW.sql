--SELECT SIMPLE
---------------
--1) Traer todos campos de la tabla Vendedor
select * from dbo.MovimientoEmpresa
select * from dbo.Vendedor
select sum(Superficie)
from MovimientoEmpresa where FechaAlta between convert(datetime,'01/01/2004 00:00:00',103) and convert(datetime,'01/02/2004',103)

--ORDER BY
---------------
--2) Traer las provincias ordenadas de manera descendente
select Provincia from Provincia order by Provincia desc

-------------------------------------
--BETWEEN
---------------
--3) Traer todos registros de la tabla MovimientoEmpresa que se hayan realizado en enero de 2004
select * from MovimientoEmpresa where FechaAlta between convert(datetime,'01/01/2004 00:00:00',103) and convert(datetime,'01/02/2004',103)

-------------------------------------
--TOP
---------------
--4) Traer los primeros tres registros de la tabla TipoInmueble pero solo mostrar el campo TipoInmueble
select top 3 TipoInmueble from TipoInmueble

-------------------------------------
--DISTINCT
---------------
--5) Obtener la FechaAlta y Superficie que no se repitan que fueron realizados el primer dia del 2004 ordenadas por superficie de manera ascendente
select DISTINCT FechaAlta,Superficie from MovimientoEmpresa where FechaAlta = convert(datetime,'01/01/2004 12:00:00',103) order by Superficie

-------------------------------------
--AND
---------------
--6) Traer los registros de la tabla MovimientoEmpresa que hayan sido realizados por el vendedor 1 y en la Provincia 2
Select * from MovimientoEmpresa where idVendedor = 1 and idProvincia=2

-------------------------------------
--OR
---------------
--7) Traer los registros de la tabla MovimientoEmpresa que hayan sido realizados por el vendedor 1 y el vendedor 2
Select * from MovimientoEmpresa where idVendedor = 1 or idVendedor=2

-------------------------------------
--IN
---------------
--8) Traer los registros de la tabla MovimientoEmpresa de las provincias 1, 2 y 3
Select * from MovimientoEmpresa where idProvincia IN (1,2,3)

-------------------------------------
--LIKE y comodin %
---------------
--9a) Traer los Vendedores que comiencen con la letra c
Select * from Vendedor where Vendedor like('c%')
--9b) Traer los Vendedores que contengan una letra c
Select * from Vendedor where Vendedor like('%c%')
--9c) Traer los Vendedores que terminen con la letra o
Select * from Vendedor where Vendedor like('%o')
--9d) Traer los Vendedores que no contengan la letra o
Select * from Vendedor where Vendedor not like('%o%')

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
