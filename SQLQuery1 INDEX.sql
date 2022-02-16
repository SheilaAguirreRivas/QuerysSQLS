--1) Crear un indice agrupado asociado al campo Apellido de la tabla Cliente
Create Clustered index ci_cliente_apellido on Cliente(Apellido)

--2) Crear un indice no agrupado asociado al campo DNI de la tabla Cliente
Create nonClustered index nci_cliente_dni on Cliente(DNI)

--3) Verificar el plan de ejecucion de la siguiente consulta y  ver que indice utiliza
Select Apellido,Nombre,DNI from Cliente 

--4) Verificar el plan de ejecucion de la siguiente consulta y  ver que indice utiliza
Select DNI from Cliente order by dni