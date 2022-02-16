CREATE TABLE [dbo].[Vendedor](
	[idVendedor] [int] NOT NULL,
	[Vendedor] [nvarchar](255) NULL,
 CONSTRAINT [PK_Vendedor] PRIMARY KEY CLUSTERED 
(
	[idVendedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

TRUNCATE TABLE Vendedor
--------------------------------------------------------------
INSERT INTO dbo.Vendedor values (1,'Carmen');
INSERT INTO dbo.Vendedor values (2,'Pedro');
INSERT INTO dbo.Vendedor values (3,'Joaquin');
INSERT INTO dbo.Vendedor values (4,'Jesus');
INSERT INTO dbo.Vendedor values (5,'Maria');
INSERT INTO dbo.Vendedor values (6,'Luisa');
INSERT INTO dbo.Vendedor values (7,'Federico');
INSERT INTO dbo.Vendedor values (8,'Juan Pablo');
GO

select * from dbo.vendedor

INSERT INTO Vendedor(idVendedor,Vendedor) VALUES (9, 'Juan Perez')


Select c.Nombre as Cliente,me.Nombre as MovimientoEmpresa,pr.Nombre as Provincia
from Cliente c
inner join Pais p 
on c.idPais = p.idPais 
inner join Empresa e 
on c.idEmpresa = e.idEmpresa
where p.Nombre like '%gu%'
and e.Nombre like '%on'


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