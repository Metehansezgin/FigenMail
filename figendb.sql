USE [master]
GO
/****** Object:  Database [FigenSoftDB]    Script Date: 4.04.2021 17:31:30 ******/
CREATE DATABASE [FigenSoftDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FigenSoftDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\FigenSoftDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FigenSoftDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\FigenSoftDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [FigenSoftDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FigenSoftDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FigenSoftDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FigenSoftDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FigenSoftDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FigenSoftDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FigenSoftDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FigenSoftDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FigenSoftDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FigenSoftDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FigenSoftDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FigenSoftDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FigenSoftDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FigenSoftDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FigenSoftDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FigenSoftDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FigenSoftDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FigenSoftDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FigenSoftDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FigenSoftDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FigenSoftDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FigenSoftDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FigenSoftDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FigenSoftDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FigenSoftDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FigenSoftDB] SET  MULTI_USER 
GO
ALTER DATABASE [FigenSoftDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FigenSoftDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FigenSoftDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FigenSoftDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FigenSoftDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FigenSoftDB] SET QUERY_STORE = OFF
GO
USE [FigenSoftDB]
GO
/****** Object:  Table [dbo].[MAIL_SENT]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAIL_SENT](
	[id] [int] NULL,
	[RecordTime] [datetime] NULL,
	[refUser] [int] NULL,
	[EmailReceiver] [nchar](255) NULL,
	[EmailSubject] [nchar](500) NULL,
	[EmailContent] [varchar](max) NULL,
	[PgMailUniqueId] [nchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAIL_TEMPLATE]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAIL_TEMPLATE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[EmailContent] [nvarchar](50) NULL,
 CONSTRAINT [PK_MAIL_TEMPLATE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[NameSurname] [nvarchar](500) NULL,
	[PgUsername] [nvarchar](50) NULL,
	[PgPassword] [nvarchar](50) NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_MAIL_SENT_ADD]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MAIL_SENT_ADD]

	@RecordTime datetime,
	@RefUser int, 
	@EmailReceiver nchar(255),
	@EmailSubject nchar(500),
	@EmailContent varchar(MAX),
	@PgMailUniqueId nchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	INSERT INTO dbo.MAIL_SENT (RecordTime,refUser,EmailReceiver,EmailSubject,EmailContent,PgMailUniqueId) 
	Values(@RecordTime,@RefUser,@EmailReceiver,@EmailSubject,@EmailContent,@PgMailUniqueId)
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_MAIL_SENT_GET_LIST_WITH_USER]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MAIL_SENT_GET_LIST_WITH_USER]
 	@refUser int 
AS
BEGIN


	SET NOCOUNT ON;
	
	SELECT * FROM dbo.MAIL_SENT WHERE refUser=@refUser
    
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_MAIL_SENT_GET_WITH_ID]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MAIL_SENT_GET_WITH_ID]
 
	@id int 
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	SELECT * FROM dbo.MAIL_SENT WHERE id=@id
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_MAIL_TEMPLATE_GET_LIST]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MAIL_TEMPLATE_GET_LIST]
 
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM dbo.MAIL_TEMPLATE
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_MAIL_TEMPLATE_GET_WITH_ID]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MAIL_TEMPLATE_GET_WITH_ID]
	@id int
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM dbo.MAIL_TEMPLATE WHERE id= @id
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserAdd]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UserAdd]
	-- Add the parameters for the stored procedure here
	@Username nchar(50),
	@Password nchar(50),
	@NameSurname nchar(500),
	@PgUsername nchar(50),
	@PgPassword nchar(50)
AS
BEGIN
	
	   

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[USER](Username,Password ,NameSurname ,PgUsername ,PgPassword)
	Values(@Username,@Password,@NameSurname,@PgUsername,@PgPassword)
	 
	SELECT  1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserDelete]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UserDelete]
	@id int
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	 DELETE [dbo].[USER] where id =@id
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserEdit]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UserEdit]
	@id int,
	@Username nchar(50),
	@Password nchar(50),
	@NameSurname nchar(500),
	@PgUsername nchar(50),
	@PgPassword nchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE [dbo.USER] SET Username=@Username , Password=@Password  ,NameSurname=@NameSurname ,
	PgUsername=@PgUsername ,PgPassword=@PgPassword WHERE id =@id
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserGetWithID]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UserGetWithID]
	@id int
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM [dbo].[USER] WHERE id= @id
    -- Insert statements for procedure here
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserGetWithUserName]    Script Date: 4.04.2021 17:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UserGetWithUserName]
	@Username varchar(50)
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM [dbo].[USER] WHERE Username= @Username
    -- Insert statements for procedure here
	 
END
GO
USE [master]
GO
ALTER DATABASE [FigenSoftDB] SET  READ_WRITE 
GO
