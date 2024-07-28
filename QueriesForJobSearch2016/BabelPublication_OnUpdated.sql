
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[BabelPublication_OnUpdated]
   On [dbo].[BabelPublication]
   AFTER Update
AS 
BEGIN

	SET NOCOUNT ON;

	Update BabelPublication Set PostUpdateDate = GetDate() Where PublicationId=(Select PublicationId from Inserted)

END
