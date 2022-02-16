-----------------------------------------------------
--1) Mostrar los movimientos y los nombres de los vendedores
-------------------
SELECT v.Vendedor, pr.Provincia--me.idMovimiento,
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON v.idVendedor = me.idVendedor

-------------
--INNER JOIN Provincia pr
--ON pr.idProvincia = me.idProvincia


-----------------------------------------------------
--2) Mostrar los movimientos de Luisa
-------------------
SELECT me.idMovimiento,v.Vendedor 
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON v.idVendedor = me.idVendedor

WHERE v.Vendedor = 'Luisa' or v.Vendedor= 'Pedro' or v.Vendedor='Joaquin'

----
SELECT me.idMovimiento,v.Vendedor, pr.Provincia
FROM MovimientoEmpresa me

INNER JOIN Vendedor v
ON v.idVendedor = me.idVendedor

inner join provincia pr
on pr.idProvincia= me.idProvincia

---
Select v.idVendedor, Count(me.idMovimiento) as cant
		FROM MovimientoEmpresa me
		INNER JOIN Vendedor v
		on me.idVendedor = v.idVendedor
		GROUP BY p.idPais,p.Nombre

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
SELECT * from (
select COUNT(idMovimiento) [Cant mov de Luisa] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where v.idVendedor='6'
Union
SELECT COUNT(idMovimiento) [Cant mov de Pedro] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where v.idVendedor='2'
Union
SELECT COUNT(idMovimiento) [Cant mov de Pedro] 
FROM MovimientoEmpresa me
INNER JOIN Vendedor v
ON me.idVendedor=v.idVendedor
where v.idVendedor='4') as cant
order by cant.[Cant mov de Luisa] asc



--7)Traer los movimientos con su vendedor, provincia, operacion, 
--y tipo de inmueble asociado para todos los vendedores existentes en la tabla MovimientoEmpresa
--Que se realizaron en febrero de 2004
SELECT 
me.idMovimiento,
me.Superficie,
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

---
select * from MovimientoEmpresa

---
Select p.Nombre as Pais, Count(c.idPais) as cant
		FROM Cliente c
		INNER JOIN Pais p 
		on c.idPais = p.idPais
		GROUP BY p.idPais,p.Nombre

Select Count(me.idVendedor) as cant, Vendedor as vendedor, Provincia as pr--, Count(me.idVendedor) as cant
		FROM MovimientoEmpresa me
		INNER JOIN Vendedor v 
		on me.idVendedor = v.idVendedor

		inner join Provincia pr
		on me.idProvincia = pr.idProvincia
		GROUP BY Vendedor, Provincia--,me.Superficie
		having count(me.idVendedor) > 450
		order by Vendedor asc

---
Select c.Nombre, p.Nombre as Pais, e.Nombre as cant
	FROM Cliente c
		INNER JOIN Pais p 
		on c.idPais = p.idPais
		INNER JOIN Empresa e
		on c.idEmpresa = e.idEmpresa
WHERE (p.idPais = @idPais or @idPais IS NULL) AND (e.idEmpresa = @idEmpresa or @idEmpresa IS NULL)
---
@idVendedor as int,
@idProvincia as int
As

Select v.idVendedor, me.idMovimiento as Movimiento, pr.idProvincia as Provincia
		FROM MovimientoEmpresa me
		INNER JOIN Vendedor v 
		on me.idVendedor = v.idVendedor
		INNER JOIN Provincia pr
		on me.idProvincia = pr.idProvincia
WHERE (v.idVendedor = @idVendedor or @idVendedor IS NULL) AND (pr.idProvincia = @idProvincia or @idProvincia IS NULL)



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
