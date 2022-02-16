--Hacer una tabla temporal que contenga el nombre,apellido y DNI de los clientes de capital

--Tablas temporales
CREATE TABLE #TablaClienteCABATemporal
(
	Nombre varchar(255), 
	Apellido varchar(255),
	DNI varchar(255)
)

INSERT INTO #TablaClienteCABATemporal
SELECT Nombre,Apellido,DNI FROM Cliente
WHERE Zona='Capital Federal'

SELECT * from #TablaClienteCABATemporal

DROP TABLE #TablaClienteCABATemporal

---------------------------------------------------
--Variables tipo tabla
DECLARE @VariableTabla TABLE (Campo1 int, Campo2 char(50))
INSERT INTO @VariableTabla VALUES (1,'Primer campo')
INSERT INTO @VariableTabla VALUES (2,'Segundo campo')
SELECT * FROM @VariableTabla


-----
DECLARE @VAR TABLE (Campo1 varchar(255), Campo2 varchar(255))
INSERT INTO @VAR
Select TOP 1 pr.Provincia,v.Vendedor as Empresa
from MovimientoEmpresa me

inner join Provincia pr
on me.idProvincia = pr.idProvincia

inner join Vendedor v
on me.idVendedor = v.idVendedor

ORDER BY pr.idProvincia desc

SELECT * from @VAR
---

inner join MovimientoEmpresa me
on pr.idMovimiento = me.idMovimiento



 