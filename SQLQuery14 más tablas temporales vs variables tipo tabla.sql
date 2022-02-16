	-- creamos tabla temporal 1 y la llenamos
	select object_id, name
	into #tmp1
	from sys.all_objects
	

	-- creamos tabla temporal 2 y la llenamos
	select object_id, column_id, name
	into #tmp2
	from sys.all_columns
	

	SET STATISTICS IO ON
	-- obtenemos los datos
	select t1.name, count(t2.column_id)
	from #tmp1 t1
	left join #tmp2 t2 
		on t1.object_id = t2.object_id
	group by t1.name

SET STATISTICS IO OFF


--drop table #tmp1
--drop table #tmp2

--------------
	-- creamos las variables tipo tabla
	DECLARE @tmp1 TABLE (object_id int, name sysname)
	DECLARE @tmp2 TABLE (object_id int, column_id int, name sysname)
	

	-- insertamos la informacion en las variables tipo tabla
	insert into @tmp1
	select object_id, name
	from sys.all_objects
	insert into @tmp2
	select object_id, column_id, name
	from sys.all_columns
	

	-- obtenemos los datos
	SET STATISTICS IO ON
	select t1.name, count(t2.column_id)
	from @tmp1 t1
	left join @tmp2 t2 
		on t1.object_id = t2.object_id
	group by t1.name
	SET STATISTICS IO OFF
