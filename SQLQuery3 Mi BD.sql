USE [MiBase]
GO

/****** Object:  Table [dbo].[MiTabla]    Script Date: 14/09/2021 23:47:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MiTabla](
	[idMiTabla] [bigint] NULL,
	[Descripcion] [varchar](255) NULL
) ON [PRIMARY]

GO

INSERT INTO [dbo].[MiTabla](idMiTabla.Descripcion) VALUES(1, 'MI TABLA DESCRIPCION')

SELECT * FROM MiTabla

ALTER TABLE MiTabla
ALTER COLUMN DESCRIPCION varchar(1000) NULL
 



