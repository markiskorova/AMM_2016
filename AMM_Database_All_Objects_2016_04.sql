USE [AMM]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString] 
( 
    @string NVARCHAR(255), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(255) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString2]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString2]
(
	@string NVARCHAR(255)
) 
RETURNS @output TABLE(SplitText NVARCHAR(255) 
) 
BEGIN 
	
	Declare @delimiter CHAR(1) = ' '

    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (SplitText)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END
GO
/****** Object:  Table [dbo].[AmmNewTerms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmNewTerms](
	[TermId] [int] IDENTITY(1000001,1) NOT NULL,
	[WordText] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_AmmNewTerms] PRIMARY KEY CLUSTERED 
(
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmAllTerms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmAllTerms](
	[TermId] [int] NOT NULL,
	[TermType] [varchar](1) NOT NULL,
	[SynsetID] [int] NOT NULL,
	[WordText] [nvarchar](255) NOT NULL,
	[POC] [nchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AmmAllTermsUnion]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AmmAllTermsUnion]
AS
Select TermId, TermType, WordText
FROM AmmAllTerms

Union

Select TermId, 'S' As TermType, WordText
From AmmNewTerms





GO
/****** Object:  Table [dbo].[AmmNewProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmNewProper](
	[ProperId] [bigint] IDENTITY(80000001,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmAllProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmAllProper](
	[ProperId] [bigint] IDENTITY(10000001,1) NOT NULL,
	[page_id] [bigint] NOT NULL,
	[article_id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_AmmAllProper] PRIMARY KEY CLUSTERED 
(
	[ProperId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AmmAllProperUnion]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AmmAllProperUnion]
AS
SELECT        ProperId, title
FROM            AmmAllProper
UNION
SELECT        ProperId, title
FROM            AmmNewProper
GO
/****** Object:  View [dbo].[AmmAllTermsMaxId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AmmAllTermsMaxId]
AS
SELECT        MAX(TermId) AS TermId, WordText
FROM            dbo.AmmAllTerms
GROUP BY WordText
GO
/****** Object:  Table [dbo].[AMM_Asso]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Asso](
	[AssoId] [bigint] IDENTITY(1000000001,1) NOT NULL,
 CONSTRAINT [PK_AMM_Asso] PRIMARY KEY CLUSTERED 
(
	[AssoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Node]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Node](
	[NodeId] [bigint] IDENTITY(10100001,1) NOT NULL,
 CONSTRAINT [PK_AMM_Node] PRIMARY KEY CLUSTERED 
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_NodeToAsso]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_NodeToAsso](
	[NodeId] [bigint] NOT NULL,
	[AssoId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_WeightType]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_WeightType](
	[WeightTypeId] [smallint] IDENTITY(101,1) NOT NULL,
	[WeightPerc] [smallint] NOT NULL,
	[Description] [varchar](30) NOT NULL,
 CONSTRAINT [PK_AMM_WeightType] PRIMARY KEY CLUSTERED 
(
	[WeightTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[JoinedNodeTerms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JoinedNodeTerms]
AS
SELECT        dbo.AMM_Node.NodeId AS NodeId_1, dbo.AmmAllTerms.TermId AS TermId_1, dbo.AmmAllTerms.WordText AS WordText_1, 
                         dbo.AmmAllTerms.TermType AS TermType_1, AMM_Node_1.NodeId AS NodeId_2, AmmAllTerms_1.TermId AS TermId_2, AmmAllTerms_1.TermType AS TermType_2, 
                         AmmAllTerms_1.WordText AS WordText_2, dbo.AMM_Asso.AssoId, dbo.AMM_AssoToWeight.WeightTypeId, dbo.AMM_WeightType.WeightPerc
FROM            dbo.AMM_Node INNER JOIN
                         dbo.AmmAllTerms ON dbo.AMM_Node.TermId = dbo.AmmAllTerms.TermId INNER JOIN
                         dbo.AMM_NodeToAsso ON dbo.AMM_Node.NodeId = dbo.AMM_NodeToAsso.NodeId INNER JOIN
                         dbo.AMM_Asso ON dbo.AMM_NodeToAsso.AssoId = dbo.AMM_Asso.AssoId INNER JOIN
                         dbo.AMM_WeightType INNER JOIN
                         dbo.AMM_AssoToWeight ON dbo.AMM_WeightType.WeightTypeId = dbo.AMM_AssoToWeight.WeightTypeId ON 
                         dbo.AMM_Asso.AssoId = dbo.AMM_AssoToWeight.AssoId INNER JOIN
                         dbo.AMM_NodeToAsso AS AMM_NodeToAsso_1 ON dbo.AMM_Asso.AssoId = AMM_NodeToAsso_1.AssoId INNER JOIN
                         dbo.AMM_Node AS AMM_Node_1 ON AMM_NodeToAsso_1.NodeId = AMM_Node_1.NodeId INNER JOIN
                         dbo.AmmAllTerms AS AmmAllTerms_1 ON AMM_Node_1.TermId = AmmAllTerms_1.TermId
GO
/****** Object:  View [dbo].[NodesToTerms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NodesToTerms]
AS
SELECT        dbo.AMM_Node.NodeId, dbo.AMM_Node.NodeTypeId, dbo.AmmAllTerms.TermId, dbo.AmmAllTerms.TermType, dbo.AmmAllTerms.SynsetID, 
                         dbo.AmmAllTerms.WordText, dbo.AmmAllTerms.POC
FROM            dbo.AMM_Node RIGHT OUTER JOIN
                         dbo.AmmAllTerms ON dbo.AMM_Node.TermId = dbo.AmmAllTerms.TermId
GO
/****** Object:  Table [dbo].[AMM_Association]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Association](
	[NodeId] [bigint] NOT NULL,
	[AssoId] [bigint] NOT NULL,
	[Weight] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_AssoToInput]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_AssoToInput](
	[AssoId] [bigint] NOT NULL,
	[InputId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Input]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Input](
	[InputId] [bigint] IDENTITY(10000001,1) NOT NULL,
	[DateStamp] [datetime] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[TitlePrimary] [nvarchar](255) NOT NULL,
	[ThemePrimary] [nvarchar](255) NOT NULL,
	[SubTitle] [nvarchar](255) NOT NULL,
	[Section] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_AMM_Input] PRIMARY KEY CLUSTERED 
(
	[InputId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_InputSource]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_InputSource](
	[InputId] [bigint] NOT NULL,
	[SourceUrl] [varchar](1000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_InputToKeyterms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_InputToKeyterms](
	[InputId] [bigint] NOT NULL,
	[TermId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_InputToProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_InputToProper](
	[InputId] [bigint] NOT NULL,
	[ProperId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_InputToWork]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_InputToWork](
	[InputId] [bigint] NOT NULL,
	[WorkId] [bigint] NOT NULL,
	[IsPrimary] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Instance]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Instance](
	[InstanceId] [bigint] IDENTITY(1000001,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_NodeToProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_NodeToProper](
	[NodeId] [bigint] NOT NULL,
	[ProperId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_NodeToTerm]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_NodeToTerm](
	[NodeId] [bigint] NOT NULL,
	[TermId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_NodeType]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_NodeType](
	[NodeTypeId] [smallint] IDENTITY(1,1) NOT NULL,
	[NodeCode] [char](1) NOT NULL,
	[NodeType] [varchar](10) NOT NULL,
	[NodeSubType] [varchar](10) NULL,
 CONSTRAINT [PK_NodeType] PRIMARY KEY CLUSTERED 
(
	[NodeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProcessInputTerm]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProcessInputTerm](
	[ProcessId] [bigint] IDENTITY(100001,1) NOT NULL,
	[InputId] [bigint] NOT NULL,
	[ParaIndex] [int] NOT NULL,
	[SentenceIndex] [int] NOT NULL,
	[ClusterIndex] [int] NOT NULL,
	[KeyValue] [int] NOT NULL,
	[WordText] [varchar](255) NOT NULL,
	[TermId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[TermWeight] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProcessProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProcessProper](
	[InputId] [bigint] NOT NULL,
	[ProperId] [bigint] NOT NULL,
	[TotalWords] [smallint] NOT NULL,
	[TotalWeight] [int] NOT NULL,
	[CountedWords] [smallint] NOT NULL,
	[CountedWeightDistinct] [int] NOT NULL,
	[CountedWeightSum] [int] NOT NULL,
	[KeyValue] [int] NOT NULL,
	[ToAssociate] [bit] NULL,
	[NodeId] [bigint] NOT NULL,
	[Title] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProcessProperFullMatch]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProcessProperFullMatch](
	[InputId] [bigint] NOT NULL,
	[ProperId] [bigint] NOT NULL,
	[title] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Proper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Proper](
	[ProperId] [bigint] IDENTITY(100000001,1) NOT NULL,
	[WordText] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Proper_Snap_Weight]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Proper_Snap_Weight](
	[ProperId] [bigint] NOT NULL,
	[TotalWords] [smallint] NOT NULL,
	[TotalWeight] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProperToRelated]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProperToRelated](
	[ProperId] [bigint] NOT NULL,
	[ProperRelatedId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProperToRoot]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProperToRoot](
	[ProperId] [bigint] NOT NULL,
	[ProperRootId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProperToWord]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProperToWord](
	[ProperId] [bigint] NULL,
	[WordText] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_ProperToWord_Snap_Count]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_ProperToWord_Snap_Count](
	[TermId] [int] NOT NULL,
	[WordText] [nvarchar](255) NOT NULL,
	[WordCount] [int] NOT NULL,
	[Weight] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Term]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Term](
	[TermId] [int] IDENTITY(1000001,1) NOT NULL,
	[RootId] [bigint] NOT NULL,
	[Term] [varchar](100) NOT NULL,
 CONSTRAINT [PK_AMM_Term] PRIMARY KEY CLUSTERED 
(
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_TermToProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_TermToProper](
	[TermId] [int] NOT NULL,
	[ProperId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_Work]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_Work](
	[WorkId] [bigint] IDENTITY(100000001,1) NOT NULL,
	[RootWorkId] [bigint] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_AMM_Work] PRIMARY KEY CLUSTERED 
(
	[WorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AMM_WorkToProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMM_WorkToProper](
	[WorkId] [bigint] NOT NULL,
	[page_id] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmImport_Collection]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmImport_Collection](
	[CollectionId] [bigint] IDENTITY(100001,1) NOT NULL,
	[CollectionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AmmImport_Collection] PRIMARY KEY CLUSTERED 
(
	[CollectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmImport_Item]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmImport_Item](
	[ItemId] [bigint] IDENTITY(1000001,1) NOT NULL,
	[CollectionId] [bigint] NOT NULL,
	[ImportDate] [smalldatetime] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[TitlePrimary] [nvarchar](255) NOT NULL,
	[ThemePrimary] [nvarchar](255) NOT NULL,
	[SubTitle] [nvarchar](255) NOT NULL,
	[Section] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NOT NULL,
	[Keywords] [nvarchar](255) NOT NULL,
	[Bodytext] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmImport_Item2]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmImport_Item2](
	[ItemId] [bigint] NOT NULL,
	[CollectionId] [bigint] NOT NULL,
	[ImportDate] [smalldatetime] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[TitleAlt] [nvarchar](255) NOT NULL,
	[SubTitle] [nvarchar](255) NOT NULL,
	[Section] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NOT NULL,
	[Keywords] [nvarchar](255) NOT NULL,
	[Bodytext] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmmProperLookup]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmmProperLookup](
	[ProperId] [bigint] NOT NULL,
	[WordText] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Math_ProperWeightCalcRange]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Math_ProperWeightCalcRange](
	[Amin] [int] NOT NULL,
	[Amax] [int] NOT NULL,
	[B] [int] NOT NULL,
	[x] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AMM_Association] ADD  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT (getdate()) FOR [DateStamp]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT ('') FOR [TitlePrimary]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT ('') FOR [ThemePrimary]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT ('') FOR [SubTitle]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT ('') FOR [Section]
GO
ALTER TABLE [dbo].[AMM_Input] ADD  DEFAULT ('') FOR [Author]
GO
ALTER TABLE [dbo].[AMM_InputSource] ADD  CONSTRAINT [DF_AMM_InputSource_SourceUrl]  DEFAULT ('') FOR [SourceUrl]
GO
ALTER TABLE [dbo].[AMM_InputToWork] ADD  CONSTRAINT [DF_AMM_InputToWork_IsPrimary]  DEFAULT ((0)) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[AMM_NodeToAsso] ADD  CONSTRAINT [DF_AMM_NodeToAsso_NodeId]  DEFAULT ((0)) FOR [NodeId]
GO
ALTER TABLE [dbo].[AMM_NodeToProper] ADD  CONSTRAINT [DF_AMM_NodeToProper_NodeId]  DEFAULT ((0)) FOR [NodeId]
GO
ALTER TABLE [dbo].[AMM_NodeToTerm] ADD  CONSTRAINT [DF_AMM_NodeToTerm_NodeId]  DEFAULT ((0)) FOR [NodeId]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_InputId]  DEFAULT ((0)) FOR [InputId]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_ParaIndex]  DEFAULT ((-1)) FOR [ParaIndex]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_SentenceIndex]  DEFAULT ((-1)) FOR [SentenceIndex]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_ClusterIndex]  DEFAULT ((-1)) FOR [ClusterIndex]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  DEFAULT ((0)) FOR [KeyValue]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_TermId]  DEFAULT ((0)) FOR [TermId]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_NodeId]  DEFAULT ((0)) FOR [NodeId]
GO
ALTER TABLE [dbo].[AMM_ProcessInputTerm] ADD  CONSTRAINT [DF_AMM_ProcessInputTerm_TermWeight]  DEFAULT ((0)) FOR [TermWeight]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_TotalWords]  DEFAULT ((0)) FOR [TotalWords]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_TotalWeight]  DEFAULT ((0)) FOR [TotalWeight]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_CountedWords]  DEFAULT ((0)) FOR [CountedWords]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_CountedWeightDistinct]  DEFAULT ((0)) FOR [CountedWeightDistinct]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_CountedWeightSum]  DEFAULT ((0)) FOR [CountedWeightSum]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  DEFAULT ((0)) FOR [KeyValue]
GO
ALTER TABLE [dbo].[AMM_ProcessProper] ADD  CONSTRAINT [DF_AMM_ProcessProper_NodeId]  DEFAULT ((0)) FOR [NodeId]
GO
ALTER TABLE [dbo].[AMM_ProperToWord_Snap_Count] ADD  CONSTRAINT [DF_AMM_ProperToWord_Snap_Count_TermId]  DEFAULT ((0)) FOR [TermId]
GO
ALTER TABLE [dbo].[AMM_ProperToWord_Snap_Count] ADD  CONSTRAINT [DF_AMM_ProperToWord_Snap_Count_WordCount]  DEFAULT ((0)) FOR [WordCount]
GO
ALTER TABLE [dbo].[AMM_ProperToWord_Snap_Count] ADD  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[AMM_Term] ADD  CONSTRAINT [DF_AMM_Term_RootTermId]  DEFAULT ((0)) FOR [RootId]
GO
ALTER TABLE [dbo].[AMM_Term] ADD  CONSTRAINT [DF_AMM_Term_Term]  DEFAULT ('') FOR [Term]
GO
ALTER TABLE [dbo].[AMM_WeightType] ADD  CONSTRAINT [DF_AMM_WeightType_WeightPerc]  DEFAULT ((100)) FOR [WeightPerc]
GO
ALTER TABLE [dbo].[AMM_Work] ADD  CONSTRAINT [DF_AMM_Work_ParentWorkId]  DEFAULT ((0)) FOR [RootWorkId]
GO
ALTER TABLE [dbo].[AMM_Work] ADD  CONSTRAINT [DF_AMM_Work_Author]  DEFAULT ('') FOR [Author]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  DEFAULT ((0)) FOR [CollectionId]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_TitleAlt]  DEFAULT ('') FOR [TitlePrimary]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  DEFAULT ('') FOR [ThemePrimary]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_SubTitle]  DEFAULT ('') FOR [SubTitle]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_Section]  DEFAULT ('') FOR [Section]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_Author]  DEFAULT ('') FOR [Author]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_Keywords]  DEFAULT ('') FOR [Keywords]
GO
ALTER TABLE [dbo].[AmmImport_Item] ADD  CONSTRAINT [DF_AmmImport_Item_Bodytext]  DEFAULT ('') FOR [Bodytext]
GO
/****** Object:  StoredProcedure [dbo].[AssociateInput]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[AssociateInput]
	@AssoId bigint,
	@InputId bigint
AS
BEGIN

SET NOCOUNT ON;


Insert Into AMM_AssoToInput
	(AssoId, InputId)
Values
	( @AssoId, @InputId)

END


GO
/****** Object:  StoredProcedure [dbo].[AssociateNode]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AssociateNode]
	@AssoId bigint,
	@NodeId bigint,
	@WeightTypeId smallint
AS
BEGIN

SET NOCOUNT ON;


Insert Into AMM_Association
	(NodeId, AssoId, WeightTypeId)
Values
	(@NodeId, @AssoId, @WeightTypeId)

END

GO
/****** Object:  StoredProcedure [dbo].[AssociationJoinNodes]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AssociationJoinNodes]
	@NodeId1 bigint,
	@NodeId2 bigint,
	@WeightTypeId smallint
AS
BEGIN

SET NOCOUNT ON;

Declare @AssoId bigint

Insert Into Amm_Asso Default Values

Select @AssoId=@@IDENTITY

Insert Into AMM_AssoToWeight
	(AssoId, WeightTypeId)
Values
	(@AssoId, @WeightTypeId)

Insert Into AMM_NodeToAsso
	(NodeId, AssoId)
Values
	(@NodeId1, @AssoId)

Insert Into AMM_NodeToAsso
	(NodeId, AssoId)
Values
	(@NodeId2, @AssoId)


END
GO
/****** Object:  StoredProcedure [dbo].[GetImportItemById]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetImportItemById]
	@ItemId bigint
AS
BEGIN

SET NOCOUNT ON;


SELECT        ItemId, CollectionId, ImportDate, Title, TitlePrimary, ThemePrimary, SubTitle, Section, Author, Keywords, Bodytext
FROM            AmmImport_Item

Where ItemId=@ItemId


END

GO
/****** Object:  StoredProcedure [dbo].[GetImportItemsByCollectionId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetImportItemsByCollectionId]
	@CollectionId bigint
AS
BEGIN

SET NOCOUNT ON;


SELECT        ItemId, ImportDate, Title, TitlePrimary, ThemePrimary, SubTitle, Section, Author, Keywords
FROM            AmmImport_Item


Where CollectionId=@CollectionId


END



--Cast((Case When ImportDate Is Null Then 0 Else 1 End) As Bit) As IsImported
--(Case ImportDate When Null Then 0 Else 1 End)
GO
/****** Object:  StoredProcedure [dbo].[GetOrSetNodeIdFromAssoId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[GetOrSetNodeIdFromAssoId]
	@AssoId bigint
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Select @NodeId=NodeId From AMM_NodeToAsso Where AssoId=@AssoId

if @NodeId Is Null
Begin
	Insert Into AMM_Node Default Values
	Select @NodeId = @@IDENTITY

	Insert Into AMM_NodeToAsso
		(NodeId, AssoId)
	Values
		(@NodeId, @AssoId)
End

Select @AssoId As AssoId, @NodeId As NodeId

END

GO
/****** Object:  StoredProcedure [dbo].[GetOrSetNodeIdFromProperId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetOrSetNodeIdFromProperId]
	@ProperId bigint
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Select @NodeId=NodeId From AMM_NodeToProper Where ProperId=@ProperId

if @NodeId Is Null
Begin
	Insert Into AMM_Node Default Values
	Select @NodeId = @@IDENTITY

	Insert Into AMM_NodeToProper
		(NodeId, ProperId)
	Values
		(@NodeId, @ProperId)
End

Select @ProperId As ProperId, @NodeId As NodeId

END

GO
/****** Object:  StoredProcedure [dbo].[GetOrSetNodeIdFromTermId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetOrSetNodeIdFromTermId]
	@TermId int
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Select @NodeId=NodeId From AMM_NodeToTerm Where TermId=@TermId

if @NodeId Is Null
Begin
	Insert Into AMM_Node Default Values
	Select @NodeId = @@IDENTITY

	Insert Into AMM_NodeToTerm
		(NodeId, TermId)
	Values
		(@NodeId, @TermId)
End

Select @TermId As TermId, @NodeId As NodeId

END

GO
/****** Object:  StoredProcedure [dbo].[GetProperFromText]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetProperFromText]
	@Text nvarchar(255)
AS
BEGIN

SET NOCOUNT ON;

SELECT    Top 20     Min(ProperId), title As ProperText
FROM            AmmAllProper
Where 
	title like '%' + @Text + '%'
	and title not like '%(%'
Group by title
Order by Min(page_id)


END

GO
/****** Object:  StoredProcedure [dbo].[GetTermByID]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetTermByID]
	@TermId int
AS
BEGIN

SET NOCOUNT ON;


SELECT    Top 1    TermId, TermType, WordText
FROM            AmmAllTermsUnion
Where TermId=@TermId



END
GO
/****** Object:  StoredProcedure [dbo].[GetTermByText]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetTermByText]
	@WordText varchar(255)
AS
BEGIN

SET NOCOUNT ON;


SELECT    Top 1    TermId, TermType, WordText
FROM            AmmAllTermsUnion
Where WordText=@WordText
Order by TermId


END
GO
/****** Object:  StoredProcedure [dbo].[GetTinyTerms]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetTinyTerms]
AS
BEGIN

SET NOCOUNT ON;

SELECT        WordText
FROM            AmmAllTermsUnion
Where TermType='t'

END

GO
/****** Object:  StoredProcedure [dbo].[GetWorksFromInputId]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetWorksFromInputId]
	@InputId bigint
AS
BEGIN

SET NOCOUNT ON;

SELECT        AMM_InputToWork.WorkId, AMM_Work.RootWorkId, AMM_InputToWork.IsPrimary
FROM            AMM_InputToWork INNER JOIN
                         AMM_Work ON AMM_InputToWork.WorkId = AMM_Work.WorkId
Where InputId=@InputId


END
GO
/****** Object:  StoredProcedure [dbo].[InsertAssociation]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertAssociation]
AS
BEGIN

SET NOCOUNT ON;

Declare @AssoId bigint

Insert Into Amm_Asso Default Values

Select @AssoId=@@IDENTITY

Select @AssoId As AssoId

END

GO
/****** Object:  StoredProcedure [dbo].[InsertInput]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertInput]
	@Title nvarchar(255),
	@TitlePrimary nvarchar(255),
	@ThemePrimary nvarchar(255),
	@SubTitle nvarchar(255),
	@Section nvarchar(255),
	@Author nvarchar(255)
AS
BEGIN

SET NOCOUNT ON;

Declare @InputId bigint


Insert Into AMM_Input
	(Title, TitlePrimary, ThemePrimary, SubTitle, Section, Author)
Values
	(@Title, @TitlePrimary, @ThemePrimary, @SubTitle, @Section, @Author)

Select @InputId = @@IDENTITY

Select @InputId As InputId

END
GO
/****** Object:  StoredProcedure [dbo].[InsertNodeToAsso]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[InsertNodeToAsso]
	@AssoId bigint
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Insert Into AMM_Node Default Values
Select @NodeId = @@IDENTITY

Insert Into AMM_NodeToAsso (NodeId, AssoId)
Values (@NodeId, @AssoId)

END

GO
/****** Object:  StoredProcedure [dbo].[InsertNodeToProper]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[InsertNodeToProper]
	@ProperId bigint
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Insert Into AMM_Node Default Values
Select @NodeId = @@IDENTITY

Insert Into AMM_NodeToProper (NodeId, ProperId)
Values (@NodeId, @ProperId)

END

GO
/****** Object:  StoredProcedure [dbo].[InsertNodeToTerm]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[InsertNodeToTerm]
	@TermId int
AS
BEGIN

SET NOCOUNT ON;

Declare @NodeId bigint

Insert Into AMM_Node Default Values
Select @NodeId = @@IDENTITY

Insert Into AMM_NodeToTerm (NodeId, TermId)
Values (@NodeId, @TermId)

END

GO
/****** Object:  StoredProcedure [dbo].[ProcessPropers]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ProcessPropers]
	@InputId bigint
AS
BEGIN

SET NOCOUNT ON;



--Insert Terms
Insert Into AMM_ProcessProper (ProperId, TotalWords, TotalWeight, KeyValue, InputId)
SELECT Distinct AMM_ProperToWord.ProperId, AMM_Proper_Snap_Weight.TotalWords, AMM_Proper_Snap_Weight.TotalWeight, AMM_ProcessInputTerm.KeyValue, @InputId
FROM            AMM_ProperToWord INNER JOIN
                         AMM_ProcessInputTerm ON AMM_ProperToWord.WordText = AMM_ProcessInputTerm.WordText AND AMM_ProcessInputTerm.KeyValue=0
						INNER JOIN
                         AMM_Proper_Snap_Weight ON AMM_ProperToWord.ProperId = AMM_Proper_Snap_Weight.ProperId
Where AMM_ProcessInputTerm.TermWeight >= 400
And AMM_ProcessInputTerm.TermId Not Between 990000 And 999999		--Cheap way to filter tiny terms for now


--Insert Key Terms
Insert Into AMM_ProcessProper (ProperId, Title, InputId, KeyValue, ToAssociate)
SELECT   0, AMM_ProcessInputTerm.WordText, @InputId, AMM_ProcessInputTerm.KeyValue, 1
FROM	AMM_ProcessInputTerm 						
Where InputId=@InputId
And AMM_ProcessInputTerm.KeyValue>0

--Link Keyterms to Proper 
Update AMM_ProcessProper Set AMM_ProcessProper.ProperId=AmmAllProperUnion.ProperId
FROM            AMM_ProcessProper INNER JOIN
                         AmmAllProperUnion ON AMM_ProcessProper.Title=AmmAllProperUnion.title
Where AMM_ProcessProper.InputId=@InputId

--Insert into Propers terms not found where value is>2 (input header info: title, author, etc...)
Insert Into AmmNewProper (title)
Select Title From AMM_ProcessProper Where ProperId=0 And KeyValue>2 And InputId=@InputId

--Remove keyterms with value >= 2 and no proper association
--Delete From AMM_ProcessProper Where ProperId<=2 And InputId=@InputId

--Link Keyterms to Proper (including inserted)
Update AMM_ProcessProper Set AMM_ProcessProper.ProperId=AmmAllProperUnion.ProperId
FROM            AMM_ProcessProper INNER JOIN
                         AmmAllProperUnion ON AMM_ProcessProper.Title=AmmAllProperUnion.title
Where AMM_ProcessProper.InputId=@InputId

Update AMM_ProcessProper Set AMM_ProcessProper.Title=AmmAllProperUnion.title
FROM            AMM_ProcessProper INNER JOIN
                         AmmAllProperUnion ON AMM_ProcessProper.ProperId = AmmAllProperUnion.ProperId
Where AMM_ProcessProper.InputId=@InputId




Update AMM_ProcessProper Set AMM_ProcessProper.TotalWords=AMM_Proper_Snap_Weight.TotalWords, AMM_ProcessProper.TotalWeight=AMM_Proper_Snap_Weight.TotalWeight
FROM            AMM_ProcessProper INNER JOIN
                         AMM_Proper_Snap_Weight ON AMM_ProcessProper.ProperId = AMM_Proper_Snap_Weight.ProperId
Where InputId=@InputId
And KeyValue>0

Update AMM_ProcessProper Set TotalWords = (LEN(Title)-LEN(REPLACE(Title,' ',''))+1)
Where InputId=@InputId
And KeyValue>0

Update AMM_ProcessProper Set CountedWords=TotalWords
Where InputId=@InputId
And KeyValue>0



Update AMM_ProcessProper Set CountedWords=TermCount From (Select Count(Distinct TermId) As TermCount, AMM_ProperToWord.ProperId
FROM            AMM_ProperToWord 
					INNER JOIN
						AMM_ProcessProper 
							ON AMM_ProperToWord.ProperId = AMM_ProcessProper.ProperId
					INNER JOIN
                         (Select Distinct WordText, TermId From AMM_ProcessInputTerm) As DInputTerm 
							ON AMM_ProperToWord.WordText = DInputTerm.WordText 
Group By AMM_ProperToWord.ProperId) As SP
					INNER JOIN
						AMM_ProcessProper 
							ON SP.ProperId = AMM_ProcessProper.ProperId
Where AMM_ProcessProper.InputId=@InputId
	And KeyValue=0



Update AMM_ProcessProper Set CountedWords=TotalWords
Where InputId=@InputId
And KeyValue>0



Update AMM_ProcessProper Set CountedWeightDistinct=SumWeight From (Select Sum(Distinct TermWeight) As SumWeight, AMM_ProperToWord.ProperId
FROM            AMM_ProperToWord 
					INNER JOIN
						AMM_ProcessProper 
							ON AMM_ProperToWord.ProperId = AMM_ProcessProper.ProperId
					INNER JOIN
                         (Select Distinct WordText, TermWeight From AMM_ProcessInputTerm) As DInputTerm 
							ON AMM_ProperToWord.WordText = DInputTerm.WordText 
Group By AMM_ProperToWord.ProperId) As SP
					INNER JOIN
						AMM_ProcessProper 
							ON SP.ProperId = AMM_ProcessProper.ProperId
Where AMM_ProcessProper.InputId=@InputId


Update AMM_ProcessProper Set TotalWeight=1000*TotalWords
Where InputId=@InputId
And TotalWeight=0
And KeyValue>0




Update AMM_ProcessProper Set CountedWeightDistinct=TotalWeight
Where InputId=@InputId
And KeyValue>0
And CountedWeightDistinct<TotalWeight




Update AMM_ProcessProper Set CountedWeightSum=SumWeight From (Select Sum(TermWeight) As SumWeight, AMM_ProperToWord.ProperId
FROM            AMM_ProperToWord 
					INNER JOIN
						AMM_ProcessProper 
							ON AMM_ProperToWord.ProperId = AMM_ProcessProper.ProperId
					INNER JOIN
                         (Select WordText, TermWeight From AMM_ProcessInputTerm) As DInputTerm 
							ON AMM_ProperToWord.WordText = DInputTerm.WordText 
Group By AMM_ProperToWord.ProperId) As SP
					INNER JOIN
						AMM_ProcessProper 
							ON SP.ProperId = AMM_ProcessProper.ProperId
Where AMM_ProcessProper.InputId=@InputId


Update AMM_ProcessProper Set CountedWeightSum=CountedWeightDistinct
Where InputId=@InputId
And KeyValue>0
And CountedWeightSum=0



Update AMM_ProcessProper Set CountedWeightSum=CountedWeightSum*(KeyValue+1)
Where InputId=@InputId




Update AMM_ProcessProper Set ToAssociate=1
FROM            AMM_ProcessProper
Where AMM_ProcessProper.InputId=@InputId
And (
	(TotalWords=1 And CountedWords=1 And TotalWeight>1000 And CountedWeightSum>2000)
  Or
	(TotalWords=2 And CountedWords>=1 And TotalWeight>800 And CountedWeightDistinct>800 And CountedWeightSum>TotalWeight*7)
		Or
	(TotalWords=2 And TotalWeight>1000 And CountedWeightDistinct>1000 And CountedWeightSum>TotalWeight*4)
  Or
	(TotalWords>=3
	And (
			(TotalWeight>800 And CountedWeightDistinct>(400*(TotalWords-1)))
			And ((CountedWeightDistinct/CountedWords) > 800)
		)
	 And (CountedWeightDistinct>TotalWeight/2 And CountedWeightSum>TotalWeight*2))
	 )

Update AMM_ProcessProper Set ToAssociate=1 Where InputId=@InputId And KeyValue>0


Delete From AMM_ProcessProper Where CountedWeightSum=0 Or CountedWeightDistinct<333
Delete From AMM_ProcessProper Where IsNull(ToAssociate, 0)=0


END

GO
/****** Object:  StoredProcedure [dbo].[ProcessPropersAssociate]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ProcessPropersAssociate]
	@InputId bigint
AS
BEGIN



--Associate Proper Terms from Input Text

--Find Nodes
Update        AMM_ProcessProper Set AMM_ProcessProper.NodeId=AMM_NodeToProper.NodeId
FROM            AMM_ProcessProper INNER JOIN
                         AMM_NodeToProper ON AMM_NodeToProper.ProperId=AMM_ProcessProper.ProperId
Where InputId=@InputId


--Insert Nodes where there are none
Declare @ProperId int
Declare @NodeId bigint

DECLARE dcursor CURSOR FOR  
Select ProperId From AMM_ProcessProper Where InputId=@InputId And NodeId=0

OPEN dcursor
FETCH NEXT FROM dcursor INTO @ProperId

WHILE @@FETCH_STATUS = 0
BEGIN   
	
	Insert Into AMM_Node Default Values
	Select @NodeId = @@IDENTITY

	Insert Into AMM_NodeToProper (NodeId, ProperId)
	Values (@NodeId, @ProperId)
	
	FETCH NEXT FROM dcursor INTO @ProperId
END

Deallocate dcursor

--Find new Nodes
Update        AMM_ProcessProper Set AMM_ProcessProper.NodeId=AMM_NodeToProper.NodeId
FROM            AMM_ProcessProper INNER JOIN
                         AMM_NodeToProper ON AMM_NodeToProper.ProperId=AMM_ProcessProper.ProperId
Where InputId=@InputId


--Associate Nodes by Proper
Declare @AssoId bigint

Insert Into Amm_Asso Default Values
Select @AssoId=@@IDENTITY

Insert Into AMM_Association
	(NodeId, AssoId, [Weight])
	Select NodeId, @AssoId, Cast((TotalWeight+1)*Cast(CountedWeightSum As Float)/Cast(CountedWeightDistinct As float)/10 As Int) From AMM_ProcessProper Where InputId=@InputId

--Cast(1500*(1-(Cast(TotalWeight As float)/Cast(CountedWeightSum As Float))) As Int)

END
GO
/****** Object:  StoredProcedure [dbo].[ProcessPropersRemove]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ProcessPropersRemove]
	@InputId bigint
AS
BEGIN


Delete From AMM_ProcessProper Where InputId=@InputId


END


GO
/****** Object:  StoredProcedure [dbo].[ProcessTermByInput]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProcessTermByInput] 
	@InputId bigint,
	@ParaIndex int
AS
BEGIN

SET NOCOUNT ON;

END
GO
/****** Object:  StoredProcedure [dbo].[ProcessTermsList]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ProcessTermsList]
	@InputId bigint
AS
BEGIN

SET NOCOUNT ON;


--Get Weight from Snap Count
Update        AMM_ProcessInputTerm Set TermWeight=AMM_ProperToWord_Snap_Count.[Weight]
FROM            AMM_ProperToWord_Snap_Count INNER JOIN
                         AMM_ProcessInputTerm ON AMM_ProperToWord_Snap_Count.WordText = AMM_ProcessInputTerm.WordText
Where AMM_ProcessInputTerm.InputId=@InputId --And KeyValue=0



--Get max TermId from AmmAllTerms
Update        AMM_ProcessInputTerm Set TermID=AmmAllTermsMaxId.TermId
FROM            AMM_ProcessInputTerm INNER JOIN
                         AmmAllTermsMaxId ON AMM_ProcessInputTerm.WordText = AmmAllTermsMaxId.WordText
Where AMM_ProcessInputTerm.InputId=@InputId --And KeyValue=0

--Look for Variations
Update        AMM_ProcessInputTerm Set TermID=AmmAllTermsMaxId.TermId
FROM            AmmAllTermsMaxId INNER JOIN AMM_ProcessInputTerm 
					ON 
		(AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'s'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'''s'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+''''
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'es'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'ed'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'ing'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'ly'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'d'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'n''t'
	Or	AMM_ProcessInputTerm.WordText=AmmAllTermsMaxId.WordText+'''nt')
Where AMM_ProcessInputTerm.InputId=@InputId
	--And AmmAllTermsMaxId.TermType='S'
	And AMM_ProcessInputTerm.TermId=0 
	--And KeyValue=0


--Get TermID from AmmNewTerms where not found in AmmAllTerms
Update        AMM_ProcessInputTerm Set TermID=AmmNewTerms.TermId
FROM            AMM_ProcessInputTerm INNER JOIN
                         AmmNewTerms ON AMM_ProcessInputTerm.WordText = AmmNewTerms.WordText
Where AMM_ProcessInputTerm.InputId=@InputId
	And AMM_ProcessInputTerm.TermID=0 --And KeyValue=0

--Insert new terms into AmmNewTerms
Insert Into AmmNewTerms (WordText)
	Select WordText From AMM_ProcessInputTerm 
	Where AMM_ProcessInputTerm.InputId=@InputId And TermId=0 And KeyValue=0

--Get TermID from newly added AmmNewTerms 
Update        AMM_ProcessInputTerm Set TermID=AmmNewTerms.TermId
FROM            AMM_ProcessInputTerm INNER JOIN
                         AmmNewTerms ON AMM_ProcessInputTerm.WordText = AmmNewTerms.WordText
Where AMM_ProcessInputTerm.InputId=@InputId
	And AMM_ProcessInputTerm.TermID=0 And KeyValue=0


--Add Value to Key Terms where no TermWeight was found
Update AMM_ProcessInputTerm Set TermWeight=100*KeyValue
Where InputId=@InputId
	And KeyValue>0
	And TermWeight=0


--Remove KeyTerms where len=1 or in tinyterms
Delete from AMM_ProcessInputTerm
Where InputId=@InputId
	And (
		KeyValue>0  
			And (
			(Len(WordText)=1) Or (TermId Between 990000 And 999999)
			)
		)









END
GO
/****** Object:  StoredProcedure [dbo].[ProcessTermsListAssociate]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ProcessTermsListAssociate]
	@InputId bigint
AS
BEGIN

--Associate Terms

--Find Nodes
Update        AMM_ProcessInputTerm Set AMM_ProcessInputTerm.NodeId=AMM_NodeToTerm.NodeId
FROM            AMM_NodeToTerm INNER JOIN
                         AMM_ProcessInputTerm ON AMM_NodeToTerm.TermId=AMM_ProcessInputTerm.TermId
Where InputId=@InputId


--Insert Nodes where there are none
Declare @TermId int
Declare @NodeId bigint

DECLARE dcursor CURSOR FOR  
Select TermId From AMM_ProcessInputTerm Where InputId=@InputId And NodeId=0

OPEN dcursor
FETCH NEXT FROM dcursor INTO @TermId

WHILE @@FETCH_STATUS = 0   
BEGIN   
	
	Insert Into AMM_Node Default Values
	Select @NodeId = @@IDENTITY

	Insert Into AMM_NodeToTerm (NodeId, TermId)
	Values (@NodeId, @TermId)
	
	FETCH NEXT FROM dcursor INTO @TermId
END   

Deallocate dcursor

--Find new Nodes
Update        AMM_ProcessInputTerm Set AMM_ProcessInputTerm.NodeId=AMM_NodeToTerm.NodeId
FROM            AMM_NodeToTerm INNER JOIN
                         AMM_ProcessInputTerm ON AMM_NodeToTerm.TermId=AMM_ProcessInputTerm.TermId
Where InputId=@InputId


--Associate Nodes by Text
Declare @AssoId bigint

Insert Into Amm_Asso Default Values
Select @AssoId=@@IDENTITY

Insert Into AMM_Association
	(NodeId, AssoId, [Weight])
	Select NodeId, @AssoId, 10 From AMM_ProcessInputTerm Where InputId=@InputId

Declare @ParaIndex int

--Associate Nodes by Paragraph
DECLARE pcursor CURSOR FOR  
Select distinct ParaIndex From AMM_ProcessInputTerm Where InputId=@InputId

OPEN pcursor
FETCH NEXT FROM pcursor INTO @ParaIndex

WHILE @@FETCH_STATUS = 0   
BEGIN   
	
Insert Into Amm_Asso Default Values
Select @AssoId=@@IDENTITY

Insert Into AMM_Association
	(NodeId, AssoId, [Weight])
	Select NodeId, @AssoId, 25 From AMM_ProcessInputTerm Where InputId=@InputId And ParaIndex=@ParaIndex
	
	FETCH NEXT FROM pcursor INTO @ParaIndex
END

Deallocate pcursor

  

END
GO
/****** Object:  StoredProcedure [dbo].[ProcessTermsListRemove]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ProcessTermsListRemove]
	@InputId bigint
AS
BEGIN


Delete From AMM_ProcessInputTerm Where InputId=@InputId


END


GO
/****** Object:  StoredProcedure [dbo].[SetWorksFromInput]    Script Date: 7/5/2024 1:45:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SetWorksFromInput]
	@InputId bigint,
	@Title Nvarchar(255),
	@SubTitle Nvarchar(255)
AS
BEGIN

SET NOCOUNT ON;

Declare @WorkId bigint
Declare @RootWorkId bigint
Declare @IsPrimary bit = 1

Select Top 1  @WorkId=WorkId from AMM_Work Where Title=@Title Order by WorkId

if @WorkId Is Null
Begin
	Insert Into AMM_Work (Title) Values (@Title)
	Select @WorkId = @@IDENTITY
	Insert Into AMM_InputToWork (InputId, WorkId, IsPrimary) Values (@WorkId, @InputId, 1)
	Insert Into AMM_Work (Title, RootWorkId) Values (@SubTitle, @WorkId)
	Select @RootWorkId = @@IDENTITY
End

Select @WorkId As WorkId, @RootWorkId As RootWorkId, @IsPrimary As IsPrimary



END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllProperUnion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllProperUnion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AmmAllTerms"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3135
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllTermsMaxId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllTermsMaxId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllTermsUnion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AmmAllTermsUnion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AMM_Node"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AmmAllTerms"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_NodeToAsso"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 101
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_Asso"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 84
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_WeightType"
            Begin Extent = 
               Top = 84
               Left = 662
               Bottom = 196
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_AssoToWeight"
            Begin Extent = 
               Top = 102
               Left = 454
               Bottom = 197
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_NodeToAsso_1"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 233
               Right = 208
            End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JoinedNodeTerms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AMM_Node_1"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 267
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AmmAllTerms_1"
            Begin Extent = 
               Top = 198
               Left = 454
               Bottom = 327
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JoinedNodeTerms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'JoinedNodeTerms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AMM_Node"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AmmAllTerms"
            Begin Extent = 
               Top = 72
               Left = 324
               Bottom = 201
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NodesToTerms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NodesToTerms'
GO
