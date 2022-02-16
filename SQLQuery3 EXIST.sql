--1) Reemplazar IN por EXISTS para mejorar performance
--Traer los movimientos de los tipo de inmuebles 1,3,5
SELECT * FROM dbo.MovimientoEmpresa
WHERE idTipoInmueble IN(1,3,5)

SELECT *
FROM dbo.MovimientoEmpresa me
WHERE EXISTS (Select idTipoInmueble 
				from TipoInmueble ti
				where ((ti.idTipoInmueble = 1 OR ti.idTipoInmueble = 3 OR ti.idTipoInmueble = 5)
						AND ti.idTipoInmueble = me.idTipoInmueble))



--2) Los vendedores que no vendieron Parking en febrero de 2004 utilizando EXISTS

SELECT DISTINCT v.Vendedor
FROM Vendedor v

WHERE NOT EXISTS (SELECT distinct mem.idVendedor
				FROM MovimientoEmpresa mem

				INNER JOIN TipoInmueble tin
				ON tin.idTipoInmueble=mem.idTipoInmueble

				WHERE tin.TipoInmueble = 'Parking' AND 
				mem.FechaAlta BETWEEN '2004-02-01' AND '2004-03-01' 
				AND mem.idVendedor = v.idVendedor)