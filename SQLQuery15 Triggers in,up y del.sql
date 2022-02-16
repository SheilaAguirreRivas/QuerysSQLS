USE [BD_INMOVILIARIA]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 10/29/2019 16:40:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[logDescripcion] [varchar](3000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF


--insert into MovimientoEmpresa values(Getdate(),	291,	21333,	Getdate(),	6,	2,	4,	5)
--update MovimientoEmpresa Set PrecioVenta = 21350 where idMovimiento = 2763
--delete from MovimientoEmpresa where idMovimiento=2762

select * from Logs
----------------------------------------------------------IN
USE [BD_INMOVILIARIA]
GO
/****** Object:  Trigger [dbo].[trMovEmpresaIn]    Script Date: 11/03/2020 18:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trMovEmpresaIn]
ON [dbo].[MovimientoEmpresa]
FOR INSERT
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM INSERTED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento insertado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento)+ ' Usuario: ' + CURRENT_USER)

END
----------------------------------------------------------
ALTER TRIGGER trMovEmpresaIn
ON MovimientoEmpresa
FOR INSERT
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM INSERTED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento insertado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento)+ ' Usuario: ' + CURRENT_USER)
END
GO
----------------------------------------------------------UP
USE [BD_INMOVILIARIA]
GO
/****** Object:  Trigger [dbo].[trMovEmpresaUp]    Script Date: 11/03/2020 18:58:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trMovEmpresaUp]
ON [dbo].[MovimientoEmpresa]
AFTER Update
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM DELETED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento modificado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento) + ' Usuario: ' + CURRENT_USER)
END
---------------------------------------------------------
ALTER TRIGGER trMovEmpresaUp
ON MovimientoEmpresa
AFTER Update
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM DELETED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento modificado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento) + ' Usuario: ' + CURRENT_USER)
END
GO
----------------------------------------------------------DEL
USE [BD_INMOVILIARIA]
GO
/****** Object:  Trigger [dbo].[trMovEmpresaDel]    Script Date: 11/03/2020 19:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trMovEmpresaDel]
ON [dbo].[MovimientoEmpresa]
FOR DELETE
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM DELETED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento eliminado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento) + ' Usuario: ' + CURRENT_USER)
END
-------------------------------------------------------------------
ALTER TRIGGER trMovEmpresaDel
ON MovimientoEmpresa
FOR DELETE
AS
BEGIN
	--SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales
	-- interferir con las instrucciones SELECT.
	SET NOCOUNT ON;

	-- obtener el último valor de identificación del registro insertado o actualizado
	DECLARE @id INT, @idMovimiento INT
	SELECT @id = [idVendedor],@idMovimiento = [idMovimiento]
	FROM DELETED

	INSERT INTO Logs VALUES(Getdate(),'Movimiento eliminado por el vendedor : ' + convert(varchar(50),@id) + ' movimiento: '+convert(varchar(50),@idMovimiento) + ' Usuario: ' + CURRENT_USER)
END
GO
--------------------------------------------------------------

--insert into MovimientoEmpresa values(Getdate(),	291,	21333,	Getdate(),	6,	2,	4,	5)
--update MovimientoEmpresa Set PrecioVenta = 21350 where idMovimiento = 2763
--delete from MovimientoEmpresa where idMovimiento=2762

select * from Logs


---------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
