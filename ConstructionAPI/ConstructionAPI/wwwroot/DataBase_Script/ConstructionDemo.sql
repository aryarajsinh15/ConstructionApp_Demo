USE [master]
GO
/****** Object:  Database [ConstructionApp_Demo]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE DATABASE [ConstructionApp_Demo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ConstructionApp_Demo1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ConstructionApp_Demo1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ConstructionApp_Demo1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ConstructionApp_Demo1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ConstructionApp_Demo] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ConstructionApp_Demo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ConstructionApp_Demo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET ARITHABORT OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ConstructionApp_Demo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ConstructionApp_Demo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ConstructionApp_Demo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ConstructionApp_Demo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ConstructionApp_Demo] SET  MULTI_USER 
GO
ALTER DATABASE [ConstructionApp_Demo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ConstructionApp_Demo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ConstructionApp_Demo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ConstructionApp_Demo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ConstructionApp_Demo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ConstructionApp_Demo] SET QUERY_STORE = OFF
GO
USE [ConstructionApp_Demo]
GO
/****** Object:  UserDefinedTableType [dbo].[ExpenseIdTableType]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[ExpenseIdTableType] AS TABLE(
	[ExpenseId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SiteIdTableType]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[SiteIdTableType] AS TABLE(
	[SiteId] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_BillEstimateItemDetails]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_BillEstimateItemDetails] AS TABLE(
	[BillEstimateItemId] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Nos] [decimal](18, 2) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Rate] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_BillSiteItem]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_BillSiteItem] AS TABLE(
	[BillSiteItemId] [nvarchar](max) NULL,
	[ItemName] [nvarchar](max) NULL,
	[Rate] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_BillSiteItemDetails]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_BillSiteItemDetails] AS TABLE(
	[BillSiteItemId] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[IsSubItem] [bit] NULL,
	[IsTotalItem] [bit] NULL,
	[MainItemPKId] [nvarchar](max) NULL,
	[ItemCategory] [nvarchar](max) NULL,
	[ItemName] [nvarchar](max) NULL,
	[ItemType] [nvarchar](max) NULL,
	[Qty] [decimal](18, 2) NULL,
	[Length] [decimal](18, 2) NULL,
	[Height] [decimal](18, 2) NULL,
	[Width] [decimal](18, 2) NULL,
	[Area] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_PersonGroupMapping]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_PersonGroupMapping] AS TABLE(
	[PersonGroupMapId] [nvarchar](max) NULL,
	[PersonId] [nvarchar](max) NULL,
	[PersonGroupId] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_SavePersonAttendance]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_SavePersonAttendance] AS TABLE(
	[PersonAttendanceId] [nvarchar](max) NULL,
	[PersonId] [nvarchar](max) NULL,
	[AttendanceStatus] [decimal](18, 2) NULL,
	[SiteId] [nvarchar](max) NULL,
	[WithdrawAmount] [int] NULL,
	[OvertimeAmount] [int] NULL,
	[Remarks] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[tbl_SitePhotos]    Script Date: 6/18/2024 4:18:23 PM ******/
CREATE TYPE [dbo].[tbl_SitePhotos] AS TABLE(
	[PhotoName] [nvarchar](max) NULL,
	[PhotoEncryptedName] [nvarchar](max) NULL
)
GO
/****** Object:  Table [dbo].[tbl_Attendance]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Attendance](
	[AttendaceId] [uniqueidentifier] NOT NULL,
	[AttendanceDate] [datetime] NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tbl_Attendance] PRIMARY KEY CLUSTERED 
(
	[AttendaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BillDebitNew]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BillDebitNew](
	[BillId] [uniqueidentifier] NOT NULL,
	[BillDate] [datetime] NOT NULL,
	[BillNo] [nvarchar](50) NULL,
	[BillType] [nvarchar](50) NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Remarks] [nvarchar](200) NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_BillDebitNew] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BillSiteItemNew]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BillSiteItemNew](
	[BillSiteItemId] [uniqueidentifier] NOT NULL,
	[BillId] [uniqueidentifier] NOT NULL,
	[IsMainItem] [bit] NOT NULL,
	[IsSubItem] [bit] NOT NULL,
	[IsTotalItem] [bit] NOT NULL,
	[MainItemPKId] [uniqueidentifier] NULL,
	[ItemCategory] [nvarchar](20) NULL,
	[ItemName] [nvarchar](200) NULL,
	[ItemType] [nvarchar](50) NULL,
	[Qty] [decimal](18, 2) NULL,
	[Length] [decimal](18, 2) NULL,
	[Height] [decimal](18, 2) NULL,
	[Width] [decimal](18, 2) NULL,
	[Area] [decimal](18, 2) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tbl_BillSiteItemNew] PRIMARY KEY CLUSTERED 
(
	[BillSiteItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BillSiteNew]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BillSiteNew](
	[BillId] [uniqueidentifier] NOT NULL,
	[BillDate] [datetime] NOT NULL,
	[BillNo] [nvarchar](50) NULL,
	[BillType] [nvarchar](50) NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Remarks] [nvarchar](200) NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_BillSiteNew] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Challan]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Challan](
	[ChallanId] [uniqueidentifier] NOT NULL,
	[ChallanDate] [datetime] NOT NULL,
	[ChallanNo] [nvarchar](50) NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[MerchantId] [uniqueidentifier] NULL,
	[CarNo] [nvarchar](50) NULL,
	[FileTypeId] [int] NULL,
	[Remarks] [nvarchar](500) NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Challan] PRIMARY KEY CLUSTERED 
(
	[ChallanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Clients]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Clients](
	[ClientId] [uniqueidentifier] NOT NULL,
	[ClientName] [nvarchar](365) NOT NULL,
	[FirmName] [nvarchar](100) NULL,
	[PackageTypeId] [int] NOT NULL,
	[ExpireDate] [datetime] NULL,
	[Address] [nvarchar](500) NULL,
	[Remarks] [nvarchar](max) NULL,
	[HeaderImageLetterPage] [nvarchar](500) NULL,
	[FooterImageLetterPage] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ContractorFinance]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ContractorFinance](
	[ContractorFinanceId] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[SelectedDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[CreditOrDebit] [nvarchar](50) NULL,
	[PaymentType] [nvarchar](50) NULL,
	[ChequeNo] [nvarchar](50) NULL,
	[BankName] [nvarchar](50) NULL,
	[ChequeFor] [nvarchar](50) NULL,
	[Remarks] [nvarchar](365) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_ContractorFinance] PRIMARY KEY CLUSTERED 
(
	[ContractorFinanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Estimate]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Estimate](
	[EstimateId] [uniqueidentifier] NOT NULL,
	[EstimateDate] [datetime] NOT NULL,
	[PartyName] [nvarchar](100) NOT NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remarks] [nvarchar](500) NULL,
	[FileTypeId] [int] NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[EstimateType] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Estimate] PRIMARY KEY CLUSTERED 
(
	[EstimateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_EstimateItem]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_EstimateItem](
	[EstimateItemId] [uniqueidentifier] NOT NULL,
	[EstimateId] [uniqueidentifier] NOT NULL,
	[ItemName] [nvarchar](100) NOT NULL,
	[Nos] [decimal](18, 2) NOT NULL,
	[Qty] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[SeqNo] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tbl_EstimateItem] PRIMARY KEY CLUSTERED 
(
	[EstimateItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Expenses]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Expenses](
	[ExpenseId] [uniqueidentifier] NOT NULL,
	[ExpenseDate] [datetime] NOT NULL,
	[ExpenseTypeId] [int] NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SiteId] [uniqueidentifier] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Expenses] PRIMARY KEY CLUSTERED 
(
	[ExpenseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ExpenseType]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ExpenseType](
	[ExpenseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_ExpenseType] PRIMARY KEY CLUSTERED 
(
	[ExpenseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_FileCategory]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FileCategory](
	[FileCategoryId] [int] NOT NULL,
	[FileCategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_FileCategory] PRIMARY KEY CLUSTERED 
(
	[FileCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Files]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Files](
	[FileId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[FileCategory] [int] NOT NULL,
	[OriginalFileName] [nvarchar](500) NOT NULL,
	[EncryptFileName] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_tbl_Files] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Finance]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Finance](
	[FinanceId] [uniqueidentifier] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[SelectedDate] [datetime] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[CreditOrDebit] [nvarchar](50) NOT NULL,
	[GivenAmountBy] [uniqueidentifier] NOT NULL,
	[PaymentType] [nvarchar](50) NOT NULL,
	[ChequeNo] [nvarchar](50) NULL,
	[BankName] [nvarchar](50) NULL,
	[ChequeFor] [nvarchar](50) NULL,
	[Remarks] [nvarchar](365) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Finance] PRIMARY KEY CLUSTERED 
(
	[FinanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Merchant]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Merchant](
	[MerchantId] [uniqueidentifier] NOT NULL,
	[MerchantName] [nvarchar](100) NOT NULL,
	[FirmName] [nvarchar](100) NULL,
	[MobileNo] [nvarchar](15) NULL,
	[Address] [nvarchar](100) NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Merchant] PRIMARY KEY CLUSTERED 
(
	[MerchantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_MerchantPayment]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_MerchantPayment](
	[MerchantPaymentId] [uniqueidentifier] NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[MerchantId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[PaymentType] [nvarchar](50) NULL,
	[ChequeNo] [nvarchar](50) NULL,
	[BankName] [nvarchar](50) NULL,
	[ChequeFor] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tbl_MerchantPayment] PRIMARY KEY CLUSTERED 
(
	[MerchantPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PackageType]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PackageType](
	[PackageTypeId] [int] IDENTITY(1,1) NOT NULL,
	[PackageType] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_PackageType] PRIMARY KEY CLUSTERED 
(
	[PackageTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonAttendance]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonAttendance](
	[PersonAttendanceId] [uniqueidentifier] NOT NULL,
	[AttendanceId] [uniqueidentifier] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[AttendanceStatus] [decimal](18, 1) NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[PersonDailyRate] [int] NULL,
	[PayableAmount] [decimal](18, 2) NULL,
	[WithdrawAmount] [int] NULL,
	[OvertimeAmount] [int] NULL,
	[TotalRokadiya] [decimal](18, 2) NULL,
	[PersonTypeId] [int] NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tbl_PersonAttendance] PRIMARY KEY CLUSTERED 
(
	[PersonAttendanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonGroup]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonGroup](
	[PersonGroupId] [uniqueidentifier] NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_tbl_PersonGroup] PRIMARY KEY CLUSTERED 
(
	[PersonGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonGroupMap]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonGroupMap](
	[PersonGroupMapId] [uniqueidentifier] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[PersonGroupId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_tbl_PersonGroupMap] PRIMARY KEY CLUSTERED 
(
	[PersonGroupMapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Persons]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Persons](
	[PersonId] [uniqueidentifier] NOT NULL,
	[PersonFirstName] [nvarchar](365) NULL,
	[PersonAddress] [nvarchar](365) NULL,
	[MobileNo] [nvarchar](50) NULL,
	[PersonPhoto] [nvarchar](365) NULL,
	[DailyRate] [int] NULL,
	[PersonTypeId] [int] NULL,
	[IsAttendancePerson] [bit] NULL,
	[OrderNo] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[ClientId] [uniqueidentifier] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Persons] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonType]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_PersonType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Role]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NULL,
 CONSTRAINT [PK_tbl_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SitePhoto]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SitePhoto](
	[SitePhotoId] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[SitePhotoCategoryId] [uniqueidentifier] NULL,
	[PhotoDate] [datetime] NOT NULL,
	[PhotoName] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_tbl_SitePhoto] PRIMARY KEY CLUSTERED 
(
	[SitePhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SitePhotoCategory]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SitePhotoCategory](
	[SitePhotoCategoryId] [uniqueidentifier] NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_SitePhotoCategory] PRIMARY KEY CLUSTERED 
(
	[SitePhotoCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Sites]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Sites](
	[SiteId] [uniqueidentifier] NOT NULL,
	[SiteName] [nvarchar](365) NULL,
	[SiteDescription] [nvarchar](max) NOT NULL,
	[PartyId] [uniqueidentifier] NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Sites] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](367) NOT NULL,
	[Password] [nvarchar](67) NOT NULL,
	[ClientId] [uniqueidentifier] NULL,
	[RoleId] [int] NOT NULL,
	[FirstName] [nvarchar](367) NOT NULL,
	[EmailId] [nvarchar](67) NULL,
	[MobileNo] [nvarchar](15) NULL,
	[UserPhoto] [nvarchar](365) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[JWTToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_VehicleOwner]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_VehicleOwner](
	[VehicleOwnerId] [uniqueidentifier] NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[VehicleOwnerName] [nvarchar](200) NOT NULL,
	[MobileNo] [nvarchar](15) NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_VehicleOwner] PRIMARY KEY CLUSTERED 
(
	[VehicleOwnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_VehicleRent]    Script Date: 6/18/2024 4:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_VehicleRent](
	[VehicleRentId] [uniqueidentifier] NOT NULL,
	[VehicleOwnerId] [uniqueidentifier] NOT NULL,
	[VehicleRentDate] [datetime] NOT NULL,
	[FromLocation] [nvarchar](200) NOT NULL,
	[ToLocation] [nvarchar](200) NOT NULL,
	[VehicleNumber] [nvarchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[IsPaid] [bit] NOT NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[ClientId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_VehicleRent] PRIMARY KEY CLUSTERED 
(
	[VehicleRentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'af7c0477-67e5-419d-8841-1d61b02e0fd6', CAST(N'2024-05-03T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-18T09:56:10.360' AS DateTime), NULL, N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL)
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'430153e0-3bb2-4383-b7d1-4b79f8ab789e', CAST(N'2024-06-16T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-17T14:14:36.570' AS DateTime), NULL, N'2f134572-edf7-408d-a459-563c1bd4ac06', NULL)
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'0df0662d-5df8-4d5c-ba11-75debebb9ae4', CAST(N'2024-06-17T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-17T14:15:29.473' AS DateTime), NULL, N'2f134572-edf7-408d-a459-563c1bd4ac06', NULL)
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'7361a699-4fda-4321-9c59-9282363f40e8', CAST(N'2024-06-03T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-17T14:25:27.870' AS DateTime), NULL, N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL)
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'35a5fd62-0743-4041-b6a2-9710e0a3b46d', CAST(N'2024-05-02T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-18T09:51:51.787' AS DateTime), NULL, N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL)
INSERT [dbo].[tbl_Attendance] ([AttendaceId], [AttendanceDate], [ClientId], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (N'583b69cd-d23b-478e-abee-cb5444f2ffba', CAST(N'2024-06-04T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-17T14:18:48.663' AS DateTime), NULL, N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL)
INSERT [dbo].[tbl_BillDebitNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [PersonId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'a3ca6f9a-ef22-4ba5-87ac-26729699b2cd', CAST(N'2024-06-02T00:00:00.000' AS DateTime), N'1005', N'Person-File', NULL, N'22e4923f-96b7-4d56-8bac-42429b77b8cb', CAST(100.00 AS Decimal(18, 2)), N'ok', N'22e4923f-96b7-4d56-8bac-42429b77b8cb', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:05:51.550' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:07:05.247' AS DateTime))
INSERT [dbo].[tbl_BillDebitNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [PersonId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e5d2f5d6-3670-4c6e-9754-77179b6ee294', CAST(N'2024-06-18T00:00:00.000' AS DateTime), N'23', N'Person-File', NULL, N'fd246aea-1fed-442e-8cd5-096988f754b5', CAST(2.00 AS Decimal(18, 2)), NULL, N'fd246aea-1fed-442e-8cd5-096988f754b5', 1, 0, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T04:55:27.500' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillDebitNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [PersonId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e352b92d-ad22-4aba-8775-add7641d2eb6', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'1005', N'Person-File', NULL, N'22e4923f-96b7-4d56-8bac-42429b77b8cb', CAST(100.00 AS Decimal(18, 2)), N'ok', N'22e4923f-96b7-4d56-8bac-42429b77b8cb', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:07:50.903' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_BillSiteItemNew] ON 

INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'a26ceec4-0598-4011-a344-0eb4c69ac023', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 0, 0, 1, N'edccd84b-4284-41c2-be30-9d30ebee8a72', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(-22.00 AS Decimal(18, 2)), CAST(N'2024-06-11T10:49:52.137' AS DateTime), 12)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'89f6c39d-5f73-4dcf-a120-1b54a204221e', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 0, 1, 0, N'4a806382-5625-44eb-9187-3e9f7d8a8ad2', N'Plus', N'2.1', N'CFT', CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-11T10:49:52.137' AS DateTime), 10)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'201bbf6d-27ef-4410-b15e-1db2835edd07', N'16bf8950-5e1c-4bc4-b8d8-cde31fe90c80', 0, 1, 0, N'9e0f6185-f942-4cb1-bdb9-ef88ce41ad90', N'Plus', N'1.1', N'CFT', CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-13T05:06:03.877' AS DateTime), 17)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'ea5697a7-4399-4ea9-af39-282c07a6c54a', N'2bdaf81d-4b6c-4bcb-85ce-0cdf9e40b3a1', 0, 0, 1, N'4ec5932e-41cd-454d-8fba-c9d398a975cb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(86.00 AS Decimal(18, 2)), CAST(N'2024-06-17T14:11:16.543' AS DateTime), 33)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'c7d6f118-2d72-4e03-a094-2ced3ccc4c0a', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 0, 1, 0, N'edccd84b-4284-41c2-be30-9d30ebee8a72', N'Less', N'1.2', N'SFT', CAST(3.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), NULL, CAST(3.00 AS Decimal(18, 2)), CAST(27.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-11T10:49:52.137' AS DateTime), 9)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'4c9bce96-5bb6-427e-ac97-3144f2ea77fd', N'08a48bdf-6cff-42bf-9121-65cb24df8771', 0, 1, 0, N'c559de61-44c2-4719-9a70-9985854b34d7', N'Plus', N'Item 2', N'CFT', CAST(100.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(24000.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-17T10:18:21.300' AS DateTime), 26)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'ed01d5fe-8d79-4a13-8e42-34915658fc6b', N'4e168073-53af-475a-8a7e-10bc865b4a8d', 1, 0, 0, NULL, NULL, N'435', NULL, NULL, NULL, NULL, NULL, NULL, CAST(5.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-12T08:12:13.117' AS DateTime), 13)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'4a806382-5625-44eb-9187-3e9f7d8a8ad2', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 1, 0, 0, NULL, NULL, N'desc2', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-11T10:49:52.137' AS DateTime), 8)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'83fc7b12-b8b9-4705-968c-61cdcb62066f', N'16bf8950-5e1c-4bc4-b8d8-cde31fe90c80', 0, 0, 1, N'9e0f6185-f942-4cb1-bdb9-ef88ce41ad90', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(32.00 AS Decimal(18, 2)), CAST(N'2024-06-13T05:06:15.280' AS DateTime), 19)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'f5d221c4-d6df-4edd-977f-7c4e49e480ef', N'25cef01d-1a8f-4a22-94fb-cce8fb8f4ecc', 0, 0, 1, N'b091c5b2-d601-4611-9154-e03a575cf0f5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(-612.00 AS Decimal(18, 2)), CAST(N'2024-06-18T07:47:06.123' AS DateTime), 36)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'67ee740a-5978-4fa5-8ecc-881df974245d', N'4e168073-53af-475a-8a7e-10bc865b4a8d', 0, 0, 1, N'ed01d5fe-8d79-4a13-8e42-34915658fc6b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(-3125.00 AS Decimal(18, 2)), CAST(N'2024-06-12T08:12:13.120' AS DateTime), 15)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'c418becf-fba8-4dac-b467-90e273735b7f', N'2bdaf81d-4b6c-4bcb-85ce-0cdf9e40b3a1', 0, 1, 0, N'4ec5932e-41cd-454d-8fba-c9d398a975cb', N'Plus', N'1.1', N'CFT', CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-17T10:57:13.663' AS DateTime), 29)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'c559de61-44c2-4719-9a70-9985854b34d7', N'08a48bdf-6cff-42bf-9121-65cb24df8771', 1, 0, 0, NULL, NULL, N'Des 1', NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-17T10:18:21.300' AS DateTime), 21)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'edccd84b-4284-41c2-be30-9d30ebee8a72', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 1, 0, 0, NULL, NULL, N'desc 1', NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-11T04:40:37.613' AS DateTime), 5)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'0f5bf16b-55c7-44a5-80d2-9fbfd6c6c7b9', N'2bdaf81d-4b6c-4bcb-85ce-0cdf9e40b3a1', 0, 1, 0, N'4ec5932e-41cd-454d-8fba-c9d398a975cb', N'Plus', N'1.2', N'SFT', CAST(3.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), NULL, CAST(3.00 AS Decimal(18, 2)), CAST(27.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-17T10:57:13.663' AS DateTime), 30)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'207d6f68-d58e-4abf-b8a3-a0c614fdc139', N'08a48bdf-6cff-42bf-9121-65cb24df8771', 0, 0, 1, N'c559de61-44c2-4719-9a70-9985854b34d7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(48400.00 AS Decimal(18, 2)), CAST(N'2024-06-17T10:18:21.307' AS DateTime), 27)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'52a53ce3-d1c9-46f8-9c07-a9765760688c', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 0, 0, 1, N'4a806382-5625-44eb-9187-3e9f7d8a8ad2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-11T10:49:52.137' AS DateTime), 11)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'905e757d-97f2-4d04-ac90-c2a1514034c9', N'f6301b05-7896-4edb-9f5c-00fe6905de30', 0, 1, 0, N'edccd84b-4284-41c2-be30-9d30ebee8a72', N'Plus', N'1.1', N'CFT', CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-11T04:40:37.617' AS DateTime), 6)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'4ec5932e-41cd-454d-8fba-c9d398a975cb', N'2bdaf81d-4b6c-4bcb-85ce-0cdf9e40b3a1', 1, 0, 0, NULL, NULL, N'desc 1', NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-17T10:57:13.663' AS DateTime), 28)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'259d635f-c162-4f1d-9fcb-ca83bf472efc', N'ab84355e-b9df-4854-a04e-460cc3e0e3cf', 0, 0, 1, N'c2cd1902-d96f-4d7a-9883-eddc6afb9079', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-10T10:36:34.150' AS DateTime), 4)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'3b2594fd-fa99-46f8-b61b-cc3d9267cf2e', N'08a48bdf-6cff-42bf-9121-65cb24df8771', 0, 1, 0, N'c559de61-44c2-4719-9a70-9985854b34d7', N'Plus', N'Item 1', N'NOS', CAST(10.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), NULL, NULL, CAST(200.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-17T10:18:21.300' AS DateTime), 25)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'b600f0fb-6cfa-4551-8b6c-d7fac0c7b772', N'ab84355e-b9df-4854-a04e-460cc3e0e3cf', 0, 1, 0, N'c2cd1902-d96f-4d7a-9883-eddc6afb9079', N'Plus', N'વસ્તુનુ નામ', N'CFT', CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-10T10:36:27.493' AS DateTime), 2)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'b091c5b2-d601-4611-9154-e03a575cf0f5', N'25cef01d-1a8f-4a22-94fb-cce8fb8f4ecc', 1, 0, 0, NULL, NULL, N'test', NULL, NULL, NULL, NULL, NULL, NULL, CAST(34.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-18T07:47:06.120' AS DateTime), 34)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'771e0e45-decf-4bd9-9e48-e6397689c810', N'4e168073-53af-475a-8a7e-10bc865b4a8d', 0, 1, 0, N'ed01d5fe-8d79-4a13-8e42-34915658fc6b', N'Less', N'345', N'CFT', CAST(5.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(625.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-12T08:12:13.120' AS DateTime), 14)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'c2cd1902-d96f-4d7a-9883-eddc6afb9079', N'ab84355e-b9df-4854-a04e-460cc3e0e3cf', 1, 0, 0, NULL, NULL, N'વસ્તુનું વર્ણન', NULL, NULL, NULL, NULL, NULL, NULL, CAST(1.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-10T10:36:27.487' AS DateTime), 1)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'9e0f6185-f942-4cb1-bdb9-ef88ce41ad90', N'16bf8950-5e1c-4bc4-b8d8-cde31fe90c80', 1, 0, 0, NULL, NULL, N'desc 1', NULL, NULL, NULL, NULL, NULL, NULL, CAST(2.00 AS Decimal(18, 2)), NULL, CAST(N'2024-06-13T05:06:03.877' AS DateTime), 16)
INSERT [dbo].[tbl_BillSiteItemNew] ([BillSiteItemId], [BillId], [IsMainItem], [IsSubItem], [IsTotalItem], [MainItemPKId], [ItemCategory], [ItemName], [ItemType], [Qty], [Length], [Height], [Width], [Area], [Rate], [Amount], [CreatedDate], [SeqNo]) VALUES (N'2c14b16c-3400-46cb-9269-fd643216c5a7', N'25cef01d-1a8f-4a22-94fb-cce8fb8f4ecc', 0, 1, 0, N'b091c5b2-d601-4611-9154-e03a575cf0f5', N'Less', N'tset1 ', N'SFT', CAST(3.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), NULL, CAST(3.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2024-06-18T07:47:06.120' AS DateTime), 35)
SET IDENTITY_INSERT [dbo].[tbl_BillSiteItemNew] OFF
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'f6301b05-7896-4edb-9f5c-00fe6905de30', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'12345', N'Area', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', CAST(-6.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T04:40:37.613' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T10:49:52.133' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'2bdaf81d-4b6c-4bcb-85ce-0cdf9e40b3a1', CAST(N'2024-06-17T00:00:00.000' AS DateTime), N'1010', N'Area', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', CAST(86.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T10:57:13.663' AS DateTime), N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-17T14:11:16.543' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'4e168073-53af-475a-8a7e-10bc865b4a8d', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'345', N'Area', N'cf8f9e77-42f0-428c-abd2-f89868994b3e', CAST(-3125.00 AS Decimal(18, 2)), N'345', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'dd665146-c965-417b-b0fb-b11a41809d88', CAST(N'2024-06-12T08:12:13.117' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'5c84d8e4-2828-4e1f-9d29-1631a5a03c0f', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'123', N'File', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', CAST(100.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T12:23:52.270' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'bc760800-38f4-4bf5-87eb-1907cf45eb76', CAST(N'2024-06-06T00:00:00.000' AS DateTime), N'34645', N'Area', N'8a05d16d-1c6b-4e50-8451-e3921b86e382', CAST(48400.00 AS Decimal(18, 2)), N'Test', N'3d295037-5f64-4265-b934-137e2bf78e7b', 0, 1, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:18:21.300' AS DateTime), N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:28:45.547' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'0c220660-0113-4dd9-b4c2-241c656cd833', CAST(N'2024-06-05T00:00:00.000' AS DateTime), N'2334', N'File', N'8a05d16d-1c6b-4e50-8451-e3921b86e382', CAST(90000.00 AS Decimal(18, 2)), N'TEst', N'3d295037-5f64-4265-b934-137e2bf78e7b', 1, 0, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:15:21.687' AS DateTime), N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:16:03.233' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'2ef2cfeb-7574-486f-8a37-25f6db125835', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'1', N'File', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', CAST(10000.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-13T10:34:00.590' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6b493b4d-3860-4e90-8b0f-28e1aa1098ed', CAST(N'2024-06-15T00:00:00.000' AS DateTime), N'1001', N'File', N'd9068046-1ca7-41af-9df6-f8593db3dd46', CAST(200.00 AS Decimal(18, 2)), N'?????', N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-10T10:34:43.813' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'b24c773d-fe69-4262-b66a-3a137cbb15c4', CAST(N'2024-06-07T00:00:00.000' AS DateTime), N'1003', N'File', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', CAST(300.00 AS Decimal(18, 2)), N'ok', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T07:04:01.480' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'ab84355e-b9df-4854-a04e-460cc3e0e3cf', CAST(N'2024-06-20T00:00:00.000' AS DateTime), N'1002', N'Area', N'd9068046-1ca7-41af-9df6-f8593db3dd46', CAST(16.00 AS Decimal(18, 2)), N'વર્ણન', N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-10T10:36:27.487' AS DateTime), N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-10T10:36:34.147' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'03bd1721-1531-44b0-a074-525a1c4a501d', CAST(N'2024-06-17T00:00:00.000' AS DateTime), N'111', N'File', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', CAST(1000.00 AS Decimal(18, 2)), NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T11:34:05.437' AS DateTime), N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-17T14:10:59.857' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'32ea5109-605a-45ab-a71b-56fb88cac503', CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'4232323', N'File', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', CAST(2000.00 AS Decimal(18, 2)), N'dadsa', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T12:15:56.477' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T12:17:29.480' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'4f4ef4d3-84f8-45e1-b421-60d244a80fc2', CAST(N'2024-06-05T00:00:00.000' AS DateTime), N'1002', N'File', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', CAST(100.00 AS Decimal(18, 2)), N'ok', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T07:03:39.633' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'08a48bdf-6cff-42bf-9121-65cb24df8771', CAST(N'2024-06-06T00:00:00.000' AS DateTime), N'34645', N'Area', N'8a05d16d-1c6b-4e50-8451-e3921b86e382', CAST(48400.00 AS Decimal(18, 2)), N'Test', N'3d295037-5f64-4265-b934-137e2bf78e7b', 1, 0, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:18:21.300' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'85a21963-e49b-4503-b959-6b6ac7d0656d', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'2', N'File', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', CAST(5000.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-13T11:15:15.283' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'2b97e8d4-9d92-4bf5-8411-bd6bf3b48c24', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'4e', N'File', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', CAST(5.00 AS Decimal(18, 2)), NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T04:44:57.680' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T04:45:11.320' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'25cef01d-1a8f-4a22-94fb-cce8fb8f4ecc', CAST(N'2024-06-06T00:00:00.000' AS DateTime), N'344', N'Area', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', CAST(-612.00 AS Decimal(18, 2)), N'tet', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T07:47:06.120' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'16bf8950-5e1c-4bc4-b8d8-cde31fe90c80', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'1001', N'Area', N'3ac26047-ff73-4ccd-8d82-c92b400b2681', CAST(32.00 AS Decimal(18, 2)), N'test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T05:06:03.877' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T05:06:15.280' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'cd48c42d-e95d-4e45-894e-d63e308d0f12', CAST(N'2024-06-10T00:00:00.000' AS DateTime), N'1', N'File', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', CAST(5000.00 AS Decimal(18, 2)), N'જય માતાજી', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-10T11:23:25.007' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T12:17:26.600' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'1d041e66-55ba-450f-bf5e-e758db264ba1', CAST(N'2024-06-01T00:00:00.000' AS DateTime), N'jl', N'File', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', CAST(98.00 AS Decimal(18, 2)), NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T05:05:32.597' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T05:05:43.080' AS DateTime))
INSERT [dbo].[tbl_BillSiteNew] ([BillId], [BillDate], [BillNo], [BillType], [SiteId], [TotalAmount], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'a75570cc-bbff-4ade-ae5a-e9ec77a9dcc2', CAST(N'2024-06-04T00:00:00.000' AS DateTime), N'1001', N'File', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', CAST(200.00 AS Decimal(18, 2)), N'ok', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T06:56:35.890' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Challan] ([ChallanId], [ChallanDate], [ChallanNo], [SiteId], [MerchantId], [CarNo], [FileTypeId], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'17a873d2-4d6a-40ae-826f-0753bf5f33da', CAST(N'2024-06-17T00:00:00.000' AS DateTime), N'gdfgt', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'163ae566-067a-4ba6-8fb8-60df368df0bf', N'dfgfdgfg', 5, NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:54:26.260' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T13:06:48.673' AS DateTime))
INSERT [dbo].[tbl_Challan] ([ChallanId], [ChallanDate], [ChallanNo], [SiteId], [MerchantId], [CarNo], [FileTypeId], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'011e97a1-76cf-4670-a2a6-19a442f80d22', CAST(N'2024-06-04T00:00:00.000' AS DateTime), N'1004', N'd9068046-1ca7-41af-9df6-f8593db3dd46', N'd846b772-76d8-44e6-ace7-6053f5c32042', N'GJ01AD1234', 5, N'માલિક', N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-10T10:55:17.250' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Challan] ([ChallanId], [ChallanDate], [ChallanNo], [SiteId], [MerchantId], [CarNo], [FileTypeId], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'4ac3100d-0c64-458c-b911-49c3a5bf7bf2', CAST(N'2024-06-06T00:00:00.000' AS DateTime), N'5152', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', N'c50a97f6-5d81-46a9-8d74-1d3dd1e95eaa', N'GJ 01 KC 4329', 5, N'undefined', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T09:29:41.010' AS DateTime), N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', CAST(N'2024-06-17T10:53:43.600' AS DateTime))
INSERT [dbo].[tbl_Challan] ([ChallanId], [ChallanDate], [ChallanNo], [SiteId], [MerchantId], [CarNo], [FileTypeId], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'2f96c9e3-fc2c-4f9b-9c05-85dcd6d014bc', CAST(N'2024-06-04T00:00:00.000' AS DateTime), N'6458723847', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'c5e1659b-abe7-4ceb-a351-c0f3cb4853f9', N'GJ 01 EK 2374', 5, N'undefined', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T09:08:59.510' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T09:33:09.310' AS DateTime))
INSERT [dbo].[tbl_Challan] ([ChallanId], [ChallanDate], [ChallanNo], [SiteId], [MerchantId], [CarNo], [FileTypeId], [Remarks], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6f19c6af-f690-4266-afda-cca4ba234004', CAST(N'2024-03-31T00:00:00.000' AS DateTime), N'123', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', N'c50a97f6-5d81-46a9-8d74-1d3dd1e95eaa', N'GJ23', 5, NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-17T14:16:22.240' AS DateTime), N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-17T14:17:38.257' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Nilesh Prajapati', N'Shaligram Infotech', 1, CAST(N'2024-06-25T18:30:00.000' AS DateTime), N'Anand', N'ok', NULL, NULL, 1, 0, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-05-27T09:48:02.787' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'3d295037-5f64-4265-b934-137e2bf78e7b', N'Test', N'Test 1', 1, CAST(N'2024-06-20T00:00:00.000' AS DateTime), N'Test', NULL, NULL, NULL, 1, 0, CAST(N'2024-06-17T10:00:18.683' AS DateTime), NULL)
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'ac7f104a-ed08-452d-afa1-2207f10ff2a2', N'fhfg', N'hfgh', 1, CAST(N'2024-06-17T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, CAST(N'2024-06-17T12:30:56.753' AS DateTime), CAST(N'2024-06-17T12:31:07.257' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'11cca0f1-8ac4-41d8-9dca-4341d697d65b', N'khg', N'kh', 1, CAST(N'2024-06-17T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, CAST(N'2024-06-17T13:50:16.990' AS DateTime), CAST(N'2024-06-17T13:50:20.640' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'c50ef8d6-0ee9-4eef-ade8-6637b945ffa1', N'Demo Client', N'Demo Firm', 1, CAST(N'2024-06-16T00:00:00.000' AS DateTime), N'Test', N'Test', N'cdde43bb-730a-4b0f-9226-703a425067c0.png', N'2363ff0c-f885-4c94-9bca-d6d3cb16438f.png', 1, 0, CAST(N'2024-06-17T06:12:02.033' AS DateTime), CAST(N'2024-06-17T07:02:02.523' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'e093dc54-5ad4-4395-8675-6c7653e6def9', N'test', N'main 1', 1, CAST(N'2024-06-25T00:00:00.000' AS DateTime), N'ok', N'ok', N'338f5d55-3376-4efe-867d-78e4358064ee.png', N'65f53aae-1c97-4d22-9937-c585bf2a6766.png', 0, 1, CAST(N'2024-06-11T06:00:36.223' AS DateTime), CAST(N'2024-06-17T06:44:51.583' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'52ddff21-2a10-4f55-9f67-752abb4fd9c0', N'yashk', N'wrfs', 6, CAST(N'2024-05-22T18:30:00.000' AS DateTime), N'test', N'okk', NULL, NULL, 0, 1, CAST(N'2024-05-23T05:49:48.707' AS DateTime), CAST(N'2024-05-23T06:13:20.700' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'c52e83e3-c02c-4dd0-875f-757935720e6d', N'khj', N'jl', 1, CAST(N'2024-06-17T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, CAST(N'2024-06-18T05:04:14.660' AS DateTime), CAST(N'2024-06-18T05:04:35.080' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'd9000c0a-fea5-44cb-b06a-78ad01d7d07c', N'hgh', N'Shaligram Infotech', 2, CAST(N'2024-05-23T18:30:00.000' AS DateTime), N'jghj', N'jhjhkhjk', NULL, NULL, 0, 1, CAST(N'2024-05-24T09:48:40.720' AS DateTime), CAST(N'2024-05-24T09:48:53.450' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'80bc1656-651b-4990-9049-82e9c0a9f4d9', N'test', N'main 1', 1, CAST(N'2024-06-25T00:00:00.000' AS DateTime), N'ok', N'ok', NULL, NULL, 0, 1, CAST(N'2024-06-11T05:56:46.100' AS DateTime), CAST(N'2024-06-11T05:57:18.237' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'f8732bfd-45a7-4a22-9188-980eb4b5c1e2', N'hgh', N'Shaligram Infotech', 2, CAST(N'2024-05-23T18:30:00.000' AS DateTime), N'jghj', N'jhjhkhjk', NULL, NULL, 0, 1, CAST(N'2024-05-24T09:48:47.210' AS DateTime), CAST(N'2024-05-24T09:48:55.397' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'4f200cae-1ecd-474d-be5b-9ebad0875700', N'test11', N'test11', 1, CAST(N'2024-06-17T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, CAST(N'2024-06-17T14:07:13.967' AS DateTime), CAST(N'2024-06-17T14:07:46.280' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'9be3b836-4cca-46db-b9b8-a237894217c6', N'gf', N'hfgh', 1, CAST(N'2024-06-17T00:00:00.000' AS DateTime), N'undefined', N'undefined', NULL, NULL, 0, 1, CAST(N'2024-06-17T12:27:14.200' AS DateTime), CAST(N'2024-06-17T12:27:24.370' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'e5287657-57f4-4747-a934-ad7f8b0da0ee', N'gfd', N'fhf', 2, CAST(N'2024-06-29T00:00:00.000' AS DateTime), N'g', NULL, NULL, NULL, 0, 1, CAST(N'2024-06-17T07:01:36.983' AS DateTime), CAST(N'2024-06-17T07:01:47.683' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'1cb9c7ad-06c1-4436-b81f-cc410a658aca', N'ssdg', N'Shaligram Infotech', 2, CAST(N'2024-05-23T18:30:00.000' AS DateTime), N'sd', N'fsdf', NULL, NULL, 0, 1, CAST(N'2024-05-24T09:48:14.447' AS DateTime), CAST(N'2024-05-24T09:48:27.973' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'9fc9d8ff-6734-4e1b-9caf-e204cf5893c8', N'Hemang dholu', N'Test', 1, CAST(N'2024-06-20T00:00:00.000' AS DateTime), N'Test', N'Ok', NULL, NULL, 1, 0, CAST(N'2024-05-27T05:59:05.200' AS DateTime), CAST(N'2024-06-17T06:15:15.040' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'25d9b52c-8ffb-40cf-bd18-e637c237a1be', N'dg', N'dsf', 1, CAST(N'2024-06-18T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, 0, 1, CAST(N'2024-06-18T05:01:41.940' AS DateTime), CAST(N'2024-06-18T05:01:51.423' AS DateTime))
INSERT [dbo].[tbl_Clients] ([ClientId], [ClientName], [FirmName], [PackageTypeId], [ExpireDate], [Address], [Remarks], [HeaderImageLetterPage], [FooterImageLetterPage], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate]) VALUES (N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', N'યશ કોટડીયા', N'યશ પેઢી', 2, CAST(N'2024-06-28T00:00:00.000' AS DateTime), N'જુનાગઢ', N'ટિપ્પણી', NULL, NULL, 0, 1, CAST(N'2024-06-10T09:47:56.543' AS DateTime), CAST(N'2024-06-17T10:50:40.743' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'fb9ba9a4-0ff0-4885-8d35-039c1461f6ae', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', CAST(N'2024-06-05T00:00:00.000' AS DateTime), CAST(500.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-13T06:56:02.967' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'03d595b5-aeeb-4346-a1cf-0b6d073598c3', N'd9068046-1ca7-41af-9df6-f8593db3dd46', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-14T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'વર્ણન', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-10T10:33:49.103' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'443d5a0b-9d98-4065-9529-0baba96e2ae9', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'c27901bc-325d-4f43-8881-7ee9c139aeb9', CAST(N'2024-04-03T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T09:06:11.337' AS DateTime), CAST(N'2024-06-13T09:30:23.023' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a1d75881-fe67-4f4c-b724-24e5d87f564a', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', N'0b66b75a-178c-43c4-9b7a-683b638eb9da', CAST(N'2024-06-13T00:00:00.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'test', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', NULL, CAST(N'2024-06-13T11:15:45.220' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'f1c691ba-3e66-4ffb-822a-312498519e73', N'8a05d16d-1c6b-4e50-8451-e3921b86e382', N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(3000.00 AS Decimal(18, 2)), N'Credit', N'Cheque', N'ફ 001', N'બેંક ઓફ બરોડા', N'નિલેશ પ્રજાપતિ', N'', 1, 0, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', NULL, CAST(N'2024-06-17T10:12:33.193' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'09b4a36b-e143-4d44-ab77-4f9810865478', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'c27901bc-325d-4f43-8881-7ee9c139aeb9', CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T09:03:53.090' AS DateTime), CAST(N'2024-06-13T09:04:09.300' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'fe4b75b3-0091-48b4-ba18-50f3cdfeed34', N'cf8f9e77-42f0-428c-abd2-f89868994b3e', N'79a3d35a-4be6-47c8-b42d-66ba7766ea9b', CAST(N'2024-06-06T00:00:00.000' AS DateTime), CAST(2120.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'test', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-12T13:39:29.357' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'63e2cd54-86aa-4e50-8170-5b57d1388be2', N'8953932b-83a4-4c97-acc5-07fa437db66d', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-06T00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-12T13:44:23.650' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'fab49eb4-ff9b-41a6-849c-65732aa93d97', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', CAST(N'2024-06-13T00:00:00.000' AS DateTime), CAST(56.00 AS Decimal(18, 2)), N'Credit', N'Cheque', NULL, NULL, NULL, N'', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T13:21:27.663' AS DateTime), CAST(N'2024-06-17T13:21:48.113' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'61d294a8-ca0b-4149-926e-6becd0c0ac2b', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', N'79a3d35a-4be6-47c8-b42d-66ba7766ea9b', CAST(N'2024-06-06T00:00:00.000' AS DateTime), CAST(68.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T05:05:08.923' AS DateTime), CAST(N'2024-06-18T05:05:16.847' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'4f2d9ae8-841b-47d0-a214-6cba3bd6c09a', N'9aef7884-90d6-4986-b374-c6e30e714953', N'c27901bc-325d-4f43-8881-7ee9c139aeb9', CAST(N'2021-02-02T00:00:00.000' AS DateTime), CAST(2545.00 AS Decimal(18, 2)), N'Credit', N'UPI', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-12T13:45:00.320' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'934fd0f6-48eb-401b-ba33-863f8a472394', N'8a05d16d-1c6b-4e50-8451-e3921b86e382', N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(2000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'Test', 1, 0, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:09:40.073' AS DateTime), CAST(N'2024-06-17T10:10:06.800' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'380d5226-9041-42fc-91ef-898db26ce87c', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', CAST(N'2024-06-18T00:00:00.000' AS DateTime), CAST(2000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'feec4997-53e4-4269-b74f-5d7dfe551099', NULL, CAST(N'2024-06-17T11:45:11.533' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'2843dfba-41f7-4174-b730-9a072ee7c2e6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'dd665146-c965-417b-b0fb-b11a41809d88', CAST(N'2024-04-03T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T09:05:52.247' AS DateTime), CAST(N'2024-06-13T09:05:58.377' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'224cfa2a-50cb-436f-bd49-9e6a9c4c9018', N'3ac26047-ff73-4ccd-8d82-c92b400b2681', N'dd665146-c965-417b-b0fb-b11a41809d88', CAST(N'2024-06-06T00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-12T13:54:43.897' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'71c2847f-94e3-4ce8-9b44-a17bdcfb3080', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-07T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), N'Credit', N'Cheque', N'1001', N'બેંક ઓફ ઇન્ડિયા', N'test', N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-13T07:03:06.040' AS DateTime), CAST(N'2024-06-17T11:27:04.927' AS DateTime))
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'44e8a3b0-34ff-4657-b5f5-aad75b4388b4', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', N'dd665146-c965-417b-b0fb-b11a41809d88', CAST(N'2024-06-10T00:00:00.000' AS DateTime), CAST(2000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'જય માતાજી', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', NULL, CAST(N'2024-06-10T11:35:37.927' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'd3f16c90-cff3-4261-89e5-c02731502945', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'0b66b75a-178c-43c4-9b7a-683b638eb9da', CAST(N'2024-06-06T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-13T07:02:52.590' AS DateTime), NULL)
INSERT [dbo].[tbl_ContractorFinance] ([ContractorFinanceId], [SiteId], [UserId], [SelectedDate], [Amount], [CreditOrDebit], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'9c236a6d-f16b-4d5c-8440-e8c013c42998', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'c27901bc-325d-4f43-8881-7ee9c139aeb9', CAST(N'2024-04-03T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'Credit', N'Cash', NULL, NULL, NULL, N'', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T09:04:31.770' AS DateTime), CAST(N'2024-06-13T09:05:05.320' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'f4beb855-cc79-4953-9f45-09a95c6357dc', CAST(N'2024-06-18T00:00:00.000' AS DateTime), N'Test Party 18', CAST(92.00 AS Decimal(18, 2)), N'Test', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T06:54:05.277' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T06:56:34.757' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'740c3c9a-11fb-4665-bede-1bf8ed0b00d7', CAST(N'2024-05-28T00:00:00.000' AS DateTime), N'TEST 5', CAST(500.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:47:28.080' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:10:49.707' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'007d49c0-ef86-408f-b831-33d59922d5cd', CAST(N'2024-06-13T00:00:00.000' AS DateTime), N'c', CAST(4.00 AS Decimal(18, 2)), N'zdc', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T14:30:13.227' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:10.817' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'4ff15058-a9eb-4cce-b050-37406b8fd811', CAST(N'2024-06-10T00:00:00.000' AS DateTime), N'estimate', CAST(2500.00 AS Decimal(18, 2)), N'yes', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', CAST(N'2024-06-17T10:40:57.743' AS DateTime), N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', CAST(N'2024-06-17T10:41:17.120' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'95bd4f55-9d03-4fb1-8e14-37f14fd592a1', CAST(N'2024-06-05T00:00:00.000' AS DateTime), N'test', CAST(3.00 AS Decimal(18, 2)), N'wtefrxet', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:34:11.723' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:51:29.100' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6a772d9f-81b5-4f86-b973-48f197d9d12a', CAST(N'2024-06-07T00:00:00.000' AS DateTime), N'tset', CAST(4.00 AS Decimal(18, 2)), N'dc', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T04:58:14.617' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:06:46.300' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'eea6e0e4-e874-4b21-a29e-52bd40ed63b7', CAST(N'2024-05-09T00:00:00.000' AS DateTime), N'ટેસ્ટ 9', CAST(900.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:52:11.967' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'52f0f9df-699c-4d62-8ccd-596c21660aec', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'Estimate 1', CAST(0.00 AS Decimal(18, 2)), N'remarks', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T12:32:40.547' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T12:35:29.537' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'624bcd74-a65d-4c43-8d32-6b71eea35be4', CAST(N'2024-06-09T00:00:00.000' AS DateTime), N'TEST 2', CAST(200.00 AS Decimal(18, 2)), N'undefined', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:46:48.487' AS DateTime), N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', CAST(N'2024-06-17T11:37:22.370' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'4f313ae4-1de3-4690-a473-74b33c12cc3e', CAST(N'2024-06-15T00:00:00.000' AS DateTime), N'tsetc', CAST(6.00 AS Decimal(18, 2)), N'', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:14:12.047' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:08.143' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'212d5281-d1b3-4a26-a464-756556cb23ed', CAST(N'2024-06-07T00:00:00.000' AS DateTime), N'tset', CAST(16.00 AS Decimal(18, 2)), N'dc', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:04:01.550' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:06:44.063' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'eeacbedd-ea0f-4081-b91d-78d544a12daf', CAST(N'2024-05-21T00:00:00.000' AS DateTime), N'fv', CAST(12.00 AS Decimal(18, 2)), N'', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, 1, 0, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:33:35.477' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:11:21.620' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6fa2a566-dba5-4a06-a29e-9021ebb0d3b1', CAST(N'2024-05-02T00:00:00.000' AS DateTime), N'ટેસ્ટ 10', CAST(1000.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:52:38.657' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T10:14:10.800' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'cb945d32-3891-415a-a111-93c4b75c03ea', CAST(N'2024-05-17T00:00:00.000' AS DateTime), N'TEST 7', CAST(700.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:48:08.970' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:33.933' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'41402958-c268-495e-96eb-a54b6d7332aa', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'tset', CAST(52.00 AS Decimal(18, 2)), N'estet', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T14:01:31.607' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:13.147' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'56c88b7c-dd19-4c3d-bc98-aa5d5fae4867', CAST(N'2024-05-03T00:00:00.000' AS DateTime), N'p1', CAST(7.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, 1, 0, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T05:29:23.863' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:48.523' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'9546b4da-0229-4fea-9e92-ac51c918c1a8', CAST(N'2024-06-12T00:00:00.000' AS DateTime), N'Test', CAST(0.00 AS Decimal(18, 2)), N'test', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:19:31.110' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:32:09.890' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'63e769d3-b369-49be-a299-af7c16bc2715', CAST(N'2024-06-07T00:00:00.000' AS DateTime), N'fdg', CAST(221.00 AS Decimal(18, 2)), N'yt', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T10:20:19.213' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T10:20:29.447' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'03451cf3-f821-4b15-b8a7-b065c3971f6c', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'Estimate 1', CAST(0.00 AS Decimal(18, 2)), N'remarks', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T12:55:42.637' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:18:34.993' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'f4d254a2-a119-4e7b-9265-bf1521993cc0', CAST(N'2024-06-01T00:00:00.000' AS DateTime), N'TEST 4', CAST(400.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:47:17.253' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:10:08.373' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'7f75256e-aa4d-4c39-9585-c6d47af3c538', CAST(N'2024-06-11T00:00:00.000' AS DateTime), N'Estimate 1', CAST(0.00 AS Decimal(18, 2)), N'remarks', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, 1, N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T09:51:20.447' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T13:18:38.870' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3a941d56-3f90-4b3a-8e0b-c88b97c6b9da', CAST(N'2024-06-12T00:00:00.000' AS DateTime), N'TEST 1', CAST(100.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:46:36.457' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:10:35.333' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'f29e6a3b-0e2c-42f1-b608-e1aa695cf639', CAST(N'2024-06-05T00:00:00.000' AS DateTime), N'ટેસ્ટ 3', CAST(300.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:46:59.550' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:10:21.443' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e33d6ae4-b3b0-48f9-a23d-e9c8e8819f1d', CAST(N'2024-05-22T00:00:00.000' AS DateTime), N'ટેસ્ટ 6', CAST(600.00 AS Decimal(18, 2)), N'undefined', 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:47:41.970' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:55.183' AS DateTime))
INSERT [dbo].[tbl_Estimate] ([EstimateId], [EstimateDate], [PartyName], [TotalAmount], [Remarks], [FileTypeId], [ClientId], [EstimateType], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3de0551a-b31b-4862-8e87-efa691462a3d', CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'TEST 8', CAST(800.00 AS Decimal(18, 2)), NULL, 6, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T09:51:03.280' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:09:26.597' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_EstimateItem] ON 

INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'1e941afc-7154-4218-a2fa-00d2fc0fec0a', N'28395288-7566-4e6c-9502-9bb647641a6b', N'rere', CAST(3.00 AS Decimal(18, 2)), 3, CAST(1.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2024-06-11T06:37:04.043' AS DateTime), 1)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'f2e84669-871f-4447-ab0f-07bc259710cf', N'74f69e56-c726-4b13-9b6b-e783db46e02d', N'test 2', CAST(5.00 AS Decimal(18, 2)), 5, CAST(12.00 AS Decimal(18, 2)), CAST(180.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:06:03.627' AS DateTime), 10030)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'e7383d59-3d38-4898-b474-0ec2cfda8d9c', N'eeacbedd-ea0f-4081-b91d-78d544a12daf', N'ewe', CAST(2.00 AS Decimal(18, 2)), 2, CAST(2.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:11:21.623' AS DateTime), 10053)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'ecbb9bae-a887-4b3d-b7a8-2046f9a67c50', N'f4beb855-cc79-4953-9f45-09a95c6357dc', N'Item 1.4', CAST(1.00 AS Decimal(18, 2)), 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:56:32.127' AS DateTime), 10078)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'43a09e39-498e-4764-b81c-22bf6a4bdb20', N'a04229d7-eb10-43e4-a375-22ab2652eaa0', N'item 01 ', CAST(9.00 AS Decimal(18, 2)), 9, CAST(9.00 AS Decimal(18, 2)), CAST(27.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:17:21.093' AS DateTime), 6)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'a745f940-0102-493f-adbe-29099c26a49b', N'ac19e2d4-5a8b-48cb-9aad-c5600a215eb7', N'item - 1', CAST(4.00 AS Decimal(18, 2)), 4, CAST(7.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-11T09:52:28.980' AS DateTime), 11)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'6e159cbf-1f84-4352-a169-2e09829770c8', N'9ea8172d-9a9c-4ccf-a597-caa0f64ffdf8', N'Item added', CAST(9.00 AS Decimal(18, 2)), 9, CAST(9.00 AS Decimal(18, 2)), CAST(729.00 AS Decimal(18, 2)), CAST(N'2024-06-12T08:21:49.090' AS DateTime), 17)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'1cc4320e-80db-4bbf-8174-3b6026dc2bcb', N'9ea8172d-9a9c-4ccf-a597-caa0f64ffdf8', N'4', CAST(4.00 AS Decimal(18, 2)), 4, CAST(4.00 AS Decimal(18, 2)), CAST(64.00 AS Decimal(18, 2)), CAST(N'2024-06-12T08:21:49.090' AS DateTime), 18)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'b60e44c3-1944-4f3a-8bd5-45abbd6b6ec9', N'22223f13-f342-49a4-b823-57477bea357e', N'asdf11111', CAST(3.00 AS Decimal(18, 2)), 3, CAST(3.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2024-06-11T06:40:52.653' AS DateTime), 3)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'7b0746e7-8c11-4b5d-8405-4b92839d129a', N'18bf83ad-6edf-492a-aa7c-a6fc281d0b5a', N'it23', CAST(2.00 AS Decimal(18, 2)), 2, CAST(4.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:18:06.990' AS DateTime), 10032)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'd51e36b6-0946-4a69-9db2-507a81c518a5', N'457c2c33-f255-446b-aac1-e890c423afe1', N't34', CAST(3.00 AS Decimal(18, 2)), 3, CAST(2.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:18:06.990' AS DateTime), 10033)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'74457c57-2099-4ad6-9e50-55e9d2aeeac8', N'9e7c689e-4c86-49f2-9e49-7bd0f289c3c1', N'i1 ', CAST(7.00 AS Decimal(18, 2)), 7, CAST(7.00 AS Decimal(18, 2)), CAST(21.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:21:25.813' AS DateTime), 8)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'adab98bc-c29c-49e7-801b-58cc99af920a', N'15c84b9f-363c-4e57-b376-ee1e98637822', N'test 1', CAST(2.00 AS Decimal(18, 2)), 2, CAST(4.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:02:49.453' AS DateTime), 10027)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'4cf1b819-bbb2-4987-b298-5fd92adba69b', N'8126742a-107f-4b70-ab25-30da26d9cd9e', N'it4', CAST(4.00 AS Decimal(18, 2)), 4, CAST(2.00 AS Decimal(18, 2)), CAST(32.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:30:01.843' AS DateTime), 10035)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'80d1b60b-4f9e-4e64-bdb9-60bb45d05f8c', N'7917821a-dad8-4387-a583-cc64f400dabc', N'test 1', CAST(2.00 AS Decimal(18, 2)), 2, CAST(4.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:02:01.750' AS DateTime), 10026)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'14563f4f-77ea-40ef-bbf0-712d393c91c5', N'536a3272-5ff3-46ec-8829-44ba7d4c49ac', N'asdf', CAST(3.00 AS Decimal(18, 2)), 3, CAST(3.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2024-06-11T06:39:46.963' AS DateTime), 2)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'99e82e5f-3592-4cda-abb7-73b7c0873773', N'eeacbedd-ea0f-4081-b91d-78d544a12daf', N'xc c', CAST(6.00 AS Decimal(18, 2)), 6, CAST(5.00 AS Decimal(18, 2)), CAST(180.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:11:21.623' AS DateTime), 10051)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'2711ec94-0d9a-49f8-832b-766b17019979', N'eeacbedd-ea0f-4081-b91d-78d544a12daf', N'cvg', CAST(4.00 AS Decimal(18, 2)), 4, CAST(5.00 AS Decimal(18, 2)), CAST(80.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:11:21.623' AS DateTime), 10052)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'b1f179e2-e4ed-4fc1-aac0-938dcf26ef29', N'a04229d7-eb10-43e4-a375-22ab2652eaa0', N'item 02', CAST(3.00 AS Decimal(18, 2)), 3, CAST(4.00 AS Decimal(18, 2)), CAST(11.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:17:21.093' AS DateTime), 7)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'3fd7b8fd-b78d-47fb-b01d-9de48278d5c3', N'c4b8658f-17a4-440a-b395-c1a1d64b7cb8', N'erw', CAST(3.00 AS Decimal(18, 2)), 3, CAST(8.00 AS Decimal(18, 2)), CAST(39.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:00:44.900' AS DateTime), 4)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'ab2fa641-4790-459b-8ba0-b2b2793247d8', N'8a4f1c90-af3c-493a-a30d-40cfd0bbccf1', N'wer', CAST(7.00 AS Decimal(18, 2)), 7, CAST(7.00 AS Decimal(18, 2)), CAST(21.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:05:03.773' AS DateTime), 5)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'cfeb94c3-598a-4e74-b689-b4fb7f395aa8', N'f4beb855-cc79-4953-9f45-09a95c6357dc', N'item 1.2', CAST(3.00 AS Decimal(18, 2)), 3, CAST(3.00 AS Decimal(18, 2)), CAST(27.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:56:32.127' AS DateTime), 10076)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'4a75702e-30f4-43e2-b9de-b7cc60cf54f1', N'9e7c689e-4c86-49f2-9e49-7bd0f289c3c1', N'i3', CAST(5.00 AS Decimal(18, 2)), 5, CAST(5.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:21:25.813' AS DateTime), 10)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'39ca1d3e-5c8b-4bec-847e-b82d55b72682', N'225817c6-3c17-4f35-a977-8246e183b67a', N'sdfsd', CAST(3.00 AS Decimal(18, 2)), 3, CAST(3.00 AS Decimal(18, 2)), CAST(27.00 AS Decimal(18, 2)), CAST(N'2024-06-12T06:08:56.373' AS DateTime), 15)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'43d742ae-0eea-4408-9704-c3dfa7ec9e0e', N'10536752-75d0-4b23-8b67-9d047174343d', N'it5', CAST(6.00 AS Decimal(18, 2)), 6, CAST(5.00 AS Decimal(18, 2)), CAST(150.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:30:01.843' AS DateTime), 10036)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'dc84ec5a-2019-4dd9-a04e-c7737165e41e', N'ac19e2d4-5a8b-48cb-9aad-c5600a215eb7', N'item - 2', CAST(3.00 AS Decimal(18, 2)), 3, CAST(8.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-11T09:52:28.980' AS DateTime), 12)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'633962c1-e973-482d-a22d-d5b7831e58d4', N'97141e24-779f-4cfb-bf9d-9f8485a787ad', N'test 1', CAST(2.00 AS Decimal(18, 2)), 2, CAST(4.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-18T05:06:03.627' AS DateTime), 10029)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'abec3fb6-ab17-460e-ba78-e6903df3ff72', N'225817c6-3c17-4f35-a977-8246e183b67a', N'SADFSAFD', CAST(66.00 AS Decimal(18, 2)), 66, CAST(6.00 AS Decimal(18, 2)), CAST(2376.00 AS Decimal(18, 2)), CAST(N'2024-06-12T06:08:56.373' AS DateTime), 16)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'a547241d-ece1-4735-8d7e-e8910339a410', N'9ed1e50c-3278-45a4-8862-e63bba820748', N'ite', CAST(3.00 AS Decimal(18, 2)), 3, CAST(32.00 AS Decimal(18, 2)), CAST(288.00 AS Decimal(18, 2)), CAST(N'2024-06-12T06:02:40.937' AS DateTime), 14)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'3c894c03-ab40-4bbf-9d18-eb0674b10426', N'1013b0ce-d93d-42ae-b0e5-969d0c674709', N'xc', CAST(2.00 AS Decimal(18, 2)), 2, CAST(4.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(N'2024-06-17T14:32:49.397' AS DateTime), 10024)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'a18600c9-f676-4333-b107-f1eb044b7b8c', N'9e7c689e-4c86-49f2-9e49-7bd0f289c3c1', N'i2', CAST(8.00 AS Decimal(18, 2)), 8, CAST(8.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), CAST(N'2024-06-11T07:21:25.813' AS DateTime), 9)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'654368fa-48a0-42ed-80af-f2120d403308', N'ac19e2d4-5a8b-48cb-9aad-c5600a215eb7', N'item-3', CAST(2.00 AS Decimal(18, 2)), 2, CAST(2.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(N'2024-06-11T09:52:28.980' AS DateTime), 13)
INSERT [dbo].[tbl_EstimateItem] ([EstimateItemId], [EstimateId], [ItemName], [Nos], [Qty], [Rate], [TotalAmount], [CreatedDate], [SeqNo]) VALUES (N'bc06976a-3a3f-436a-a4a4-f61d2116569d', N'f4beb855-cc79-4953-9f45-09a95c6357dc', N'item 1.3', CAST(4.00 AS Decimal(18, 2)), 4, CAST(4.00 AS Decimal(18, 2)), CAST(64.00 AS Decimal(18, 2)), CAST(N'2024-06-18T06:56:32.127' AS DateTime), 10077)
SET IDENTITY_INSERT [dbo].[tbl_EstimateItem] OFF
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'84b39dd9-53d5-4dfd-9c2f-062631e7712c', CAST(N'2024-06-01T00:00:00.000' AS DateTime), 3, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(1000.00 AS Decimal(18, 2)), N'ઇન્ટરનેટ અને ફોન બિલ', N'00000000-0000-0000-0000-000000000000', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:23:20.827' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:26:25.937' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6fd4580e-d41c-403a-8443-0e406b58dce1', CAST(N'2024-06-17T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), N'undefined', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:27:41.853' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:28:48.343' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'99bc82c3-0ed0-4810-b43e-2b67ecf1bee6', CAST(N'2024-06-17T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), NULL, N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:29:26.480' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:29:35.930' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3a54c7bf-2644-4b69-969f-4224b4422619', CAST(N'2024-05-30T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(5000.00 AS Decimal(18, 2)), N'વકાલત સેવાઓ', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:25:48.613' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:24:16.503' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'04d05f60-b311-418e-bbb0-4a2b2d84b55a', CAST(N'2024-05-20T00:00:00.000' AS DateTime), 3, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(500.00 AS Decimal(18, 2)), N'Taxi fare for business travel', NULL, 0, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:19:25.080' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:39:14.840' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'0e25c0f0-0d8b-48cb-abd7-54200fde2921', CAST(N'2024-05-10T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(2000.00 AS Decimal(18, 2)), N'Office supplies purchase', N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:17:40.307' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T09:35:06.420' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'c715c85a-2f68-4367-89a0-66e6645c42b5', CAST(N'2024-06-08T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), NULL, N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:21:44.550' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:23:12.580' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'c529f035-dbb2-41ba-b9c8-7665e128c430', CAST(N'2024-06-08T00:00:00.000' AS DateTime), 1, N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', CAST(1000.00 AS Decimal(18, 2)), N'વસ્તુનું વર્ણન', N'd9068046-1ca7-41af-9df6-f8593db3dd46', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-10T10:39:29.580' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'cb0d214d-3493-4bbf-997d-7a855e1336d9', CAST(N'2024-06-17T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), N'test', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:23:33.077' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:25:52.000' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'9abc4dd5-9153-48e9-bf68-8741b87502ea', CAST(N'2024-06-07T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), NULL, N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:23:47.660' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:23:51.097' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'85048bd1-c1db-459b-9ff5-8f5596595aed', CAST(N'2024-06-07T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), NULL, N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:23:25.287' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:23:35.043' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'edcc079d-ed74-4059-8dc2-9c9728d754a8', CAST(N'2024-06-16T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(100.00 AS Decimal(18, 2)), N'test', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:25:59.760' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:26:18.710' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'854e1e77-64b8-4604-808a-a7d19a95918e', CAST(N'2024-05-09T00:00:00.000' AS DateTime), 2, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(1000.00 AS Decimal(18, 2)), N'Light Bill', NULL, 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:15:57.533' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'833ddb23-9320-4221-9530-b12d845b80ec', CAST(N'2024-05-13T00:00:00.000' AS DateTime), 3, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(3500.00 AS Decimal(18, 2)), N'Travel expenses for client meeting', N'00000000-0000-0000-0000-000000000000', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:18:34.653' AS DateTime), N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:21:09.380' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'1254ee6b-2f10-471b-b6dd-bc4556ef646c', CAST(N'2024-06-03T00:00:00.000' AS DateTime), 2, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(1000.00 AS Decimal(18, 2)), N'સ્થળાંતર વ્યય', NULL, 0, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:26:59.087' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:38:20.047' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e786e720-80df-40c0-aafc-d2ba82012534', CAST(N'2024-05-15T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(3000.00 AS Decimal(18, 2)), N'Consultancy fees', N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:19:09.103' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:24:29.267' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e1fde3e8-357c-4593-ae71-e139a4b1736c', CAST(N'2024-05-23T00:00:00.000' AS DateTime), 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(10000.00 AS Decimal(18, 2)), N'Promotional event expenses', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:24:54.267' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:24:22.843' AS DateTime))
INSERT [dbo].[tbl_Expenses] ([ExpenseId], [ExpenseDate], [ExpenseTypeId], [ClientId], [Amount], [Description], [SiteId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'90f50419-ec7f-4dcb-a598-fece908dc0af', CAST(N'2024-05-23T00:00:00.000' AS DateTime), 3, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(20000.00 AS Decimal(18, 2)), N'કમ્પ્યુટર હાર્ડવેરની ખરીદી', NULL, 0, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T08:23:40.203' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T09:39:04.687' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_ExpenseType] ON 

INSERT [dbo].[tbl_ExpenseType] ([ExpenseTypeId], [ExpenseType]) VALUES (1, N'Site')
INSERT [dbo].[tbl_ExpenseType] ([ExpenseTypeId], [ExpenseType]) VALUES (2, N'Home')
INSERT [dbo].[tbl_ExpenseType] ([ExpenseTypeId], [ExpenseType]) VALUES (3, N'Personal')
SET IDENTITY_INSERT [dbo].[tbl_ExpenseType] OFF
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (1, N'Credit')
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (2, N'Debit')
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (3, N'Material')
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (4, N'Expense')
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (5, N'Challan')
INSERT [dbo].[tbl_FileCategory] ([FileCategoryId], [FileCategoryName]) VALUES (6, N'Estimate')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'263f92e3-1dea-4b01-b841-07effd1a5352', N'e786e720-80df-40c0-aafc-d2ba82012534', 4, N'MOU_IOD.pdf', N'e546b329-9536-4019-a1ce-0ca9049303ed.pdf')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'33c6682b-0097-47c7-a680-14d61885c687', N'3a941d56-3f90-4b3a-8e0b-c88b97c6b9da', 6, N'Default.png', N'87cde5ff-3ad0-451f-9653-bf49926bc3ea.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'162d1203-1eec-4aa7-bb56-17b4a096edfe', N'cd48c42d-e95d-4e45-894e-d63e308d0f12', 2, N'1.png', N'6c23158a-ef72-4dbf-8679-972eb009ef2b.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'e8531b82-815c-4fb6-a3c8-1ea366b46793', N'833ddb23-9320-4221-9530-b12d845b80ec', 4, N'images.jpg', N'ce7ceeed-f2ce-47d0-93b6-695d10d86a8c.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'c50e0cf6-e11d-466c-869c-2435d6fc9db0', N'1d041e66-55ba-450f-bf5e-e758db264ba1', 2, N'download.png', N'2ac728c4-593f-4e6a-a8e9-5fb5eac2d097.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'4b37e1ec-04f8-4e4d-b272-2797d2a08db6', N'c715c85a-2f68-4367-89a0-66e6645c42b5', 4, N'4.png', N'0172a062-0df2-4976-ac1d-bf9ff004f862.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'8d242414-1302-4357-80be-2eeb005b4cee', N'5c84d8e4-2828-4e1f-9d29-1631a5a03c0f', 2, N'dashimage.png', N'7bf20ded-8d80-4f2d-b702-1c0dbee11b25.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'ef0774fb-612c-4fdc-b637-302f214e5225', N'f9ff40a4-241d-43c2-a050-34c93d1c45ec', 6, N'Screenshot (1).png', N'91192964-e37c-438b-a3ee-bd094529bb68.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'ba1b0f11-938a-4c48-b610-39226ddb5024', N'feab4778-4bb1-4ef3-9037-ec7785dc9855', 2, N'4.png', N'04e31958-bc32-4e85-833c-ca6f6d89b9a6.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'99225210-0eef-4e53-8ea6-3d1dfb47c30c', N'cb0d214d-3493-4bbf-997d-7a855e1336d9', 4, N'4.png', N'3e6347fb-b6ba-4c7c-9402-714e77bc6322.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'3c4ecd21-8828-4717-b474-40d5161dac79', N'080e1467-4dbf-4e5b-a082-8769800539d8', 2, N'4.png', N'50b99c93-185e-4f23-adb0-35efc95ca3fa.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'e9f90fac-cfee-4bd6-9867-42b83ac43e75', N'740c3c9a-11fb-4665-bede-1bf8ed0b00d7', 6, N'054c7416-e695-4bbd-ab8e-2f12a520d17c.jpeg', N'9d998cb1-446c-4517-944d-f2a71e5d0ffd.jpeg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'f31d793d-e0a4-4940-8533-456adff4afe0', N'624bcd74-a65d-4c43-8d32-6b71eea35be4', 6, N'Tesitng_Demo_Bugs.txt', N'2bd92621-e0b1-4f6e-99ad-28a1e5b08c28.txt')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'7b51f413-f87d-455a-8d7a-45f75a308fc1', N'f4d254a2-a119-4e7b-9265-bf1521993cc0', 6, N'bridge_e3022928-953d-448a-9fae-b92c76a243d9.jpeg', N'9cd7c1c8-bde9-4f2f-9052-7f92702b96d9.jpeg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'ba585433-3734-4e03-bd19-48d7deb2a143', N'e352b92d-ad22-4aba-8775-add7641d2eb6', 2, N'light-green-bg.png', N'2d9597e3-7590-4bb4-b981-b6a0f8b5cc35.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'5c2e9f1a-4120-451d-bca8-4a4b013ef4f3', N'85048bd1-c1db-459b-9ff5-8f5596595aed', 4, N'3.jfif', N'5de1c81b-dd96-4bcb-982a-2a9222f0f9a6.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'5b325850-2945-4f38-8c92-62ce28107b5b', N'0c220660-0113-4dd9-b4c2-241c656cd833', 2, N'3.jfif', N'af217198-df5b-44ee-b5ca-4cc4ac1196e1.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'a1e328ea-4705-4214-bd55-641a7e86f9da', N'03bd1721-1531-44b0-a074-525a1c4a501d', 2, N'3.jfif', N'9d346ebd-fff2-4054-bca0-7111250448fc.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'628975d4-99b4-4624-93aa-6490318cadc7', N'56c88b7c-dd19-4c3d-bc98-aa5d5fae4867', 6, N'IMG_0747_07fab184-5ca0-4c66-907f-36041e4593af.jpeg', N'2d74409e-abc3-4ad1-8e4c-dec29845fcf8.jpeg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'0e1c386c-7527-4531-bf45-6876e71bed01', N'2c0f9caa-da0b-45c3-84d1-51f4c2a49203', 6, N'pexels-photo-1308881.jpeg', N'8a62d916-0015-4729-aa86-77547411ac54.jpeg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'9d9d364a-ef1f-4a23-bf73-6e2e63ee7b0a', N'a75570cc-bbff-4ade-ae5a-e9ec77a9dcc2', 2, N'dashimage.png', N'7353d8d3-b996-4a78-8ca3-f9db73da517d.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'615c18c1-82cc-45b4-a67a-793c0768b5d4', N'2ef2cfeb-7574-486f-8a37-25f6db125835', 2, N'2.png', N'f0fd42ec-e0d2-4260-8888-ec4c26631255.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'b5cf4eef-cbed-4608-9e7a-8be7e83e469f', N'eea6e0e4-e874-4b21-a29e-52bd40ed63b7', 6, N'3.jfif', N'd5b24c13-3e54-4774-b7ac-6529fec8e25b.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'e5e07cad-b394-49d1-a9fe-98d0acad5415', N'8c8634c0-34f9-442d-8427-740eea7919d9', 6, N'Screenshot (1).png', N'17259e6b-8957-458d-81fc-5f32cd0357af.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'9b889019-9ff8-4cc5-94f1-9f3765dd8129', N'9abc4dd5-9153-48e9-bf68-8741b87502ea', 4, N'4.png', N'a1396a25-9cf1-4832-b5eb-cb844f19d69f.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'9e4c667a-73c2-4ffa-985c-a0abcfb5c621', N'4ff15058-a9eb-4cce-b050-37406b8fd811', 6, N'Tesitng_Demo_Bugs.txt', N'c7dc5e41-d67a-430a-9dac-e940fd4ccf5b.txt')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'b5b912f6-1fd7-4d7c-bbee-a510dc4ea3d5', N'85a21963-e49b-4503-b959-6b6ac7d0656d', 2, N'2.png', N'030de636-98a0-4870-a99b-0a3718ee9644.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'4a8c1720-2588-415a-ad73-b16a5565177f', N'2b97e8d4-9d92-4bf5-8411-bd6bf3b48c24', 2, N'3.jfif', N'738dd6d2-cee4-4731-a094-bc9cdb0bc374.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'a4e3925e-e8ce-4b08-827e-b1842d939b9a', N'63e769d3-b369-49be-a299-af7c16bc2715', 6, N'4.png', N'ad8d4db9-05f4-449f-9e77-72b31c10c695.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'ef23cdef-31a2-4754-bbf6-bac5d3b15f4f', N'6fa2a566-dba5-4a06-a29e-9021ebb0d3b1', 6, N'3.jfif', N'717310cb-b0fd-4ee7-9251-8a7f598d7b8e.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'3be84d4a-4669-46c6-baf0-bdcb16930b99', N'e33d6ae4-b3b0-48f9-a23d-e9c8e8819f1d', 6, N'wallpaperflare.com_wallpaper (1)_45cacb5c-3608-47c6-a826-05f9ec489e8f.jpg', N'af894162-2fc8-43cb-8404-3609727bb4bf.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'19f553ae-f854-40b1-a916-c578be480cde', N'cb945d32-3891-415a-a111-93c4b75c03ea', 6, N'moon_105860ed-da62-4e1c-a2a1-e3de8f94edde.jpg', N'b76f745c-3e27-4918-83b9-1a77d569812a.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'a6b6795a-3f03-4203-9a39-cc188c9c1f53', N'3de0551a-b31b-4862-8e87-efa691462a3d', 6, N'13648_3e8b7f15-35d4-4fd9-a671-8f773d7245e1.jpg', N'bd1602e4-9a14-478e-8790-8a196fb6b0d1.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'4b238371-c68a-4f00-b481-d3c6e86aa6c4', N'239b32be-0e2b-4f69-8d24-a2d73370ea36', 5, N'1.webp', N'6e0da42e-645e-4d8b-8579-c2307195e315.webp')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'd548ea69-ef88-4c28-b67e-d3f3d3177184', N'0391cd6c-c52f-44ca-827a-972b601922b6', 2, N'DB_Script.sql', N'f53c602d-e60b-4a18-9cbc-d7971c84a393.sql')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'6ddb896d-d87a-4e7d-bee0-d9805d5eecd3', N'7f4627c7-de88-4384-af79-9e067b694d6f', 6, N'1.png', N'6c23158a-ef72-4dbf-8679-972eb009ef2b.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'265c2fd8-1384-413e-ac53-da42a0850955', N'f29e6a3b-0e2c-42f1-b608-e1aa695cf639', 6, N'03fig04_7aee2502-fca7-4660-bc72-a9370ca86281 (1).jpg', N'59b1b79a-d9b4-4aec-a803-1e8c0ef3ad30.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'18c9ac04-75e0-49b0-b543-e32121462eb4', N'17a873d2-4d6a-40ae-826f-0753bf5f33da', 5, N'3.jfif', N'27e7d739-cb5d-4dc5-a145-fd6bdc6d9bf6.jfif')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'0397eafd-ee85-49da-9a33-e4ab8a492f62', N'4f4ef4d3-84f8-45e1-b421-60d244a80fc2', 2, N'light-green-bg.png', N'034e8da1-3106-4346-8e56-559d0d638406.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'73afa2fa-711f-433e-933c-e700297d0773', N'c79390d6-dad1-4cba-8ed1-a497b1764ea3', 5, N'2.jpg', N'7c179262-cbad-42d2-9f24-aecca737a283.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'dfbaab9e-ed78-4b49-8f33-ec75a0ac33a4', N'b24c773d-fe69-4262-b66a-3a137cbb15c4', 2, N'logo-removebg-preview.png', N'd84dae1a-0273-4bad-b968-7de705e60d41.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'e73a0bdb-a961-4fb7-b695-f3101dfa8be1', N'32ea5109-605a-45ab-a71b-56fb88cac503', 2, N'YASH BHANUBHAI KOTADIYA_JFFPK9453G_AY202425_16_SIGNED.pdf', N'3f56f054-a36d-47f0-8178-f3cdc8f84c21.pdf')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'389f43c3-1233-4bf6-8378-f4ef6dea7e4c', N'6f19c6af-f690-4266-afda-cca4ba234004', 5, N'1.png', N'59b69b12-4be9-4b75-b149-2020846311b4.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'1d1bf773-d422-42bb-810c-f503486c5291', N'a3ca6f9a-ef22-4ba5-87ac-26729699b2cd', 2, N'dashimage.png', N'2fad44a2-506b-4626-b4f0-ed0a0dad3b83.png')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'd4186b76-7936-4044-8053-f82bffe7102b', N'6b493b4d-3860-4e90-8b0f-28e1aa1098ed', 2, N'Gift Hamper.jpg', N'7a588d91-e633-4b2b-92b6-eff467e37805.jpg')
INSERT [dbo].[tbl_Files] ([FileId], [ParentId], [FileCategory], [OriginalFileName], [EncryptFileName]) VALUES (N'029a1a0e-9b5f-43d5-8c5e-fc20faa4bfe7', N'e5d2f5d6-3670-4c6e-9754-77179b6ee294', 2, N'download.jpg', N'c8e860d8-c834-4d18-8d85-5b077fa581af.jpg')
INSERT [dbo].[tbl_Finance] ([FinanceId], [PersonId], [SelectedDate], [Amount], [SiteId], [CreditOrDebit], [GivenAmountBy], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'9990d510-1eba-4aad-ab8b-2607f911c895', N'22e4923f-96b7-4d56-8bac-42429b77b8cb', CAST(N'2024-06-13T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), NULL, N'Credit', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', N'Cash', NULL, NULL, NULL, N'ok', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T10:15:52.193' AS DateTime), CAST(N'2024-06-13T12:06:44.450' AS DateTime))
INSERT [dbo].[tbl_Finance] ([FinanceId], [PersonId], [SelectedDate], [Amount], [SiteId], [CreditOrDebit], [GivenAmountBy], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'b8e491a5-f8da-43d1-8bbe-4f4c3f37a3ae', N'22e4923f-96b7-4d56-8bac-42429b77b8cb', CAST(N'2024-06-14T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), NULL, N'Credit', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'Cash', NULL, NULL, NULL, N'ok', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T11:48:45.687' AS DateTime), CAST(N'2024-06-13T12:06:59.207' AS DateTime))
INSERT [dbo].[tbl_Finance] ([FinanceId], [PersonId], [SelectedDate], [Amount], [SiteId], [CreditOrDebit], [GivenAmountBy], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'c5d491cb-dc24-4464-9d99-c81aa8131373', N'22e4923f-96b7-4d56-8bac-42429b77b8cb', CAST(N'2024-06-05T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), NULL, N'Credit', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', N'Cash', NULL, NULL, NULL, N'', 1, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:07:17.717' AS DateTime), CAST(N'2024-06-13T12:28:06.780' AS DateTime))
INSERT [dbo].[tbl_Finance] ([FinanceId], [PersonId], [SelectedDate], [Amount], [SiteId], [CreditOrDebit], [GivenAmountBy], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'31be35b5-8d94-4be5-964f-ef64d0e2f242', N'fd246aea-1fed-442e-8cd5-096988f754b5', CAST(N'2024-06-08T00:00:00.000' AS DateTime), CAST(321.00 AS Decimal(18, 2)), NULL, N'Credit', N'3cc87490-eed4-4687-b3c6-735c3b4feb57', N'UPI', NULL, NULL, NULL, N'', 1, 0, N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', NULL, CAST(N'2024-06-17T11:23:47.070' AS DateTime), NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'd7fe63b0-b6cf-4646-9d2b-07e6c08f0c0b', N'વિજય કુમાર', N'કુમાર ટ્રેડિંગ કંપની', N'9876543212', N'789 ઓક સ્ટ્રીટ', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'893767cc-3d31-4ae6-bbf1-3f58fe3389a3', CAST(N'2024-06-12T06:55:01.050' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'c50a97f6-5d81-46a9-8d74-1d3dd1e95eaa', N'Manoj Patel', N'Patel Agro Products', N'9876543224', N'1212 Walnut Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'1156441b-73e6-440f-81c0-804000af00b0', CAST(N'2024-06-12T06:55:59.017' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'8f426af2-a24c-4d70-af19-3ca8b35d9aae', N'Rajesh Patel', N'Patel Enterprises', N'9876543210', N'123 Main Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'9b98ace7-4fd2-4460-bccb-dcc835dd6be7', CAST(N'2024-06-12T06:54:37.113' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'b9f406b7-2e14-4daa-a446-4ee81c7daeed', N'સંજય ગુપ્તા', N'ગુપ્તા ફેશન હાઉસ', N'9876543214', N'202 મેપલ સ્ટ્રીટ', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'9969d266-e474-4039-b2d8-a77f3340f1de', CAST(N'2024-06-12T06:56:40.273' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'd846b772-76d8-44e6-ace7-6053f5c32042', N'પરીક્ષણ વેપારી નામ', N'પરીક્ષણ નામ', N'9876543241', N'અમદાવાદ', N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', 1, 0, N'1c674415-3226-4de6-a786-bc4e630be6ae', CAST(N'2024-06-10T10:45:56.480' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'163ae566-067a-4ba6-8fb8-60df368df0bf', N'Chirag', N'Phoenix Firm', N'9876543210', N'Shaligram', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'b08fea6f-bd24-4b09-be2f-bce87f662ac7', CAST(N'2024-06-11T05:26:19.350' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e90218f2-e93d-425f-9e40-6c1a0224fe58', N'Vikram Singh', N'Singh Furniture', N'9876543228', N'1616 Cedar Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'b201c953-05c5-4f95-9aa0-01e1928ee9a2', CAST(N'2024-06-12T06:55:19.160' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'76b251eb-25a2-4eab-acf2-78d16fb98d8c', N'Merchant 1', N'Firm 1', N'9823467834', N'Surat', N'3d295037-5f64-4265-b934-137e2bf78e7b', 1, 0, N'93cd9e35-aaaa-4f1d-9e99-2afc411cd62f', CAST(N'2024-06-17T10:38:56.480' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'ad0653c9-09be-4178-a1d6-831e9f602e50', N'Vijay Kumar', N'Kumar Trading Co.', N'9876543212', N'789 Oak Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'01fab9e5-0fa6-454f-9501-bb396d550502', CAST(N'2024-06-12T06:58:07.043' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T05:14:35.090' AS DateTime))
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'e0d390c7-854d-4bec-9e4c-8607c785a46a', N'Rakesh Joshi', N'Joshi Hardware', N'9876543226', N'1414 Oak Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'631a2aae-79bb-4146-9629-4d961a8514ea', CAST(N'2024-06-12T06:55:36.587' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'17d3f938-8807-4ffa-a5ac-93e2ad359b64', N'રવિ શર્મા', N'શર્મા ઇલેક્ટ્રોનિક્સ', N'9876543216', N'404 બર્ચ સ્ટ્રીટ', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'a42c01cc-9942-4ffd-90d5-db0fe18390d4', CAST(N'2024-06-12T06:57:04.107' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3159852a-32aa-4875-ad92-98d124acb6b4', N'Test', N'Test', N'9283724897', N'Test', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 1, N'45836d68-669f-4c48-a8eb-fd99bcfb8234', CAST(N'2024-06-11T05:30:50.897' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Merchant] ([MerchantId], [MerchantName], [FirmName], [MobileNo], [Address], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'c5e1659b-abe7-4ceb-a351-c0f3cb4853f9', N'Kavita Mehta', N'Mehta Cosmetics', N'9876543219', N'707 Pine Street', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'3a627f61-e904-4702-b929-c868a1dbce83', CAST(N'2024-06-12T06:57:24.827' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'808439f1-05ab-4eec-b77e-16432e0ca6ef', CAST(N'2024-06-17T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', N'163ae566-067a-4ba6-8fb8-60df368df0bf', CAST(1000.00 AS Decimal(18, 2)), N'UPI', NULL, NULL, NULL, N'', CAST(N'2024-06-18T05:38:20.837' AS DateTime), N'3218cd61-bfb9-46c5-956a-35b71c43c8b5', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'7c3afc24-82c1-4ba0-ba43-206171ca3bf8', CAST(N'2024-05-31T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'8f426af2-a24c-4d70-af19-3ca8b35d9aae', CAST(10000.00 AS Decimal(18, 2)), N'Cheque', N'9324865', N'TEst', N'Goods', N'Plywoords', CAST(N'2024-06-13T12:44:44.650' AS DateTime), N'515d73bb-9f54-4f82-87fb-0c19f9a1d03e', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'ca9e0985-ce97-44ba-94d8-5f382f9e3d10', CAST(N'2024-06-06T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'e90218f2-e93d-425f-9e40-6c1a0224fe58', CAST(10000.00 AS Decimal(18, 2)), N'Cash', NULL, NULL, NULL, N'0', CAST(N'2024-06-13T08:30:42.813' AS DateTime), N'44fc0c4b-47b3-4216-a4b2-9bb9e781c3d1', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'd4ed0ead-279b-45e4-b336-780ac6089165', CAST(N'2024-06-04T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'e90218f2-e93d-425f-9e40-6c1a0224fe58', CAST(10025.00 AS Decimal(18, 2)), N'Cash', NULL, NULL, NULL, N'10', CAST(N'2024-06-13T08:37:31.440' AS DateTime), N'1771be25-828f-444b-a5fd-a7eb25182a71', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'6d2fcb04-c483-46db-908f-8f22b82a308c', CAST(N'2024-06-13T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'17d3f938-8807-4ffa-a5ac-93e2ad359b64', CAST(100.00 AS Decimal(18, 2)), N'Cash', NULL, NULL, NULL, N'', CAST(N'2024-06-14T07:22:05.480' AS DateTime), N'9b1a54a0-dfe0-43bb-bffa-1bb2409a75ea', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'0bbfb43e-19ac-4b00-b92f-9c2176ea81cc', CAST(N'2024-06-01T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'e90218f2-e93d-425f-9e40-6c1a0224fe58', CAST(2500.00 AS Decimal(18, 2)), N'Cheque', N'45436667', N'BOI', N'GOODS', N'METAL', CAST(N'2024-06-13T08:38:14.343' AS DateTime), N'd03f28c7-2ec7-42b8-a239-a7621ac7e2fb', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'1736291b-4c4e-4afa-a035-c6b5e0a0b689', CAST(N'2024-06-06T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'e90218f2-e93d-425f-9e40-6c1a0224fe58', CAST(10020.00 AS Decimal(18, 2)), N'Cash', NULL, NULL, NULL, N'10', CAST(N'2024-06-13T08:37:04.170' AS DateTime), N'ef18b45e-f23f-4f34-8a13-62ec73f3e4b5', NULL, NULL)
INSERT [dbo].[tbl_MerchantPayment] ([MerchantPaymentId], [PaymentDate], [ClientId], [SiteId], [MerchantId], [Amount], [PaymentType], [ChequeNo], [BankName], [ChequeFor], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'b8cb5cb2-4fd6-4491-9fef-d4d4ab623923', CAST(N'2024-06-13T18:30:00.000' AS DateTime), N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'e90218f2-e93d-425f-9e40-6c1a0224fe58', CAST(90000.00 AS Decimal(18, 2)), N'Cash', NULL, NULL, NULL, N'test12', CAST(N'2024-06-13T06:37:30.267' AS DateTime), N'8cc635d3-0666-479f-9536-d5b29e614af6', NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_PackageType] ON 

INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (1, N'Free Trial Package')
INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (2, N'1 Month Package')
INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (3, N'3 Month Package')
INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (4, N'6 Month Package')
INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (5, N'1 Year Package')
INSERT [dbo].[tbl_PackageType] ([PackageTypeId], [PackageType]) VALUES (6, N'One Time Package')
SET IDENTITY_INSERT [dbo].[tbl_PackageType] OFF
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'f78f52ac-885d-4a32-8d43-38293301cf6d', N'35a5fd62-0743-4041-b6a2-9710e0a3b46d', N'0a904e1d-f21e-4d5e-9de0-36f3f035f8e0', CAST(1.0 AS Decimal(18, 1)), N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', 1000, CAST(1000.00 AS Decimal(18, 2)), 1000, 0, NULL, 1, N'', CAST(N'2024-06-18T09:51:51.787' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T09:53:42.250' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091')
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'8993e3fd-edb6-446e-a9da-75f1f7fee28a', N'af7c0477-67e5-419d-8841-1d61b02e0fd6', N'b556831f-2d68-41c0-89b4-0c986462393a', CAST(1.0 AS Decimal(18, 1)), N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', 100, CAST(100.00 AS Decimal(18, 2)), 1000, 5000, NULL, 1, N'tt', CAST(N'2024-06-18T09:56:10.360' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T10:38:31.250' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099')
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'8ea4615a-bbe5-4a18-a27c-9b1323e32eb0', N'35a5fd62-0743-4041-b6a2-9710e0a3b46d', N'b556831f-2d68-41c0-89b4-0c986462393a', CAST(0.5 AS Decimal(18, 1)), N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', 100, CAST(50.00 AS Decimal(18, 2)), 1000, 100, NULL, 1, N'', CAST(N'2024-06-18T09:51:51.787' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T09:53:42.250' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091')
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'92b26062-7bfe-47fc-854b-be3bd903f1bb', N'af7c0477-67e5-419d-8841-1d61b02e0fd6', N'0a904e1d-f21e-4d5e-9de0-36f3f035f8e0', CAST(0.5 AS Decimal(18, 1)), N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', 1000, CAST(500.00 AS Decimal(18, 2)), 100, 5000, NULL, 1, N'', CAST(N'2024-06-18T09:56:10.360' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T10:38:31.250' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099')
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'36a526ab-00b2-40d5-b13c-da551c7823a7', N'35a5fd62-0743-4041-b6a2-9710e0a3b46d', N'd5564709-2709-48aa-9827-47947899822e', CAST(1.0 AS Decimal(18, 1)), N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', 780, CAST(780.00 AS Decimal(18, 2)), 1000, 1100, NULL, 2, N'', CAST(N'2024-06-18T09:51:51.787' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T09:53:42.250' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091')
INSERT [dbo].[tbl_PersonAttendance] ([PersonAttendanceId], [AttendanceId], [PersonId], [AttendanceStatus], [SiteId], [PersonDailyRate], [PayableAmount], [WithdrawAmount], [OvertimeAmount], [TotalRokadiya], [PersonTypeId], [Remarks], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (N'1b659aa9-4e2d-44b5-9f16-f60d53a6c28f', N'af7c0477-67e5-419d-8841-1d61b02e0fd6', N'd5564709-2709-48aa-9827-47947899822e', CAST(1.0 AS Decimal(18, 1)), N'4b890e1f-89bf-4bf1-9968-bf40de942539', 780, CAST(780.00 AS Decimal(18, 2)), 100, 0, NULL, 2, N'', CAST(N'2024-06-18T09:56:10.360' AS DateTime), N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T10:38:31.250' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099')
INSERT [dbo].[tbl_PersonGroup] ([PersonGroupId], [GroupName], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (N'b239c13d-c34e-40d0-9f52-67f510542354', N'Group 1', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T05:02:42.897' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tbl_PersonGroup] ([PersonGroupId], [GroupName], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (N'6c205021-9626-4477-bb5d-a9f00b1166e6', N'Group 3', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T06:26:01.853' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tbl_PersonGroup] ([PersonGroupId], [GroupName], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (N'5af6f321-3e57-4bb4-9f8d-ce2d8b67ded8', N'Group 2', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-17T05:06:14.003' AS DateTime), N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', CAST(N'2024-06-17T10:48:50.560' AS DateTime), 1, 0)
INSERT [dbo].[tbl_PersonGroup] ([PersonGroupId], [GroupName], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive], [IsDeleted]) VALUES (N'0fcd7f46-0ab6-4c35-a1ec-d91eec0bae43', N'Group 4', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-18T10:12:00.477' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tbl_PersonGroupMap] ([PersonGroupMapId], [PersonId], [PersonGroupId], [IsActive], [IsDeleted]) VALUES (N'8369f735-5695-43b5-88dc-4182fab1d7fb', N'd5564709-2709-48aa-9827-47947899822e', N'6c205021-9626-4477-bb5d-a9f00b1166e6', 1, 0)
INSERT [dbo].[tbl_PersonGroupMap] ([PersonGroupMapId], [PersonId], [PersonGroupId], [IsActive], [IsDeleted]) VALUES (N'8ff0e595-74c0-48d1-b5e3-4603e4e0547b', N'b556831f-2d68-41c0-89b4-0c986462393a', N'b239c13d-c34e-40d0-9f52-67f510542354', 1, 0)
INSERT [dbo].[tbl_PersonGroupMap] ([PersonGroupMapId], [PersonId], [PersonGroupId], [IsActive], [IsDeleted]) VALUES (N'c867cdfd-d86f-4f25-94b6-cbdc3b33eff5', N'830d0a7b-8db3-4518-b2c6-9406aaeec802', N'5af6f321-3e57-4bb4-9f8d-ce2d8b67ded8', 1, 0)
INSERT [dbo].[tbl_PersonGroupMap] ([PersonGroupMapId], [PersonId], [PersonGroupId], [IsActive], [IsDeleted]) VALUES (N'226afef3-16b8-4945-bcc3-d41c04df74f9', N'edb7167e-0d69-42b8-a14d-10daa6fcf6d3', N'5af6f321-3e57-4bb4-9f8d-ce2d8b67ded8', 1, 0)
INSERT [dbo].[tbl_PersonGroupMap] ([PersonGroupMapId], [PersonId], [PersonGroupId], [IsActive], [IsDeleted]) VALUES (N'3f8f34cc-4a8e-4c00-bca7-f90d9a86d0eb', N'0a904e1d-f21e-4d5e-9de0-36f3f035f8e0', N'0fcd7f46-0ab6-4c35-a1ec-d91eec0bae43', 1, 0)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a57e9b3d-c653-4983-bf28-03c505bf51bc', N'Test', N'TEst', N'9487239473', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-11T09:56:13.980' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'fd246aea-1fed-442e-8cd5-096988f754b5', N'shubham', N'ahmedabad', N'9785462135', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', NULL, CAST(N'2024-06-17T11:17:23.910' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'b556831f-2d68-41c0-89b4-0c986462393a', N'vatsal', N'ahmedabad', N'1234567890', NULL, 100, 1, 1, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', NULL, CAST(N'2024-06-14T13:23:04.133' AS DateTime), CAST(N'2024-06-18T06:23:16.617' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'edb7167e-0d69-42b8-a14d-10daa6fcf6d3', N'tset', N'3fd', N'8978467', NULL, 90, 2, 1, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-14T13:27:04.983' AS DateTime), CAST(N'2024-06-18T06:58:25.127' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'f5a24a18-56c6-46a3-8d9b-1d8311101f07', N'Amit Verma', N'', N'', NULL, NULL, NULL, 0, 0, 0, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:37:52.833' AS DateTime), CAST(N'2024-06-14T12:46:15.900' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'2177f42c-d5e8-4f3d-ad0a-1f3a5e10113e', N'Kunal Darji', N'Surat', N'8593224514', NULL, 600, 1, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-17T05:48:14.620' AS DateTime), CAST(N'2024-06-18T06:30:13.347' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'4ac4186e-e404-4394-b65e-309d72a67b93', N'કુલદિપ પંચોલી', N'Ahmedabad', N'9823476218', NULL, 650, 1, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-12T09:35:02.130' AS DateTime), CAST(N'2024-06-12T09:50:13.060' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'e4573cac-e68e-4672-b5d4-358a18b87485', N'Arjun Gupta', N'101, Gupta Colony, Delhi, Delhi', N'9876543213', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:37:29.203' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'b7a3a08c-89bf-4226-ae30-3598f2dd23a0', N'Test', N'Ahmedabad', N'9346372432', NULL, 800, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-12T10:07:30.767' AS DateTime), CAST(N'2024-06-12T10:07:35.847' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'0a904e1d-f21e-4d5e-9de0-36f3f035f8e0', N'Test Person', N'Test', N'1234567890', NULL, 1000, 1, 1, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'feec4997-53e4-4269-b74f-5d7dfe551099', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T06:59:02.237' AS DateTime), CAST(N'2024-06-18T06:59:14.800' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8a530c94-c0d7-47ec-88e4-3b31f3d30950', N'Vatsal', N'', N'9824372846', NULL, 500, 1, 1, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-18T10:09:20.287' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'22e4923f-96b7-4d56-8bac-42429b77b8cb', N'અંકિત મિશ્રા', N'789, મિશ્રા કોલોની, પુણે, મહારાષ્ટ્ર', N'9876543219', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:39:36.630' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'd5564709-2709-48aa-9827-47947899822e', N'Kuldip Sharma', N'Surat', N'9324972384', NULL, 780, 2, 1, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-17T05:45:29.357' AS DateTime), CAST(N'2024-06-18T06:59:30.947' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'7098e4f9-f5c5-4507-9602-48ea18e1276d', N'gh', N'j', N'', NULL, NULL, NULL, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:13:23.757' AS DateTime), CAST(N'2024-06-13T12:13:26.510' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'c4116929-f084-4d62-a9ff-51c47e98d521', N'રાહુલ કડિયા', N'Ahmedabad', N'1234567890', NULL, 800, 2, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-11T07:18:30.017' AS DateTime), CAST(N'2024-06-14T12:56:02.187' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'314745e2-e101-414a-9f6f-5a01d1d1ef22', N'Rahul Patel', N'456, Patel Chowk, Ahmedabad, Gujarat', N'9876543211', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:28:40.730' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'e3a39b1d-475f-43ed-a23e-607c0873be0a', N'Akash Sharma', N'123, Gandhi Nagar, Jaipur, Rajasthan', N'9876543210', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:28:21.593' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'3b4ca43a-71cd-4b22-9f7c-6b98c1266599', N'Raj Sharma', N'Mahesana', N'9587348273', NULL, 500, 2, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-11T10:05:05.013' AS DateTime), CAST(N'2024-06-14T12:55:57.830' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'd250f35a-649f-4f34-826d-6e2906a49bc5', N'asdf', N'asdf', N'324234', NULL, 234, 1, 0, 234, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'dd665146-c965-417b-b0fb-b11a41809d88', NULL, CAST(N'2024-06-10T11:52:15.057' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'69505449-7923-4c96-9ab3-6ec7df40825b', N'Kalubhai Joshi', N'Ahmedabad', N'9023674985', NULL, 950, 1, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-12T09:39:20.370' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8d932fec-3d96-43f0-847e-720808415dab', N'ભીખુભાઈ ટંડેલ', N'Surat', N'9522735473', NULL, 600, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-12T09:37:49.997' AS DateTime), CAST(N'2024-06-12T09:49:54.407' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8f7bd030-a494-43e4-95a8-731bbc2ad2e9', N'chiarg', N'test', N'1234567890', NULL, 100, 2, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T07:09:53.480' AS DateTime), CAST(N'2024-06-11T07:16:26.890' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'5c8e9afe-7e79-4c9d-84e5-75aef7668699', N'Jagdish Yadav', N'Ahmedabad', N'9534656475', NULL, 900, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-12T09:36:25.920' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a7b3a512-1be9-4822-9ed1-770f08db9902', N'hkhk', N'', N'', NULL, NULL, NULL, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'feec4997-53e4-4269-b74f-5d7dfe551099', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T13:18:12.720' AS DateTime), CAST(N'2024-06-17T13:18:31.000' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a4a87dc0-0aee-483a-bbfe-7b103162df1b', N'મયંક કનોજીયા', N'Bhavnagar', N'9587348273', NULL, 750, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-12T09:38:36.997' AS DateTime), CAST(N'2024-06-12T09:50:31.217' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'78afb174-c7e0-4626-9454-807de6ae5c9b', N'Suresh Tiwari', N'890, Tiwari Street, Kolkata, West Bengal', N'9876543216', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:38:15.950' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'93c22ab3-1a5e-4e11-900b-8cb4b6c6c6a4', N'Test', N'', N'9864352342', NULL, 4983, 2, 1, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-18T06:21:19.980' AS DateTime), CAST(N'2024-06-18T06:58:19.640' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'830d0a7b-8db3-4518-b2c6-9406aaeec802', N'Test', N'Surat', N'9673565465', NULL, 900, 2, 1, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T05:05:45.130' AS DateTime), CAST(N'2024-06-18T06:58:22.460' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'c1c60ac6-43d7-4f48-9ff2-9aa345b5800c', N'Minubhai Raj', N'Surat', N'9823623484', NULL, 500, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-12T09:34:13.700' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'cfca8dea-ffba-44cb-b947-a32d705dcf25', N'vc', N'vhbfgghh', N'', NULL, NULL, NULL, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:12:00.303' AS DateTime), CAST(N'2024-06-13T12:12:10.163' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'0cb1c7a4-ea21-4731-ac4d-a8c1eea3ceea', N'ચિરાગ', N'સિદ્ધપુર', N'1234567890', NULL, 100, 1, 0, 1003, 1, 0, N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-10T10:46:55.417' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'124c4718-7e70-4f6b-baf6-b15a884756f2', N'Ram Patel', N'Surat', N'9348234787', NULL, 1000, 1, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-12T10:02:42.917' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'1398b03e-a761-47db-b272-bd7913a4ed35', N'Dhaval Patel', N'', N'', NULL, 500, 1, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'2f134572-edf7-408d-a459-563c1bd4ac06', NULL, CAST(N'2024-06-14T07:05:23.300' AS DateTime), CAST(N'2024-06-18T06:30:15.630' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'97ff2ba4-192c-40ce-a38f-c4ae66e08e16', N'Avinash Sharma', N'Surat', N'90', NULL, 800, 2, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', NULL, CAST(N'2024-06-12T09:43:00.683' AS DateTime), CAST(N'2024-06-18T06:30:18.580' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'4b88c81d-f127-44ed-9dc9-ca2435ca2f55', N'Vikas Patel', N'Surat', N'9587348273', NULL, 100, 2, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'be1ac69d-1a31-4378-91e4-116bd28a1091', CAST(N'2024-06-11T10:05:37.070' AS DateTime), CAST(N'2024-06-14T12:56:27.060' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'45c44670-4e76-47d4-a5dd-dffd58545a9d', N'bvgf', N'hfgh', N'1234567890', NULL, NULL, NULL, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-13T12:11:46.627' AS DateTime), CAST(N'2024-06-13T12:11:49.317' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'938cb599-61e0-4f3e-92a5-e46f46c8617f', N'વિશાલ રેડ્ડી', N'', N'', NULL, NULL, NULL, 0, 0, 0, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T08:39:11.660' AS DateTime), CAST(N'2024-06-14T12:46:33.177' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'1b6aac06-3e22-40ae-b6ad-e4c99e393ed1', N'yash', N'test', N'1234567890', NULL, NULL, NULL, 0, 0, 0, 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-11T07:11:05.157' AS DateTime), CAST(N'2024-06-11T07:16:20.700' AS DateTime))
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'1d6b7d7d-84b8-4295-89e8-e64c54fcec7e', N'Manoj Kumar', N'234, Kumar Lane, Bengaluru, Karnataka', N'9876543214', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:37:45.890' AS DateTime), NULL)
INSERT [dbo].[tbl_Persons] ([PersonId], [PersonFirstName], [PersonAddress], [MobileNo], [PersonPhoto], [DailyRate], [PersonTypeId], [IsAttendancePerson], [OrderNo], [IsActive], [IsDeleted], [ClientId], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a185d017-6485-414c-9423-fde218c345f4', N'Rajesh Singh', N'789, Krishna Nagar, Lucknow, Uttar Pradesh', N'9876543212', NULL, NULL, NULL, 0, 0, 1, 0, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-12T08:37:15.427' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[tbl_PersonType] ON 

INSERT [dbo].[tbl_PersonType] ([Id], [PersonType]) VALUES (1, N'Account')
INSERT [dbo].[tbl_PersonType] ([Id], [PersonType]) VALUES (2, N'Helper')
SET IDENTITY_INSERT [dbo].[tbl_PersonType] OFF
SET IDENTITY_INSERT [dbo].[tbl_Role] ON 

INSERT [dbo].[tbl_Role] ([RoleId], [RoleName]) VALUES (1, N'Site Owner')
INSERT [dbo].[tbl_Role] ([RoleId], [RoleName]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[tbl_Role] OFF
INSERT [dbo].[tbl_SitePhoto] ([SitePhotoId], [SiteId], [SitePhotoCategoryId], [PhotoDate], [PhotoName]) VALUES (N'186fb6bf-f6b6-42ba-bcf6-7cd9dbfa53f4', N'd9068046-1ca7-41af-9df6-f8593db3dd46', N'a7dbfb1c-4b1c-42e8-8bf8-1ba59e91c354', CAST(N'2024-06-10T10:37:31.867' AS DateTime), N'0d5fe79f-e90c-471c-890e-398615d46441.png')
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'c1929041-3c94-400a-ac97-0ed3c0283b70', N'Infrastructure', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:56.843' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'a7dbfb1c-4b1c-42e8-8bf8-1ba59e91c354', N'પરીક્ષણ છબી શ્રેણી', N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', CAST(N'2024-06-10T10:37:16.483' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'5151057f-e757-42b8-84f9-2fc415303519', N'Commercial construction', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:01.187' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'618e0a9b-9917-437b-b57e-64cb7ad94f2e', N'સુથાર', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:08.280' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'9a1a3b29-4d95-4609-b7d3-8eb393e52df5', N'Residential area', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:29:54.890' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'8e260774-da26-406f-be67-97da99374cdc', N'ચણતર', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:31:04.140' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'47b1eaf4-466f-4659-b3cf-9c8ad292f394', N'ઇલેક્ટ્રિશિયન', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:49.797' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'dfc64056-3433-48ab-9045-ac5775ea0fa5', N'Construction management', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:34.140' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'1923b525-33fe-4948-aadc-b179934e663b', N'Civil Engineer', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:27.857' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'544eaf78-e841-4800-bc9f-bf91357fb690', N'Plumber', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:30:42.780' AS DateTime))
INSERT [dbo].[tbl_SitePhotoCategory] ([SitePhotoCategoryId], [CategoryName], [ClientId], [CreatedDate]) VALUES (N'80464d16-acb6-4566-91b5-db3cc41982eb', N'Architect', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', CAST(N'2024-06-12T09:31:16.467' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8953932b-83a4-4c97-acc5-07fa437db66d', N'Patan Residential Towers', N'Building residential towers in Patan', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:03:44.250' AS DateTime), CAST(N'2024-06-12T13:54:05.803' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'e5160b44-ce13-4aea-bc6d-0ba56bd9caf7', N'ભાવનગર હાઈવે', N'ભાવનગર નજીકનો હાઈવે નિર્માણ', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:02:58.733' AS DateTime), CAST(N'2024-06-12T13:50:08.210' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'1c11bad7-e86c-4b1a-8623-1626095c1694', N'પોરબંદર એરપોર્ટ ટર્મિનલ', N'પોરબંદર એરપોર્ટમાં ટર્મિનલ નિર્માણ', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:04:33.920' AS DateTime), CAST(N'2024-06-12T13:49:57.130' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'0db97e57-da0a-44a8-8122-1fec75d282e1', N'વલસાડ કોન્વેન્શન હોલ', N'વલસાડમાં કોન્વેન્શન હોલ નિર્માણ', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:04:18.413' AS DateTime), CAST(N'2024-06-12T13:49:59.617' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'7afefb65-51be-4e4d-a79c-20cc155eba23', N'Kutch Solar Park', N'Building solar park in Kutch', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:03:24.580' AS DateTime), CAST(N'2024-06-12T13:50:04.477' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'36aea2cd-af71-45c1-b7f1-27c5bfca79d5', N'Shaligram Site', N'test site', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T05:59:36.260' AS DateTime), CAST(N'2024-06-14T06:07:15.890' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'efe26ef5-36a2-4de4-9178-2b8ac60423ec', N'Nilesh site', N'Anand', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'2f134572-edf7-408d-a459-563c1bd4ac06', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-05-24T11:19:51.893' AS DateTime), CAST(N'2024-06-12T13:53:16.410' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'7837cec4-ed6b-4ba6-a087-3a6b27a14458', N'Chirag Testing', N'Testing', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'0b66b75a-178c-43c4-9b7a-683b638eb9da', NULL, CAST(N'2024-06-13T06:33:15.930' AS DateTime), NULL)
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'1914d383-a2b2-47ca-8f20-6c672eb9b14e', N'Nilesh Site', N'test', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 1, 0, N'2f134572-edf7-408d-a459-563c1bd4ac06', N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-13T10:33:13.233' AS DateTime), CAST(N'2024-06-13T11:16:53.250' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'addeba13-595f-49f0-9a8c-7d95637c362a', N'મહેસાણા હોસ્પિટલ', N'મહેસાણામાં હોસ્પિટલ નિર્માણ', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:04:00.610' AS DateTime), CAST(N'2024-06-12T13:50:01.367' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'2df912e7-b9e7-4719-bac4-8386fbd9a11e', N'test site', N'test site', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'2f134572-edf7-408d-a459-563c1bd4ac06', N'2f134572-edf7-408d-a459-563c1bd4ac06', CAST(N'2024-06-17T11:07:17.190' AS DateTime), CAST(N'2024-06-17T11:07:20.737' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'a938c57c-143c-4023-a05b-ad7007738db6', N'Vadodara Flyover', N'Flyover construction in Vadodara', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:02:39.163' AS DateTime), CAST(N'2024-06-12T13:50:10.240' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'4b890e1f-89bf-4bf1-9968-bf40de942539', N'નવી સાઇટ', N'test', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 0, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T07:04:04.437' AS DateTime), CAST(N'2024-06-17T05:47:53.610' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'49960be3-4866-4433-99d7-c0c90b415848', N'જુનાગઢ કોન્વેન્શન સેન્ટર', N'જુનાગઢમાં કોન્વેન્શન સેન્ટર નિર્માણ', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:03:14.143' AS DateTime), CAST(N'2024-06-12T13:50:06.350' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8ffa4540-806a-49ab-a617-c4b2e5cd1807', N'dsf', N'sdf', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'dd665146-c965-417b-b0fb-b11a41809d88', N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:48:53.743' AS DateTime), CAST(N'2024-06-12T06:05:00.900' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'9aef7884-90d6-4986-b374-c6e30e714953', N'Gandhidham Seaport', N'Expansion of seaport in Gandhidham', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:03:33.877' AS DateTime), CAST(N'2024-06-12T13:54:00.630' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'3ac26047-ff73-4ccd-8d82-c92b400b2681', N'Test', N'Testt', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T13:54:25.177' AS DateTime), CAST(N'2024-06-13T06:31:48.493' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'80a12722-92ec-4c32-a47f-d25aa52c83f9', N'Ahmedabad Metro', N'Metro construction project in Ahmedabad', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:02:29.407' AS DateTime), CAST(N'2024-06-12T13:50:11.977' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'8a05d16d-1c6b-4e50-8451-e3921b86e382', N'Site 1', N'Description', NULL, N'3d295037-5f64-4265-b934-137e2bf78e7b', 1, 0, N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', CAST(N'2024-06-17T10:07:50.880' AS DateTime), CAST(N'2024-06-17T10:08:15.697' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'837eb6fe-c500-4f75-8caf-ebd8c542723e', N'abc', N'gg', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'6b2a9281-49b4-48a3-b59a-c75ebd417995', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-14T06:06:08.070' AS DateTime), CAST(N'2024-06-14T06:07:13.913' AS DateTime))
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'd9068046-1ca7-41af-9df6-f8593db3dd46', N'પરીક્ષણ સ્થળ', N'પરીક્ષણ સાઇટનું વર્ણન', NULL, N'd0fb2361-bd50-41ef-a4b3-e6b54e499007', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', NULL, CAST(N'2024-06-10T10:33:12.090' AS DateTime), NULL)
INSERT [dbo].[tbl_Sites] ([SiteId], [SiteName], [SiteDescription], [PartyId], [ClientId], [IsActive], [IsDeleted], [CreatedBy], [UpdatedBy], [CreatedDate], [ModifiedDate]) VALUES (N'cf8f9e77-42f0-428c-abd2-f89868994b3e', N'Gandhinagar IT Park', N'Construction of IT Park in Gandhinagar', NULL, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 0, 1, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T06:04:54.283' AS DateTime), CAST(N'2024-06-12T13:53:21.380' AS DateTime))
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'8614aa90-353c-403e-8cde-0a0530903def', N'hemangd', N'yG4QANJcUIqAT8Rc1ULVvw==', NULL, 1, N'Hemang Dholu', N'hemang.d@shaligraminfotech.com', N'1234567809', N'9ffa3b04-1803-4e7c-ad6d-5aac60c503cc.png', 1, 0, CAST(N'2024-05-22T10:10:56.790' AS DateTime), CAST(N'2024-06-17T06:56:27.457' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiODYxNGFhOTAtMzUzYy00MDNlLThjZGUtMGEwNTMwOTAzZGVmXCIsXCJDbGllbnRJZFwiOlwiXCIsXCJSb2xlSWRcIjoxLFwiRnVsbE5hbWVcIjpcIkhlbWFuZyBEaG9sdVwiLFwiVXNlck5hbWVcIjpcImhlbWFuZ2RcIixcIlRva2VuVmFsaWRUb1wiOlwiMDAwMS0wMS0wMVQwMDowMDowMFwiLFwiQ2xpZW50SWRHdWlkXCI6XCIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDBcIn0iLCJuYmYiOjE3MTg2OTQ1NzAsImV4cCI6MTcxODk1NDk3MCwiaWF0IjoxNzE4Njk0NTcwfQ.Q7UYoGFSp28mMaO7pF6Uf80mVnPXL5Svw-7hU9YkGvfkiVuimAR_cxin24ed5RbT6wfpADvNi9tU97CPeEA-ag')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'be1ac69d-1a31-4378-91e4-116bd28a1091', N'vatsal p', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Vatsal Prajapati', N'vatsal.p@shaligraminfotech.com', N'1234567890', NULL, 1, 0, CAST(N'2024-05-27T10:16:22.910' AS DateTime), CAST(N'2024-06-17T07:33:52.417' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiYmUxYWM2OWQtMWEzMS00Mzc4LTkxZTQtMTE2YmQyOGExMDkxXCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIlZhdHNhbCBQcmFqYXBhdGlcIixcIlVzZXJOYW1lXCI6XCJ2YXRzYWwgcFwiLFwiVG9rZW5WYWxpZFRvXCI6XCIwMDAxLTAxLTAxVDAwOjAwOjAwXCIsXCJDbGllbnRJZEd1aWRcIjpcIjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMFwifSIsIm5iZiI6MTcxODY4NzA1MSwiZXhwIjoxNzE4OTQ3NDUxLCJpYXQiOjE3MTg2ODcwNTF9.ZnftolJmsj9y2eQWOE7d3hTu3p5L-_tUokxBLzIeWttrIHKLJH4pnrgfd7ETvTkvWJXGVl3Gd7wc9Hz1PAa8wQ')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'ab11f8c8-b221-4e3c-b88f-26b1227c32e8', N'abx', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'gfhfgfhf', N'abc@shaligraminfotech.com', N'1234567890', NULL, 0, 1, CAST(N'2024-05-28T13:19:10.880' AS DateTime), CAST(N'2024-05-28T13:19:56.410' AS DateTime), NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'0befcf6e-3747-41ca-b894-2aecb1e6b94e', N'nileshprajapati', N'lPyF2oMLsZqdvcU2gJQl73csaUJx9JJhi5EdI+0piog=', NULL, 1, N'Nilesh Prajapati', N'prajapati.nileshbhai@gmail.com', N'9824936252', NULL, 1, 0, CAST(N'2024-05-22T00:00:00.000' AS DateTime), NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiMGJlZmNmNmUtMzc0Ny00MWNhLWI4OTQtMmFlY2IxZTZiOTRlXCIsXCJDbGllbnRJZFwiOlwiXCIsXCJSb2xlSWRcIjoxLFwiRnVsbE5hbWVcIjpcIk5pbGVzaCBQcmFqYXBhdGlcIixcIlVzZXJOYW1lXCI6XCJuaWxlc2hwcmFqYXBhdGlcIixcIlRva2VuVmFsaWRUb1wiOlwiMDAwMS0wMS0wMVQwMDowMDowMFwifSIsIm5iZiI6MTcxNjk2MTg1NiwiZXhwIjoxNzE3MjIyMjU2LCJpYXQiOjE3MTY5NjE4NTZ9.5lkbyxVSO_OKpX6hkeae6j7CeYZBDmPzqiBH_aWsb4x9NGzfBPb4xN442mQgzgnTvquJ4gLp9B-87Kgb4MmuOA')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'2f134572-edf7-408d-a459-563c1bd4ac06', N'nileshp', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Nilesh Prajapati', N'nilesh.p@shaligraminfotech.com', N'9824936252', N'fd3206d8-8f10-4711-8947-7c54c733c45f.jpg', 1, 0, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-06-17T14:21:22.910' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiMmYxMzQ1NzItZWRmNy00MDhkLWE0NTktNTYzYzFiZDRhYzA2XCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIk5pbGVzaCBQcmFqYXBhdGlcIixcIlVzZXJOYW1lXCI6XCJuaWxlc2hwXCIsXCJUb2tlblZhbGlkVG9cIjpcIjAwMDEtMDEtMDFUMDA6MDA6MDBcIixcIkNsaWVudElkR3VpZFwiOlwiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwXCJ9IiwibmJmIjoxNzE4NjMzNzQyLCJleHAiOjE3MTg4OTQxNDIsImlhdCI6MTcxODYzMzc0Mn0.XBPmL7tSTQih-007EEfknvvTZdz18Sn5C77Q8sUV4jNooD1xvJrhWulZHYAMXJCOK_6BsKkbrtGSAIZc7OhUTw')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'57387ba8-d3c2-46db-9139-5d1964b9cbd2', N'shubham.p', N'id3NbbpDv2rF6xRqPxr830TG9jvsme7TY21rKv7a16w=', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Shubham', N'shubham.p@shaligraminfotech.com', N'9834374654', NULL, 1, 0, CAST(N'2024-06-14T05:36:08.060' AS DateTime), NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiNTczODdiYTgtZDNjMi00NmRiLTkxMzktNWQxOTY0YjljYmQyXCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIlNodWJoYW1cIixcIlVzZXJOYW1lXCI6XCJzaHViaGFtLnBcIixcIlRva2VuVmFsaWRUb1wiOlwiMDAwMS0wMS0wMVQwMDowMDowMFwiLFwiQ2xpZW50SWRHdWlkXCI6XCIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDBcIn0iLCJuYmYiOjE3MTg3MDY0NjcsImV4cCI6MTcxODk2Njg2NywiaWF0IjoxNzE4NzA2NDY3fQ.ieM28sWP6AV7w8aoMB0a5guGaW9xHL9Sz56OQLKDQJgZXsadGTmH9J9adHYxGHWp2KtPeqVtBHccw3JHDk3qXw')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'feec4997-53e4-4269-b74f-5d7dfe551099', N'yashk', N'iqoZU83xhlBxYTe8sMTjQw==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Yash', N'yash.k@shaligraminfotech.com', N'4354354354', NULL, 1, 0, CAST(N'2024-06-17T09:19:26.050' AS DateTime), CAST(N'2024-06-17T11:43:19.633' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiZmVlYzQ5OTctNTNlNC00MjY5LWI3NGYtNWQ3ZGZlNTUxMDk5XCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIllhc2hcIixcIlVzZXJOYW1lXCI6XCJ5YXNoa1wiLFwiVG9rZW5WYWxpZFRvXCI6XCIwMDAxLTAxLTAxVDAwOjAwOjAwXCIsXCJDbGllbnRJZEd1aWRcIjpcIjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMFwifSIsIm5iZiI6MTcxODcwNjgxMSwiZXhwIjoxNzE4OTY3MjExLCJpYXQiOjE3MTg3MDY4MTF9.F874oR7AXSIhy7FzrfcdC8W47J78jgQi5ypXgev_VV7uc_k5w6x73YlDcMkkRBwAE_R8X3un2CWlFhuBU7TSwA')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'943665bc-1302-4d60-80e6-5ddd5165b76b', N'uttam.v', N'lPyF2oMLsZqdvcU2gJQl73csaUJx9JJhi5EdI+0piog=', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Uttam Vora', N'uttam.v@shaligraminfotech.com', N'9876543210', NULL, 1, 0, CAST(N'2024-06-14T05:29:49.277' AS DateTime), CAST(N'2024-06-17T10:54:54.793' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiOTQzNjY1YmMtMTMwMi00ZDYwLTgwZTYtNWRkZDUxNjViNzZiXCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIlV0dGFtIFZvcmFcIixcIlVzZXJOYW1lXCI6XCJ1dHRhbS52XCIsXCJUb2tlblZhbGlkVG9cIjpcIjAwMDEtMDEtMDFUMDA6MDA6MDBcIixcIkNsaWVudElkR3VpZFwiOlwiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwXCJ9IiwibmJmIjoxNzE4NjI2OTY1LCJleHAiOjE3MTg4ODczNjUsImlhdCI6MTcxODYyNjk2NX0.unCG7rh6QZD0kqFpmgd7ifu8Be4KIv9IzYdNeA7pINJ9qObS01zuWfSwPGSrNxcLVy7EIOc4xoyVEoFcDCfp8g')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'79a3d35a-4be6-47c8-b42d-66ba7766ea9b', N'nileshy', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'nilesh', N'nilesh.y@shaligraminfotech.com', N'1234567890', NULL, 1, 0, CAST(N'2024-06-12T09:28:42.903' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'0b66b75a-178c-43c4-9b7a-683b638eb9da', N'chirag.p', N'lPyF2oMLsZqdvcU2gJQl70cP+ql3CLmRwBVDJ+zP/hc=', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'ચિરાગ', N'chirag.p@shaligraminfotech.com', N'9587348273', NULL, 1, 0, CAST(N'2024-06-11T05:25:38.283' AS DateTime), CAST(N'2024-06-12T09:50:02.013' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiMGI2NmI3NWEtMTc4Yy00M2M0LTliN2EtNjgzYjYzOGViOWRhXCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIuCqmuCqv-CqsOCqvuCql1wiLFwiVXNlck5hbWVcIjpcImNoaXJhZy5wXCIsXCJUb2tlblZhbGlkVG9cIjpcIjAwMDEtMDEtMDFUMDA6MDA6MDBcIixcIkNsaWVudElkR3VpZFwiOlwiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwXCJ9IiwibmJmIjoxNzE4Mjg3NjAwLCJleHAiOjE3MTg1NDgwMDAsImlhdCI6MTcxODI4NzYwMH0.gbttaVYP1aYTMqbXz1Ged2yejwbXpPyewCoxIwEhuYKfqJXc99YDGIWXo0DgxPBj6MUwbkSC0Z-n0JXBPfhORA')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'e2bc1211-6476-4ff1-a08f-6c5b83c31de6', N'Hemaji', N'lPyF2oMLsZqdvcU2gJQl70cP+ql3CLmRwBVDJ+zP/hc=', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Hemji Chaudhari', N'hemji.c@shaligraminfotech.com', N'9876543210', NULL, 0, 1, CAST(N'2024-05-27T05:44:23.637' AS DateTime), CAST(N'2024-06-17T06:45:10.863' AS DateTime), NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'3cc87490-eed4-4687-b3c6-735c3b4feb57', N'manavn', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'manav', N'manav.n@shaligraminfotech.com', N'1234567890', NULL, 1, 0, CAST(N'2024-06-12T09:28:16.687' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'c27901bc-325d-4f43-8881-7ee9c139aeb9', N'vaibhavp', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Vaibhav', N'vaibhav.p@shaligraminfotech.com', N'1234567890', NULL, 1, 0, CAST(N'2024-06-12T09:29:07.857' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'dd665146-c965-417b-b0fb-b11a41809d88', N'Tejas', N'54QUk+keeWsT7bzSj1Q9GQ==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'Tejas Solanki', N'tejas.s@shaligraminfotech.com', N'9876543210', NULL, 1, 0, CAST(N'2024-05-23T11:34:19.090' AS DateTime), NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiZGQ2NjUxNDYtYzk2NS00MTdiLWIwZmItYjExYTQxODA5ZDg4XCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIlRlamFzIFNvbGFua2lcIixcIlVzZXJOYW1lXCI6XCJUZWphc1wiLFwiVG9rZW5WYWxpZFRvXCI6XCIwMDAxLTAxLTAxVDAwOjAwOjAwXCJ9IiwibmJmIjoxNzE4MTc1NTQ2LCJleHAiOjE3MTg0MzU5NDYsImlhdCI6MTcxODE3NTU0Nn0.LKtNo7OEl40rePXIH2vCC1T2KgZEPPgW5MaQdv378oFfpU6NHmo_SXqrHQ6IaaU5s7mLC9kSjStAV5f18eM0Bg')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'0cc3b2a9-fdad-4972-92be-b2967c18f4c8', N'vatsalpraj', N'yG4QANJcUIqAT8Rc1ULVvw==', N'3d295037-5f64-4265-b934-137e2bf78e7b', 2, N'Vatsal', N'vatsalprajapati12@gmail.com', N'9328478437', NULL, 1, 0, CAST(N'2024-06-17T10:03:05.720' AS DateTime), CAST(N'2024-06-17T10:06:20.327' AS DateTime), N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiMGNjM2IyYTktZmRhZC00OTcyLTkyYmUtYjI5NjdjMThmNGM4XCIsXCJDbGllbnRJZFwiOlwiM2QyOTUwMzctNWY2NC00MjY1LWI5MzQtMTM3ZTJiZjc4ZTdiXCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIlZhdHNhbFwiLFwiVXNlck5hbWVcIjpcInZhdHNhbHByYWpcIixcIlRva2VuVmFsaWRUb1wiOlwiMDAwMS0wMS0wMVQwMDowMDowMFwiLFwiQ2xpZW50SWRHdWlkXCI6XCIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDBcIn0iLCJuYmYiOjE3MTg2MjAxMDksImV4cCI6MTcxODg4MDUwOSwiaWF0IjoxNzE4NjIwMTA5fQ.sjwD7A48WtsqX_dsqjEVThnYGligoEHtIzIRmf-3KLku9grNFo_8c-qAXxjiSC0tCdKFlg_PdEYfl77E0hoa7g')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'37f56002-1a05-4c1d-a291-be72907dbde8', N'vatsal praj', N'iqoZU83xhlBxYTe8sMTjQw==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'vatsal test', N'vatsal.p@yopmail.com', N'9587348273', NULL, 1, 0, CAST(N'2024-06-17T09:22:31.153' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'ea836192-9dd5-4eaa-9b94-daf668ddad01', N'હેમાંગ', N'2vnJCvMxVWF9s3yQdSxajg==', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', 2, N'હેમાંગ', N'hemang@yopmail.com', N'1234567890', NULL, 1, 0, CAST(N'2024-06-10T10:30:07.963' AS DateTime), NULL, N'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IntcIlVzZXJJZFwiOlwiZWE4MzYxOTItOWRkNS00ZWFhLTliOTQtZGFmNjY4ZGRhZDAxXCIsXCJDbGllbnRJZFwiOlwiOTNhMTQ3ZGYtMDViOS00ZjkzLThjMmQtMGUzZmI3Y2I5OWY2XCIsXCJSb2xlSWRcIjoyLFwiRnVsbE5hbWVcIjpcIuCqueCrh-CqruCqvuCqguCql1wiLFwiVXNlck5hbWVcIjpcIuCqueCrh-CqruCqvuCqguCql1wiLFwiVG9rZW5WYWxpZFRvXCI6XCIwMDAxLTAxLTAxVDAwOjAwOjAwXCJ9IiwibmJmIjoxNzE4MTY5Mjk4LCJleHAiOjE3MTg0Mjk2OTgsImlhdCI6MTcxODE2OTI5OH0.5NxADVU-V3sTCk168e_5musuzYNqyDV37BhJnx1ns0ozHp23piDPZ9B8GghPMxwzgeGxrKqEY2g5GP4xrZNkUA')
INSERT [dbo].[tbl_Users] ([UserId], [UserName], [Password], [ClientId], [RoleId], [FirstName], [EmailId], [MobileNo], [UserPhoto], [IsActive], [IsDeleted], [CreatedDate], [ModifiedDate], [JWTToken]) VALUES (N'83d5caaf-36a2-44fc-99d4-ddb3d8365bed', N'vatsal pr', N'yG4QANJcUIqAT8Rc1ULVvw==', N'c50ef8d6-0ee9-4eef-ade8-6637b945ffa1', 2, N'Test', N'vatsal.pr@shaligraminfotech.com', N'9587348273', NULL, 1, 0, CAST(N'2024-06-17T09:24:10.787' AS DateTime), CAST(N'2024-06-17T09:25:31.987' AS DateTime), NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'45f6fc9e-bae6-4208-af99-00b2879266c9', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Harshad Mehta', N'9778654322', N'', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:32:41.893' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'530ab22a-4b42-4c6f-9207-1a439ff002d3', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'અજય ઠાકુર', N'9854321099', N'', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:31:37.943' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'61f3c2da-cf49-4c1d-99c6-1c07f03a6a35', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Manoj Bhatt', N'9756432110', N'punctual', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:32:28.063' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'705e3ad1-4303-450a-9399-46b8031406c5', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'મહેશ બાબુ', N'9865432110', N'સમયસર', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:31:04.550' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'0fb73281-2801-4430-8bca-4b33bb32ad82', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'અનિલ કપૂર', N'9810987655', N'', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:33:31.497' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'03c8f4c6-d446-47a7-a490-65730556ed78', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Vikram Singh', N'9854321098', N'Professional service', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:35:13.443' AS DateTime), N'6b2a9281-49b4-48a3-b59a-c75ebd417995', CAST(N'2024-06-12T08:41:52.880' AS DateTime))
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'ebd88858-af1e-4226-b375-99e27a5d89e4', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'અભિનવ જોષી', N'9789765433', N'Efficient Driver', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:33:10.880' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'a290ad81-2c8a-4f13-a04a-b945cca85a51', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Rahul Vyas', N'9723109877', N'', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:31:21.443' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'1713288a-11b2-4162-94ab-c5a68be8f495', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'Parth Dave', N'9745321099', N'Great Driver', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:31:57.370' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'9c7db68d-2d2b-4bea-9fce-ca03148514d6', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'hfgh', N'1234567890', N'g', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:37:16.887' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:37:31.707' AS DateTime))
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'6a6baf43-13fc-4e52-bb1f-d2b9406756ff', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'રવિ શાહ', N'9876543211', N'વિશ્વસનીય અને વ્યાવસાયિક', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:30:40.827' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'654c3910-436b-458b-a2e3-dfc28dc30015', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'hgh', N'1234567890', N'', 0, 1, N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:37:41.303' AS DateTime), N'feec4997-53e4-4269-b74f-5d7dfe551099', CAST(N'2024-06-17T12:37:51.290' AS DateTime))
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'51dac2bb-acf8-44ad-96ad-e35fccc8951f', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'અમિત શાહ', N'9800876543', N'વિશ્વસનીય', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:34:30.987' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3ea8f629-f1db-4f38-be22-fd97a9d4aa3a', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'સુરેશ મહેતા', N'9821098765', N'સારી રીતે જાળવેલ વાહનો', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:34:49.317' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleOwner] ([VehicleOwnerId], [ClientId], [VehicleOwnerName], [MobileNo], [Remarks], [IsActive], [IsDeleted], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'9325fb0d-a3b3-4e30-b9ce-fdc5cee36c00', N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'મનીષ અગ્રવાલ', N'9734210987', N'સમયસર અને કાર્યક્ષમ', 1, 0, N'ea836192-9dd5-4eaa-9b94-daf668ddad01', CAST(N'2024-06-12T05:34:02.450' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'd05b0233-65b4-4b59-bffa-2997d38da675', N'1713288a-11b2-4162-94ab-c5a68be8f495', CAST(N'2024-05-09T00:00:00.000' AS DateTime), N'જૂનાગઢ', N'ગાંધીનગર', N'GJ04GH3456', CAST(3000.00 AS Decimal(18, 2)), 0, N'કોઈ સમસ્યા નથી', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'4cd7c4ea-3b0d-4f84-9d83-3c5936a5073b', CAST(N'2024-06-12T05:46:06.963' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'b70e6607-a001-4171-8436-341d439e5449', N'530ab22a-4b42-4c6f-9207-1a439ff002d3', CAST(N'2024-05-09T00:00:00.000' AS DateTime), N'Patan', N'Navsari', N'GJ10ST7890', CAST(8900.00 AS Decimal(18, 2)), 0, N'Professional driver', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'b5610ab6-d062-4c96-bb8f-73401882db10', CAST(N'2024-06-12T05:46:51.433' AS DateTime), N'f7c7abe8-4d74-4108-b723-7c4064b88aff', CAST(N'2024-06-13T12:04:19.610' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'5f6280dc-1e68-4f4b-aea2-3ccd9ac6900b', N'ebd88858-af1e-4226-b375-99e27a5d89e4', CAST(N'2024-05-19T00:00:00.000' AS DateTime), N'Mehsana', N'Anand', N'GJ11UV1234', CAST(900.00 AS Decimal(18, 2)), 0, N'Good experience', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'91ad25a4-ebd5-48fd-b525-2be794f48f79', CAST(N'2024-06-12T05:53:22.677' AS DateTime), N'4c4bbb11-5143-467c-a35c-4f1a82e35b70', CAST(N'2024-06-13T11:57:47.700' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'f6fcd16a-a69b-4b49-9ce2-3d65d7f1b6cc', N'45f6fc9e-bae6-4208-af99-00b2879266c9', CAST(N'2024-05-24T00:00:00.000' AS DateTime), N'જૂનાગઢ', N'સુરેન્દ્રનગર', N'GJ07MN5678', CAST(3500.00 AS Decimal(18, 2)), 0, N'ડ્રાઈવર સૌજન્ય હતો', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'c6871998-b6f9-4fe6-87ca-27e99fc89e86', CAST(N'2024-06-12T05:54:30.107' AS DateTime), N'dbd89f38-96ac-4aac-94e4-4a9a3c7ee0cc', CAST(N'2024-06-13T12:03:57.543' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'43e96a9c-8265-4b82-aa74-53b849293e43', N'3ea8f629-f1db-4f38-be22-fd97a9d4aa3a', CAST(N'2024-05-03T00:00:00.000' AS DateTime), N'વડોદરા', N'રાજકોટ', N'GJ02CD5678', CAST(2000.00 AS Decimal(18, 2)), 0, N'On time', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'837c120d-e5aa-412e-9e88-d0f9ba3e356e', CAST(N'2024-06-12T05:36:05.677' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'02e97035-e57f-40f7-ab44-5b17c3fada31', N'1713288a-11b2-4162-94ab-c5a68be8f495', CAST(N'2024-05-06T00:00:00.000' AS DateTime), N'Surat', N'Ahmedabad', N'GJ01AB1234', CAST(1200.00 AS Decimal(18, 2)), 0, N'Safe items
', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'014930e5-8015-4baf-8723-3c52a59bd16a', CAST(N'2024-06-12T05:39:19.067' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'48f6c3cd-eebf-4161-b827-a9f2f71db4c4', N'9325fb0d-a3b3-4e30-b9ce-fdc5cee36c00', CAST(N'2024-05-14T00:00:00.000' AS DateTime), N'રાજકોટ', N'જામનગર', N'GJ04GH3456', CAST(30000.00 AS Decimal(18, 2)), 0, N'Good Service
', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'5c45f4f1-140b-4fba-afb2-af4975bb058d', CAST(N'2024-06-12T05:51:46.853' AS DateTime), N'9eed6a61-00f2-44a5-ad7b-55c8d2b648ed', CAST(N'2024-06-13T12:04:32.280' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'42d35913-9a48-4a58-b11f-af5ad8e8a66e', N'61f3c2da-cf49-4c1d-99c6-1c07f03a6a35', CAST(N'2024-05-07T00:00:00.000' AS DateTime), N'Bhavnagar', N'Jamnagar', N'GJ01AB1234', CAST(1200.00 AS Decimal(18, 2)), 0, N'Traffic jam', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'd9dd8fbb-9a72-4432-9fd2-437513c05cb7', CAST(N'2024-06-12T05:45:23.370' AS DateTime), N'b12ec290-fab6-4b89-91c2-1aec6efb8f35', CAST(N'2024-06-13T12:04:24.590' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'333a0212-bc41-4abf-85e5-b3a4ea592952', N'6a6baf43-13fc-4e52-bb1f-d2b9406756ff', CAST(N'2024-05-16T00:00:00.000' AS DateTime), N'Valsad', N'Gandhidham', N'GJ15CD7890', CAST(4300.00 AS Decimal(18, 2)), 0, N'Fast service', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'96d8bcad-beae-438d-b7f6-666435ef0039', CAST(N'2024-06-12T05:47:29.890' AS DateTime), N'49285b98-d723-468f-bfcb-3a718bd7c1bb', CAST(N'2024-06-13T12:04:15.050' AS DateTime))
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'3adcd62e-44d7-432d-82d7-bc336b9c281c', N'a29f0ef1-e681-45cd-8382-836db8844077', CAST(N'2023-02-11T00:00:00.000' AS DateTime), N'Ahmedabad', N'Surat', N'1234', CAST(5000.00 AS Decimal(18, 2)), 0, N'Test', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'f48b5cdb-65e1-4ffc-8c34-7bbb3eaa9272', CAST(N'2024-06-11T08:45:22.573' AS DateTime), NULL, NULL)
INSERT [dbo].[tbl_VehicleRent] ([VehicleRentId], [VehicleOwnerId], [VehicleRentDate], [FromLocation], [ToLocation], [VehicleNumber], [Amount], [IsPaid], [Remarks], [IsActive], [ClientId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (N'd74a92f7-5c5e-44e8-ab56-d025e7e85a56', N'03c8f4c6-d446-47a7-a490-65730556ed78', CAST(N'2024-05-16T00:00:00.000' AS DateTime), N'Gandhinagar', N'Patan', N'GJ08OP9012', CAST(18000.00 AS Decimal(18, 2)), 0, N'Excellent service', 1, N'93a147df-05b9-4f93-8c2d-0e3fb7cb99f6', N'1f6ca1ad-0642-48f9-b28a-d26155c43106', CAST(N'2024-06-12T05:52:46.200' AS DateTime), N'9eed5b59-04db-41da-9bde-6e9ff2e191fa', CAST(N'2024-06-13T11:57:54.930' AS DateTime))
ALTER TABLE [dbo].[tbl_PersonGroup] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_PersonGroup] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[tbl_PersonGroupMap] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_PersonGroupMap] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInActive_Challan]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInActive_Challan](        
@ChallanId VARCHAR(299),        
@userId VARCHAR(255)        
)        
AS        
BEGIN        
 IF((SELECT IsActive FROM tbl_Challan WHERE ChallanId = @ChallanId)= 1)        
 BEGIN        
  UPDATE tbl_Challan SET IsActive = 0,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE ChallanId = @ChallanId  
  SELECT c.ChallanId,c.ChallanDate,c.ChallanNo,c.SiteId,c.MerchantId,c.CarNo,c.Remarks,c.ClientId FROM tbl_Challan as c WHERE c.ChallanId = @ChallanId  
 END        
 ELSE IF((SELECT IsActive FROM tbl_Challan WHERE ChallanId = @ChallanId)= 0)        
 BEGIN        
  UPDATE tbl_Challan SET IsActive = 1,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE ChallanId = @ChallanId        
  SELECT c.ChallanId,c.ChallanDate,c.ChallanNo,c.SiteId,c.MerchantId,c.CarNo,c.Remarks,c.ClientId FROM tbl_Challan as c WHERE c.ChallanId = @ChallanId    
 END        
END  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveClient]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveClient]    
(    
@clientId VARCHAR(255),    
@userId VARCHAR(255)    
)    
AS    
BEGIN    
IF((SELECT IsActive FROM tbl_Clients WHERE ClientId = @ClientId)= 1)    
BEGIN    
 UPDATE tbl_Clients SET IsActive = 0, ModifiedDate = GETUTCDATE() WHERE ClientId = @ClientId    
 SELECT ClientId, ClientName, FirmName,PackageTypeId, Address, IsActive FROM tbl_Clients WHERE ClientId = @ClientId    
END    
ELSE IF((SELECT IsActive FROM tbl_Clients WHERE ClientId = @ClientId)= 0)    
BEGIN    
 UPDATE tbl_Clients SET IsActive = 1, ModifiedDate = GETUTCDATE() WHERE ClientId = @ClientId    
 SELECT ClientId, ClientName, FirmName,PackageTypeId, Address, IsActive FROM tbl_Clients WHERE ClientId = @ClientId    
    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveEstimate]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveEstimate]      
(      
@EstimateId VARCHAR(255),      
@userId VARCHAR(255)      
)      
AS      
BEGIN      
IF((SELECT IsActive FROM tbl_Estimate WHERE EstimateId = @EstimateId)= 1)      
BEGIN      
 UPDATE tbl_Estimate SET IsActive = 0,ModifiedBy = @userId, ModifiedDate = GETUTCDATE()  WHERE EstimateId = @EstimateId       
 SELECT *  FROM tbl_Estimate WHERE EstimateId= @EstimateId
END      
ELSE IF((SELECT IsActive FROM tbl_Estimate WHERE EstimateId = @EstimateId )= 0)      
BEGIN      
 UPDATE tbl_Estimate SET IsActive = 1,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE EstimateId = @EstimateId       
 SELECT *  FROM tbl_Estimate WHERE EstimateId= @EstimateId    
      
END      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveExpense]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveExpense](    
@ExpenseId VARCHAR(255),    
@userId VARCHAR(255)    
)    
AS    
BEGIN    
IF((SELECT IsActive FROM tbl_Expenses WHERE ExpenseId = @ExpenseId)= 1)    
BEGIN    
 UPDATE tbl_Expenses SET IsActive = 0,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE ExpenseId = @ExpenseId    
 SELECT SiteId, IsActive, Description,Amount FROM tbl_Expenses WHERE ExpenseId = @ExpenseId    
END    
ELSE IF((SELECT IsActive FROM tbl_Expenses WHERE ExpenseId = @ExpenseId)= 0)    
BEGIN    
 UPDATE tbl_Expenses SET IsActive = 1,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE ExpenseId = @ExpenseId    
 SELECT SiteId, IsActive, Description,Amount FROM tbl_Expenses WHERE ExpenseId = @ExpenseId    
    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveMerchant]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveMerchant]    
(    
@MerchantId VARCHAR(255),    
@UserId VARCHAR(255)    
)    
AS    
BEGIN
    
	IF(( SELECT
			IsActive
		FROM tbl_Merchant
		WHERE MerchantId = @MerchantId)
	= 1)
	BEGIN
		UPDATE tbl_Merchant
		SET IsActive = 0
		   ,ModifiedDate = GETUTCDATE()
		   ,ModifiedBy = @UserId
		WHERE MerchantId = @MerchantId
		SELECT
			MerchantId
		   ,MerchantId
		   ,FirmName
		   ,MerchantName
		   ,Address
		   ,IsActive
		FROM tbl_Merchant
		WHERE MerchantId = @MerchantId
	END
	ELSE IF ((SELECT
					IsActive
				FROM tbl_Merchant
				WHERE MerchantId = @MerchantId)
			= 0)
	BEGIN
		UPDATE tbl_Merchant
		SET IsActive = 1
			,ModifiedDate = GETUTCDATE()
		WHERE MerchantId = @MerchantId
		SELECT
			MerchantId
			,MerchantId
			,FirmName
			,MerchantName
			,Address
			,IsActive
		FROM tbl_Merchant
		WHERE MerchantId = @MerchantId

	END
END

Select * from tbl_Merchant
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactivePerson]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactivePerson](
@personId VARCHAR(255),
@userId VARCHAR(255) 
)
AS
BEGIN
	IF((SELECT IsActive FROm tbl_Persons WHERE PersonId = @personId) = 1)
		BEGIN
			UPDATE tbl_Persons SET IsActive = 0, ModifiedDate = GETUTCDATE() WHERE PersonId = @personId
			SELECT PersonId, PersonFirstName, PersonAddress, MobileNo, DailyRate,PersonTypeId,OrderNo,ClientId,IsActive FROM tbl_Persons where  PersonId = @personId
		END
	ELSE IF(((SELECT IsActive FROM tbl_Persons WHERE PersonId = @personId)= 0))
		BEGIN
			UPDATE tbl_Persons SET IsActive = 1, ModifiedDate = GETUTCDATE() WHERE PersonId = @personId
			SELECT PersonId, PersonFirstName, PersonAddress, MobileNo, DailyRate,PersonTypeId,OrderNo,ClientId,IsActive FROM tbl_Persons where  PersonId = @personId
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactivePersonGroup]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactivePersonGroup](    
@PersonGroupId VARCHAR(255),    
@UserId VARCHAR(255)    
)    
AS    
BEGIN    
IF((SELECT IsActive FROM tbl_PersonGroup WHERE PersonGroupId = @PersonGroupId)= 1)    
BEGIN    
 UPDATE tbl_PersonGroup SET IsActive = 0,ModifiedBy = @UserId, ModifiedDate = GETUTCDATE() WHERE PersonGroupId = @PersonGroupId  
 SELECT 6 AS IsSuccess, 'Person group inactivated successfully' AS Result    
END    
ELSE IF((SELECT IsActive FROM tbl_PersonGroup WHERE PersonGroupId = @PersonGroupId)= 0)    
BEGIN    
 UPDATE tbl_PersonGroup SET IsActive = 1,ModifiedBy = @UserId, ModifiedDate = GETUTCDATE() WHERE PersonGroupId = @PersonGroupId    
    SELECT 5 AS IsSuccess, 'Person group activated successfully' AS Result    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveSite]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveSite](  
@SiteId varchar(255),  
@userId VARCHAR(255)  
)  
AS  
BEGIN  
IF((SELECT IsActive FROM tbl_Sites WHERE SiteId = @SiteId)= 1)  
BEGIN  
 UPDATE tbl_Sites SET IsActive = 0,UpdatedBy = @userId, ModifiedDate = GETUTCDATE() WHERE SiteId = @SiteId  
 SELECT SiteId, IsActive, SiteName,SiteDescription FROM tbl_Sites WHERE SiteId = @SiteId  
END  
ELSE IF((SELECT IsActive FROM tbl_Sites WHERE SiteId = @SiteId)= 0)  
BEGIN  
 UPDATE tbl_Sites SET IsActive = 1,UpdatedBy = @userId, ModifiedDate = GETUTCDATE() WHERE SiteId = @SiteId  
 SELECT SiteId, IsActive, SiteName,SiteDescription FROM tbl_Sites WHERE SiteId = @SiteId  
  
END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveUser]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveUser]        
(        
@userId VARCHAR(255)
)        
AS        
BEGIN        
IF((SELECT IsActive FROM tbl_Users WHERE UserId = @userId )= 1)        
BEGIN  
  
 UPDATE tbl_Users SET IsActive = 0, ModifiedDate = GETUTCDATE()  WHERE UserId = @userId         
 SELECT UserId,UserName,[Password], IsActive FROM tbl_Users WHERE UserId = @userId         
  
END        
ELSE IF((SELECT IsActive FROM tbl_Users WHERE UserId = @userId )= 0)        
BEGIN     
  
 UPDATE tbl_Users SET IsActive = 1, ModifiedDate = GETUTCDATE()  WHERE UserId = @userId         
 SELECT UserId,UserName,[Password], IsActive FROM tbl_Users WHERE UserId = @userId         
        
END        
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveInactiveVehicleOwner]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveInactiveVehicleOwner]    
(    
@vehicleOwnerId VARCHAR(255),    
@userId VARCHAR(255)    
)    
AS    
BEGIN    
IF((SELECT IsActive FROM tbl_VehicleOwner WHERE VehicleOwnerId = @vehicleOwnerId )= 1)    
BEGIN    
 UPDATE tbl_VehicleOwner SET IsActive = 0,ModifiedBy = @userId, ModifiedDate = GETUTCDATE()  WHERE VehicleOwnerId = @vehicleOwnerId     
 SELECT VehicleOwnerId,VehicleOwnerName,MobileNo,IsActive FROM tbl_VehicleOwner WHERE VehicleOwnerId = @vehicleOwnerId     
END    
ELSE IF((SELECT IsActive FROM tbl_VehicleOwner WHERE VehicleOwnerId = @vehicleOwnerId )= 0)    
BEGIN    
 UPDATE tbl_VehicleOwner SET IsActive = 1,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE VehicleOwnerId = @vehicleOwnerId     
 SELECT VehicleOwnerId,VehicleOwnerName,MobileNo,IsActive FROM tbl_VehicleOwner WHERE VehicleOwnerId = @vehicleOwnerId     
    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ActiveSiteList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ActiveSiteList] (  
@clientId NVARCHAR(50)  
)   
AS    
BEGIN    
SELECT SiteId, SiteName, IsActive FROM tbl_Sites WHERE IsActive = 1 AND IsDeleted = 0  AND ClientId = @clientId  ORDER BY SiteName ASC
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_AddBillWithoutFile]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddBillWithoutFile]    
(    
@billId NVARCHAR(255)= null,    
@billDate DATETIME,    
@billNo NVARCHAR(255),    
@siteId NVARCHAR(255),    
@remarks NVARCHAR(255),    
@createdBy NVARCHAR(255),    
@billSiteItem tbl_BillSiteItem READONLY,    
@billSiteItemDetails tbl_BillSiteItemDetails READONLY    
)    
AS    
BEGIN    
     
 -- Get clientId of Site    
 DECLARE @clientId UNIQUEIDENTIFIER = (SELECT TOP 1 ClientId FROM tbl_Sites WHERE SiteId = @SiteId)    
    
 IF(ISNULL(@billId , '') = '')    
 BEGIN    
  -- Generate NewId for insertation    
  DECLARE @newBillId UNIQUEIDENTIFIER = (SELECT NEWID())    
     
  --Add data into BillSiteNew (Master Table)    
  INSERT INTO [tbl_BillSiteNew] (BillId,BillDate,BillNo,BillType,SiteId,TotalAmount,Remarks,ClientId,IsActive,IsDeleted,CreatedBy,CreatedDate )    
  VALUES (@newBillId,@billDate,@billNo,'Area',@siteId,0,@remarks,@clientId,1,0,@createdBy,GETUTCDATE())    
    
  --Add main category into tbl_BillSiteItemNew table    
  INSERT INTO tbl_BillSiteItemNew(BillSiteItemId, BillId,IsMainItem,IsSubItem,IsTotalItem,ItemName,Rate,CreatedDate)    
  SELECT NEWID(),@newBillId,1,0,0,ItemName,Rate,GETUTCDATE() FROM @billSiteItem    
    
     
  -- Insert item detail set with condition    
  INSERT INTO tbl_BillSiteItemNew    
  (BillSiteItemId,BillId,IsMainItem,IsSubItem,IsTotalItem,MainItemPKId,ItemCategory,ItemName,ItemType,    
  Qty,[Length],Height,Width,Area,Rate,Amount,CreatedDate)    
     
  SELECT NEWID(),@newBillId,0,SD.IsSubItem,SD.IsTotalItem, BI.BillSiteItemId,SD.ItemCategory,SD.ItemName,SD.ItemType,    
  SD.Qty,SD.[Length],SD.Height,SD.Width,SD.Area,null,null,GETUTCDATE()    
  FROM @billSiteItemDetails SD    
  INNER JOIN tbl_BillSiteItemNew BI ON BI.ItemName = SD.[Description] AND BI.IsMainItem = 1 AND BI.BillId = @newBillId    
    
     
  -- Insert total of perticular item detail set with condition    
  INSERT INTO tbl_BillSiteItemNew    
  (BillSiteItemId,BillId,IsMainItem,IsSubItem,IsTotalItem,MainItemPKId,ItemCategory,ItemName,ItemType,    
  Qty,[Length],Height,Width,Area,Rate,Amount,CreatedDate)    
    
  SELECT NEWID(),@newBillId,0,0,1, BI.MainItemPKId,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,SUM(    
  CASE    
  WHEN BI.ItemCategory = 'Less' THEN (-BI.Area * BI2.Rate)    
  ELSE (BI.Area * BI2.Rate)    
  END)     
  ,GETUTCDATE()    
  FROM tbl_BillSiteItemNew BI    
  inner join tbl_BillSiteItemNew BI2 on BI.MainItemPKId = BI2.BillSiteItemId    
  WHERE BI.IsSubItem = 1 AND BI.BillId = @newBillId GROUP BY BI.MainItemPKId     
     
  -- Update total amount of bill    
  UPDATE BS    SET TotalAmount = (         SELECT SUM(BI.Amount)         FROM tbl_BillSiteItemNew BI         WHERE BI.BillId = BS.BillId AND BI.IsTotalItem = 1         )    FROM tbl_BillSiteNew BS    WHERE BS.BillId = @newBillId;    
    SELECT 0
 END    
    
 ELSE    
 BEGIN    
    
  -- Update Bill site master detail into [tbl_BillSiteNew] table    
  UPDATE [tbl_BillSiteNew] SET BillDate = @billDate, BillNo =@billNo, Remarks = @remarks, ModifiedBy  = @createdBy, ModifiedDate = GETUTCDATE() WHERE BillId = @billId    
   
  --Delete record from tbl_BillSiteItemNew which are not there in list  
  DELETE FROM tbl_BillSiteItemNew WHERE BillSiteItemId NOT IN (SELECT BillSiteItemId FROM @billSiteItem WHERE BillSiteItemId IS NOT NULL)   
  AND BillId = @billId AND IsMainItem = 1 AND MainItemPKId IS NULL  
   
  -- Update Existing record of main category  
  UPDATE BI SET BI.ItemName = I.ItemName, BI.Rate = I.Rate FROM tbl_BillSiteItemNew BI   
  INNER JOIN @billSiteItem I ON I.BillSiteItemId = BI.BillSiteItemId  
  
  
  --Add main category into tbl_BillSiteItemNew table    
  INSERT INTO tbl_BillSiteItemNew(BillSiteItemId, BillId,IsMainItem,IsSubItem,IsTotalItem,ItemName,Rate,CreatedDate)    
  SELECT NEWID(),@billId,1,0,0,ItemName,Rate,GETUTCDATE() FROM @billSiteItem WHERE BillSiteItemId IS NULL  
    
 --Delete sub category record which are deleted in updated  
  DELETE FROM tbl_BillSiteItemNew WHERE BillSiteItemId NOT IN (SELECT BillSiteItemId FROM @billSiteItemDetails WHERE BillSiteItemId IS NOT NULL) AND IsSubItem = 1 AND BillId = @billId  
     
    -- Update Existing record of sub category  
  UPDATE BI SET BI.ItemName = SD.ItemName,BI.ItemCategory = SD.ItemCategory, BI.ItemType = SD.ItemType, BI.Qty = SD.Qty,   
  BI.[Length] = SD.[Length], BI.Height = SD.Height, BI.Width = SD.Width, BI.Area = SD.Area  
  FROM tbl_BillSiteItemNew BI   
  INNER JOIN @billSiteItemDetails SD ON SD.BillSiteItemId = BI.BillSiteItemId   
   
  
  -- Insert item detail which is added new item  
  INSERT INTO tbl_BillSiteItemNew    
  (BillSiteItemId,BillId,IsMainItem,IsSubItem,IsTotalItem,MainItemPKId,ItemCategory,ItemName,ItemType,    
  Qty,[Length],Height,Width,Area,Rate,Amount,CreatedDate)    
     
  SELECT NEWID(),@billId,0,SD.IsSubItem,SD.IsTotalItem, BI.BillSiteItemId,SD.ItemCategory,SD.ItemName,SD.ItemType,    
  SD.Qty,SD.[Length],SD.Height,SD.Width,SD.Area,null,null,GETUTCDATE()    
  FROM @billSiteItemDetails SD    
  INNER JOIN tbl_BillSiteItemNew BI ON BI.ItemName = SD.[Description] AND BI.IsMainItem = 1 AND BI.BillId = @billId AND SD.BillSiteItemId IS NULL    
  

 --Delete total of item if item delete in update  
 DELETE FROM tbl_BillSiteItemNew WHERE IsTotalItem = 1 AND BillId = @billId  
  
  
  -- Insert total of perticular item detail set with condition    
  INSERT INTO tbl_BillSiteItemNew    
  (BillSiteItemId,BillId,IsMainItem,IsSubItem,IsTotalItem,MainItemPKId,ItemCategory,ItemName,ItemType,    
  Qty,[Length],Height,Width,Area,Rate,Amount,CreatedDate)    
    
  SELECT NEWID(),@billId,0,0,1, BI.MainItemPKId,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,SUM(    
  CASE    
  WHEN BI.ItemCategory = 'Less' THEN (-BI.Area * BI2.Rate)    
  ELSE (BI.Area * BI2.Rate)    
  END)     
  ,GETUTCDATE()    
  FROM tbl_BillSiteItemNew BI    
  INNER JOIN tbl_BillSiteItemNew BI2 on BI.MainItemPKId = BI2.BillSiteItemId  
  WHERE BI.IsSubItem = 1 AND BI.BillId = @billId GROUP BY BI.MainItemPKId     
     
  -- Update total amount of bill    
  UPDATE BS    SET TotalAmount = ( SELECT SUM(BI.Amount) FROM tbl_BillSiteItemNew BI  WHERE BI.BillId = BS.BillId AND BI.IsTotalItem = 1)    FROM tbl_BillSiteNew BS    WHERE BS.BillId = @billId;    
   SELECT 1
 END    
    
     
END 



GO
/****** Object:  StoredProcedure [dbo].[SP_AddEdit_Challan]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SP_AddEdit_Challan null,'2024-05-23 10:15:52.817','31','EFE26EF5-36A2-4DE4-9178-2B8AC60423EC','C516F7D3-6322-4323-90C9-DA6DC32FD2F8','GJ-01','4444OK','6B2A9281-49B4-48A3-B59A-C75EBD417995','6B2A9281-49B4-48A3-B59A-C75EBD417995','1.png','98115a70-fb3d-41fa-8750-4b64b5ebdeb5.png'
CREATE PROCEDURE [dbo].[SP_AddEdit_Challan]
    @ChallanId varchar(255)= null, 
    @ChallanDate DATETIME,
    @ChallanNo VARCHAR(255),
    @SiteId varchar(255)= null, 
    @MerchantId varchar(255)= null,
    @CarNo VARCHAR(200),
    @Remarks NVARCHAR(MAX),
    @ClientId varchar(255)= null,
    @CreatedBy varchar(255)= null,
	@ChallanOriginalFileName NVARCHAR(255)= null,  
	@ChallanNewFileName NVARCHAR(255)= null  

	
AS
BEGIN
    SET NOCOUNT ON;
	
	DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Challan')  
	
	IF (@ChallanId IS NULL)              
	Begin
	
		
	DECLARE @newExpenseId UNIQUEIDENTIFIER= (SELECT NEWID());    

		INSERT INTO tbl_Challan(ChallanId, ChallanDate, ChallanNo, SiteId, MerchantId, CarNo,FileTypeId ,IsActive,IsDeleted, Remarks, ClientId,CreatedBy, CreatedDate)
		VALUES (@newExpenseId, @ChallanDate, @ChallanNo, @SiteId, @MerchantId, @CarNo, @FileCategoryId,1,0 ,@Remarks, @ClientId,@CreatedBy, GETUTCDATE());
		
		IF((@ChallanOriginalFileName IS NOT NULL) AND (@ChallanNewFileName IS NOT NULL))  
		BEGIN  
		  INSERT INTO tbl_Files VALUES (NEWID(), @newExpenseId, @FileCategoryId, @ChallanOriginalFileName, @ChallanNewFileName)  
		END  
		  SELECT 0  

	end
	else
	begin
			UPDATE tbl_Challan
			SET 
				ChallanDate = @ChallanDate,
				ChallanNo = @ChallanNo,
				SiteId = @SiteId,
				MerchantId = @MerchantId,
				CarNo = @CarNo,
				FileTypeId = @FileCategoryId,
				Remarks = @Remarks,
				ClientId = @ClientId,
				ModifiedBy = @CreatedBy,
				ModifiedDate = GETUTCDATE()
			WHERE ChallanId = @ChallanId;


		 IF((@ChallanOriginalFileName IS NOT NULL) AND (@ChallanNewFileName IS NOT NULL))  
		 BEGIN  
  
		  IF EXISTS(SELECT TOP 1 1 FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @ChallanId)  
		  BEGIN  
  
		   UPDATE tbl_Files SET OriginalFileName = @ChallanOriginalFileName,EncryptFileName = @ChallanNewFileName WHERE FileId = (SELECT  FileId FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @ChallanId)  
  
		  END  
		  ELSE  
		  BEGIN  
  
		  INSERT INTO tbl_Files VALUES (NEWID(), @ChallanId, @FileCategoryId, @ChallanOriginalFileName, @ChallanNewFileName)  
  
		  END  
 END  
 SELECT 1 
			
	End
END



GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditAttendantPerson]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_AddEditAttendantPerson]@PersonId NVARCHAR(MAX) NULL,@PersonFirstName NVARCHAR(250) NULL,@PersonAddress NVARCHAR(MAX) NULL,@MobileNo NVARCHAR(12) NULL,@PersonTypeId BIGINT NULL,@DailyRate BIGINT NULL,@ClientId NVARCHAR(MAX) NULL,@CreatedBy NVARCHAR(MAX) NULLAsBeginIF (ISNULL( @PersonId, '') = '')      Begin	INSERT INTO tbl_Persons(PersonId,PersonFirstName,PersonAddress,MobileNo, PersonTypeId, DailyRate,IsAttendancePerson,						OrderNo,IsActive,IsDeleted,ClientId,CreatedBy,CreatedDate)				Values(NEWID(),@PersonFirstName,@PersonAddress,@MobileNo, @PersonTypeId,@DailyRate,1,						0,1,0,@ClientId,@CreatedBy,GETUTCDATE())	SELECT 1 AS IsSuccess, 'Person added successfully!' AS ResultENDELSEBEGIN	UPDATE tbl_Persons	SET	PersonId = @PersonId,	PersonFirstName = @PersonFirstName,	PersonAddress = @PersonAddress,	MobileNo = @MobileNo,	PersonTypeId = @PersonTypeId,	DailyRate = @DailyRate,	UpdatedBy = @CreatedBy,	ModifiedDate = GETUTCDATE()	where PersonId = @PersonId	SELECT 1 AS IsSuccess, 'Person updated successfully!' AS ResultendEnd
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditEstimate]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AddEditEstimate]     
	@EstimateId NVARCHAR(255), 
    @EstimateDate DATETIME,
    @PartyName NVARCHAR(255),
    @TotalAmount DECIMAL(18, 2),
    @Remarks NVARCHAR(255),
    @ClientId NVARCHAR(255),   
	@CreatedBy NVARCHAR(255),
	@EstimateOriginalFileName NVARCHAR(255)= null,  
	@EstimateNewFileName NVARCHAR(255)= null  
	    
AS
Begin
	DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Estimate')  
	
 declare @newEstimateId UNIQUEIDENTIFIER;  

	IF (@EstimateId IS NULL)              
	Begin
 
	
		INSERT INTO tbl_Estimate(EstimateId,EstimateDate,PartyName,TotalAmount,Remarks,ClientId,FileTypeId, EstimateType,IsActive,IsDeleted ,CreatedBy,CreatedDate)
				VALUES (NEWID(),@EstimateDate,@PartyName,@TotalAmount,@Remarks,@ClientId,@FileCategoryId,1,1,0,@CreatedBy,GETUTCDATE());
		
		SELECT TOP 1 @newEstimateId = EstimateId   FROM tbl_Estimate   ORDER BY CreatedDate DESC;

		IF((@EstimateOriginalFileName IS NOT NULL) AND (@EstimateNewFileName IS NOT NULL))  
		BEGIN  
		  INSERT INTO tbl_Files VALUES (NEWID(), @newEstimateId, @FileCategoryId, @EstimateOriginalFileName, @EstimateNewFileName)  
		END  
        
		SELECT 0 AS IsSuccess, 'Estimate saved successfully!' AS Result

	end
	else
	begin
	UPDATE tbl_Estimate
			SET
			    EstimateDate = @EstimateDate,
			    PartyName = @PartyName,
			    TotalAmount = @TotalAmount,
			    Remarks = @Remarks,
				FileTypeId = @FileCategoryId,
			    ClientId = @ClientId,
			    ModifiedBy = @CreatedBy,
			    ModifiedDate = GETUTCDATE()
			WHERE
			    EstimateId = @EstimateId;


		IF((@EstimateOriginalFileName IS NOT NULL) AND (@EstimateNewFileName IS NOT NULL))  
		 BEGIN  
  
		  IF EXISTS(SELECT TOP 1 1 FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @EstimateId)  
		  BEGIN  
  
		   UPDATE tbl_Files SET OriginalFileName = @EstimateOriginalFileName,EncryptFileName = @EstimateNewFileName WHERE FileId = (SELECT  FileId FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @EstimateId)  
  
		  END  
		  ELSE  
		  BEGIN  
  
		  INSERT INTO tbl_Files VALUES (NEWID(), @EstimateId, @FileCategoryId, @EstimateOriginalFileName, @EstimateNewFileName)  
  
		  END  

		  END
			SELECT 1 AS IsSuccess, 'Estimate updated successfully!' AS Result
	
	End
END



GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditMerchant]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_AddEditMerchant '','',
CREATE PROCEDURE  [dbo].[SP_AddEditMerchant] 
@MerchantId nvarchar(max)=NULL ,
@MerchantName nvarchar(max) ,
@FirmName nvarchar(max) NULL,
@MobileNo nvarchar(max) NULL,
@Address nvarchar(max) NULL,
@ClientId uniqueidentifier ,
@CreatedBy uniqueidentifier
As
Begin
IF (ISNULL( @MerchantId, '') = '')      
Begin
INSERT INTO tbl_Merchant(
MerchantId,
MerchantName,
FirmName,
MobileNo,
Address,
ClientId,
IsActive,
IsDeleted,
CreatedBy,
CreatedDate
)Values(
NEWID(),
@MerchantName,
@FirmName,
@MobileNo,
@Address,
@ClientId,
1,
0,
@CreatedBy,
GETUTCDATE()
)
SELECT 1 AS IsSuccess, 'Record saved successfully!' AS Result
end
else
begin
	UPDATE tbl_Merchant
	SET
	MerchantId = @MerchantId,
	MerchantName = @MerchantName,
	FirmName = @FirmName,
	MobileNo = @MobileNo,
	Address = @Address,
	ClientId = @ClientId,	
	ModifiedBy = @CreatedBy,
	ModifiedDate = GETUTCDATE()
	where MerchantId = @MerchantId
	SELECT 1 AS IsSuccess, 'Record updated successfully!' AS Result
end
End
------------------------- Get By Id--------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditMerchantPayment]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_AddEditMerchantPayment](
	@MerchantPaymentId NVARCHAR(MAX),
    @PaymentDate DATETIME,
    @ClientId NVARCHAR(MAX),
	@SiteId NVARCHAR(MAX),
    @MerchantId NVARCHAR(MAX),
    @Amount DECIMAL(18,2),
    @PaymentType NVARCHAR(MAX),
    @ChequeNo NVARCHAR(MAX),
    @BankName NVARCHAR(MAX),
    @ChequeFor NVARCHAR(MAX),
    @Remarks NVARCHAR(MAX) = NULL,
    @CreatedBy  NVARCHAR(MAX)
)
AS
BEGIN
	IF(ISNULL(@MerchantPaymentId,'') ='')
	BEGIN
		INSERT INTO tbl_MerchantPayment(MerchantPaymentId,PaymentDate,ClientId,SiteId,MerchantId,Amount,PaymentType,ChequeNo,BankName
		,ChequeFor,Remarks,CreatedBy,CreatedDate)
		VALUES(NEWID(),@PaymentDate,@ClientId,@SiteId,@MerchantId,@Amount,@PaymentType,@ChequeNo,@BankName,@ChequeFor,@Remarks
		,@CreatedBy,GETUTCDATE())
		SELECT 1 AS IsSuccess
	END
	ELSE
	BEGIN
		UPDATE tbl_MerchantPayment SET PaymentDate = @PaymentDate,ClientId = @ClientId,SiteId = @SiteId,
		MerchantId = @MerchantId,Amount = @Amount,PaymentType = @PaymentType,ChequeNo = @ChequeNo,BankName = @BankName
		,ChequeFor = @ChequeFor,Remarks = @Remarks
		WHERE MerchantPaymentId = @MerchantPaymentId
		SELECT 3 AS IsSuccess
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditPerson]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_AddEditPerson]@PersonId nvarchar(max) NULL,@PersonFirstName nvarchar(250) NULL,@PersonAddress nvarchar(max) NULL,@MobileNo varchar(12) NULL,@ClientId nvarchar(max) NULL,@CreatedBy nvarchar(max) NULLAsBeginIF (ISNULL( @PersonId, '') = '')      Begin	INSERT INTO tbl_Persons(PersonId,PersonFirstName,PersonAddress,MobileNo,IsAttendancePerson,						OrderNo,IsActive,IsDeleted,ClientId,CreatedBy,CreatedDate)				Values(NEWID(),@PersonFirstName,@PersonAddress,@MobileNo,0,						0,1,0,@ClientId,@CreatedBy,GETUTCDATE())	SELECT 1 AS IsSuccess, 'Person added successfully!' AS ResultENDELSEBEGIN	UPDATE tbl_Persons	SET	PersonId = @PersonId,	PersonFirstName = @PersonFirstName,	PersonAddress = @PersonAddress,	MobileNo = @MobileNo,	ClientId = @ClientId,	UpdatedBy = @CreatedBy,	ModifiedDate = GETUTCDATE()	where PersonId = @PersonId	SELECT 1 AS IsSuccess, 'Person updated successfully!' AS ResultendEnd
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditSite]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddEditSite]       
(          
@SiteId varchar(255) = null,          
@SiteName NVARCHAR(500),          
@SiteDescription NVARCHAR(MAX),         
@ClientId VARCHAR(255),    
@CreatedBy VARCHAR(255)          
)          
AS          
BEGIN          
 IF(@SiteId IS NULL)          
  BEGIN
  IF EXISTS(SELECT TOP 1 1 FROM tbl_Sites WHERE SiteName = @SiteName AND IsDeleted = 0)
  BEGIN
	 SELECT 2
  END
  ELSE
  BEGIN
   DECLARE @NewSiteId UNIQUEIDENTIFIER = (SELECT NEWID())           
   INSERT INTO tbl_Sites(SiteId,SiteName,SiteDescription,CreatedBy,CreatedDate,IsActive, IsDeleted, ClientId) VALUES (@NewSiteId,@SiteName,@SiteDescription,@CreatedBy,GETUTCDATE(),1,0, @ClientId)          
   SELECT 0
  END
           
  END          
 ELSE          
  BEGIN     
  IF EXISTS(SELECT TOP 1 1 FROM tbl_Sites WHERE SiteName = @SiteName AND IsDeleted = 0 AND SiteId != @SiteId)
  BEGIN
	 SELECT 2
  END
  ELSE
  BEGIN
   UPDATE tbl_Sites SET SiteName = @SiteName, SiteDescription = @SiteDescription, UpdatedBy = @CreatedBy, ModifiedDate = GETUTCDATE() WHERE SiteId = @SiteId           
   SELECT 1  
  END
  END          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditVehicleRent]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AddEditVehicleRent]
    @VehicleRentId varchar(255)= null,    
    @VehicleOwnerId varchar(255)= null ,    
    @VehicleRentDate DATETIME,
    @FromLocation NVARCHAR(MAX) = NULL,
    @ToLocation NVARCHAR(MAX) = NULL,
    @VehicleNumber NVARCHAR(MAX),
    @Amount DECIMAL,
    @IsPaid BIT,
    @Remarks NVARCHAR(MAX) = NULL,
	@ClientId varchar(255),     
	@CreatedBy varchar(255)     
AS
Begin
	IF (@VehicleRentId IS NULL)              
	Begin
	
		INSERT INTO tbl_VehicleRent(VehicleRentId,VehicleOwnerId, VehicleRentDate, FromLocation, ToLocation, VehicleNumber, Amount, IsPaid, Remarks, IsActive, ClientId,CreatedBy,CreatedDate)
				VALUES (NEWID(), @VehicleOwnerId,@VehicleRentDate, @FromLocation, @ToLocation, @VehicleNumber, @Amount, @IsPaid, @Remarks, 1, @ClientId,@CreatedBy,GETUTCDATE())
   
		SELECT 1 AS IsSuccess, 'Vehicle rent saved successfully!' AS Result
	end
	else
	begin
			 UPDATE tbl_VehicleRent
			SET VehicleOwnerId = @VehicleOwnerId,
				VehicleRentDate = @VehicleRentDate,
				FromLocation = @FromLocation,
				ToLocation = @ToLocation,
				VehicleNumber = @VehicleNumber,
				Amount = @Amount,
				IsPaid = @IsPaid,
				Remarks = @Remarks,
				ClientId = @ClientId,
				ModifiedBy=@CreatedBy,
				ModifiedDate=GETUTCDATE()
			WHERE VehicleRentId = @VehicleRentId

			SELECT 1 AS IsSuccess, 'Vehicle rent updated successfully!' AS Result
	End
END



GO
/****** Object:  StoredProcedure [dbo].[SP_AddEstimateBillWithoutFile]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddEstimateBillWithoutFile]    
(    
@estimateId NVARCHAR(255) = NULL,    
@estimateBillDate DateTime,    
@partyName NVARCHAR(255),    
@remarks NVARCHAR(255),  
@itemTotal decimal,
@clientId NVARCHAR(255),
@createdBy NVARCHAR(255),
@billEstimateItemDetails tbl_BillEstimateItemDetails READONLY    
)    
AS    
BEGIN    
	DECLARE @LastEstimateId VARCHAR(MAX) = NEWID();
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Estimate')  
IF ( @estimateId IS NULL)              
	Begin
	
		INSERT INTO tbl_Estimate(EstimateId,EstimateDate,PartyName,TotalAmount,Remarks,ClientId,FileTypeId, EstimateType,IsActive,IsDeleted ,CreatedBy,CreatedDate)
				VALUES (@LastEstimateId,@estimateBillDate,@PartyName,@itemTotal,@Remarks,@ClientId,@FileCategoryId,2,1,0,@CreatedBy,GETUTCDATE());
		


					INSERT INTO tbl_EstimateItem (EstimateItemId, EstimateId,ItemName,Nos,Qty,Rate,TotalAmount,CreatedDate)
						SELECT
							NEWID()
							,@LastEstimateId
							,BED.Name
						   ,BED.Nos
						   ,BED.Quantity
						   ,BED.Rate
						   ,BED.TotalAmount
						   ,GETUTCDATE()
						 
						FROM @billEstimateItemDetails AS BED;
        
		SELECT 1 AS IsSuccess, 'Estimate saved successfully!' AS Result

	end
	else
	begin
	UPDATE tbl_Estimate
			SET
			    EstimateDate = @estimateBillDate,
			    PartyName = @PartyName,
			    TotalAmount = @itemTotal,
			    Remarks = @Remarks,
				FileTypeId = @FileCategoryId,
			    ClientId = @ClientId,
			    ModifiedBy = @CreatedBy,
			    ModifiedDate = GETUTCDATE()
			WHERE
			    EstimateId = @EstimateId;


		DELETE FROM tbl_EstimateItem
				WHERE EstimateId = @EstimateId;

				INSERT INTO tbl_EstimateItem (EstimateItemId, EstimateId,ItemName,Nos,Qty,Rate,TotalAmount,CreatedDate)
					SELECT
						NEWID()
							,@EstimateId
							,BED.Name
						   ,BED.Nos
						   ,BED.Quantity
						   ,BED.Rate
						   ,BED.TotalAmount
						   ,GETUTCDATE()
						FROM @billEstimateItemDetails AS BED;

			SELECT 0 AS IsSuccess, 'Estimate updated successfully!' AS Result
	
	End







END
GO
/****** Object:  StoredProcedure [dbo].[SP_Challan_List]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_Challan_List 1,10,'','asc',null

CREATE PROCEDURE  [dbo].[SP_Challan_List] 
@pageIndex INT = 1,
@pageSize INT = 10,
@orderBy NVARCHAR(MAX) = '' ,
@sortOrder NVARCHAR(10) = 'ASC',
@strSearch NVARCHAR(MAX) = NULL,
@clientId NVARCHAR(MAX) = NULL,
@siteId NVARCHAR(MAX) = '',
@merchantId NVARCHAR(MAX) = '',
@startDate DATETIME = NULL,
@endDate DATETIME = NULL

AS
BEGIN
 DECLARE @FileCategoryId INT = (SELECT TOP 1 FileCategoryId FROM [tbl_FileCategory] where FileCategoryName= 'Challan')   
	SET @strSearch = LTRIM(RTRIM(@strSearch))

	SET @orderBy = LTRIM(RTRIM(@orderBy))
	SET @sortOrder = LTRIM(RTRIM(@sortOrder))
	IF(ISNULL(@orderBy, '') = '')
	BEGIN
	SET  @orderBy = 'CreatedDate'
	END
	IF(ISNULL(@sortOrder, '') = '')
	BEGIN

	SET @sortOrder = 'DESC'
	END
	IF(ISNULL(@PageSize, 0) = 0)
	BEGIN
	SET @PageSize = 10
	END
	IF(ISNULL(@PageSize, 0) = 0)
	BEGIN
	SET @PageSize = 10
	END
	else  IF(ISNULL(@PageSize,0) = -1)
	BEGIN
	SET @PageSize = 500000000  
	END
	
	select c.ChallanId,c.ChallanDate,c.ChallanNo,c.SiteId,c.MerchantId,m.MerchantName,s.SiteName,
	F.EncryptFileName AS ChallanPhoto,  c.CarNo,c.FileTypeId,c.Remarks,c.IsActive,

	COUNT(*) OVER() AS totalRecords 
	from tbl_Challan C
	LEFT JOIN tbl_Clients CL on CL.ClientId=c.ClientId
	left join tbl_Merchant m on m.MerchantId =c.MerchantId
	left join tbl_Sites s on s.SiteId=c.SiteId
	LEFT JOIN tbl_Files F ON c.ChallanId = F.ParentId and F.FileCategory = @FileCategoryId  

	Where
	C.ClientId = @clientId AND
	(ISNULL(@siteId, '') = '' or C.SiteId  IN (SELECT value FROM STRING_SPLIT(@siteId, ',')))AND
	(ISNULL(@merchantId, '') = '' or C.MerchantId  IN (SELECT value FROM STRING_SPLIT(@merchantId, ',')))AND
	(@startDate IS NULL OR C.ChallanDate >= @startDate)AND
	(@endDate IS NULL OR C.ChallanDate <= @endDate)AND
	

	 (ISNULL(@strSearch, '') = ''
	 OR c.ChallanDate Like '%' + @strSearch + '%'
	 OR c.ChallanNo Like '%' + @strSearch + '%'
	 OR c.SiteId Like '%' + @strSearch + '%'
	 OR c.MerchantId Like '%' + @strSearch + '%'
	 OR c.CarNo Like '%' + @strSearch + '%'
	 OR c.Remarks Like '%' + @strSearch + '%'
	 OR (CASE WHEN C.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) Like '%' + @strSearch + '%'
 
	 ) 
	 and c.IsDeleted=0 
	ORDER BY 
		CASE WHEN @orderBy = 'ChallanDate' AND @sortOrder ='ASC' THEN c.ChallanDate END ASC,
		CASE WHEN @orderBy = 'ChallanDate' AND @sortOrder ='DESC' THEN c.ChallanDate END DESC, 
		CASE WHEN @orderBy = 'ChallanNo' AND @sortOrder ='ASC' THEN c.ChallanNo END ASC,
		CASE WHEN @orderBy = 'ChallanNo' AND @sortOrder ='DESC' THEN c.ChallanNo END DESC, 
		CASE WHEN @orderBy = 'SiteId' AND @sortOrder ='ASC' THEN c.SiteId END ASC,
		CASE WHEN @orderBy = 'SiteId' AND @sortOrder ='DESC' THEN c.SiteId END DESC,
		CASE WHEN @orderBy = 'MerchantId' AND @sortOrder ='ASC' THEN c.MerchantId END ASC,
		CASE WHEN @orderBy = 'MerchantId' AND @sortOrder ='DESC' THEN c.MerchantId END DESC, 
		CASE WHEN @orderBy = 'CarNo' AND @sortOrder ='ASC' THEN c.CarNo END ASC,
		CASE WHEN @orderBy = 'CarNo' AND @sortOrder ='DESC' THEN c.CarNo END DESC, 
		CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='ASC' THEN c.Remarks END ASC,
		CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='DESC' THEN c.Remarks END DESC, 
		CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='ASC' THEN c.IsActive END ASC,
		CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='DESC' THEN c.IsActive END DESC,
		CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN c.CreatedDate END ASC,          
		CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN c.CreatedDate END DESC   
	OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS
	FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ChangePassword]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChangePassword](
@oldPassword NVARCHAR(255),
@newPassword NVARCHAR(255),
@userId NVARCHAR(255)
)
AS
BEGIN

IF((SELECT [Password] FROM tbl_Users WHERE UserId = @userId) != @oldPassword)
	
	BEGIN
		SELECT 1
	END

ELSE IF(@newPassword = @oldPassword)
	
	BEGIN
		SELECT 2
	END

ELSE

	BEGIN
		UPDATE tbl_Users SET Password = @newPassword WHERE UserId = @userId
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_ClientList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_ClientList]        
@pageIndex int = 1,      
@pageSize int = 10,      
@orderBy varchar(100) = '' ,      
@sortOrder varchar(10) = 'asc',      
@strSearch varchar(250) = null       
AS      
BEGIN      
SET @strSearch = LTRIM(RTRIM(@strSearch))      
      
 SET @orderBy = LTRIM(RTRIM(@orderBy))      
SET @sortOrder = LTRIM(RTRIM(@sortOrder))      
    
IF(ISNULL(@orderBy, '') = '')      
BEGIN      
SET  @orderBy = 'CreatedDate'      
END      
    
IF(ISNULL(@sortOrder, '') = '')      
BEGIN      
SET @sortOrder = 'DESC'      
END    
    
IF(ISNULL(@PageSize, 0) = 0)      
BEGIN      
SET @PageSize = 10      
END     
    
else  IF(ISNULL(@PageSize,0) = -1)      
BEGIN      
SET @PageSize = 500000000        
END        
       
	   ;WITH ClientData AS
    (
        SELECT 
            C.ClientId, 
            C.ClientName, 
            C.FirmName, 
            PT.PackageType, 
            C.ExpireDate, 
            C.Address, 
            C.Remarks, 
            C.IsActive,
			C.CreatedDate,
            COUNT(*) OVER() AS TotalRecords,
            (SELECT COUNT(1) FROM tbl_Users U WHERE U.ClientId = C.ClientId AND U.IsDeleted = 0) AS [UserCount]
        FROM 
            tbl_Clients C      
        INNER JOIN 
            tbl_PackageType PT ON PT.PackageTypeId = C.PackageTypeId      
        WHERE
            IsDeleted = 0 AND
            (ISNULL(@strSearch, '') = ''      
            OR ClientId LIKE '%' + @strSearch + '%'      
            OR ClientName LIKE '%' + @strSearch + '%'      
            OR FirmName LIKE '%' + @strSearch + '%'      
            OR PackageType LIKE '%' + @strSearch + '%'      
            OR [ExpireDate] LIKE '%' + @strSearch + '%'      
            OR [Address] LIKE '%' + @strSearch + '%'      
            OR Remarks LIKE '%' + @strSearch + '%'      
            OR (CASE WHEN IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')
    )
SELECT ClientId, ClientName, FirmName,PackageType, 
            ExpireDate, 
            Address, 
            Remarks, 
            IsActive,
			TotalRecords,
			[UserCount]
    FROM ClientData
    ORDER BY      
        CASE WHEN (@orderBy = 'ClientId' AND @sortOrder = 'ASC') THEN ClientId  END ASC,              
        CASE WHEN (@orderBy = 'ClientId' AND @sortOrder = 'DESC') THEN ClientId  END DESC,              
        CASE WHEN (@orderBy = 'ClientName' AND @sortOrder = 'ASC') THEN ClientName  END ASC,              
        CASE WHEN (@orderBy = 'ClientName' AND @sortOrder = 'DESC') THEN ClientName  END DESC,              
        CASE WHEN (@orderBy = 'PackageType' AND @sortOrder = 'ASC') THEN PackageType  END ASC,              
        CASE WHEN (@orderBy = 'PackageType' AND @sortOrder = 'DESC') THEN PackageType  END DESC,              
        CASE WHEN (@orderBy = 'FirmName' AND @sortOrder = 'ASC') THEN FirmName  END ASC,              
        CASE WHEN (@orderBy = 'FirmName' AND @sortOrder = 'DESC') THEN FirmName  END DESC,              
        CASE WHEN (@orderBy = 'ExpireDate' AND @sortOrder = 'ASC') THEN ExpireDate  END ASC,              
        CASE WHEN (@orderBy = 'ExpireDate' AND @sortOrder = 'DESC') THEN ExpireDate  END DESC,        
        CASE WHEN (@orderBy = 'Address' AND @sortOrder = 'ASC') THEN Address END ASC,              
        CASE WHEN (@orderBy = 'Address' AND @sortOrder = 'DESC') THEN Address END DESC,         
        CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'ASC') THEN Remarks END ASC,              
        CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'DESC') THEN Remarks END DESC,      
        CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN IsActive END ASC,      
        CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN IsActive END DESC,      
        CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'ASC') THEN CreatedDate END ASC,      
        CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'DESC') THEN CreatedDate  END DESC,
        CASE WHEN (@orderBy = 'User' AND @sortOrder = 'ASC') THEN UserCount END ASC,
        CASE WHEN (@orderBy = 'User' AND @sortOrder = 'DESC') THEN UserCount END DESC
    OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS      
    FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY;
   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ContractorFinaceList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_ContractorFinaceList]  
@pageIndex INT = 1,              
@pageSize INT = 10,              
@orderBy NVARCHAR(100) = '' ,              
@sortOrder NVARCHAR(10) = 'asc',              
@strSearch NVARCHAR(250) = null,          
@siteId NVARCHAR(50)      
AS              
BEGIN              
SET @strSearch = LTRIM(RTRIM(@strSearch))                    
 SET @orderBy = LTRIM(RTRIM(@orderBy))              
SET @sortOrder = LTRIM(RTRIM(@sortOrder))              
            
IF(ISNULL(@orderBy, '') = '')              
BEGIN              
SET  @orderBy = 'CreatedDate'              
END              
            
IF(ISNULL(@sortOrder, '') = '')              
BEGIN              
SET @sortOrder = 'DESC'              
END            
            
IF(ISNULL(@PageSize, 0) = 0)              
BEGIN              
SET @PageSize = 10              
END             
ELSE  IF(ISNULL(@PageSize,0) = -1)              
BEGIN              
SET @PageSize = 500000000                
END              
            
SELECT CF.ContractorFinanceId, CF.SiteId, S.SiteName,CF.UserId, CF.SelectedDate, CF.Amount, CF.CreditOrDebit, CF.PaymentType, CF.ChequeNo, CF.BankName, CF.ChequeFor,  
CF.Remarks, U.FirstName AS [UserName],CF.IsActive, COUNT(*) OVER() AS TotalRecords 
FROM [tbl_ContractorFinance] CF INNER JOIN tbl_Sites S ON S.SiteId = CF.SiteId    
INNER JOIN tbl_Users U ON U.UserId = CF.UserId  
Where              
CF.IsDeleted = 0 AND CF.SiteId = @siteId AND             
 (ISNULL(@strSearch, '') = ''              
 OR SiteName Like '%' + @strSearch + '%'              
 OR SelectedDate Like '%' + @strSearch + '%'              
 OR Amount Like '%' + @strSearch + '%'              
 OR CreditOrDebit Like '%' + @strSearch + '%'  
 OR PaymentType Like '%' + @strSearch + '%'  
 OR ChequeNo Like '%' + @strSearch + '%'  
 OR BankName Like '%' + @strSearch + '%'  
 OR ChequeFor Like '%' + @strSearch + '%'  
 OR Remarks Like '%' + @strSearch + '%')              

ORDER BY              

 CASE WHEN (@orderBy = 'SiteName' AND @sortOrder = 'ASC') THEN SiteName  END ASC,                      
 CASE WHEN (@orderBy = 'SiteName' AND @sortOrder = 'DESC') THEN SiteName  END DESC,                      
 CASE WHEN (@orderBy = 'SelectedDate' AND @sortOrder = 'ASC') THEN CF.SelectedDate  END ASC,                      
 CASE WHEN (@orderBy = 'SelectedDate' AND @sortOrder = 'DESC') THEN CF.SelectedDate  END DESC,                      
 CASE WHEN (@orderBy = 'Amount' AND @sortOrder = 'ASC') THEN Amount  END ASC,                      
 CASE WHEN (@orderBy = 'Amount' AND @sortOrder = 'DESC') THEN Amount END DESC,                      
 CASE WHEN (@orderBy = 'CreditOrDebit' AND @sortOrder = 'ASC') THEN CreditOrDebit  END ASC,                      
 CASE WHEN (@orderBy = 'CreditOrDebit' AND @sortOrder = 'DESC') THEN CreditOrDebit  END DESC,                      
 CASE WHEN (@orderBy = 'PaymentType' AND @sortOrder = 'ASC') THEN PaymentType  END ASC,                      
 CASE WHEN (@orderBy = 'PaymentType' AND @sortOrder = 'DESC') THEN PaymentType  END DESC,                
 CASE WHEN (@orderBy = 'ChequeNo' AND @sortOrder = 'ASC') THEN ChequeNo END ASC,                      
 CASE WHEN (@orderBy = 'ChequeNo' AND @sortOrder = 'DESC') THEN ChequeNo END DESC,                     
 CASE WHEN (@orderBy = 'BankName' AND @sortOrder = 'ASC') THEN BankName END ASC,              
 CASE WHEN (@orderBy = 'BankName' AND @sortOrder = 'DESC') THEN BankName  END DESC ,  
 CASE WHEN (@orderBy = 'ChequeFor' AND @sortOrder = 'ASC') THEN ChequeFor END ASC,              
 CASE WHEN (@orderBy = 'ChequeFor' AND @sortOrder = 'DESC') THEN ChequeFor  END DESC,       
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'ASC') THEN Remarks END ASC,              
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'DESC') THEN Remarks  END DESC,  
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'ASC') THEN CF.CreatedDate END ASC,              
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'DESC') THEN CF.CreatedDate  END DESC,  
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'ASC') THEN U.FirstName END ASC,              
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'DESC') THEN U.FirstName  END DESC         
              
	OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS              
	FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY              
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ContractorFinaceListForExport]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_ContractorFinaceListForExport]      
@siteId NVARCHAR(50)          
AS                  
BEGIN  
	DECLARE @TotalAmount DECIMAL(18,2) = (SELECT SUM(CF.Amount) FROM [tbl_ContractorFinance] CF INNER JOIN tbl_Sites S ON S.SiteId = CF.SiteId
                                          INNER JOIN tbl_Users U ON U.UserId = CF.UserId Where CF.IsDeleted = 0 AND CF.SiteId = @siteId )

SELECT CF.ContractorFinanceId, CF.SiteId, S.SiteName,CF.UserId, CF.SelectedDate, CF.Amount, CF.CreditOrDebit, CF.PaymentType, CF.ChequeNo, CF.BankName, CF.ChequeFor, CF.Remarks, U.FirstName AS [UserName],CF.IsActive, COUNT(*) OVER() AS TotalRecords , @TotalAmount as TotalAmount
FROM [tbl_ContractorFinance] CF INNER JOIN tbl_Sites S ON S.SiteId = CF.SiteId        
INNER JOIN tbl_Users U ON U.UserId = CF.UserId      
Where                  
CF.IsDeleted = 0 AND CF.SiteId = @siteId  
ORDER BY CF.CreatedDate ASC                         
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_DashboardInfo]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DashboardInfo] 
(  
@clientId NVARCHAR(50) = Null  
)  
AS    
BEGIN   

	IF(@clientId = '')
		BEGIN
			SET @clientId = NULL
		END

   DECLARE @SiteCount BIGINT, @MerchantCount BIGINT, @PersonCount BIGINT, @UserCount BIGINT, @VehicleOwnerCount BIGINT, @ClientCount BIGINT
   IF(@clientId IS NOT NULL)
   BEGIN
	   SET @SiteCount = (SELECT COUNT(*) FROM tbl_Sites WHERE IsActive = 1 AND IsDeleted = 0 AND  (@clientId IS NULL OR  ClientId = @clientId));  
	   SET @MerchantCount = (SELECT COUNT(*) FROM tbl_Merchant WHERE IsActive = 1 AND IsDeleted = 0 AND  (@clientId IS NULL OR ClientId = @clientId))    
	   SET @UserCount = (SELECT COUNT(*) FROM tbl_Users WHERE IsActive = 1 AND IsDeleted = 0 
	   AND (
			(@clientId IS NULL AND ClientId IS NOT NULL) OR 
			(@clientId IS NOT NULL AND ClientId = @clientId)
		));
	   SET @PersonCount = (SELECT COUNT(*) FROM tbl_Persons WHERE IsActive = 1 AND IsDeleted = 0 AND  (@clientId IS NULL OR ClientId = @clientId) AND IsAttendancePerson = 0)    
	   SET @VehicleOwnerCount = (SELECT COUNT(*) FROM tbl_VehicleOwner WHERE IsActive = 1 AND IsDeleted = 0 AND  (@clientId IS NULL OR ClientId = @clientId))    
   END
   ELSE
   BEGIN
	SET @ClientCount = (SELECT COUNT(*) FROM tbl_Clients WHERE IsActive = 1 AND IsDeleted = 0 )
   END
    
   SELECT @SiteCount AS SiteCount, @MerchantCount AS MerchantCount, @UserCount AS UserCount, @PersonCount AS PersonCount, @VehicleOwnerCount AS VehicleOwnerCount , @ClientCount AS ClientCount   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteChallan]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteChallan](    
@ChallanId VARCHAR(255),
@userId VARCHAR(255)
)    
AS    
BEGIN    
 UPDATE tbl_Challan SET IsDeleted = 1,IsActive = 0 ,ModifiedBy = @userId , ModifiedDate = GETUTCDATE() WHERE ChallanId = @ChallanId  
SELECT 1 AS IsSuccess, 'Record deleted successfully!' AS Result
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteClient]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DeleteClient]
(      
@clientId VARCHAR(255)  ,  
@userId VARCHAR(255)  
)      
AS      
BEGIN      
 UPDATE tbl_Clients SET IsDeleted = 1,IsActive = 0 , ModifiedDate = GETUTCDATE() WHERE ClientId = @clientId     
 select 1  
END  


  
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteContractFinance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteContractFinance]    
(          
@contractorFinanceId NVARCHAR(255),
@userId NVARCHAR(50)
)          
AS          
BEGIN          
 UPDATE [tbl_ContractorFinance] SET IsDeleted = 1,IsActive = 0 , ModifiedDate = GETUTCDATE(), UpdatedBy = @userId WHERE ContractorFinanceId = @contractorFinanceId         
 SELECT 1      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteEstimate]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteEstimate]  
(        
@EstimateId VARCHAR(255), 
@userId VARCHAR(255)    
)        
AS        
BEGIN      

 UPDATE tbl_Estimate SET IsDeleted = 1,IsActive = 0,ModifiedBy=@userId, ModifiedDate = GETUTCDATE() WHERE EstimateId = @EstimateId   
 SELECT 1
 
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteExpense]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteExpense]  
(        
@expenseId VARCHAR(255)  ,    
@userId VARCHAR(255)    
)        
AS        
BEGIN        
 UPDATE tbl_Expenses SET IsDeleted = 1,IsActive = 0 ,ModifiedBy = @userId , ModifiedDate = GETUTCDATE() WHERE ExpenseId = @expenseId      
 select 1    
END    
  
  
    
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteMerchant]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_DeleteMerchant]
@Id uniqueidentifier
As
Begin
	Update tbl_Merchant set IsDeleted=1 where MerchantId=@Id
	SELECT 1 AS IsSuccess, 'Record deleted successfully!' AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteMerchantPayment]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DeleteMerchantPayment](
	@Id NVARCHAR(MAX)
)
AS
BEGIN
	DELETE FROM tbl_MerchantPayment WHERE LOWER(MerchantPaymentId) = LOWER(@Id)
	SELECT 1 AS IsSuccess
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePerson]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_DeletePerson]
@Id nvarchar(max),
@userId VARCHAR(255)
As
Begin
	UPDATE tbl_Persons SET IsDeleted = 1,IsActive = 0 ,UpdatedBy = @userId , ModifiedDate = GETUTCDATE() WHERE PersonId=@Id  
	SELECT 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePersonAttendance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DeletePersonAttendance](
	@AttendanceId NVARCHAR(MAX),
	@LoggedId NVARCHAR(MAX)
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM tbl_Attendance WHERE AttendaceId = @AttendanceId
			DELETE FROM tbl_PersonAttendance WHERE AttendanceId = @AttendanceId
		COMMIT TRAN
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
		ROLLBACK TRAN
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePersonBill]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeletePersonBill]      
(            
@billId VARCHAR(255)  ,        
@userId VARCHAR(255)        
)            
AS            
BEGIN            
 UPDATE tbl_BillDebitNew SET IsDeleted = 1,IsActive = 0 ,ModifiedBy = @userId , ModifiedDate = GETUTCDATE() WHERE BillId = @billId  
 SELECT 1        
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePersonFinance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DeletePersonFinance]    
(          
@personFinanceId NVARCHAR(255),
@userId NVARCHAR(50)
)          
AS          
BEGIN          
 UPDATE [tbl_Finance] SET IsDeleted = 1,IsActive = 0 , ModifiedDate = GETUTCDATE(), UpdatedBy = @userId WHERE FinanceId = @personFinanceId         
 SELECT 1      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePersonGroup]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeletePersonGroup]
	@ClientId NVARCHAR(MAX),
	@PersonGroupId NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
			UPDATE tbl_PersonGroup SET IsDeleted = 1, IsActive = 0, ModifiedBy = @ClientId, ModifiedDate = GETUTCDATE() WHERE PersonGroupId = @PersonGroupId;

			UPDATE tbl_PersonGroupMap SET IsDeleted = 1, IsActive = 0 WHERE PersonGroupId = @PersonGroupId;
		COMMIT TRAN
		SELECT 4 AS IsSuccess, 'Person group deleted successfully' AS Result
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 0 AS IsSuccess, 'Error occured while deleting person group' AS Result
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSite]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteSite](    
@SiteId VARCHAR(255)  ,
@userId VARCHAR(255)
)    
AS    
BEGIN    
 UPDATE tbl_Sites SET IsDeleted = 1,IsActive = 0 ,UpdatedBy = @userId , ModifiedDate = GETUTCDATE() WHERE SiteId = @SiteId  
 select 1
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSiteBill]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteSiteBill]    
(          
@billId VARCHAR(255)  ,      
@userId VARCHAR(255)      
)          
AS          
BEGIN          
	DELETE FROM tbl_BillSiteItemNew WHERE BillId = @billId
	UPDATE tbl_BillSiteNew SET IsDeleted = 1,IsActive = 0 ,ModifiedBy = @userId , ModifiedDate = GETUTCDATE() WHERE BillId = @billId
	SELECT 1      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSitePhoto]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteSitePhoto](
@sitePhotoId NVARCHAR(255)
)
AS
BEGIN

	DELETE FROM [dbo].[tbl_SitePhoto] WHERE SitePhotoId = @SitePhotoId
	SELECT 1
		
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteSitePhotoCategory]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteSitePhotoCategory]        
(              
@sitePhotoCategoryId VARCHAR(255)  
)              
AS              
BEGIN              
 DELETE FROM [dbo].[tbl_SitePhotoCategory] WHERE SitePhotoCategoryId  = @sitePhotoCategoryId   
 SELECT 1          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUser]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_DeleteUser]  
(        
@userId VARCHAR(255)    
)        
AS        
BEGIN        
 UPDATE tbl_Users SET IsDeleted = 1,IsActive = 0 , ModifiedDate = GETUTCDATE() WHERE UserId = @userId       
 select 1    
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteVehicleOwner]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteVehicleOwner]  
(        
@VehicleOwnerId VARCHAR(255)  ,    
@userId VARCHAR(255)    
)        
AS        
BEGIN      

 UPDATE tbl_VehicleOwner SET IsDeleted = 1,IsActive = 0 , ModifiedDate = GETUTCDATE() WHERE VehicleOwnerId = @VehicleOwnerId       
 SELECT 1
 
END    
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteVehicleRent]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE  [dbo].[SP_DeleteVehicleRent]  
@VehicleRentId uniqueidentifier  
As  
Begin  
 delete from tbl_VehicleRent where VehicleRentId=@VehicleRentId  
 SELECT 1 AS IsSuccess, 'Vehicle rent deleted successfully.' AS Result  
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_EstimateList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  








  -- EXEC SP_EstimateList 1,100,'','','','93A147DF-05B9-4F93-8C2D-0E3FB7CB99F6','2024-04-01T18:30:00.000Z','2024-06-12T18:29:44.687Z'  
CREATE PROCEDURE [dbo].[SP_EstimateList]
    @pageIndex INT = 1,
    @pageSize INT = 10,
    @orderBy NVARCHAR(100) = '',
    @sortOrder NVARCHAR(10) = 'ASC',
    @strSearch NVARCHAR(250) = NULL,
    @clientId NVARCHAR(50),
    @startDate NVARCHAR(100),
    @endDate NVARCHAR(100)
AS
BEGIN
    DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId FROM [tbl_FileCategory] WHERE FileCategoryName = 'Estimate');

    SET @strSearch = LTRIM(RTRIM(@strSearch));
    SET @orderBy = LTRIM(RTRIM(@orderBy));
    SET @sortOrder = LTRIM(RTRIM(@sortOrder));

    IF(ISNULL(@orderBy, '') = '')
    BEGIN
        SET @orderBy = 'CreatedDate';
    END

    IF(ISNULL(@sortOrder, '') = '')
    BEGIN
        SET @sortOrder = 'DESC';
    END

    IF(ISNULL(@PageSize, 0) = 0)
    BEGIN
        SET @PageSize = 10;
    END

    ELSE IF(ISNULL(@PageSize, 0) = -1)
    BEGIN
        SET @PageSize = 500000000;
    END

    SELECT
        E.EstimateId,
        E.EstimateDate,
        E.PartyName,
        E.TotalAmount,
        E.Remarks,
        E.EstimateType,
        E.CreatedDate,
        E.IsActive,
        COUNT(*) OVER () AS TotalRecords,
        F.EncryptFileName AS EstimateFile,
        CASE WHEN EXISTS (SELECT * FROM tbl_EstimateItem EI WHERE EI.EstimateId = E.EstimateId) THEN 1 ELSE 0 END AS HasItems
    FROM
        tbl_Estimate E
    LEFT JOIN
        tbl_Files F ON E.EstimateId = F.ParentId AND F.FileCategory = @FileCategoryId
    WHERE
		E.ClientId = @clientId AND
        E.EstimateDate >= @startDate AND E.EstimateDate <= @endDate
        AND E.IsDeleted = 0
        AND (ISNULL(@strSearch, '') = ''
            OR E.EstimateDate LIKE '%' + @strSearch + '%'
            OR E.PartyName LIKE '%' + @strSearch + '%'
            OR E.TotalAmount LIKE '%' + @strSearch + '%'
            OR (CASE WHEN E.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')
    ORDER BY
        CASE WHEN @orderBy = 'EstimateDate' AND @sortOrder = 'ASC' THEN E.EstimateDate END ASC,
        CASE WHEN @orderBy = 'EstimateDate' AND @sortOrder = 'DESC' THEN E.EstimateDate END DESC,
        CASE WHEN @orderBy = 'PartyName' AND @sortOrder = 'ASC' THEN E.PartyName END ASC,
        CASE WHEN @orderBy = 'PartyName' AND @sortOrder = 'DESC' THEN E.PartyName END DESC,
        CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder = 'ASC' THEN E.TotalAmount END ASC,
        CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder = 'DESC' THEN E.TotalAmount END DESC,
        CASE WHEN @orderBy = 'IsActive' AND @sortOrder = 'ASC' THEN E.IsActive END ASC,
        CASE WHEN @orderBy = 'IsActive' AND @sortOrder = 'DESC' THEN E.IsActive END DESC,
        CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'ASC' THEN E.CreatedDate END ASC,
        CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'DESC' THEN E.CreatedDate END DESC
    OFFSET ((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS
    FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ExpenseListForExport]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ExpenseListForExport] (
	@ClientId NVARCHAR(MAX),
	@ExpenseTypeId VARCHAR(MAX) = NULL,
	@SiteId VARCHAR(MAX) = NULL,
	@StatusId VARCHAR(MAX) = NULL 
) 
AS
BEGIN
	SELECT 
		E.ExpenseId,
		E.ExpenseDate,
		ET.ExpenseType,
		E.Amount,
		E.[Description],
		ISNULL(S.SiteName,'') AS SiteName,
		E.IsActive,
		COUNT(*) OVER() AS TotalRecords  
	FROM tbl_Expenses E INNER JOIN tbl_ExpenseType ET ON E.ExpenseTypeId = ET.ExpenseTypeId
	LEFT JOIN tbl_Sites S ON S.SiteId = E.SiteId 
	WHERE E.IsDeleted = 0 AND E.ClientId = @ClientId
	AND ((1=1 AND ISNULL(@ExpenseTypeId,'')=''OR(E.ExpenseTypeId IN (SELECT value FROM string_split(@ExpenseTypeId,',')))))
	AND ((1=1 AND ISNULL(@SiteId,'')=''OR(E.SiteId IN (SELECT value FROM string_split(@SiteId,',')))))
	AND ((1=1 AND ISNULL(@StatusId,'')=''OR(E.IsActive IN (SELECT value FROM string_split(@StatusId,',')))))
	ORDER BY E.ExpenseDate ASC  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveClient]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetActiveClient]
AS
BEGIN
	Select ClientId,ClientName from tbl_Clients where IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActivePersonTypeList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetActivePersonTypeList]
AS
BEGIN
	Select Id,PersonType from tbl_PersonType
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveSiteList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetActiveSiteList](
@clientId NVARCHAR(50)
)
AS
BEGIN

SELECT SiteId,SiteName FROM tbl_Sites WHERE IsActive = 1 AND IsDeleted = 0 AND ClientId = @clientId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveSitePhotoCategoryList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetActiveSitePhotoCategoryList]           
@clientId NVARCHAR(250)   
AS                  
BEGIN             
          

SELECT SitePhotoCategoryId,CategoryName                
from tbl_SitePhotoCategory C                  
Where       
ClientId = @clientId 
ORDER BY CategoryName ASC        
                
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActiveUserList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetActiveUserList] 
(  
@clientId NVARCHAR(50)  
)  
AS  
BEGIN  
  
SELECT UserId,FirstName as [Name], EmailId, IsActive FROM tbl_Users WHERE IsActive = 1 AND IsDeleted = 0 and ClientId = @clientId  ORDER BY [Name] ASC
END  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllInOneList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
CREATE PROCEDURE  [dbo].[SP_GetAllInOneList]     
@pageIndex INT = 1,            
@pageSize INT = 10,            
@orderBy NVARCHAR(100) = '' ,            
@sortOrder NVARCHAR(10) = 'asc',            
@strSearch NVARCHAR(250) = null
AS            
BEGIN       
     
SET @strSearch = LTRIM(RTRIM(@strSearch))            
            
 SET @orderBy = LTRIM(RTRIM(@orderBy))            
SET @sortOrder = LTRIM(RTRIM(@sortOrder))        
    
IF(ISNULL(@orderBy, '') = '')            
BEGIN            
SET  @orderBy = 'CreatedDate'            
END     
    
IF(ISNULL(@sortOrder, '') = '')            
BEGIN            
            
SET @sortOrder = 'DESC'            
END       
    
IF(ISNULL(@PageSize, 0) = 0)            
BEGIN            
SET @PageSize = 10            
END            
IF(ISNULL(@PageSize, 0) = 0)            
    
BEGIN            
SET @PageSize = 10            
END    
    
else  IF(ISNULL(@PageSize,0) = -1)            
    
BEGIN            
SET @PageSize = 500000000              
END            
    
SELECT PersonId AS AllInOneId,PersonFirstName AS [Name],PersonAddress AS [Address],MobileNo AS Phone,COUNT(*) OVER() AS TotalRecords          
from tbl_Persons             
Where                 
 (ISNULL(@strSearch, '') = ''            
 OR PersonFirstName Like '%' + @strSearch + '%'            
 OR PersonAddress Like '%' + @strSearch + '%'            
 OR MobileNo Like '%' + @strSearch + '%')            
ORDER BY             
             
 CASE WHEN @orderBy = 'Name' AND @sortOrder ='ASC' THEN PersonFirstName END ASC, 
 CASE WHEN @orderBy = 'Name' AND @sortOrder ='DESC' THEN PersonFirstName END DESC,            
            
 CASE WHEN @orderBy = 'Address' AND @sortOrder ='ASC' THEN PersonAddress END ASC, 
 CASE WHEN @orderBy = 'Address' AND @sortOrder ='DESC' THEN PersonAddress END DESC,           
             
 CASE WHEN @orderBy = 'Phone' AND @sortOrder ='ASC' THEN MobileNo END ASC,  
 CASE WHEN @orderBy = 'Phone' AND @sortOrder ='DESC' THEN MobileNo END DESC           
             
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS           
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY            
          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAttendedPersonList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec SP_GetPersonList 1,10,'','',''      
CREATE PROCEDURE  [dbo].[SP_GetAttendedPersonList]      
@pageIndex int = 1,      
@pageSize int = 10,      
@orderBy varchar(100) = '' ,      
@sortOrder varchar(10) = 'asc',      
@strSearch varchar(250) = '',       
@clientId NVARCHAR(255) = NULL,
@activeInActiveStatus NVARCHAR(10)  
AS      
BEGIN      
SET @strSearch = LTRIM(RTRIM(@strSearch))      
      
 SET @orderBy = LTRIM(RTRIM(@orderBy))    
SET @sortOrder = LTRIM(RTRIM(@sortOrder))      
IF(ISNULL(@orderBy, '') = '')      
BEGIN      
SET  @orderBy = 'CreatedDate'      
END      
IF(ISNULL(@sortOrder, '') = '')      
BEGIN      
      
SET @sortOrder = 'DESC'      
END      
IF(ISNULL(@PageSize, 0) = 0)      
BEGIN      
SET @PageSize = 10      
END      
IF(ISNULL(@PageSize, 0) = 0)      
BEGIN      
SET @PageSize = 10      
END      
else  IF(ISNULL(@PageSize,0) = -1)      
BEGIN      
SET @PageSize = 500000000        
END      
select P.PersonId,P.PersonFirstName,P.PersonAddress,P.MobileNo,P.PersonPhoto,P.DailyRate,ISNULL(P.PersonTypeId,0) [PersonTypeId],PT.PersonType      
,ISNULL(PT.PersonType,'') PersonType,P.IsAttendancePerson,P.OrderNo,P.ClientId,C.ClientName,U.FirstName [createdBy],CONVERT(varchar, P.CreatedDate, 120) CreatedDate, P.IsActive ,COUNT(*) OVER() AS TotalRecords       
,Case when P.IsActive=1 then 'Active' Else 'InActive' END [Status]      
from tbl_Persons P      
Left join tbl_PersonType PT on PT.Id=P.PersonTypeId      
Left join tbl_Clients C on C.ClientId=P.ClientId      
Left Join tbl_Users U on U.UserId=P.CreatedBy      
Where ISNULL(P.isdeleted,0)= 0 AND P.ClientId = @clientId  AND P.IsAttendancePerson = 1
AND P.IsActive IN (SELECT value FROM STRING_SPLIT(@activeInActiveStatus, ',')) AND    
 (ISNULL(@strSearch, '') = '' 
 OR PersonFirstName Like '%' + @strSearch + '%'      
 OR PersonAddress Like '%' + @strSearch + '%'      
 OR P.MobileNo Like '%' + @strSearch + '%'      
 OR DailyRate Like '%' + @strSearch + '%'      
 OR PersonTypeId Like '%' + @strSearch + '%'      
 OR OrderNo Like '%' + @strSearch + '%'      
 OR (CASE WHEN P.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')      
ORDER BY       
       
 CASE WHEN @orderBy = 'PersonId' AND @sortOrder ='ASC' THEN PersonId END ASC,      
 CASE WHEN @orderBy = 'PersonId' AND @sortOrder ='DESC' THEN PersonId END DESC,      
 CASE WHEN @orderBy = 'PersonFirstName' AND @sortOrder ='ASC' THEN PersonFirstName END ASC,      
 CASE WHEN @orderBy = 'PersonFirstName' AND @sortOrder ='DESC' THEN PersonFirstName END DESC,       
 CASE WHEN @orderBy = 'PersonAddress' AND @sortOrder ='ASC' THEN PersonAddress END ASC,      
 CASE WHEN @orderBy = 'PersonAddress' AND @sortOrder ='DESC' THEN PersonAddress END DESC,       
 CASE WHEN @orderBy = 'MobileNo' AND @sortOrder ='ASC' THEN P.MobileNo END ASC,      
 CASE WHEN @orderBy = 'MobileNo' AND @sortOrder ='DESC' THEN P.MobileNo END DESC,       
 CASE WHEN @orderBy = 'PersonPhoto' AND @sortOrder ='ASC' THEN PersonPhoto END ASC,      
 CASE WHEN @orderBy = 'PersonPhoto' AND @sortOrder ='DESC' THEN PersonPhoto END DESC,       
 CASE WHEN @orderBy = 'DailyRate' AND @sortOrder ='ASC' THEN DailyRate END ASC,      
 CASE WHEN @orderBy = 'DailyRate' AND @sortOrder ='DESC' THEN DailyRate END DESC,       
 CASE WHEN @orderBy = 'PersonTypeId' AND @sortOrder ='ASC' THEN PersonTypeId END ASC,      
 CASE WHEN @orderBy = 'PersonTypeId' AND @sortOrder ='DESC' THEN PersonTypeId END DESC,       
 CASE WHEN @orderBy = 'IsAttendancePerson' AND @sortOrder ='ASC' THEN IsAttendancePerson END ASC,      
 CASE WHEN @orderBy = 'IsAttendancePerson' AND @sortOrder ='DESC' THEN IsAttendancePerson END DESC,       
 CASE WHEN @orderBy = 'OrderNo' AND @sortOrder ='ASC' THEN OrderNo END ASC,      
 CASE WHEN @orderBy = 'OrderNo' AND @sortOrder ='DESC' THEN OrderNo END DESC,       
 CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='ASC' THEN P.ClientId END ASC,      
 CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='DESC' THEN P.ClientId END DESC,       
 CASE WHEN @orderBy = 'CreatedBy' AND @sortOrder ='ASC' THEN CreatedBy END ASC,      
 CASE WHEN @orderBy = 'CreatedBy' AND @sortOrder ='DESC' THEN CreatedBy END DESC,       
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN P.CreatedDate END ASC,      
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN P.CreatedDate END DESC,      
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN P.IsActive END ASC,              
    CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN P.IsActive END DESC      
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS      
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY      
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCategoryListForSite]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCategoryListForSite](  
@siteId NVARCHAR(255)  
)  
AS  
BEGIN  
SELECT DISTINCT C.CategoryName, C. SitePhotoCategoryId FROM [dbo].[tbl_SitePhotoCategory] C  
INNER JOIN [dbo].[tbl_SitePhoto] P ON P.SitePhotoCategoryId = C.SitePhotoCategoryId where SiteId = @siteId 
  
SELECT P.PhotoName, P.SitePhotoId,P.SitePhotoCategoryId, P.SiteId  FROM [dbo].[tbl_SitePhotoCategory] C INNER JOIN [dbo].[tbl_SitePhoto] P ON P.SitePhotoCategoryId = C.SitePhotoCategoryId  where SiteId = @siteId
  
END  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChallanDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetChallanDetailById]    
(            
@ChallanId VARCHAR(255)            
)            
AS            
BEGIN      
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Challan')     
  
  SELECT c.ChallanId,c.ChallanDate,c.ChallanNo,c.SiteId,  
   F.EncryptFileName AS ChallanPhoto,s.SiteName,m.MerchantName,  
  c.MerchantId,c.CarNo,c.Remarks,c.ClientId    
  FROM tbl_Challan c    
 left join tbl_Merchant m on m.MerchantId =c.MerchantId  
 left join tbl_Sites s on s.SiteId=c.SiteId  
 left join tbl_Files F ON c.ChallanId = F.ParentId and F.FileCategory = @FileCategoryId   
  WHERE c.ChallanId = @ChallanId       
END      
      
      
GO
/****** Object:  StoredProcedure [dbo].[SP_GetChallanImageName]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetChallanImageName]
(            
@challanId VARCHAR(255)            
)            
AS            
BEGIN      
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Challan')     


select f.EncryptFileName as ChallanPhoto from tbl_Challan as c left join tbl_Files F ON c.ChallanId = F.ParentId and F.FileCategory = @FileCategoryId   
where ChallanId =  @challanId


END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClientDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetClientDetailById]
(          
@clientId VARCHAR(255)          
)          
AS          
BEGIN          
 SELECT ClientId, ClientName, FirmName,[Address],[ExpireDate], PackageTypeId, Remarks, HeaderImageLetterPage, FooterImageLetterPage, IsActive FROM tbl_Clients WHERE ClientId = @clientId   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetContractorFinaceById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetContractorFinaceById]    
(                
@contractorFinanceId VARCHAR(255)                
)                
AS                
BEGIN                
 SELECT  ContractorFinanceId,SiteId,UserId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,ChequeFor,ChequeFor,IsActive, Remarks   FROM tbl_ContractorFinance CF  WHERE CF.ContractorFinanceId = @contractorFinanceId      
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEstimateById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetEstimateById](          
@EstimateId VARCHAR(255)          
)          
AS          
BEGIN      
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Estimate')   
 SELECT EstimateId,EstimateDate,PartyName,TotalAmount,IsActive,Remarks, F.EncryptFileName AS EstimateFile FROM tbl_Estimate E  
 LEFT JOIN tbl_Files F ON E.EstimateId = F.ParentId and F.FileCategory = @FileCategoryId  WHERE EstimateId = @EstimateId  
END    
  
    
    
    
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExpenseDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetExpenseDetailById]
(        
@expenseId VARCHAR(255)        
)        
AS        
BEGIN  

	DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Expense') 

	 SELECT ExpenseId, ExpenseDate, ExpenseTypeId, Amount,Description, SiteId, IsActive, F.EncryptFileName AS ExpenseFile
	 FROM tbl_Expenses E
	 LEFT JOIN tbl_Files F ON E.ExpenseId = F.ParentId and F.FileCategory = @FileCategoryId
	 WHERE E.ExpenseId = @expenseId   

END  
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExpenseList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetExpenseList]   
@pageIndex INT = 1,          
@pageSize INT = 10,          
@orderBy NVARCHAR(100) = '' ,          
@sortOrder NVARCHAR(10) = 'asc',          
@strSearch NVARCHAR(250) = null,
@clientId NVARCHAR(250),
@startDate DATETIME,
@endDate DATETIME,
@expenseTypeId NVARCHAR(MAX),
@siteId NVARCHAR(MAX),
@activeInActiveStatus NVARCHAR(10)
AS          
BEGIN     
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Expense')     
  
SET @strSearch = LTRIM(RTRIM(@strSearch))          
          
 SET @orderBy = LTRIM(RTRIM(@orderBy))          
SET @sortOrder = LTRIM(RTRIM(@sortOrder))      
	
IF(ISNULL(@orderBy, '') = '')          
BEGIN          
SET  @orderBy = 'CreatedDate'          
END   
  
IF(ISNULL(@sortOrder, '') = '')          
BEGIN          
          
SET @sortOrder = 'DESC'          
END     
  
IF(ISNULL(@PageSize, 0) = 0)          
BEGIN          
SET @PageSize = 10          
END          
IF(ISNULL(@PageSize, 0) = 0)          
  
BEGIN          
SET @PageSize = 10          
END  
  
else  IF(ISNULL(@PageSize,0) = -1)          
  
BEGIN          
SET @PageSize = 500000000            
END          
  
SELECT E.ExpenseId, E.ExpenseDate, ET.ExpenseType, E.Amount, E.[Description],    
S.SiteName,     
 F.EncryptFileName AS ExpenseFile ,  
E.IsActive,COUNT(*) OVER() AS TotalRecords        
from tbl_Expenses E          
INNER JOIN tbl_ExpenseType ET on ET.ExpenseTypeId = E.ExpenseTypeId    
LEFT JOIN tbl_Files F ON E.ExpenseId = F.ParentId and F.FileCategory = @FileCategoryId    
left JOIN tbl_Sites S on S.SiteId = E.SiteId          
Where          
E.IsDeleted = 0 AND E.ClientId = @clientId
AND (
    E.ExpenseDate >= @startDate
    AND
    E.ExpenseDate <= @endDate
)
AND E.ExpenseTypeId IN (SELECT value FROM STRING_SPLIT(@expenseTypeId, ','))
AND (ISNULL(@siteId, '') = '' or E.SiteId  IN (SELECT value FROM STRING_SPLIT(@siteId, ',')))
AND E.IsActive IN (SELECT value FROM STRING_SPLIT(@activeInActiveStatus, ','))
AND
 (ISNULL(@strSearch, '') = ''          
 OR ExpenseId Like '%' + @strSearch + '%'          
 OR ExpenseDate Like '%' + @strSearch + '%'          
 OR ET.ExpenseType Like '%' + @strSearch + '%'          
 OR Amount Like '%' + @strSearch + '%'          
 OR Description Like '%' + @strSearch + '%'
 OR (CASE WHEN E.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) Like '%' + @strSearch + '%'
 )          
ORDER BY           
           
 CASE WHEN @orderBy = 'ExpenseId' AND @sortOrder ='ASC' THEN ExpenseId END ASC,          
          
 CASE WHEN @orderBy = 'ExpenseId' AND @sortOrder ='DESC' THEN ExpenseId END DESC,          
           
 CASE WHEN @orderBy = 'ExpenseDate' AND @sortOrder ='ASC' THEN ExpenseDate END ASC,          
          
 CASE WHEN @orderBy = 'ExpenseDate' AND @sortOrder ='DESC' THEN ExpenseDate END DESC,          
           
 CASE WHEN @orderBy = 'ExpenseType' AND @sortOrder ='ASC' THEN ExpenseType END ASC,          
          
 CASE WHEN @orderBy = 'ExpenseType' AND @sortOrder ='DESC' THEN ExpenseType END DESC,          
           
 CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='ASC' THEN S.ClientId END ASC,          
          
 CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='DESC' THEN S.ClientId END DESC,          
           
 CASE WHEN @orderBy = 'Amount' AND @sortOrder ='ASC' THEN Amount END ASC,          
          
 CASE WHEN @orderBy = 'Amount' AND @sortOrder ='DESC' THEN Amount END DESC,          
           
 CASE WHEN @orderBy = 'Description' AND @sortOrder ='ASC' THEN [Description] END ASC,          
          
 CASE WHEN @orderBy = 'Description' AND @sortOrder ='DESC' THEN [Description] END DESC,          
           
 CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='ASC' THEN S.SiteName END ASC,          
          
 CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='DESC' THEN S.SiteName END DESC,          
           
 CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='ASC' THEN E.IsActive END ASC,          
          
 CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='DESC' THEN E.IsActive END DESC,          
           
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN E.CreatedDate END ASC,          
          
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN E.CreatedDate END DESC          
           
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS          
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY          
        
END

SELECT * FROM tbl_Expenses
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMarchantList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_GetMarchantList]          
AS          
BEGIN                
  select MerchantId,MerchantName from tbl_Merchant  ORDER BY MerchantName ASC
END    
    
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMerchantById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetMerchantById '4F389DB6-38B6-4B8C-B0FD-DCC8B5BBA61E'
CREATE PROCEDURE  [dbo].[SP_GetMerchantById]
@Id nvarchar(max)
As
Begin
select MerchantId,MerchantName,FirmName,MobileNo,Address,ClientId from tbl_Merchant where MerchantId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMerchantPaymentById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GetMerchantPaymentById](
	@Id NVARCHAR(MAX)
)
AS
BEGIN
	SELECT MerchantPaymentId,PaymentDate,ClientId,SiteId,MerchantId,Amount,PaymentType,ChequeNo,BankName,ChequeFor,Remarks 
	FROM tbl_MerchantPayment WHERE MerchantPaymentId = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPackageTypeList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPackageTypeList]  
AS  
BEGIN  
SELECT * FROM tbl_PackageType   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonAttendanceById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GetPersonAttendanceById](    
 @AttendanceId NVARCHAR(MAX)    
)    
AS    
BEGIN    
 SELECT AttendaceId AS AttendanceId,AttendanceDate,ClientId     
 FROM tbl_Attendance WHERE AttendaceId = @AttendanceId    
    
 SELECT PA.PersonAttendanceId,PA.PersonId, P.PersonFirstName AS PersonName ,PA.AttendanceStatus,PA.SiteId,PA.WithdrawAmount,PA.OvertimeAmount,PA.Remarks     
 FROM tbl_PersonAttendance PA
 INNER JOIN tbl_Persons P ON PA.PersonId = P.PersonId
 WHERE PA.AttendanceId = @AttendanceId    
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonBillDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPersonBillDetailById]      
(              
@billId VARCHAR(255)              
)              
AS              
BEGIN        
      
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit')       
      
  SELECT BillId,BillDate,BillNo, TotalAmount,Remarks, F.EncryptFileName AS SiteBillFile    
  FROM tbl_BillDebitNew E      
  LEFT JOIN tbl_Files F ON E.BillId = F.ParentId and F.FileCategory = @FileCategoryId      
  WHERE E.BillId = @billId    
      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonBillList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetPersonBillList]         
@pageIndex INT = 1,                
@pageSize INT = 10,                
@orderBy NVARCHAR(100) = '' ,                
@sortOrder NVARCHAR(10) = 'asc',                
@strSearch NVARCHAR(250) = null,      
@personId NVARCHAR(250)       
AS                
BEGIN           
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit')           
        
SET @strSearch = LTRIM(RTRIM(@strSearch))                
                
 SET @orderBy = LTRIM(RTRIM(@orderBy))                
SET @sortOrder = LTRIM(RTRIM(@sortOrder))            
        
IF(ISNULL(@orderBy, '') = '')                
BEGIN                
SET  @orderBy = 'CreatedDate'                
END         
        
IF(ISNULL(@sortOrder, '') = '')                
BEGIN                  
SET @sortOrder = 'DESC'                
END           
        
IF(ISNULL(@PageSize, 0) = 0)                  
BEGIN                
SET @PageSize = 10                
END        
ELSE  IF(ISNULL(@PageSize,0) = -1)                
BEGIN                
SET @PageSize = 500000000                  
END                
        
SELECT B.BillId,B.BillDate,B.BillNo, B.SiteId,B.TotalAmount, B.BillType, B.Remarks, F.EncryptFileName AS  SiteBillFile,COUNT(*) OVER() AS TotalRecords              
from tbl_BillDebitNew B                          
LEFT JOIN tbl_Files F ON B.BillId = F.ParentId and F.FileCategory = @FileCategoryId          
Where                
B.IsDeleted = 0 AND B.PersonId = @personId AND           
 (ISNULL(@strSearch, '') = ''                
 OR BillDate Like '%' + @strSearch + '%'                
 OR BillNo Like '%' + @strSearch + '%'                
 OR TotalAmount Like '%' + @strSearch + '%'                
 OR BillType Like '%' + @strSearch + '%'      
 OR Remarks Like '%' + @strSearch + '%'      
 )                
ORDER BY                 
 CASE WHEN @orderBy = 'BillDate' AND @sortOrder ='ASC' THEN BillDate END ASC,                
                
 CASE WHEN @orderBy = 'BillDate' AND @sortOrder ='DESC' THEN BillDate END DESC,                
                 
 CASE WHEN @orderBy = 'BillNo' AND @sortOrder ='ASC' THEN BillNo END ASC,                
                
 CASE WHEN @orderBy = 'BillNo' AND @sortOrder ='DESC' THEN BillNo END DESC,                
                 
 CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='ASC' THEN TotalAmount END ASC,                
                
 CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='DESC' THEN TotalAmount END DESC,                
                 
 CASE WHEN @orderBy = 'BillType' AND @sortOrder ='ASC' THEN BillType END ASC,                
                
 CASE WHEN @orderBy = 'BillType' AND @sortOrder ='DESC' THEN BillType END DESC,                
                 
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='ASC' THEN Remarks END ASC,                
                
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='DESC' THEN Remarks END DESC,                       
                 
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN B.CreatedDate END ASC,                
                
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN B.CreatedDate END DESC                
                 
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS                
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY                
              
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetPersonById]  
@Id nvarchar(max)  
As  
Begin  
 select P.PersonId,P.PersonFirstName,P.PersonAddress,P.MobileNo,P.PersonPhoto,P.DailyRate,P.PersonTypeId [id]  
 ,PT.PersonType,P.IsAttendancePerson,P.OrderNo,P.ClientId,C.ClientName,U.FirstName, P.IsActive [Status]  
 from tbl_Persons P  
 left join tbl_PersonType PT on PT.Id=P.PersonTypeId  
 Inner join tbl_Clients C on C.ClientId=P.ClientId  
 Inner Join tbl_Users U on U.UserId=P.CreatedBy  
 where PersonId=@Id  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonFinaceById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPersonFinaceById]      
(                  
@personFinanceId VARCHAR(255)                  
)                  
AS                  
BEGIN                  
 SELECT  CF.FinanceId,CF.PersonId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,ChequeFor,ChequeFor,IsActive, Remarks   FROM tbl_Finance CF  WHERE CF.FinanceId = @personFinanceId        
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonFinanceById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE [dbo].[SP_GetContractorFinaceById]      
--(                  
--@contractorFinanceId VARCHAR(255)                  
--)                  
--AS                  
--BEGIN                  
-- SELECT  ContractorFinanceId,SiteId,UserId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,ChequeFor,ChequeFor,IsActive, Remarks   FROM tbl_ContractorFinance CF  WHERE CF.ContractorFinanceId = @contractorFinanceId        
--END   


CREATE PROCEDURE [dbo].[SP_GetPersonFinanceById]      
(                  
@personFinanceId VARCHAR(255)                  
)                  
AS                  
BEGIN                  
 SELECT  CF.FinanceId,SiteId,CF.PersonId,GivenAmountBy as UserId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,ChequeFor,ChequeFor,IsActive, Remarks   FROM tbl_Finance CF  WHERE CF.FinanceId = @personFinanceId        
END   

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonGroupList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetPersonGroupList]
@pageIndex int = 1,
@pageSize int = 10,
@orderBy varchar(100) = '' ,
@sortOrder varchar(10) = 'asc',
@strSearch varchar(250) = '',
@clientId NVARCHAR(250) 
AS
BEGIN
SET @strSearch = LTRIM(RTRIM(@strSearch))

 SET @orderBy = LTRIM(RTRIM(@orderBy))
SET @sortOrder = LTRIM(RTRIM(@sortOrder))
IF(ISNULL(@orderBy, '') = '')
BEGIN
SET  @orderBy = 'CreatedDate'
END
IF(ISNULL(@sortOrder, '') = '')
BEGIN

SET @sortOrder = 'DESC'
END
IF(ISNULL(@PageSize, 0) = 0)
BEGIN
SET @PageSize = 10
END
IF(ISNULL(@PageSize, 0) = 0)
BEGIN
SET @PageSize = 10
END
else  IF(ISNULL(@PageSize,0) = -1)
BEGIN
SET @PageSize = 500000000  
END
select P.PersonGroupId,P.GroupName, P.IsActive ,(SELECT COUNT(*) FROM tbl_PersonGroupMap PGM WHERE PGM.PersonGroupId = P.PersonGroupId) AS PersonCount ,CONVERT(varchar, P.CreatedDate, 120) CreatedDate,COUNT(*) OVER() AS TotalRecords 
from tbl_PersonGroup P
Where ISNULL(P.IsDeleted,0)= 0 AND P.ClientId = @clientId AND
 (ISNULL(@strSearch, '') = ''
 OR P.GroupName Like '%' + @strSearch + '%'
 OR P.ClientId Like '%' + @strSearch + '%'
 OR P.CreatedBy Like '%' + @strSearch + '%'
 OR P.CreatedDate Like '%' + @strSearch + '%')
ORDER BY 
	CASE WHEN @orderBy = 'PersonGroupId' AND @sortOrder ='ASC' THEN P.PersonGroupId END ASC,
	CASE WHEN @orderBy = 'PersonGroupId' AND @sortOrder ='DESC' THEN P.PersonGroupId END DESC,
	CASE WHEN @orderBy = 'GroupName' AND @sortOrder ='ASC' THEN P.GroupName END ASC,
	CASE WHEN @orderBy = 'GroupName' AND @sortOrder ='DESC' THEN P.GroupName END DESC,
	CASE WHEN @orderBy = 'PersonCount' AND @sortOrder ='ASC' THEN (SELECT COUNT(*) FROM tbl_PersonGroupMap PGM WHERE PGM.PersonGroupId = P.PersonGroupId) END ASC,
	CASE WHEN @orderBy = 'PersonCount' AND @sortOrder ='DESC' THEN (SELECT COUNT(*) FROM tbl_PersonGroupMap PGM WHERE PGM.PersonGroupId = P.PersonGroupId) END DESC,
	CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='ASC' THEN P.ClientId END ASC,
	CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='DESC' THEN P.ClientId END DESC, 
	CASE WHEN @orderBy = 'CreatedBy' AND @sortOrder ='ASC' THEN CreatedBy END ASC,
	CASE WHEN @orderBy = 'CreatedBy' AND @sortOrder ='DESC' THEN CreatedBy END DESC, 
	CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN P.CreatedDate END ASC,
	CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN P.CreatedDate END DESC,
	CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN P.IsActive END ASC,        
    CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN P.IsActive END DESC
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY
END




GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPersonList]        
@pageIndex int = 1,        
@pageSize int = 10,        
@orderBy varchar(100) = '' ,        
@sortOrder varchar(10) = 'asc',        
@strSearch varchar(250) = '',         
@clientId NVARCHAR(255) = NULL,
@startDate DATETIME,    
@endDate DATETIME,
@activeInActiveStatus NVARCHAR(10)
AS        
BEGIN        
    SET @strSearch = LTRIM(RTRIM(@strSearch))        
    SET @orderBy = LTRIM(RTRIM(@orderBy))        
    SET @sortOrder = LTRIM(RTRIM(@sortOrder))        
  
    IF(ISNULL(@orderBy, '') = '')        
    BEGIN        
        SET @orderBy = 'CreatedDate'        
    END        
  
    IF(ISNULL(@sortOrder, '') = '')        
    BEGIN        
        SET @sortOrder = 'DESC'        
    END        
  
    IF(ISNULL(@PageSize, 0) = 0)        
    BEGIN        
        SET @PageSize = 10        
    END        
  
    IF(ISNULL(@PageSize, 0) = 0)        
    BEGIN        
        SET @PageSize = 10        
    END        
    ELSE IF(ISNULL(@PageSize,0) = -1)        
    BEGIN        
        SET @PageSize = 500000000          
    END        
  
    SELECT   
        P.PersonId,  
        P.PersonFirstName,  
        P.PersonAddress,  
        P.MobileNo,  
        P.PersonPhoto,  
        P.DailyRate,  
        ISNULL(P.PersonTypeId, 0) [PersonTypeId],  
        PT.PersonType,  
        ISNULL(PT.PersonType, '') PersonType,  
        P.IsAttendancePerson,  
        P.OrderNo,  
        P.ClientId,  
        C.ClientName,  
        U.FirstName [createdBy],  
        CONVERT(varchar, P.CreatedDate, 120) CreatedDate,  
        P.IsActive,  
        COUNT(*) OVER() AS TotalRecords,  
        CASE   
            WHEN P.IsActive = 1 THEN 'Active'   
            ELSE 'Inactive'   
        END [Status],  
        ISNULL(F.CreditAmount, 0) AS CreditAmount,  
        ISNULL(BDN.BillAmount, 0) AS BillAmount,  
        ISNULL(F.CreditAmount, 0) - ISNULL(BDN.BillAmount, 0) AS Remaining  
    FROM tbl_Persons P        
    LEFT JOIN tbl_PersonType PT ON PT.Id = P.PersonTypeId        
    LEFT JOIN tbl_Clients C ON C.ClientId = P.ClientId        
    LEFT JOIN tbl_Users U ON U.UserId = P.CreatedBy  
    LEFT JOIN (    
        SELECT   
            F.PersonId,   
            SUM(F.Amount) AS CreditAmount       
        FROM tbl_Finance F       
        WHERE F.IsDeleted = 0    
		AND (ISNULL(@startDate,'')='' OR F.SelectedDate >= @startDate)  
        AND (ISNULL(@endDate,'')= '' OR F.SelectedDate <= @endDate) 
        GROUP BY F.PersonId    
    ) F ON P.PersonId = F.PersonId        
    LEFT JOIN (    
        SELECT   
            BDN.PersonId,   
            SUM(BDN.TotalAmount) AS BillAmount          
        FROM tbl_BillDebitNew BDN       
        WHERE BDN.IsDeleted = 0 
		AND (ISNULL(@startDate,'') ='' OR BDN.BillDate >= @startDate)  
        AND (ISNULL(@endDate,'') = '' OR BDN.BillDate <= @endDate)  
        GROUP BY BDN.PersonId    
    ) BDN ON P.PersonId = BDN.PersonId    
    WHERE ISNULL(P.isdeleted, 0) = 0   
    AND P.ClientId = @clientId    
	AND P.IsActive IN (SELECT value FROM STRING_SPLIT(@activeInActiveStatus, ','))
    AND P.IsAttendancePerson = 0   
    AND (ISNULL(@strSearch, '') = ''        
        OR P.PersonFirstName LIKE '%' + @strSearch + '%'        
        OR P.PersonAddress LIKE '%' + @strSearch + '%'        
        OR P.MobileNo LIKE '%' + @strSearch + '%'        
        OR P.DailyRate LIKE '%' + @strSearch + '%'        
        OR P.PersonTypeId LIKE '%' + @strSearch + '%'        
        OR P.OrderNo LIKE '%' + @strSearch + '%'        
		OR ISNULL(F.CreditAmount, 0) LIKE '%' + @strSearch + '%' 
		OR ISNULL(BDN.BillAmount, 0) LIKE '%' + @strSearch + '%' 
		OR ISNULL(F.CreditAmount, 0) - ISNULL(BDN.BillAmount, 0) LIKE '%' + @strSearch + '%' 
        OR (CASE WHEN P.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')        
    ORDER BY   
		CASE WHEN @orderBy = 'CreditAmount' AND @sortOrder = 'ASC' THEN ISNULL(F.CreditAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'CreditAmount' AND @sortOrder = 'DESC' THEN ISNULL(F.CreditAmount, 0) END DESC, 
        CASE WHEN @orderBy = 'BillAmount' AND @sortOrder = 'ASC' THEN ISNULL(BDN.BillAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'BillAmount' AND @sortOrder = 'DESC' THEN ISNULL(BDN.BillAmount, 0) END DESC, 
        CASE WHEN @orderBy = 'RemainingAmount' AND @sortOrder = 'ASC' THEN ISNULL(F.CreditAmount, 0) - ISNULL(BDN.BillAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'RemainingAmount' AND @sortOrder = 'DESC' THEN ISNULL(F.CreditAmount, 0) - ISNULL(BDN.BillAmount, 0) END DESC, 
        CASE   
            WHEN @orderBy = 'PersonId' AND @sortOrder = 'ASC' THEN P.PersonId   
        END ASC,        
        CASE   
            WHEN @orderBy = 'PersonId' AND @sortOrder = 'DESC' THEN P.PersonId   
        END DESC,        
        CASE   
            WHEN @orderBy = 'PersonFirstName' AND @sortOrder = 'ASC' THEN P.PersonFirstName   
        END ASC,        
        CASE   
            WHEN @orderBy = 'PersonFirstName' AND @sortOrder = 'DESC' THEN P.PersonFirstName   
        END DESC,         
        CASE   
            WHEN @orderBy = 'PersonAddress' AND @sortOrder = 'ASC' THEN P.PersonAddress   
        END ASC,        
        CASE   
            WHEN @orderBy = 'PersonAddress' AND @sortOrder = 'DESC' THEN P.PersonAddress   
        END DESC,         
        CASE   
            WHEN @orderBy = 'MobileNo' AND @sortOrder = 'ASC' THEN P.MobileNo   
        END ASC,        
        CASE   
            WHEN @orderBy = 'MobileNo' AND @sortOrder = 'DESC' THEN P.MobileNo   
        END DESC,         
        CASE   
            WHEN @orderBy = 'PersonPhoto' AND @sortOrder = 'ASC' THEN P.PersonPhoto   
        END ASC,        
        CASE   
            WHEN @orderBy = 'PersonPhoto' AND @sortOrder = 'DESC' THEN P.PersonPhoto   
        END DESC,         
        CASE   
            WHEN @orderBy = 'DailyRate' AND @sortOrder = 'ASC' THEN P.DailyRate   
        END ASC,        
        CASE   
            WHEN @orderBy = 'DailyRate' AND @sortOrder = 'DESC' THEN P.DailyRate   
        END DESC,         
        CASE   
            WHEN @orderBy = 'PersonTypeId' AND @sortOrder = 'ASC' THEN P.PersonTypeId   
        END ASC,        
        CASE   
            WHEN @orderBy = 'PersonTypeId' AND @sortOrder = 'DESC' THEN P.PersonTypeId   
        END DESC,         
        CASE   
            WHEN @orderBy = 'IsAttendancePerson' AND @sortOrder = 'ASC' THEN P.IsAttendancePerson   
        END ASC,        
        CASE   
            WHEN @orderBy = 'IsAttendancePerson' AND @sortOrder = 'DESC' THEN P.IsAttendancePerson   
        END DESC,         
        CASE   
            WHEN @orderBy = 'OrderNo' AND @sortOrder = 'ASC' THEN P.OrderNo   
        END ASC,        
        CASE   
            WHEN @orderBy = 'OrderNo' AND @sortOrder = 'DESC' THEN P.OrderNo   
        END DESC,         
        CASE   
            WHEN @orderBy = 'ClientId' AND @sortOrder = 'ASC' THEN P.ClientId   
        END ASC,        
        CASE   
            WHEN @orderBy = 'ClientId' AND @sortOrder = 'DESC' THEN P.ClientId   
        END DESC,         
        CASE   
            WHEN @orderBy = 'CreatedBy' AND @sortOrder = 'ASC' THEN P.CreatedBy   
        END ASC,        
        CASE   
            WHEN @orderBy = 'CreatedBy' AND @sortOrder = 'DESC' THEN P.CreatedBy   
        END DESC,         
        CASE   
            WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'ASC' THEN P.CreatedDate   
        END ASC,        
        CASE   
            WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'DESC' THEN P.CreatedDate   
        END DESC,        
        CASE   
            WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN P.IsActive   
        END ASC,                
        CASE   
            WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN P.IsActive   
        END DESC        
    OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS        
    FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY        
END  

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPersonListForDropDown]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPersonListForDropDown]
	@ClientId NVARCHAR(MAX),
	@PersonGroupId NVARCHAR(MAX),
	@IsAttendancePerson bit NULL = 0 
AS
BEGIN

	IF(ISNULL(@PersonGroupId,'') = '')
	BEGIN
		
		--SELECT P.PersonId, P.PersonFirstName, P.ClientId FROM tbl_Persons P WHERE P.IsDeleted = 0 AND P.ClientId = @ClientId AND 
		--P.PersonId NOT IN ( SELECT PGM.PersonId FROM tbl_PersonGroup PG 
		--INNER JOIN tbl_PersonGroupMap PGM ON PG.PersonGroupId = PGM.PersonGroupId
		--WHERE PG.IsDeleted = 0 AND PG.ClientId  = @ClientId AND P.IsAttendancePerson = @IsAttendancePerson AND P.IsDeleted = 0 
		--)

		SELECT 
			P.PersonId, 
			P.PersonFirstName, 
			P.ClientId,
			PGM.PersonId AS UsageStatus
		FROM 
			tbl_Persons P
		LEFT JOIN 
			tbl_PersonGroupMap PGM ON P.PersonId = PGM.PersonId
		LEFT JOIN 
			tbl_PersonGroup PG ON PGM.PersonGroupId = PG.PersonGroupId
		WHERE 
			P.IsDeleted = 0 
			AND P.ClientId = @ClientId
			AND PGM.PersonId IS NULL
			AND P.IsAttendancePerson = 1;
	END
	ELSE 
	BEGIN
		SELECT 
		P.PersonId, 
		P.PersonFirstName, 
		P.ClientId,

		CASE 
			WHEN PGM.PersonId IS NULL THEN 0
			ELSE 1
		END AS UsageStatus
		FROM 
			tbl_Persons P
		LEFT JOIN 
			tbl_PersonGroupMap PGM ON P.PersonId = PGM.PersonId
		LEFT JOIN 
			tbl_PersonGroup PG ON PGM.PersonGroupId = PG.PersonGroupId
		WHERE 
			P.IsDeleted = 0 AND
			(PG.PersonGroupId = @PersonGroupId OR PG.PersonGroupId IS NULL )
			AND P.ClientId = @ClientId AND P.IsAttendancePerson = 1;
	END

END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetSiteBillDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSiteBillDetailById]    
(            
@billId VARCHAR(255)            
)            
AS            
BEGIN      
    
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit')     
    
  SELECT BillId,BillDate,BillNo, TotalAmount,Remarks, F.EncryptFileName AS SiteBillFile  
  FROM tbl_BillSiteNew E    
  LEFT JOIN tbl_Files F ON E.BillId = F.ParentId and F.FileCategory = @FileCategoryId    
  WHERE E.BillId = @billId  
    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSiteBillList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetSiteBillList]     
@pageIndex INT = 1,            
@pageSize INT = 10,            
@orderBy NVARCHAR(100) = '' ,            
@sortOrder NVARCHAR(10) = 'asc',            
@strSearch NVARCHAR(250) = null,  
@siteId NVARCHAR(250)   
AS            
BEGIN       
 DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit')       
    
SET @strSearch = LTRIM(RTRIM(@strSearch))            
            
 SET @orderBy = LTRIM(RTRIM(@orderBy))            
SET @sortOrder = LTRIM(RTRIM(@sortOrder))        
    
IF(ISNULL(@orderBy, '') = '')            
BEGIN            
SET  @orderBy = 'CreatedDate'            
END     
    
IF(ISNULL(@sortOrder, '') = '')            
BEGIN              
SET @sortOrder = 'DESC'            
END       
    
IF(ISNULL(@PageSize, 0) = 0)              
BEGIN            
SET @PageSize = 10            
END    
ELSE  IF(ISNULL(@PageSize,0) = -1)            
BEGIN            
SET @PageSize = 500000000              
END            
    
SELECT B.BillId,B.BillDate,B.BillNo, B.SiteId,B.TotalAmount, B.BillType, B.Remarks, S.SiteName, F.EncryptFileName AS  SiteBillFile,COUNT(*) OVER() AS TotalRecords          
from tbl_BillSiteNew B            
INNER JOIN tbl_Sites S on S.SiteId = B.SiteId            
LEFT JOIN tbl_Files F ON B.BillId = F.ParentId and F.FileCategory = @FileCategoryId      
Where            
B.IsDeleted = 0 AND B.SiteId = @siteId AND       
 (ISNULL(@strSearch, '') = ''            
 OR BillDate Like '%' + @strSearch + '%'            
 OR BillNo Like '%' + @strSearch + '%'            
 OR S.SiteName Like '%' + @strSearch + '%'            
 OR TotalAmount Like '%' + @strSearch + '%'            
 OR BillType Like '%' + @strSearch + '%'  
 OR Remarks Like '%' + @strSearch + '%'  
 )            
ORDER BY             
 CASE WHEN @orderBy = 'BillDate' AND @sortOrder ='ASC' THEN BillDate END ASC,            
            
 CASE WHEN @orderBy = 'BillDate' AND @sortOrder ='DESC' THEN BillDate END DESC,            
             
 CASE WHEN @orderBy = 'BillNo' AND @sortOrder ='ASC' THEN BillNo END ASC,            
            
 CASE WHEN @orderBy = 'BillNo' AND @sortOrder ='DESC' THEN BillNo END DESC,            
             
 CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='ASC' THEN TotalAmount END ASC,            
            
 CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='DESC' THEN TotalAmount END DESC,            
             
 CASE WHEN @orderBy = 'BillType' AND @sortOrder ='ASC' THEN BillType END ASC,            
            
 CASE WHEN @orderBy = 'BillType' AND @sortOrder ='DESC' THEN BillType END DESC,            
             
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='ASC' THEN Remarks END ASC,            
            
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='DESC' THEN Remarks END DESC,                   
             
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN B.CreatedDate END ASC,            
            
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN B.CreatedDate END DESC            
             
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS            
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY            
          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSiteById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSiteById](    
@SiteId VARCHAR(255)    
)    
AS    
BEGIN    
 SELECT SiteId, SiteName, SiteDescription, IsActive FROM tbl_Sites WHERE SiteId = @SiteId    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSitePhotoCategoryDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSitePhotoCategoryDetailById]      
(              
@sitePhotoCategoryId VARCHAR(255)              
)              
AS              
BEGIN        
      
  SELECT SitePhotoCategoryId,CategoryName  
  FROM tbl_SitePhotoCategory C      
  WHERE C.SitePhotoCategoryId = @sitePhotoCategoryId    
      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSitePhotoCategoryList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetSitePhotoCategoryList]         
@pageIndex INT = 1,                
@pageSize INT = 10,                
@orderBy NVARCHAR(100) = '' ,                
@sortOrder NVARCHAR(10) = 'asc',                
@strSearch NVARCHAR(250) = null,
@clientId NVARCHAR(250) 
AS                
BEGIN           
        
SET @strSearch = LTRIM(RTRIM(@strSearch))                
                
 SET @orderBy = LTRIM(RTRIM(@orderBy))                
SET @sortOrder = LTRIM(RTRIM(@sortOrder))            
        
IF(ISNULL(@orderBy, '') = '')                
BEGIN                
SET  @orderBy = 'CreatedDate'                
END         
        
IF(ISNULL(@sortOrder, '') = '')                
BEGIN                  
SET @sortOrder = 'DESC'                
END           
        
IF(ISNULL(@PageSize, 0) = 0)                  
BEGIN                
SET @PageSize = 10                
END        
ELSE  IF(ISNULL(@PageSize,0) = -1)                
BEGIN                
SET @PageSize = 500000000                  
END                
        
SELECT SitePhotoCategoryId,CategoryName,COUNT(*) OVER() AS TotalRecords              
from tbl_SitePhotoCategory C                
Where     
ClientId = @clientId AND
 (ISNULL(@strSearch, '') = ''                
 OR CategoryName Like '%' + @strSearch + '%'                
       
 )                
ORDER BY                 
 CASE WHEN @orderBy = 'CategoryName' AND @sortOrder ='ASC' THEN CategoryName END ASC,                
                
 CASE WHEN @orderBy = 'CategoryName' AND @sortOrder ='DESC' THEN CategoryName END DESC,                
  
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN C.CreatedDate END ASC,                
                
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN C.CreatedDate END DESC                
                 
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS                
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY                
              
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSiteTypeList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSiteTypeList]
AS
BEGIN
SELECT * FROM tbl_ExpenseType 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserDetailById]
(            
@userId VARCHAR(255)            
)            
AS            
BEGIN            
 SELECT  UserId, UserName, [Password] ,FirstName as [Name],EmailId,MobileNo, IsActive, UserPhoto   FROM tbl_Users U  WHERE U.UserId = @userId  
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetVehicleOwnerDetailById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetVehicleOwnerDetailById](          
@vehicleOwnerId VARCHAR(255)          
)          
AS          
BEGIN     
  
 SELECT VehicleOwnerId, ClientId, VehicleOwnerName,MobileNo,Remarks, IsActive IsActive FROM tbl_VehicleOwner WHERE VehicleOwnerId = @vehicleOwnerId   
  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetVehicleRentById]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetMerchantById '4F389DB6-38B6-4B8C-B0FD-DCC8B5BBA61E'
CREATE PROCEDURE  [dbo].[SP_GetVehicleRentById]
@VehicleRentId nvarchar(max)
As
Begin
select * from tbl_VehicleRent where VehicleRentId=@VehicleRentId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetWithoutFileEstimateBillDetail]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetWithoutFileEstimateBillDetail]  
@EstimateBillId NVARCHAR(MAX)  
AS  
BEGIN  
  
 -- Get estimate bill detail   
 select es.EstimateId,es.EstimateDate as estimateBillDate,es.PartyName,es.TotalAmount,es.Remarks from tbl_Estimate as es where EstimateId=@EstimateBillId

 select ei.EstimateItemId as BillEstimateItemId,ei.EstimateId,ei.ItemName as Name,ei.Nos,ei.Qty as Quantity,ei.Rate,ei.TotalAmount as Total from tbl_EstimateItem as ei where EstimateId = @EstimateBillId ORDER BY ei.SeqNo ASC
  
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_GetWithoutFileSiteBillDetail]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetWithoutFileSiteBillDetail]    
@billId NVARCHAR(MAX)    
AS    
BEGIN    
    
 -- Get site bill detail     
 SELECT BillId, BillDate, BillNo, BillType,S.SiteId, TotalAmount,Remarks, S.SiteName FROM tbl_BillSiteNew B INNER JOIN 
 tbl_Sites S ON S.SiteId = B.SiteId 
 WHERE BillId = @billId    
    
 -- get main item of details    
 SELECT BillSiteItemId,ItemName AS [Description], Rate FROM tbl_BillSiteItemNew WHERE BillId = @billId AND IsMainItem = 1 ORDER BY   SeqNo  
    
 -- Get sub item details of item    
 SELECT BillSiteItemId,MainItemPKId,ItemCategory,ItemType,ItemName,Qty as Quantity ,[Length],Height,Width,Area,    
 CONCAT(ItemType,     
 CASE WHEN ItemCategory = 'Less' then '(-)'    
 ELSE '(+)'    
 END    
 ) AS [Type]    
 FROM tbl_BillSiteItemNew WHERE BillId = @billId AND IsSubItem = 1  ORDER BY   SeqNo  
     
END    
    
    
select * from tbl_MerchantPayment
GO
/****** Object:  StoredProcedure [dbo].[SP_MerchantList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_MerchantList 1,10,'','',''  
CREATE PROCEDURE  [dbo].[SP_MerchantList]   
@pageIndex int = 1,  
@pageSize int = 10,  
@orderBy nvarchar(max) = '' ,  
@sortOrder varchar(10) = 'asc',  
@strSearch nvarchar(max) = null,
@clientId NVARCHAR(MAX) = null
AS  
BEGIN  
SET @strSearch = LTRIM(RTRIM(@strSearch))  
  
SET @orderBy = LTRIM(RTRIM(@orderBy))  
SET @sortOrder = LTRIM(RTRIM(@sortOrder))  
IF(ISNULL(@orderBy, '') = '')  
BEGIN  
SET @orderBy = 'CreatedDate'  
END  
IF(ISNULL(@sortOrder, '') = '')  
BEGIN  
  
SET @sortOrder = 'DESC'  
END  
IF(ISNULL(@PageSize, 0) = 0)  
BEGIN  
SET @PageSize = 10  
END  
IF(ISNULL(@PageSize, 0) = 0)  
BEGIN  
SET @PageSize = 10  
END  
else  IF(ISNULL(@PageSize,0) = -1)  
BEGIN  
SET @PageSize = 500000000  
    
END  
SELECT  
 M.merchantId  
   ,M.merchantName  
   ,M.firmName  
   ,M.mobileNo  
   ,M.address  
   ,CL.ClientName  
   ,CASE  
  WHEN M.isActive = 1 THEN 'Active'  
  ELSE 'InActive'  
 END AS [status]  
   ,U.UserName AS CreatedBy  
   ,M.CreatedDate  
   ,COUNT(*) OVER () AS TotalRecords  
   ,ROW_NUMBER() OVER (ORDER BY  
 CASE  
  WHEN @orderBy = 'MerchantId' AND  
   @sortOrder = 'ASC' THEN MerchantId  
 END ASC,  
 CASE  
  WHEN @orderBy = 'MerchantId' AND  
   @sortOrder = 'DESC' THEN MerchantId  
 END DESC,  
 CASE  
  WHEN @orderBy = 'MerchantName' AND  
   @sortOrder = 'ASC' THEN MerchantName  
 END ASC,  
  
 CASE  
  WHEN @orderBy = 'MerchantName' AND  
   @sortOrder = 'DESC' THEN MerchantName  
 END DESC,  
  
 CASE  
  WHEN @orderBy = 'FirmName' AND  
   @sortOrder = 'ASC' THEN M.FirmName  
 END ASC,  
  
 CASE  
  WHEN @orderBy = 'FirmName' AND  
   @sortOrder = 'DESC' THEN M.FirmName  
 END DESC,  
  
 CASE  
  WHEN @orderBy = 'MobileNo' AND  
   @sortOrder = 'ASC' THEN M.MobileNo  
 END ASC,  
  
 CASE  
  WHEN @orderBy = 'MobileNo' AND  
   @sortOrder = 'DESC' THEN M.MobileNo  
 END DESC,  
  
 CASE  
  WHEN @orderBy = 'Address' AND  
   @sortOrder = 'ASC' THEN M.Address  
 END ASC,  
  
 CASE  
  WHEN @orderBy = 'Address' AND  
   @sortOrder = 'DESC' THEN M.Address  
 END DESC,  
 CASE  
  WHEN @orderBy = 'IsActive' AND  
   @sortOrder = 'ASC' THEN M.IsActive  
 END ASC,  
  
 CASE  
  WHEN @orderBy = 'IsActive' AND  
   @sortOrder = 'DESC' THEN M.IsActive  
 END DESC,  
 CASE  
  WHEN @orderBy = 'ClientId' AND  
   @sortOrder = 'ASC' THEN M.ClientId  
 END ASC,  
 CASE  
  WHEN @orderBy = 'ClientId' AND  
   @sortOrder = 'DESC' THEN M.ClientId  
 END DESC  
 ) AS SrNo  
FROM tbl_Merchant M  
LEFT JOIN tbl_Clients CL  
 ON CL.ClientId = M.ClientId  
LEFT JOIN tbl_Users U  
 ON U.UserId = M.CreatedBy  
WHERE ISNULL(M.isdeleted, 0) = 0 AND M.ClientId = @clientId 
AND (ISNULL(@strSearch, '') = ''  
OR MerchantName LIKE '%' + @strSearch + '%'  
OR M.FirmName LIKE '%' + @strSearch + '%'  
OR M.MobileNo LIKE '%' + @strSearch + '%'  
OR M.Address LIKE '%' + @strSearch + '%'  
OR (CASE WHEN M.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')  
ORDER BY CASE  
 WHEN @orderBy = 'MerchantId' AND  
  @sortOrder = 'ASC' THEN MerchantId  
END ASC,  
  
CASE  
 WHEN @orderBy = 'MerchantId' AND  
  @sortOrder = 'DESC' THEN MerchantId  
END DESC,  
  
CASE  
 WHEN @orderBy = 'MerchantName' AND  
  @sortOrder = 'ASC' THEN MerchantName  
END ASC,  
  
CASE  
 WHEN @orderBy = 'MerchantName' AND  
  @sortOrder = 'DESC' THEN MerchantName  
END DESC,  
  
CASE  
 WHEN @orderBy = 'FirmName' AND  
  @sortOrder = 'ASC' THEN M.FirmName  
END ASC,  
  
CASE  
 WHEN @orderBy = 'FirmName' AND  
  @sortOrder = 'DESC' THEN M.FirmName  
END DESC,  
  
CASE  
 WHEN @orderBy = 'MobileNo' AND  
  @sortOrder = 'ASC' THEN M.MobileNo  
END ASC,  
  
CASE  
 WHEN @orderBy = 'MobileNo' AND  
  @sortOrder = 'DESC' THEN M.MobileNo  
END DESC,  
  
CASE  
 WHEN @orderBy = 'Address' AND  
  @sortOrder = 'ASC' THEN M.Address  
END ASC,  
  
CASE  
 WHEN @orderBy = 'Address' AND  
  @sortOrder = 'DESC' THEN M.Address  
END DESC,  
  
CASE  
 WHEN @orderBy = 'ClientId' AND  
  @sortOrder = 'ASC' THEN M.ClientId  
END ASC,  
  
CASE  
 WHEN @orderBy = 'ClientId' AND  
  @sortOrder = 'DESC' THEN M.ClientId  
END DESC,  
  
CASE  
 WHEN @orderBy = 'IsActive' AND  
  @sortOrder = 'ASC' THEN M.IsActive  
END ASC,  
  
CASE  
 WHEN @orderBy = 'IsActive' AND  
  @sortOrder = 'DESC' THEN M.IsActive  
END DESC,  
  
CASE  
 WHEN @orderBy = 'CreatedDate' AND  
  @sortOrder = 'ASC' THEN M.CreatedDate  
END ASC,  
  
CASE  
 WHEN @orderBy = 'CreatedDate' AND  
  @sortOrder = 'DESC' THEN M.CreatedDate  
END DESC  
  
OFFSET ((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS  
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MerchantListForDropDown]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MerchantListForDropDown](
	@ClientId NVARCHAR(250)
)
AS
BEGIN
	SELECT MerchantId, MerchantName FROM tbl_Merchant WHERE IsDeleted = 0 AND ClientId = @ClientId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MerchantListPayment]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_MerchantListPayment](
	@pageIndex INT = 1,          
	@pageSize INT = 10,          
	@orderBy NVARCHAR(100) ='',          
	@sortOrder NVARCHAR(10)='',          
	@strSearch NVARCHAR(250) = null,
	@startDate DATETIME,
	@endDate DATETIME,
	@siteId NVARCHAR(MAX),
	@paymentType NVARCHAR(MAX),
	@merchantId NVARCHAR(MAX) = NULL,
	@clientId NVARCHAR(MAX)
)
AS
BEGIN
	SET @strSearch = LTRIM(RTRIM(@strSearch))                
	SET @orderBy = LTRIM(RTRIM(@orderBy))          
	SET @sortOrder = LTRIM(RTRIM(@sortOrder))  
	
	IF(ISNULL(@orderBy, '') = '')          
	BEGIN          
		SET  @orderBy = 'CreatedDate'          
		SET @sortOrder = 'DESC'          
	END   

	IF(ISNULL(@PageSize, 0) = 0)          
	BEGIN          
		SET @PageSize = 10          
	END 
	
	SELECT COUNT(*) OVER () AS TotalRecords,
	ROW_NUMBER() OVER (ORDER BY  
	    CASE WHEN @orderBy = 'PaymentDate' AND @sortOrder ='ASC' THEN PaymentDate END ASC,     
		CASE WHEN @orderBy = 'PaymentDate' AND @sortOrder ='DESC' THEN PaymentDate END DESC,
		CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='ASC' THEN SiteName END ASC,     
		CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='DESC' THEN SiteName END DESC,
		CASE WHEN @orderBy = 'MerchantName' AND @sortOrder ='ASC' THEN M.MerchantName END ASC,     
		CASE WHEN @orderBy = 'MerchantName' AND @sortOrder ='DESC' THEN M.MerchantName END DESC,
		CASE WHEN @orderBy = 'Amount' AND @sortOrder ='ASC' THEN Amount END ASC,     
		CASE WHEN @orderBy = 'Amount' AND @sortOrder ='DESC' THEN Amount END DESC,
		CASE WHEN @orderBy = 'PaymentType' AND @sortOrder ='ASC' THEN PaymentType END ASC,     
		CASE WHEN @orderBy = 'PaymentType' AND @sortOrder ='DESC' THEN PaymentType END DESC,
		CASE WHEN @orderBy = 'ChequeNo' AND @sortOrder ='ASC' THEN ChequeNo END ASC,     
		CASE WHEN @orderBy = 'ChequeNo' AND @sortOrder ='DESC' THEN ChequeNo END DESC,
		CASE WHEN @orderBy = 'ChequeFor' AND @sortOrder ='ASC' THEN ChequeFor END ASC,     
		CASE WHEN @orderBy = 'ChequeFor' AND @sortOrder ='DESC' THEN ChequeFor END DESC,
		CASE WHEN @orderBy = 'BankName' AND @sortOrder ='ASC' THEN BankName END ASC,     
		CASE WHEN @orderBy = 'BankName' AND @sortOrder ='DESC' THEN BankName END DESC
	) AS SrNo,Mp.MerchantPaymentId, M.MerchantName ,MP.PaymentDate,S.SiteName,MP.Amount,MP.PaymentType,MP.ChequeNo,
	MP.ChequeFor,MP.BankName
	FROM tbl_MerchantPayment MP
	INNER JOIN tbl_Sites S ON MP.SiteId = S.SiteId
	INNER JOIN tbl_Merchant M ON M.MerchantId = MP.MerchantId
	WHERE 
	--(@merchantId IS NULL OR @merchantId = MP.MerchantId)
	 (ISNULL(@merchantId,'') = ''OR MP.MerchantId IN (SELECT value FROM STRING_SPLIT(@merchantId, ',')))
	AND (ISNULL(@paymentType, '') = '' or MP.PaymentType IN (SELECT value FROM STRING_SPLIT(@paymentType, ',')))
	AND @clientId = MP.ClientId
	AND (ISNULL(@strSearch, '') = ''          
		OR Amount Like '%' + @strSearch + '%'          
		OR PaymentType Like '%' + @strSearch + '%'          
		OR BankName Like '%' + @strSearch + '%'          
		OR ChequeNo Like '%' + @strSearch + '%'          
		OR M.MerchantName Like '%' + @strSearch + '%'          
		OR ChequeFor Like '%' + @strSearch + '%'
		OR SiteName Like '%' + @strSearch + '%') 
	ORDER BY                      
	    CASE WHEN @orderBy = 'PaymentDate' AND @sortOrder ='ASC' THEN PaymentDate END ASC,     
		CASE WHEN @orderBy = 'PaymentDate' AND @sortOrder ='DESC' THEN PaymentDate END DESC,
		CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='ASC' THEN SiteName END ASC,     
		CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='DESC' THEN SiteName END DESC,
		CASE WHEN @orderBy = 'Amount' AND @sortOrder ='ASC' THEN Amount END ASC,     
		CASE WHEN @orderBy = 'Amount' AND @sortOrder ='DESC' THEN Amount END DESC,
		CASE WHEN @orderBy = 'PaymentType' AND @sortOrder ='ASC' THEN PaymentType END ASC,     
		CASE WHEN @orderBy = 'PaymentType' AND @sortOrder ='DESC' THEN PaymentType END DESC,
		CASE WHEN @orderBy = 'ChequeNo' AND @sortOrder ='ASC' THEN ChequeNo END ASC,     
		CASE WHEN @orderBy = 'ChequeNo' AND @sortOrder ='DESC' THEN ChequeNo END DESC,
		CASE WHEN @orderBy = 'ChequeFor' AND @sortOrder ='ASC' THEN ChequeFor END ASC,     
		CASE WHEN @orderBy = 'ChequeFor' AND @sortOrder ='DESC' THEN ChequeFor END DESC,
		CASE WHEN @orderBy = 'BankName' AND @sortOrder ='ASC' THEN BankName END ASC,     
		CASE WHEN @orderBy = 'BankName' AND @sortOrder ='DESC' THEN BankName END DESC
		OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS          
		FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY
END


GO
/****** Object:  StoredProcedure [dbo].[SP_PersonAttendanceList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SP_PersonAttendanceList 1,10,'','',null,'93A147DF-05B9-4F93-8C2D-0E3FB7CB99F6'  
CREATE PROC [dbo].[SP_PersonAttendanceList](  
 @pageIndex INT = 1,            
 @pageSize INT = 10,            
 @orderBy NVARCHAR(100)='',            
 @sortOrder NVARCHAR(10)='',            
 @strSearch NVARCHAR(250) = null,  
 @ClientId NVARCHAR(MAX)  
)  
AS  
BEGIN  
 SET @strSearch = LTRIM(RTRIM(@strSearch))                  
 SET @orderBy = LTRIM(RTRIM(@orderBy))            
 SET @sortOrder = LTRIM(RTRIM(@sortOrder))    
   
 IF(ISNULL(@orderBy, '') = '')            
 BEGIN            
  SET  @orderBy = 'AttendanceDate'            
  SET @sortOrder = 'DESC'            
 END     
  
 IF(ISNULL(@PageSize, 0) = 0)            
 BEGIN            
  SET @PageSize = 10            
 END   
  
 SELECT A.AttendaceId AS AttendanceId,A.AttendanceDate,SUM(PayableAmount) AS TotalAmount,A.ClientId,  
 (SELECT COUNT(AttendanceStatus) FROM tbl_PersonAttendance WHERE AttendanceId = A.AttendaceId AND AttendanceStatus = 1.0) AS FullDay,  
 (SELECT COUNT(AttendanceStatus) FROM tbl_PersonAttendance WHERE AttendanceId = A.AttendaceId AND AttendanceStatus = 0.5) AS HalfDay,  
 (SELECT COUNT(AttendanceStatus) FROM tbl_PersonAttendance WHERE AttendanceId = A.AttendaceId AND AttendanceStatus = 0.0) AS [Absent],  
 (SELECT COUNT(AttendanceStatus) FROM tbl_PersonAttendance WHERE AttendanceId = A.AttendaceId) AS Total
 INTO #Temp
 FROM tbl_Attendance A INNER JOIN tbl_PersonAttendance PA ON A.AttendaceId = PA.AttendanceId  
 GROUP BY A.AttendanceDate,A.ClientId,A.AttendaceId  
  
  
 SELECT COUNT(*) OVER () AS TotalRecords,  
 ROW_NUMBER() OVER (ORDER BY   
  CASE WHEN @orderBy = 'AttendanceId' AND @sortOrder ='ASC' THEN AttendanceId END ASC,       
  CASE WHEN @orderBy = 'AttendanceId' AND @sortOrder ='DESC' THEN AttendanceId END DESC,  
  CASE WHEN @orderBy = 'AttendanceDate' AND @sortOrder ='ASC' THEN AttendanceDate END ASC,       
  CASE WHEN @orderBy = 'AttendanceDate' AND @sortOrder ='DESC' THEN AttendanceDate END DESC,  
  CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='ASC' THEN TotalAmount END ASC,       
  CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='DESC' THEN TotalAmount END DESC,  
  CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='ASC' THEN ClientId END ASC,       
  CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='DESC' THEN ClientId END DESC,  
  CASE WHEN @orderBy = 'FullDay' AND @sortOrder ='ASC' THEN FullDay END ASC,       
  CASE WHEN @orderBy = 'FullDay' AND @sortOrder ='DESC' THEN FullDay END DESC,  
  CASE WHEN @orderBy = 'HalfDay' AND @sortOrder ='ASC' THEN HalfDay END ASC,       
  CASE WHEN @orderBy = 'HalfDay' AND @sortOrder ='DESC' THEN HalfDay END DESC,  
  CASE WHEN @orderBy = 'Absent' AND @sortOrder ='ASC' THEN [Absent] END ASC,       
  CASE WHEN @orderBy = 'Absent' AND @sortOrder ='DESC' THEN [Absent] END DESC,  
  CASE WHEN @orderBy = 'Total' AND @sortOrder ='ASC' THEN Total END ASC,       
  CASE WHEN @orderBy = 'Total' AND @sortOrder ='DESC' THEN Total END DESC  
 ) AS SrNo,AttendanceId,AttendanceDate,TotalAmount,ClientId,FullDay,HalfDay,[Absent],Total  
 FROM #Temp  
 WHERE ClientId = @ClientId  
 AND (ISNULL(@strSearch, '') = ''            
  OR TotalAmount Like '%' + @strSearch + '%'            
  OR ClientId Like '%' + @strSearch + '%'            
  OR FullDay Like '%' + @strSearch + '%'            
  OR HalfDay Like '%' + @strSearch + '%'            
  OR [Absent] Like '%' + @strSearch + '%'  
  OR Total Like '%' + @strSearch + '%')  
 ORDER BY   
  CASE WHEN @orderBy = 'AttendanceId' AND @sortOrder ='ASC' THEN AttendanceId END ASC,       
  CASE WHEN @orderBy = 'AttendanceId' AND @sortOrder ='DESC' THEN AttendanceId END DESC,  
  CASE WHEN @orderBy = 'AttendanceDate' AND @sortOrder ='ASC' THEN AttendanceDate END ASC,       
  CASE WHEN @orderBy = 'AttendanceDate' AND @sortOrder ='DESC' THEN AttendanceDate END DESC,  
  CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='ASC' THEN TotalAmount END ASC,       
  CASE WHEN @orderBy = 'TotalAmount' AND @sortOrder ='DESC' THEN TotalAmount END DESC,  
  CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='ASC' THEN ClientId END ASC,       
  CASE WHEN @orderBy = 'ClientId' AND @sortOrder ='DESC' THEN ClientId END DESC,  
  CASE WHEN @orderBy = 'FullDay' AND @sortOrder ='ASC' THEN FullDay END ASC,       
  CASE WHEN @orderBy = 'FullDay' AND @sortOrder ='DESC' THEN FullDay END DESC,  
  CASE WHEN @orderBy = 'HalfDay' AND @sortOrder ='ASC' THEN HalfDay END ASC,       
  CASE WHEN @orderBy = 'HalfDay' AND @sortOrder ='DESC' THEN HalfDay END DESC,  
  CASE WHEN @orderBy = 'Absent' AND @sortOrder ='ASC' THEN [Absent] END ASC,       
  CASE WHEN @orderBy = 'Absent' AND @sortOrder ='DESC' THEN [Absent] END DESC,  
  CASE WHEN @orderBy = 'Total' AND @sortOrder ='ASC' THEN Total END ASC,       
  CASE WHEN @orderBy = 'Total' AND @sortOrder ='DESC' THEN Total END DESC  
 OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS            
 FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PersonFinaceList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_PersonFinaceList]    
@pageIndex INT = 1,                
@pageSize INT = 10,                
@orderBy NVARCHAR(100) = '' ,                
@sortOrder NVARCHAR(10) = 'asc',                
@strSearch NVARCHAR(250) = null,            
@PersonId NVARCHAR(50)        
AS                
BEGIN                
SET @strSearch = LTRIM(RTRIM(@strSearch))                      
 SET @orderBy = LTRIM(RTRIM(@orderBy))                
SET @sortOrder = LTRIM(RTRIM(@sortOrder))                
              
IF(ISNULL(@orderBy, '') = '')                
BEGIN                
SET  @orderBy = 'CreatedDate'                
END                
              
IF(ISNULL(@sortOrder, '') = '')                
BEGIN                
SET @sortOrder = 'DESC'                
END              
              
IF(ISNULL(@PageSize, 0) = 0)                
BEGIN                
SET @PageSize = 10                
END               
ELSE  IF(ISNULL(@PageSize,0) = -1)                
BEGIN                
SET @PageSize = 500000000                  
END                
              
SELECT CF.FinanceId as PersonFinanceId,CF.PersonId,CF.PaymentType, CF.SiteId,CF.SelectedDate, CF.Amount, CF.CreditOrDebit, CF.PaymentType, CF.ChequeNo, CF.BankName, CF.ChequeFor,    
CF.Remarks,U.FirstName AS [UserName],CF.IsActive, COUNT(*) OVER() AS TotalRecords   
FROM [tbl_Finance] CF INNER JOIN tbl_Users U ON U.UserId = CF.GivenAmountBy  
Where                
CF.IsDeleted = 0 AND CF.PersonId = @PersonId AND               
 (ISNULL(@strSearch, '') = ''                
 OR SelectedDate Like '%' + @strSearch + '%'                
 OR Amount Like '%' + @strSearch + '%'                
 OR CreditOrDebit Like '%' + @strSearch + '%'    
 OR PaymentType Like '%' + @strSearch + '%'    
 OR ChequeNo Like '%' + @strSearch + '%'    
 OR BankName Like '%' + @strSearch + '%'    
 OR ChequeFor Like '%' + @strSearch + '%'    
 OR Remarks Like '%' + @strSearch + '%')                
ORDER BY                
 CASE WHEN (@orderBy = 'SelectedDate' AND @sortOrder = 'ASC') THEN CF.SelectedDate  END ASC,                        
 CASE WHEN (@orderBy = 'SelectedDate' AND @sortOrder = 'DESC') THEN CF.SelectedDate  END DESC,                        
 CASE WHEN (@orderBy = 'Amount' AND @sortOrder = 'ASC') THEN Amount  END ASC,                        
 CASE WHEN (@orderBy = 'Amount' AND @sortOrder = 'DESC') THEN Amount END DESC,                        
 CASE WHEN (@orderBy = 'CreditOrDebit' AND @sortOrder = 'ASC') THEN CreditOrDebit  END ASC,                        
 CASE WHEN (@orderBy = 'CreditOrDebit' AND @sortOrder = 'DESC') THEN CreditOrDebit  END DESC,                        
 CASE WHEN (@orderBy = 'PaymentType' AND @sortOrder = 'ASC') THEN PaymentType  END ASC,                        
 CASE WHEN (@orderBy = 'PaymentType' AND @sortOrder = 'DESC') THEN PaymentType  END DESC,                  
 CASE WHEN (@orderBy = 'ChequeNo' AND @sortOrder = 'ASC') THEN ChequeNo END ASC,                        
 CASE WHEN (@orderBy = 'ChequeNo' AND @sortOrder = 'DESC') THEN ChequeNo END DESC,                       
 CASE WHEN (@orderBy = 'BankName' AND @sortOrder = 'ASC') THEN BankName END ASC,                
 CASE WHEN (@orderBy = 'BankName' AND @sortOrder = 'DESC') THEN BankName  END DESC ,    
 CASE WHEN (@orderBy = 'ChequeFor' AND @sortOrder = 'ASC') THEN ChequeFor END ASC,                
 CASE WHEN (@orderBy = 'ChequeFor' AND @sortOrder = 'DESC') THEN ChequeFor  END DESC,         
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'ASC') THEN Remarks END ASC,                
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'DESC') THEN Remarks  END DESC,    
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'ASC') THEN CF.CreatedDate END ASC,                
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'DESC') THEN CF.CreatedDate  END DESC,    
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'ASC') THEN U.FirstName END ASC,                
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'DESC') THEN U.FirstName  END DESC  
                
 OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS                
 FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY                
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_PersonFinaceListForExport]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_PersonFinaceListForExport]      
@personfinanceId NVARCHAR(50)          
AS                  
BEGIN                  
SELECT CF.FinanceId, CF.SiteId, CF.SelectedDate, CF.Amount, CF.CreditOrDebit, CF.PaymentType, CF.ChequeNo, CF.BankName, CF.ChequeFor,      
CF.Remarks, CF.IsActive, COUNT(*) OVER() AS TotalRecords     
FROM [tbl_Finance] CF   
Where                  
CF.IsDeleted = 0 AND CF.PersonId= @personfinanceId 
    
ORDER BY CF.CreatedDate ASC                         
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveClient]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
CREATE PROCEDURE  [dbo].[SP_SaveClient]      
@ClientId VARCHAR(255) ,      
@ClientName NVARCHAR(255) ,      
@FirmName NVARCHAR(255) NULL,      
@PackageTypeId INT ,      
@ExpireDate DATETIME NULL,      
@Address NVARCHAR(500) NULL,      
@Remarks NVARCHAR(max) NULL,      
@HeaderImageLetterPage NVARCHAR(255) NULL,      
@FooterImageLetterPage NVARCHAR(255)NULL      
AS      
BEGIN      
IF (@ClientId IS NULL)            
 BEGIN    
 IF EXISTS((SELECT TOP 1 1 FROM tbl_Clients WHERE FirmName = @FirmName AND IsDeleted = 0))    
 BEGIN    
  SELECT 2    
 END  
 ELSE  
 BEGIN 
 
  INSERT INTO tbl_Clients(ClientId,ClientName,FirmName,PackageTypeId,[ExpireDate],[Address],Remarks,HeaderImageLetterPage,FooterImageLetterPage,IsActive,IsDeleted,CreatedDate)      
  VALUES(NEWID(),@ClientName,@FirmName,@PackageTypeId,@ExpireDate,@Address,@Remarks,@HeaderImageLetterPage,@FooterImageLetterPage,1,0,GETUTCDATE())      
  SELECT 0    
 END    
 END      
ELSE      
    
 BEGIN      
  IF EXISTS((SELECT TOP 1 1 FROM tbl_Clients WHERE FirmName = @FirmName AND IsDeleted = 0 AND ClientId != @ClientId))    
  BEGIN    
   SELECT 2    
  END   
  ELSE  
  BEGIN    
   UPDATE tbl_Clients      
   SET      
   ClientName = @ClientName,      
   FirmName = @FirmName,      
   PackageTypeId = @PackageTypeId,      
   [ExpireDate] = @ExpireDate,      
   [Address] = @Address,      
   Remarks = @Remarks,      
   ModifiedDate = GETUTCDATE()      
   WHERE ClientId = @ClientId      

   if(@HeaderImageLetterPage IS NOT NULL)
   BEGIN
	UPDATE tbl_Clients SET HeaderImageLetterPage = @HeaderImageLetterPage WHERE ClientId = @ClientId
   END

   IF(@FooterImageLetterPage IS NOT NULL)
   BEGIN
	UPDATE tbl_Clients SET FooterImageLetterPage = @FooterImageLetterPage WHERE ClientId = @ClientId
   END
   SELECT 1      
  END    
 END      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveContractorFinance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveContractorFinance] 
@contractorFinanceId NVARCHAR(255) ,      
@siteId NVARCHAR(255),  
@userId NVARCHAR(255),  
@selectedDate DATETIME,  
@amount decimal,  
@creditOrDebit NVARCHAR(255),  
@paymentType NVARCHAR(255),  
@chequeNo NVARCHAR(255),  
@bankName NVARCHAR(255),  
@chequeFor NVARCHAR(255),  
@remarks NVARCHAR(255) ,  
@createdBy NVARCHAR(255)  
AS      
BEGIN   
  
 IF (@contractorFinanceId IS NULL)            
   BEGIN    
  
    INSERT INTO tbl_ContractorFinance  
    (ContractorFinanceId,SiteId,UserId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,Remarks,ChequeFor,  
    IsActive,IsDeleted,CreatedDate, CreatedBy)      
    VALUES(NEWID(),@siteId,@userId,@selectedDate,@amount,@creditOrDebit,@paymentType,@chequeNo,@bankName,@remarks  
    ,@chequeFor ,1,0,GETUTCDATE(), @createdBy)      
    SELECT 0    
  
   END      
  
 ELSE      
  BEGIN  
  
     UPDATE tbl_ContractorFinance      
     SET      
     SiteId = @siteId,      
     UserId = @userId,      
     SelectedDate = @selectedDate,      
     Amount = @amount,      
     CreditOrDebit = @creditOrDebit,      
     PaymentType = @paymentType,      
     ChequeNo = @chequeNo,      
     BankName = @bankName,      
     Remarks = @remarks,     
     ChequeFor = @chequeFor,  
     ModifiedDate = GETUTCDATE() ,  
     UpdatedBy = @createdBy  
     WHERE ContractorFinanceId = @contractorFinanceId      
     SELECT 1   
       
  END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveExpense]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE  [dbo].[SP_SaveExpense]     
@ExpenseId varchar(255)= null ,    
@ExpenseDate datetime ,    
@ExpenseTypeId int ,    
@ClientId varchar(255) ,    
@Amount decimal ,    
@Description nvarchar(max) NULL,    
@SiteId varchar(255) NULL,    
@CreatedBy varchar(255),
@ExpenseOriginalFileName NVARCHAR(255)= null,
@ExpenseNewFileName NVARCHAR(255)= null
AS    
BEGIN    
DECLARE @FileCategoryId int = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Expense') 
IF (@ExpenseId IS NULL)          
BEGIN    

	DECLARE @newExpenseId UNIQUEIDENTIFIER= (SELECT NEWID());    

	INSERT INTO tbl_Expenses(ExpenseId,ExpenseDate,ExpenseTypeId,ClientId,Amount,Description,SiteId,IsActive,IsDeleted,CreatedBy,CreatedDate)    
	Values(@newExpenseId,@ExpenseDate,@ExpenseTypeId,@ClientId,@Amount,@Description,@SiteId,1,0,@CreatedBy,GETUTCDATE())  
	
	IF((@ExpenseOriginalFileName IS NOT NULL) AND (@ExpenseNewFileName IS NOT NULL))
	BEGIN

		INSERT INTO tbl_Files VALUES (NEWID(), @newExpenseId, @FileCategoryId, @ExpenseOriginalFileName, @ExpenseNewFileName)

	END
	SELECT 0     
END    
ELSE    
BEGIN 

	UPDATE tbl_Expenses SET    
	ExpenseDate = @ExpenseDate,    
	ExpenseTypeId = @ExpenseTypeId,    
	ClientId = @ClientId,    
	Amount = @Amount,    
	Description = @Description,    
	SiteId = @SiteId,    
	ModifiedBy = @CreatedBy,    
	ModifiedDate = GETUTCDATE()    
	WHERE ExpenseId = @ExpenseId 
	
	IF((@ExpenseOriginalFileName IS NOT NULL) AND (@ExpenseNewFileName IS NOT NULL))
	BEGIN

		IF EXISTS(SELECT TOP 1 1 FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @ExpenseId)
		BEGIN

		 UPDATE tbl_Files SET OriginalFileName = @ExpenseOriginalFileName,EncryptFileName = @ExpenseNewFileName WHERE FileId = (SELECT  FileId FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @ExpenseId)

		END
		ELSE
		BEGIN

		INSERT INTO tbl_Files VALUES (NEWID(), @ExpenseId, @FileCategoryId, @ExpenseOriginalFileName, @ExpenseNewFileName)

		END
	END
	SELECT 1    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveFinance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveFinance] 
@personFinanceId NVARCHAR(255) ,      
@siteId NVARCHAR(255),  
@userId NVARCHAR(255),  
@selectedDate DATETIME,  
@amount decimal,  
@creditOrDebit NVARCHAR(255),  
@paymentType NVARCHAR(255),  
@chequeNo NVARCHAR(255),  
@bankName NVARCHAR(255),  
@chequeFor NVARCHAR(255),  
@remarks NVARCHAR(255) ,  
@createdBy NVARCHAR(255)  
AS      
BEGIN   
  
 IF (@personFinanceId IS NULL)            
   BEGIN    
  
    INSERT INTO tbl_Finance  
    (FinanceId,SiteId,SelectedDate,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,Remarks,ChequeFor,  
    IsActive,IsDeleted,CreatedDate, CreatedBy)      
    VALUES(NEWID(),@siteId,@selectedDate,@amount,@creditOrDebit,@paymentType,@chequeNo,@bankName,@remarks  
    ,@chequeFor ,1,0,GETUTCDATE(), @createdBy)      
    SELECT 0    
  
   END      
  
 ELSE      
  BEGIN  
  
     UPDATE tbl_Finance      
     SET      
     SiteId = @siteId,      
     SelectedDate = @selectedDate,      
     Amount = @amount,      
     CreditOrDebit = @creditOrDebit,      
     PaymentType = @paymentType,      
     ChequeNo = @chequeNo,      
     BankName = @bankName,      
     Remarks = @remarks,     
     ChequeFor = @chequeFor,  
     ModifiedDate = GETUTCDATE() ,  
     UpdatedBy = @createdBy  
     WHERE FinanceId = @personFinanceId      
     SELECT 1   
       
  END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SavePersonAttendance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SavePersonAttendance](  
 @AttendanceId NVARCHAR(MAX),  
 @AttendanceDate DATETIME,  
 @ClientId NVARCHAR(MAX),  
 @LoggedId NVARCHAR(MAX),  
 @tbl_SavePersonAttendance tbl_SavePersonAttendance readonly  
)  
AS  
BEGIN  
IF(ISNULL(@AttendanceId,'')='')  
BEGIN  
	IF EXISTS(SELECT TOP 1 1 FROM tbl_Attendance WHERE CONVERT(date, AttendanceDate) = CONVERT(date, @AttendanceDate) )  
	BEGIN  
		SELECT 0  
	END  
	ELSE  
	BEGIN  
		SET @AttendanceId = NEWID()  
     
		INSERT INTO tbl_Attendance(AttendaceId,AttendanceDate,ClientId,CreatedDate,CreatedBy)  
		VALUES(@AttendanceId,@AttendanceDate,@ClientId,GETUTCDATE(),@LoggedId)  
  
		INSERT INTO tbl_PersonAttendance(PersonAttendanceId,AttendanceId,PersonId,AttendanceStatus,SiteId,  
		PersonDailyRate,PayableAmount,WithdrawAmount,OvertimeAmount,PersonTypeId,Remarks,CreatedDate,CreatedBy)  
		SELECT NEWID(),@AttendanceId,tbl_SPA.PersonId,tbl_SPA.AttendanceStatus,tbl_SPA.SiteId,tbl_P.DailyRate,  
		(tbl_P.DailyRate * tbl_SPA.AttendanceStatus),tbl_SPA.WithdrawAmount,tbl_SPA.OvertimeAmount,  
		tbl_P.PersonTypeId,tbl_SPA.Remarks,GETUTCDATE(),@LoggedId  
		FROM @tbl_SavePersonAttendance tbl_SPA INNER JOIN tbl_Persons tbl_P ON tbl_SPA.PersonId = tbl_P.PersonId  
  
		SELECT 1  
	END  
END  
ELSE  
BEGIN  
	IF EXISTS(SELECT TOP 1 1 FROM tbl_Attendance WHERE CONVERT(date, AttendanceDate) = CONVERT(date, @AttendanceDate) AND AttendaceId <> @AttendanceId )  
	BEGIN  
		SELECT 0  
	END  
	ELSE  
	BEGIN 
		UPDATE PA SET     
		PA.AttendanceStatus = SPA.AttendanceStatus,    
		PA.SiteId = SPA.SiteId,    
		PA.PersonDailyRate = P.DailyRate,    
		PA.PayableAmount = P.DailyRate * SPA.AttendanceStatus,    
		PA.WithdrawAmount = SPA.WithdrawAmount,    
		PA.OvertimeAmount = SPA.OvertimeAmount,    
		PA.PersonTypeId = P.PersonTypeId,    
		PA.Remarks = SPA.Remarks,    
		PA.ModifiedDate = GETUTCDATE(),    
		PA.ModifiedBy = @LoggedId FROM tbl_PersonAttendance PA   
		INNER JOIN @tbl_SavePersonAttendance SPA ON PA.PersonAttendanceId = SPA.PersonAttendanceId   
		INNER JOIN tbl_Persons P ON SPA.PersonId = P.PersonId WHERE PA.PersonAttendanceId = SPA.PersonAttendanceId;  
		SELECT 2
	END

  
	--INSERT INTO tbl_PersonAttendance(PersonAttendanceId,AttendanceId,PersonId,AttendanceStatus,SiteId,  
	-- PersonDailyRate,PayableAmount,WithdrawAmount,OvertimeAmount,PersonTypeId,Remarks,CreatedDate,CreatedBy)  
	-- SELECT NEWID(),@AttendanceId,tbl_SPA.PersonId,tbl_SPA.AttendanceStatus,tbl_SPA.SiteId,tbl_P.DailyRate,  
	-- (tbl_P.DailyRate * tbl_SPA.AttendanceStatus),tbl_SPA.WithdrawAmount,tbl_SPA.OvertimeAmount,  
	-- tbl_P.PersonTypeId,tbl_SPA.Remarks,GETUTCDATE(),@LoggedId  
	-- FROM @tbl_SavePersonAttendance tbl_SPA INNER JOIN tbl_Persons tbl_P ON tbl_SPA.PersonId = tbl_P.PersonId  
	-- WHERE ISNULL(PersonAttendanceId,'') = ''   
	END  
END  

GO
/****** Object:  StoredProcedure [dbo].[SP_SavePersonBill]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SavePersonBill]    
@billId NVARCHAR(255)= null ,        
@personId NVARCHAR(255)= null ,        
@billDate DATETIME ,        
@billNo NVARCHAR(255),          
@totalAmount DECIMAL,        
@remarks varchar(255) ,        
@billOriginalFileName NVARCHAR(255)= null,    
@billNewFileName NVARCHAR(255)= null,    
@createdBy NVARCHAR(255)= null    
AS        
BEGIN        
DECLARE @clientdId UNIQUEIDENTIFIER = (SELECT TOP 1 PersonId FROM tbl_Persons WHERE PersonId = @personId)    
DECLARE @FileCategoryId INT = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit')     
IF (@billId IS NULL)              
BEGIN        
    
 DECLARE @newbillId UNIQUEIDENTIFIER= (SELECT NEWID());        
 INSERT INTO tbl_BillDebitNew(BillId,BillDate,BillNo,BillType,TotalAmount,Remarks,PersonId, ClientId,IsActive, IsDeleted,CreatedBy,CreatedDate)        
 Values(@newbillId ,@billDate,@billNo,'Person-File',@totalAmount,@remarks,@PersonId,@clientdId ,1,0,@createdBy,GETUTCDATE())      
     
 IF((@billOriginalFileName IS NOT NULL) AND (@billNewFileName IS NOT NULL))    
 BEGIN    
    
  INSERT INTO tbl_Files VALUES (NEWID(), @newbillId, @FileCategoryId, @billOriginalFileName, @billNewFileName)    
    
 END    
 SELECT 0         
END        
ELSE        
BEGIN     
    
 UPDATE tbl_BillDebitNew SET        
 BillDate = @billDate,        
 BillNo = @billNo,            
 TotalAmount = @totalAmount,        
 Remarks = @remarks,       
 ModifiedBy = @createdBy,        
 ModifiedDate = GETUTCDATE()        
 WHERE BillId = @billId     
     
 IF((@billOriginalFileName IS NOT NULL) AND (@billNewFileName IS NOT NULL))    
 BEGIN    
    
  IF EXISTS(SELECT TOP 1 1 FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @billId)    
  BEGIN    
    
   UPDATE tbl_Files SET OriginalFileName = @billOriginalFileName,EncryptFileName = @billNewFileName WHERE FileId = (SELECT  FileId FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @billId)    
    
  END    
  ELSE    
  BEGIN    
    
  INSERT INTO tbl_Files VALUES (NEWID(), @billId, @FileCategoryId, @billOriginalFileName, @billNewFileName)    
    
  END    
 END    
 SELECT 1        
END        
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SavePersonFinance]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SavePersonFinance] 
@personFinanceId NVARCHAR(255) ,      
@personId NVARCHAR(255),  
@selectedDate DATETIME,  
@givenAmountBy NVARCHAR(255),  
@amount decimal,  
@creditOrDebit NVARCHAR(255)= null ,    
@paymentType NVARCHAR(255),  
@chequeNo NVARCHAR(255)= null ,    
@bankName NVARCHAR(255)= null ,    
@chequeFor NVARCHAR(255)= null ,    
@remarks NVARCHAR(255) = null ,    
@createdBy NVARCHAR(255)  
AS      
BEGIN   
  
 IF (@personFinanceId IS NULL)            
   BEGIN    
  
    INSERT INTO tbl_Finance  
    (FinanceId, PersonId,SelectedDate,GivenAmountBy,Amount,CreditOrDebit,PaymentType,ChequeNo,BankName,Remarks,ChequeFor,  
    IsActive,IsDeleted,CreatedDate, CreatedBy)      
    VALUES(NEWID(),@personId,@selectedDate,@givenAmountBy,@amount,@creditOrDebit,@paymentType,@chequeNo,@bankName,@remarks  
    ,@chequeFor ,1,0,GETUTCDATE(), @createdBy)     
	
    SELECT 0    
  
   END      
  
 ELSE      
  BEGIN  
  
     UPDATE tbl_Finance      
     SET      
     PersonId = @personId,      
     SelectedDate = @selectedDate,      
     Amount = @amount,    
	 GivenAmountBy=@givenAmountBy,
     CreditOrDebit = @creditOrDebit,      
     PaymentType = @paymentType,      
     ChequeNo = @chequeNo,      
     BankName = @bankName,      
     Remarks = @remarks,     
     ChequeFor = @chequeFor,  
     ModifiedDate = GETUTCDATE() ,  
     UpdatedBy = @createdBy  
     WHERE FinanceId = @personFinanceId      
     SELECT 1   
       
  END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SavePersonGroup]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SavePersonGroup]
	@PersonGroupId NVARCHAR(MAX),
	@ClientId NVARCHAR(MAX),
	@GroupName NVARCHAR(MAX),
	@CreatedBy NVARCHAR(MAX),
	@PersonGroupMap tbl_PersonGroupMapping READONLY
AS
BEGIN
	DECLARE @NewPersonGroupId NVARCHAR(MAX) 
	SET @NewPersonGroupId = NEWID()
	IF(ISNULL(@PersonGroupId,'') = '')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM  tbl_PersonGroup 
		WHERE GroupName = @GroupName
		AND IsDeleted = 0
		)
		BEGIN
			SELECT -1 AS IsSuccess, 'Person group name already exists' AS Result
		END	
		ELSE 
		BEGIN
			BEGIN TRY
				BEGIN TRAN

					INSERT INTO tbl_PersonGroup(PersonGroupId,GroupName, ClientId, CreatedBy, CreatedDate, IsActive, IsDeleted)
					VALUES (@NewPersonGroupId,@GroupName, @ClientId, @CreatedBy, GETUTCDATE(),1,0)

					INSERT INTO tbl_PersonGroupMap ( PersonGroupMapId, PersonId, PersonGroupId)
					SELECT NEWID(), PersonId, @NewPersonGroupId FROM @PersonGroupMap

				COMMIT TRAN
				SELECT 2 AS IsSuccess, 'Person group saved successfully' AS Result
			END TRY
			BEGIN CATCH
				ROLLBACK TRAN
				SELECT 0 AS IsSuccess, 'Error occured while saving person group' AS Result
			END CATCH
		END
	END
	ELSE 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM  tbl_PersonGroup 
		WHERE GroupName = @GroupName AND PersonGroupId != @PersonGroupId
		AND IsDeleted = 0
		)
		BEGIN
			SELECT -1 AS IsSuccess, 'Person group name already exists' AS Result
		END	
		ELSE 
		BEGIN
			BEGIN TRY
				BEGIN TRAN
					UPDATE tbl_PersonGroup
					SET GroupName = @GroupName,
					ModifiedBy = @CreatedBy,
					ModifiedDate = GETUTCDATE()
					WHERE PersonGroupId = @PersonGroupId

					--UPDATE G SET
					--G.PersonId = G_tbl.PersonId,
					--G.PersonGroupId = G_tbl.PersonGroupId
					--FROM tbl_PersonGroupMap G
					--INNER JOIN @PersonGroupMap G_tbl ON G_tbl.PersonGroupMapId = G.PersonGroupMapId
					--WHERE G_tbl.PersonGroupMapId <> '';
					DELETE FROM tbl_PersonGroupMap WHERE PersonGroupId = @PersonGroupId

					INSERT INTO tbl_PersonGroupMap (PersonGroupMapId, PersonId, PersonGroupId)
					SELECT NEWID(), G_tbl.PersonId, G_tbl.PersonGroupId FROM @PersonGroupMap G_tbl
					

				COMMIT TRAN
				SELECT 3 AS IsSuccess, 'Person group updated successfully' AS Result
			END TRY
			BEGIN CATCH
				ROLLBACK TRAN
				SELECT 0 AS IsSuccess, 'Error occured while updating person group' AS Result
			END CATCH
		END
	END

END




GO
/****** Object:  StoredProcedure [dbo].[SP_SaveSiteBill]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveSiteBill]
@billId NVARCHAR(255)= null ,    
@billDate DATETIME ,    
@billNo NVARCHAR(255),    
@siteId NVARCHAR(255),    
@totalAmount DECIMAL,    
@remarks Nvarchar(255) ,    
@billOriginalFileName NVARCHAR(255)= null,
@billNewFileName NVARCHAR(255)= null,
@createdBy NVARCHAR(255)= null
AS    
BEGIN    
DECLARE @clientdId UNIQUEIDENTIFIER = (SELECT TOP 1 ClientId FROM tbl_Sites WHERE SiteId = @siteId)
DECLARE @FileCategoryId INT = (SELECT TOP 1 FileCategoryId from [tbl_FileCategory] where FileCategoryName= 'Debit') 
IF (@billId IS NULL)          
BEGIN    

	DECLARE @newbillId UNIQUEIDENTIFIER= (SELECT NEWID());    
	INSERT INTO tbl_BillSiteNew(BillId,BillDate,BillNo,BillType,SiteId,TotalAmount,Remarks,ClientId,IsActive, IsDeleted,CreatedBy,CreatedDate)    
	Values(@newbillId ,@billDate,@billNo,'File',@siteId,@totalAmount,@remarks,@clientdId ,1,0,@createdBy,GETUTCDATE())  
	
	IF((@billOriginalFileName IS NOT NULL) AND (@billNewFileName IS NOT NULL))
	BEGIN

		INSERT INTO tbl_Files VALUES (NEWID(), @newbillId, @FileCategoryId, @billOriginalFileName, @billNewFileName)

	END
	SELECT 0     
END    
ELSE    
BEGIN 

	UPDATE tbl_BillSiteNew SET    
	BillDate = @billDate,    
	BillNo = @billNo,        
	TotalAmount = @totalAmount,    
	Remarks = @remarks,   
	ModifiedBy = @createdBy,    
	ModifiedDate = GETUTCDATE()    
	WHERE BillId = @billId 
	
	IF((@billOriginalFileName IS NOT NULL) AND (@billNewFileName IS NOT NULL))
	BEGIN

		IF EXISTS(SELECT TOP 1 1 FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @billId)
		BEGIN

		 UPDATE tbl_Files SET OriginalFileName = @billOriginalFileName,EncryptFileName = @billNewFileName WHERE FileId = (SELECT  FileId FROM tbl_Files WHERE FileCategory = @FileCategoryId AND ParentId = @billId)

		END
		ELSE
		BEGIN

		INSERT INTO tbl_Files VALUES (NEWID(), @billId, @FileCategoryId, @billOriginalFileName, @billNewFileName)

		END
	END
	SELECT 1    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveSiteImages]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SaveSiteImages](
@siteId NVARCHAR(255),
@categoryId NVARCHAR(255),
@siteImages tbl_SitePhotos READONLY  
)
AS
BEGIN
	INSERT INTO [tbl_SitePhoto] (SitePhotoId, SiteId,SitePhotoCategoryId,PhotoDate,PhotoName)    
	SELECT NEWID(),@siteId,@categoryId,GETUTCDATE(),I.PhotoEncryptedName     
	FROM @siteImages I 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveSitePhotoCategory]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveSitePhotoCategory]  
@sitePhotoCategoryId NVARCHAR(255)= null ,      
@categoryName NVARCHAR(255)= null ,      
@clientId NVARCHAR(255)= null   
AS      
BEGIN      
IF (@sitePhotoCategoryId IS NULL)            
BEGIN      
  
 INSERT INTO [tbl_SitePhotoCategory] Values(NEWID() ,@categoryName,@clientId,GETUTCDATE())      
  
END      
ELSE      
 BEGIN   
  
  UPDATE [tbl_SitePhotoCategory] SET      
  CategoryName = @categoryName         
  WHERE SitePhotoCategoryId =  @sitePhotoCategoryId  
  
  SELECT 1      
 END      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveUser]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveUser]        
@userId NVARCHAR(255) ,        
@userName NVARCHAR(255) ,        
@password NVARCHAR(255) NULL,        
@clientId NVARCHAR(255),        
@name NVARCHAR(255),        
@email NVARCHAR(255) NULL,        
@mobileNumber NVARCHAR(30) NULL  
AS        
BEGIN        
	IF (@userId IS NULL)     
	BEGIN     
		IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE @email = RTRIM(LTRIM(EmailId)) AND IsDeleted = 0)
		BEGIN
			SELECT 2
		END
		ELSE IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE UserName = RTRIM(LTRIM(@userName)) AND IsDeleted = 0)
		BEGIN
			SELECT 3
		END
		ELSE
		BEGIN
			INSERT INTO tbl_Users(UserId,UserName,Password,ClientId,FirstName,EmailId,MobileNo,RoleId,IsActive,IsDeleted,CreatedDate)        
			VALUES(NEWID(),@userName,@password,@clientId,@name,@email,@mobileNumber,2,1,0,GETUTCDATE())        
			SELECT 0 
		END
	END       
	ELSE        
	BEGIN     
 
		IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE @email = RTRIM(LTRIM(EmailId)) AND UserId <> @userId AND IsDeleted = 0)
		BEGIN
			SELECT 2
		END
		ELSE IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE UserName = RTRIM(LTRIM(@userName)) AND UserId <> @userId AND IsDeleted = 0)
		BEGIN
			SELECT 3
		END
		ELSE 
		BEGIN
			UPDATE tbl_Users        
			SET        
			UserName = @userName,        
			Password = @password,        
			FirstName = @name,        
			EmailId = @email,        
			MobileNo = @mobileNumber,        
			ModifiedDate = GETUTCDATE(),  
			JWTToken = null  
			WHERE UserId = @userId        
			SELECT 1   
		END
     
	END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SaveVehicleOwner]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_SaveVehicleOwner]    
@VehicleOwnerId NVARCHAR(255),    
@ClientId NVARCHAR(255) ,    
@VehicleOwnerName NVARCHAR(255) NULL,    
@MobileNo NVARCHAR(20) ,    
@Remarks NVARCHAR(500),
@CreatedBy NVARCHAR(255)
AS    

BEGIN    

	IF (@VehicleOwnerId IS NULL)          
	 BEGIN  
    
	  INSERT INTO tbl_VehicleOwner(VehicleOwnerId,ClientId,VehicleOwnerName,MobileNo,Remarks,IsActive,IsDeleted,CreatedDate, CreatedBy)    
	  VALUES(NEWID(),@ClientId,@VehicleOwnerName,@MobileNo,@Remarks,1,0,GETUTCDATE(),@CreatedBy)    
	  SELECT 0  
   
	END    
	ELSE     
	BEGIN    

	   UPDATE tbl_VehicleOwner    
	   SET   
	   ClientId = @ClientId,    
	   VehicleOwnerName = @VehicleOwnerName,    
	   MobileNo = @MobileNo,    
	   Remarks = @Remarks,        
	   ModifiedDate = GETUTCDATE(),
	   ModifiedBy = @CreatedBy
	   WHERE VehicleOwnerId = @VehicleOwnerId    
	   SELECT 1    
    
 END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SiteList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec SP_SiteList 1,10,'','asc',null,'93A147DF-05B9-4F93-8C2D-0E3FB7CB99F6'
CREATE PROCEDURE [dbo].[SP_SiteList]               
@pageIndex INT = 1,              
@pageSize INT = 10,              
@orderBy NVARCHAR(100) = '' ,              
@sortOrder NVARCHAR(10) = 'ASC',              
@strSearch NVARCHAR(250) = NULL,  
@clientId NVARCHAR(50)  
AS              
BEGIN              
 SET @strSearch = LTRIM(RTRIM(@strSearch))              
 SET @orderBy = LTRIM(RTRIM(@orderBy))              
 SET @sortOrder = LTRIM(RTRIM(@sortOrder))              
 IF(ISNULL(@orderBy, '') = '')              
  BEGIN              
   SET  @orderBy = 'CreatedDate'              
  END              
 IF(ISNULL(@sortOrder, '') = '')              
  BEGIN              
   SET @sortOrder = 'DESC'              
  END              
 IF(ISNULL(@PageSize, 0) = 0)              
  BEGIN              
   SET @PageSize = 10              
  END              
 IF(ISNULL(@PageSize, 0) = 0)              
  BEGIN              
   SET @PageSize = 10              
  END              
 ELSE IF(ISNULL(@PageSize,0) = -1)              
  BEGIN              
   SET @PageSize = 500000000                
  END              
SELECT 
    S.SiteId,
    S.SiteName,
    S.SiteDescription,
    S.IsActive,
	s.CreatedDate,
    ISNULL(CF.CreditAmount, 0) AS CreditAmount,
    ISNULL(BS.BillAmount, 0) AS BillAmount,
    ISNULL(CF.CreditAmount, 0) - ISNULL(BS.BillAmount, 0) AS Remaining,
    COUNT(*) OVER () AS TotalRecords
FROM 
    tbl_Sites S
LEFT JOIN 

(SELECT CF.SiteId,SUM(CF.Amount) AS CreditAmount FROM tbl_ContractorFinance CF WHERE CF.IsDeleted = 0 GROUP BY CF.SiteId)
	CF ON S.SiteId = CF.SiteId

LEFT JOIN 

(SELECT BS.SiteId,SUM(BS.TotalAmount) AS BillAmount    FROM tbl_BillSiteNew BS WHERE BS.IsDeleted = 0 GROUP BY BS.SiteId)
BS ON S.SiteId = BS.SiteId

 WHERE         
 S.IsDeleted =0 AND S.ClientId = @clientId AND       
  (ISNULL(@strSearch, '') = ''              
  OR SiteName LIKE '%' + @strSearch + '%'              
  OR SiteDescription LIKE '%' + @strSearch + '%'               
  OR (CASE WHEN S.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')              
 GROUP BY S.SiteId,S.SiteName,S.SiteDescription, S.IsActive,S.CreatedDate,CreditAmount,BillAmount
  ORDER BY               
   CASE WHEN @orderBy = 'SiteId' AND @sortOrder ='ASC' THEN S.SiteId END ASC,              
 CASE WHEN @orderBy = 'SiteId' AND @sortOrder ='DESC' THEN S.SiteId END DESC,             
 CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='ASC' THEN SiteName END ASC,              
 CASE WHEN @orderBy = 'SiteName' AND @sortOrder ='DESC' THEN SiteName END DESC,              
 CASE WHEN @orderBy = 'SiteDescription' AND @sortOrder ='ASC' THEN SiteDescription END ASC,              
 CASE WHEN @orderBy = 'SiteDescription' AND @sortOrder ='DESC' THEN SiteDescription END DESC,               
 CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='ASC' THEN S.IsActive END ASC,              
 CASE WHEN @orderBy = 'IsActive' AND @sortOrder ='DESC' THEN S.IsActive END DESC,               
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='ASC' THEN S.CreatedDate END ASC,              
 CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder ='DESC' THEN S.CreatedDate END DESC
 OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS              
 FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY              
              
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SiteList_V2]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SiteList_V2]                     
    @pageIndex INT = 1,                    
    @pageSize INT = 10,                    
    @orderBy NVARCHAR(100) = '',                    
    @sortOrder NVARCHAR(10) = 'ASC',                    
    @strSearch NVARCHAR(250) = NULL,        
    @clientId NVARCHAR(50),    
    @startDate DATETIME,    
    @endDate DATETIME,
	@activeInActiveStatus NVARCHAR(10)  
AS                    
BEGIN                    
    SET @strSearch = LTRIM(RTRIM(@strSearch))                    
    SET @orderBy = LTRIM(RTRIM(@orderBy))                    
    SET @sortOrder = LTRIM(RTRIM(@sortOrder))                    
    
    IF(ISNULL(@orderBy, '') = '')                    
    BEGIN                    
        SET @orderBy = 'CreatedDate'                    
    END                    
    
    IF(ISNULL(@sortOrder, '') = '')                    
    BEGIN                    
        SET @sortOrder = 'DESC'                    
    END                    
    
    IF(ISNULL(@pageSize, 0) = 0)                    
    BEGIN                    
        SET @pageSize = 10                    
    END                    
    ELSE IF(ISNULL(@pageSize, 0) = -1)                    
    BEGIN                    
        SET @pageSize = 500000000                      
    END                    
    
    SELECT     
        S.SiteId,    
        S.SiteName,    
        S.SiteDescription,    
        S.IsActive,      
        ISNULL(CF.CreditAmount, 0) AS CreditAmount,    
        ISNULL(BS.BillAmount, 0) AS BillAmount,    
        ISNULL(CF.CreditAmount, 0) - ISNULL(BS.BillAmount, 0) AS Remaining,    
        COUNT(*) OVER () AS TotalRecords    
    FROM     
        tbl_Sites S     
        LEFT JOIN (  
            SELECT CF.SiteId, SUM(CF.Amount) AS CreditAmount     
            FROM tbl_ContractorFinance CF     
            WHERE CF.IsDeleted = 0  
              AND (ISNULL(@startDate,'')='' OR CF.SelectedDate >= @startDate)  
              AND (ISNULL(@endDate,'')= '' OR CF.SelectedDate <= @endDate)     
            GROUP BY CF.SiteId  
        ) CF ON S.SiteId = CF.SiteId      
        LEFT JOIN (  
            SELECT BS.SiteId, SUM(BS.TotalAmount) AS BillAmount        
            FROM tbl_BillSiteNew BS     
            WHERE BS.IsDeleted = 0  
              AND (ISNULL(@startDate,'') ='' OR BS.BillDate >= @startDate)  
              AND (ISNULL(@endDate,'') = '' OR BS.BillDate <= @endDate)     
            GROUP BY BS.SiteId  
        ) BS ON S.SiteId = BS.SiteId    
    WHERE               
        S.IsDeleted = 0     
        AND S.ClientId = @clientId     
        AND (ISNULL(@strSearch, '') = ''                    
            OR SiteName LIKE '%' + @strSearch + '%'                    
            OR SiteDescription LIKE '%' + @strSearch + '%' 
			OR ISNULL(CF.CreditAmount, 0) LIKE '%' + @strSearch + '%' 
			OR ISNULL(BS.BillAmount, 0) LIKE '%' + @strSearch + '%' 
			OR ISNULL(CF.CreditAmount, 0) - ISNULL(BS.BillAmount, 0) LIKE '%' + @strSearch + '%' 
            OR (CASE WHEN S.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%')  
		AND S.IsActive IN (SELECT value FROM STRING_SPLIT(@activeInActiveStatus, ','))  
    GROUP BY     
        S.SiteId,    
        S.SiteName,    
        S.SiteDescription,    
        S.IsActive,    
        S.CreatedDate,    
        CF.CreditAmount,    
        BS.BillAmount      
    ORDER BY                     
        CASE WHEN @orderBy = 'SiteId' AND @sortOrder = 'ASC' THEN S.SiteId END ASC,                    
        CASE WHEN @orderBy = 'SiteId' AND @sortOrder = 'DESC' THEN S.SiteId END DESC,                   
        CASE WHEN @orderBy = 'SiteName' AND @sortOrder = 'ASC' THEN S.SiteName END ASC,                    
        CASE WHEN @orderBy = 'SiteName' AND @sortOrder = 'DESC' THEN S.SiteName END DESC,   
        CASE WHEN @orderBy = 'CreditAmount' AND @sortOrder = 'ASC' THEN ISNULL(CF.CreditAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'CreditAmount' AND @sortOrder = 'DESC' THEN ISNULL(CF.CreditAmount, 0) END DESC, 
        CASE WHEN @orderBy = 'BillAmount' AND @sortOrder = 'ASC' THEN ISNULL(BS.BillAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'BillAmount' AND @sortOrder = 'DESC' THEN ISNULL(BS.BillAmount, 0) END DESC, 
        CASE WHEN @orderBy = 'RemainingAmount' AND @sortOrder = 'ASC' THEN ISNULL(CF.CreditAmount, 0) - ISNULL(BS.BillAmount, 0) END ASC,                    
        CASE WHEN @orderBy = 'RemainingAmount' AND @sortOrder = 'DESC' THEN ISNULL(CF.CreditAmount, 0) - ISNULL(BS.BillAmount, 0) END DESC, 
        CASE WHEN @orderBy = 'SiteDescription' AND @sortOrder = 'ASC' THEN SiteDescription END ASC,                    
        CASE WHEN @orderBy = 'SiteDescription' AND @sortOrder = 'DESC' THEN SiteDescription END DESC,                     
        CASE WHEN @orderBy = 'IsActive' AND @sortOrder = 'ASC' THEN S.IsActive END ASC,                    
        CASE WHEN @orderBy = 'IsActive' AND @sortOrder = 'DESC' THEN S.IsActive END DESC,                     
        CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'ASC' THEN S.CreatedDate END ASC,                    
        CASE WHEN @orderBy = 'CreatedDate' AND @sortOrder = 'DESC' THEN S.CreatedDate END DESC      
    OFFSET ((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS                    
    FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY                    
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLoginToken]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateLoginToken](
@Token NVARCHAR(max),
@UserId UNIQUEIDENTIFIER
)
AS
BEGIN
	UPDATE tbl_Users SET JWTToken = @Token WHERE UserId = @UserId
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UpdteProfile]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdteProfile](    
@UserId NVARCHAR(255), 
@UserEmail NVARCHAR(MAX),
@UserName NVARCHAR(500),    
@FirstName NVARCHAR(500),    
@MobileNo NVARCHAR(255),  
@userPhoto NVARCHAR(255)  
)    
AS    
BEGIN 
	IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE EmailId = RTRIM(LTRIM(@UserEmail)) AND UserId <> @UserId)
	BEGIN
		SELECT 2
	END
	ELSE IF EXISTS (SELECT TOP 1 1 FROM tbl_Users WHERE UserName = RTRIM(LTRIM(@UserName)) AND UserId <> @UserId)
	BEGIN
		SELECT 3
	END
	ELSE
	BEGIN
		UPDATE tbl_Users SET UserName = @UserName,  EmailId = @UserEmail, FirstName = @FirstName, MobileNo = @MobileNo, ModifiedDate = GETUTCDATE() WHERE UserId = @UserId    
		SELECT 1    
  
		IF(@userPhoto IS NOT NULL)  
		BEGIN  
			UPDATE tbl_Users SET UserPhoto = @userPhoto WHERE UserId = @UserId    
		END  
	END
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_UserList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_UserList]      
@pageIndex INT = 1,          
@pageSize INT = 10,          
@orderBy NVARCHAR(100) = '' ,          
@sortOrder NVARCHAR(10) = 'asc',          
@strSearch NVARCHAR(250) = null,      
@clientId NVARCHAR(50)
AS          
BEGIN          
SET @strSearch = LTRIM(RTRIM(@strSearch))          
          
 SET @orderBy = LTRIM(RTRIM(@orderBy))          
SET @sortOrder = LTRIM(RTRIM(@sortOrder))          
        
IF(ISNULL(@orderBy, '') = '')          
BEGIN          
SET  @orderBy = 'CreatedDate'          
END          
        
IF(ISNULL(@sortOrder, '') = '')          
BEGIN          
SET @sortOrder = 'DESC'          
END        
        
IF(ISNULL(@PageSize, 0) = 0)          
BEGIN          
SET @PageSize = 10          
END        
        
IF(ISNULL(@PageSize, 0) = 0)          
BEGIN          
SET @PageSize = 10          
END         
        
else  IF(ISNULL(@PageSize,0) = -1)          
BEGIN          
SET @PageSize = 500000000            
END          
        
SELECT U.UserId, U.UserName, U.UserPhoto, U.FirstName as [Name], U.EmailId, U.MobileNo, U.IsActive, C.ClientName, C.ClientId ,COUNT(*) OVER() AS TotalRecords       
from tbl_Users U       
INNER JOIN tbl_Clients C ON C.ClientId  = U.ClientId      
Where          
U.IsDeleted = 0 AND U.ClientId = @clientId  
AND
 (ISNULL(@strSearch, '') = ''          
 OR UserName Like '%' + @strSearch + '%'          
 OR FirstName Like '%' + @strSearch + '%'          
 OR EmailId Like '%' + @strSearch + '%'          
 OR MobileNo Like '%' + @strSearch + '%'
 OR (CASE WHEN U.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) Like '%' + @strSearch + '%'
 )          
ORDER BY          
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'ASC') THEN UserName  END ASC,                  
 CASE WHEN (@orderBy = 'UserName' AND @sortOrder = 'DESC') THEN UserName  END DESC,                  
 CASE WHEN (@orderBy = 'ClientName' AND @sortOrder = 'ASC') THEN C.ClientName  END ASC,                  
 CASE WHEN (@orderBy = 'ClientName' AND @sortOrder = 'DESC') THEN C.ClientName  END DESC,                  
 CASE WHEN (@orderBy = 'Name' AND @sortOrder = 'ASC') THEN FirstName  END ASC,                  
 CASE WHEN (@orderBy = 'Name' AND @sortOrder = 'DESC') THEN FirstName END DESC,                  
 CASE WHEN (@orderBy = 'EmailId' AND @sortOrder = 'ASC') THEN EmailId  END ASC,                  
 CASE WHEN (@orderBy = 'EmailId' AND @sortOrder = 'DESC') THEN EmailId  END DESC,                  
 CASE WHEN (@orderBy = 'MobileNo' AND @sortOrder = 'ASC') THEN MobileNo  END ASC,                  
 CASE WHEN (@orderBy = 'MobileNo' AND @sortOrder = 'DESC') THEN MobileNo  END DESC,            
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN U.IsActive END ASC,                  
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN U.IsActive END DESC,                 
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'ASC') THEN U.CreatedDate END ASC,          
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'DESC') THEN U.CreatedDate  END DESC          
           
          
          
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS          
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UserLogin]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UserLogin]    
(            
@UserName NVARCHAR(30),            
@Password NVARCHAR(50)            
)            
AS            
BEGIN     
IF EXISTS(SELECT TOP 1 1 FROM tbl_Users WHERE (EmailId = @UserName OR UserName = @UserName) AND IsDeleted = 0)    
BEGIN    
 IF((SELECT TOP 1 IsActive FROM tbl_Users WHERE (EmailId = @UserName OR UserName = @UserName) AND [Password] = @Password ) = 0  )    
 BEGIN    
 SELECT 2 AS [Status]    
 END    
 ELSE IF((SELECT C.IsActive FROM tbl_Clients C INNER JOIN tbl_Users U ON C.ClientId = U.ClientId WHERE (EmailId = @UserName OR UserName = @UserName) AND [Password] = @Password AND U.IsActive = 1 AND U.IsDeleted = 0 AND C.IsDeleted = 0) = 0)    
 BEGIN    
 SELECT 3 AS [Status]    
 END    
 ELSE IF((SELECT C.ExpireDate FROM tbl_Clients C INNER JOIN tbl_Users U ON C.ClientId = U.ClientId WHERE (EmailId = @UserName OR UserName = @UserName) AND [Password] = @Password AND U.IsActive = 1 AND U.IsDeleted = 0 AND C.IsActive = 0) < GETUTCDATE())    
 BEGIN    
 SELECT 4 AS [Status]    
 END    
  
 ELSE    
 BEGIN    
 SELECT TU.UserId, TU.UserName AS UserName, TU.ClientId, TU.EmailId, TU.UserPhoto, TU.FirstName AS FullName, TC.FirmName, TR.RoleName,TU.RoleId  FROM tbl_Users TU           
 INNER JOIN  tbl_Role TR ON TR.RoleId = TU.RoleId          
 LEFT JOIN tbl_Clients TC ON TC.ClientId = TU.ClientId           
 WHERE (EmailId = @UserName OR UserName = @UserName) AND [Password] = @Password            
 END    
END    
ELSE    
BEGIN    
SELECT 404 AS [Status]    
END       
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_validatetoken]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_validatetoken] 
(
@Id NVARCHAR(255),
@jwtToken NVARCHAR(max)
)

AS
  BEGIN
      IF((SELECT Count(jwttoken) FROM   tbl_users WHERE  userid = @Id AND isdeleted = 0) = 1)
        BEGIN
            IF(@jwtToken = (Select JWTToken  from tbl_users where UserId=@Id))    
			BEGIN    
			  SELECT 1    
			END    
			ELSE    
				BEGIN    
				  SELECT 0    
				END 
			END
      ELSE
        BEGIN
            SELECT 0
        END
  END 
GO
/****** Object:  StoredProcedure [dbo].[SP_VehicleOwnerList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_VehicleOwnerList]      
@pageIndex int = 1,    
@pageSize int = 10,    
@orderBy NVARCHAR(100) = '' ,    
@sortOrder NVARCHAR(10) = 'asc',    
@strSearch NVARCHAR(250) = null,
@clientId NVARCHAR(250) = null
AS    
BEGIN    
SET @strSearch = LTRIM(RTRIM(@strSearch))    
    
 SET @orderBy = LTRIM(RTRIM(@orderBy))    
SET @sortOrder = LTRIM(RTRIM(@sortOrder))    
IF(ISNULL(@orderBy, '') = '')    
BEGIN    
SET  @orderBy = 'CreatedDate'    
END    
IF(ISNULL(@sortOrder, '') = '')    
BEGIN    
    
SET @sortOrder = 'DESC'    
END    
IF(ISNULL(@PageSize, 0) = 0)    
BEGIN    
SET @PageSize = 10    
END    
IF(ISNULL(@PageSize, 0) = 0)    
BEGIN    
SET @PageSize = 10    
END    
else  IF(ISNULL(@PageSize,0) = -1)    
BEGIN    
SET @PageSize = 500000000      
END    
select V.VehicleOwnerId, V.Remarks,V.MobileNo, V.VehicleOwnerName,V.IsActive, COUNT(*) OVER() AS TotalRecords     
from tbl_VehicleOwner V   
Where    
V.IsDeleted = 0 AND  V.ClientId = @clientId AND  
 (ISNULL(@strSearch, '') = ''    
 OR VehicleOwnerName Like '%' + @strSearch + '%'    
 OR MobileNo Like '%' + @strSearch + '%'    
 OR Remarks Like '%' + @strSearch + '%' 
 OR (CASE WHEN V.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) Like '%' + @strSearch + '%' 
 )    
ORDER BY    
    
 CASE WHEN (@orderBy = 'VehicleOwnerName' AND @sortOrder = 'ASC') THEN VehicleOwnerName  END ASC,            
 CASE WHEN (@orderBy = 'VehicleOwnerName' AND @sortOrder = 'DESC') THEN VehicleOwnerName  END DESC,            
 CASE WHEN (@orderBy = 'MobileNo' AND @sortOrder = 'ASC') THEN MobileNo  END ASC,            
 CASE WHEN (@orderBy = 'MobileNo' AND @sortOrder = 'DESC') THEN MobileNo  END DESC,            
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'ASC') THEN Remarks  END ASC,            
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder = 'DESC') THEN Remarks  END DESC,            
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'ASC') THEN CreatedDate  END ASC,            
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder = 'DESC') THEN CreatedDate  END DESC,
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'ASC') THEN V.IsActive END ASC,            
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder = 'DESC') THEN V.IsActive END DESC 
    
    
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS    
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VehicleOwnerListForRent]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
--exec SP_GetMerchantById '4F389DB6-38B6-4B8C-B0FD-DCC8B5BBA61E'    
CREATE PROCEDURE  [dbo].[SP_VehicleOwnerListForRent]    
As    
Begin    
select VehicleOwnerId,VehicleOwnerName from tbl_VehicleOwner  WHERE IsActive = 1 AND IsDeleted = 0 ORDER BY VehicleOwnerName ASC    
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_VehicleRentActiveInActive]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VehicleRentActiveInActive](        
@VehicleRentId VARCHAR(299),        
@userId VARCHAR(255)        
)        
AS        
BEGIN        
 IF((SELECT IsActive FROM tbl_VehicleRent WHERE VehicleRentId = @VehicleRentId)= 1)        
 BEGIN        
  UPDATE tbl_VehicleRent SET IsActive = 0,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE VehicleRentId = @VehicleRentId        
  SELECT VehicleRentId,VehicleOwnerId,Remarks,VehicleRentDate,FromLocation,ToLocation,Remarks ,IsActive, Amount FROM tbl_VehicleRent WHERE VehicleRentId = @VehicleRentId        
 END        
 ELSE IF((SELECT IsActive FROM tbl_VehicleRent WHERE VehicleRentId = @VehicleRentId)= 0)        
 BEGIN        
  UPDATE tbl_VehicleRent SET IsActive = 1,ModifiedBy = @userId, ModifiedDate = GETUTCDATE() WHERE VehicleRentId = @VehicleRentId        
  SELECT VehicleRentId,VehicleOwnerId,Remarks,VehicleRentDate,FromLocation,ToLocation,Remarks, IsActive, Amount FROM tbl_VehicleRent WHERE VehicleRentId = @VehicleRentId        
 END        
END  
GO
/****** Object:  StoredProcedure [dbo].[SP_VehicleRentList]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [SP_VehicleRentList] 1,10,'','','','2024-04-01','2024-6-12',NULL  
CREATE PROCEDURE  [dbo].[SP_VehicleRentList]  
@pageIndex int = 1,  
@pageSize int = 10,  
@orderBy nvarchar(max) = '' ,  
@sortOrder varchar(10) = 'asc',  
@strSearch nvarchar(max) = null ,  
@startDate DateTime,  
@endDate DateTime,
@vehicleOwnerId NVARCHAR(MAX) = NULL,
@clientId NVARCHAR(MAX)
AS  
BEGIN  
SET @strSearch = LTRIM(RTRIM(@strSearch))  
  
SET @orderBy = LTRIM(RTRIM(@orderBy))  
SET @sortOrder = LTRIM(RTRIM(@sortOrder))  
IF(ISNULL(@orderBy, '') = '')  
BEGIN  
SET  @orderBy = 'CreatedDate'  
END  
IF(ISNULL(@sortOrder, '') = '')  
BEGIN  
  
SET @sortOrder = 'DESC'  
END  
IF(ISNULL(@PageSize, 0) = 0)  
BEGIN  
SET @PageSize = 10  
END  
IF(ISNULL(@PageSize, 0) = 0)  
BEGIN  
SET @PageSize = 10  
END  
else  IF(ISNULL(@PageSize,0) = -1)  
BEGIN  
SET @PageSize = 500000000    
END  
select V.VehicleRentId,v.VehicleOwnerId,vl.VehicleOwnerName, v.VehicleRentDate, v.FromLocation,v.Amount,v.IsActive ,v.ToLocation,v.VehicleNumber,v.IsPaid,v.Remarks,v.ClientId  
  
,V.CreatedBy AS CreatedBy,V.CreatedDate, COUNT(*) OVER() AS totalRecords   
, ROW_NUMBER() OVER (ORDER BY  
    CASE WHEN @orderBy = 'VehicleRentId' AND @sortOrder ='ASC' THEN V.VehicleRentId END ASC,  
 CASE WHEN @orderBy = 'VehicleRentId' AND @sortOrder ='DESC' THEN V.VehicleRentId END DESC,   
 CASE WHEN @orderBy = 'VehicleOwnerId' AND @sortOrder ='ASC' THEN V.VehicleOwnerId END ASC,  
 CASE WHEN @orderBy = 'VehicleOwnerId' AND @sortOrder ='DESC' THEN V.VehicleOwnerId END DESC,   
 CASE WHEN @orderBy = 'VehicleRentDate' AND @sortOrder ='ASC' THEN V.VehicleRentDate END ASC,  
 CASE WHEN @orderBy = 'VehicleRentDate' AND @sortOrder ='DESC' THEN V.VehicleRentDate END DESC,  
 CASE WHEN @orderBy = 'FromLocation' AND @sortOrder ='ASC' THEN V.FromLocation END ASC,  
 CASE WHEN @orderBy = 'FromLocation' AND @sortOrder ='DESC' THEN V.FromLocation END DESC,   
 CASE WHEN @orderBy = 'VehicleOwnerName' AND @sortOrder ='ASC' THEN vl.VehicleOwnerName END ASC,  
 CASE WHEN @orderBy = 'VehicleOwnerName' AND @sortOrder ='DESC' THEN vl.VehicleOwnerName END DESC,  
 CASE WHEN @orderBy = 'VehicleNumber' AND @sortOrder ='ASC' THEN V.VehicleNumber END ASC,  
 CASE WHEN @orderBy = 'VehicleNumber' AND @sortOrder ='DESC' THEN V.VehicleNumber END DESC,   
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='ASC' THEN V.Remarks END ASC,  
 CASE WHEN @orderBy = 'Remarks' AND @sortOrder ='DESC' THEN V.Remarks END DESC,   
 CASE WHEN @orderBy = 'IsPaid' AND @sortOrder ='ASC' THEN V.IsPaid END ASC,  
 CASE WHEN @orderBy = 'IsPaid' AND @sortOrder ='DESC' THEN V.IsPaid END DESC ,
 CASE WHEN @orderBy = 'Amount' AND @sortOrder ='ASC' THEN V.Amount END ASC,  
 CASE WHEN @orderBy = 'Amount' AND @sortOrder ='DESC' THEN V.Amount END DESC  
     ) AS SrNo  
from tbl_VehicleRent v  
left join tbl_Clients CL on CL.ClientId=V.ClientId  
left join tbl_VehicleOwner VL on VL.VehicleOwnerId=V.VehicleOwnerId  
 WHERE
	V.ClientId = @clientId AND
        V.VehicleRentDate >= @startDate AND V.VehicleRentDate <= @endDate
        AND (ISNULL(@vehicleOwnerId,'') = '' OR V.VehicleOwnerId IN (SELECT [Value] FROM STRING_SPLIT(@vehicleOwnerId,',')))
        AND (
            ISNULL(@strSearch, '') = ''
            OR V.VehicleRentId LIKE '%' + @strSearch + '%'
            OR V.VehicleOwnerId LIKE '%' + @strSearch + '%'
            OR vl.VehicleOwnerName LIKE '%' + @strSearch + '%'
            OR V.VehicleRentDate LIKE '%' + @strSearch + '%'
            OR V.FromLocation LIKE '%' + @strSearch + '%'
            OR V.ToLocation LIKE '%' + @strSearch + '%'
            OR V.VehicleNumber LIKE '%' + @strSearch + '%'
            OR V.IsPaid LIKE '%' + @strSearch + '%'
            OR V.Remarks LIKE '%' + @strSearch + '%'
            OR V.Amount LIKE '%' + @strSearch + '%'
            OR (CASE WHEN V.IsActive = 1 THEN 'Active' ELSE 'Inactive' END) LIKE '%' + @strSearch + '%'
        ) 
ORDER BY   
 CASE WHEN (@orderBy = 'VehicleRentId' AND @sortOrder ='ASC') THEN V.VehicleRentId END ASC,  
 CASE WHEN (@orderBy = 'VehicleRentId' AND @sortOrder ='DESC') THEN V.VehicleRentId END DESC,   
 CASE WHEN (@orderBy = 'VehicleOwnerId' AND @sortOrder ='ASC') THEN V.VehicleOwnerId END ASC,  
 CASE WHEN (@orderBy = 'VehicleOwnerId' AND @sortOrder ='DESC') THEN V.VehicleOwnerId END DESC,   
 CASE WHEN (@orderBy = 'VehicleRentDate' AND @sortOrder ='ASC') THEN V.VehicleRentDate END ASC,  
 CASE WHEN (@orderBy = 'VehicleRentDate' AND @sortOrder ='DESC') THEN V.VehicleRentDate END DESC,  
 CASE WHEN (@orderBy = 'FromLocation' AND @sortOrder ='ASC') THEN V.FromLocation END ASC,  
 CASE WHEN (@orderBy = 'FromLocation' AND @sortOrder ='DESC') THEN V.FromLocation END DESC,   
 CASE WHEN (@orderBy = 'VehicleNumber' AND @sortOrder ='ASC') THEN V.VehicleNumber END ASC,  
 CASE WHEN (@orderBy = 'VehicleNumber' AND @sortOrder ='DESC') THEN V.VehicleNumber END DESC,   
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder ='ASC') THEN V.Remarks END ASC,  
 CASE WHEN (@orderBy = 'Remarks' AND @sortOrder ='DESC') THEN V.Remarks END DESC,   
 CASE WHEN (@orderBy = 'IsPaid' AND @sortOrder ='ASC') THEN V.IsPaid END ASC,  
 CASE WHEN (@orderBy = 'IsPaid' AND @sortOrder ='DESC') THEN V.IsPaid END DESC,   
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder ='ASC') THEN V.CreatedDate END ASC,  
 CASE WHEN (@orderBy = 'CreatedDate' AND @sortOrder ='DESC') THEN V.CreatedDate END DESC,  
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder ='ASC') THEN V.IsActive END ASC,  
 CASE WHEN (@orderBy = 'IsActive' AND @sortOrder ='DESC') THEN V.IsActive END DESC
OFFSET((ISNULL(@pageIndex, 1) - 1) * ISNULL(@pageSize, 500000000)) ROWS  
FETCH NEXT ISNULL(@pageSize, 500000000) ROWS ONLY  
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SP_VehicleRentListForExport]    Script Date: 6/18/2024 4:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VehicleRentListForExport] 
(
@VehicleOwnerId VARCHAR(MAX) = NULL
)
AS  
BEGIN  
 SELECT   
  VR.VehicleRentId,  
  VR.VehicleRentDate,  
  VO.VehicleOwnerName,  
  VR.FromLocation,  
  VR.ToLocation,  
  VR.VehicleNumber,  
  VR.Amount,  
  VR.IsActive,  
  COUNT(*) OVER() AS TotalRecords  
 FROM tbl_VehicleRent VR   
 INNER JOIN tbl_VehicleOwner VO   
 ON VO.VehicleOwnerId = VR.VehicleOwnerId  
 WHERE VR.IsActive = 1  
 AND ((1=1 AND ISNULL(@VehicleOwnerId,'')=''OR(VR.VehicleOwnerId IN (SELECT value FROM string_split(@VehicleOwnerId,','))) ))  
 ORDER BY VR.VehicleRentDate ASC  
END  

GO
USE [master]
GO
ALTER DATABASE [ConstructionApp_Demo] SET  READ_WRITE 
GO
