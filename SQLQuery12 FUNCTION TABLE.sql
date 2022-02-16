--Hacer una funcion donde se pase una cadena de caracteres separadas por comas y 
--retorne una tabla con los valores de cada palabra insertados en un registro cada una.

USE [BD_INMOVILIARIA]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 11/05/2019 10:58:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ALTER
CREATE FUNCTION dbo.Split
(
	@ItemList VARCHAR(max)
)
RETURNS @IDTable TABLE (Item VARCHAR(max))  
AS      

BEGIN
	DECLARE @tempItemList VARCHAR(max)
	SET @tempItemList = @ItemList

	DECLARE @i INT    
	DECLARE @Item VARCHAR(max)

	WHILE (@tempItemList IS NOT NULL)
	BEGIN
		--Obtengo la posición de la coma
		SET @i = CHARINDEX(',', @tempItemList)
		--SI no es la ultima pablabra
		IF(@i<>0)
		BEGIN
			--Obtengo la primer palabra de la lista temporal y la inserto en la variable tabla
			SET @Item = LEFT(@tempItemList, @i - 1)
			INSERT INTO @IDTable(Item) VALUES(ltrim(rtrim(@Item)))
			SET @tempItemList=RIGHT(@tempItemList,LEN(@tempItemList)-LEN(@Item)-1)
		END
		ELSE   --Es la ultima palabra
		BEGIN
			--Obtengo la ultima palabra de la lista tenporal y la inserto en la variable tabla
			SET @Item = @tempItemList
			INSERT INTO @IDTable(Item) VALUES(ltrim(rtrim(@Item)))
			SET @tempItemList=NULL
		END
	END
	RETURN
END  

--select * from dbo.Split('hola,mundo,este,es,una,prueba') 

-------------------
ALTER FUNCTION dbo.Comisiones (@idVendedor VARCHAR(250),@Mes as int, @Anio as int)
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