
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[ProcessPropersAssociate]
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
--(A cursor has proven to be the fastest way to accomplish this, given the size of the Propers data tables)
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

--Find newly inserted Nodes
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


END
