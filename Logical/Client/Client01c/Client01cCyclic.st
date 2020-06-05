(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client01c
 * File: Client01cCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA_EngineeringUnit.UnitId := 0;
END_PROGRAM
      
PROGRAM _CYCLIC

	(* UA_Connect - establish connection to OPC-UA Server *)

	SessionConnectInfo_0.SecurityMsgMode := UASecurityMsgMode_None;
	SessionConnectInfo_0.SecurityPolicy := UASecurityPolicy_None;
	SessionConnectInfo_0.TransportProfile := UATP_UATcp;
	SessionConnectInfo_0.UserIdentityToken.UserIdentityTokenType := UAUITT_Username;
	SessionConnectInfo_0.UserIdentityToken.TokenParam1 := 'admin';
	SessionConnectInfo_0.UserIdentityToken.TokenParam2 := 'password';
	SessionConnectInfo_0.SessionTimeout := T#1m;
	SessionConnectInfo_0.MonitorConnection := T#10s;

	UA_Connect_0(Execute := ExecuteConnect_0,
		ServerEndpointUrl := 'opc.tcp://localhost:4841',
		SessionConnectInfo := SessionConnectInfo_0,
		Timeout := T#10s);
	IF (UA_Connect_0.Busy = 0) THEN
		ExecuteConnect_0 := 0;
		IF (UA_Connect_0.Done = 1) THEN
			ErrorID := 0;
			ConnectionHdl := UA_Connect_0.ConnectionHdl;
		END_IF
		IF (UA_Connect_0.Error = 1) THEN
			ErrorID := UA_Connect_0.ErrorID;
			ConnectionHdl := 0;
		END_IF
	END_IF

	(* UA_TranslatePath - get nodeid for required nodes *)

	StartNodeID_Root.NamespaceIndex := 0;
	StartNodeID_Root.Identifier := '84';
	StartNodeID_Root.IdentifierType := UAIdentifierType_Numeric;
	RelativePath := '/0:Objects/4:PLC/4:Modules/6:&:&:/6:ServerTask/6:VarX/0:EngineeringUnits';
	
	UA_TranslatePath_0(Execute := ExecuteTranslatePath_0,
		ConnectionHdl := ConnectionHdl,
		StartNodeID := StartNodeID_Root,
		RelativePath := RelativePath,
		Timeout := T#10s);
	IF (UA_TranslatePath_0.Busy = 0) THEN
		ExecuteTranslatePath_0 := 0;
		IF (UA_TranslatePath_0.Done = 1) THEN
			ErrorID := 0;
			TargetNodeID := UA_TranslatePath_0.TargetNodeID;
		END_IF
		IF (UA_TranslatePath_0.Error = 1) THEN
			ErrorID := UA_TranslatePath_0.ErrorID;
		END_IF
	END_IF

	(* UA_NodeGetHandle - get a handle for required node *)

	UA_NodeGetHandle_0(Execute := ExecuteNodeGetHandle_0,
		ConnectionHdl := ConnectionHdl,
		NodeID := TargetNodeID,
		Timeout := T#10s);
	IF (UA_NodeGetHandle_0.Busy = 0) THEN
		ExecuteNodeGetHandle_0 := 0;
		IF (UA_NodeGetHandle_0.Done = 1) THEN
			ErrorID := 0;
			NodeHdl := UA_NodeGetHandle_0.NodeHdl;
		END_IF
		IF (UA_NodeGetHandle_0.Error = 1) THEN
			ErrorID := UA_NodeGetHandle_0.ErrorID;
			NodeHdl := 0;
		END_IF
	END_IF
	
	(* UA_Read - read required node from OPC-UA Server and write it in local plc variable *)
	
	NodeAddInfo_0.AttributeId := UAAI_Value;
	NodeAddInfo_0.IndexRangeCount := 0;
	
	Variable_Rd0 := '::Client01c:VarA_EngineeringUnit';

	UA_Read_0(Execute := ExecuteRead_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdl := NodeHdl,
		NodeAddInfo := NodeAddInfo_0,
		Timeout := T#10s,
		Variable := Variable_Rd0);
	IF (UA_Read_0.Busy = 0) THEN
		ExecuteRead_0 := 0;
		IF (UA_Read_0.Done = 1) THEN
			ErrorID := 0;
			TimestampVarA:=UA_Read_0.TimeStamp;
		END_IF
		IF (UA_Read_0.Error = 1) THEN
			ErrorID := UA_Read_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_NodeReleaseHandle - release the handle for the node *)
	
    UA_NodeReleaseHandle_0(Execute := ExecuteNodeReleaseHandle_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdl := NodeHdl,
		Timeout := T#10s);
	IF (UA_NodeReleaseHandle_0.Busy = 0) THEN
		ExecuteNodeReleaseHandle_0 := 0;
		IF (UA_NodeReleaseHandle_0.Done = 1) THEN
			ErrorID := 0;
			NodeHdl := 0;
		END_IF
		IF (UA_NodeReleaseHandle_0.Error = 1) THEN
			ErrorID := UA_NodeReleaseHandle_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_Disconnect - disconnect from OPC-UA Server *)
	
	UA_Disconnect_0(Execute := ExecuteDisconnect_0,
		ConnectionHdl := ConnectionHdl,
		Timeout := T#10s);
	IF (UA_Disconnect_0.Busy = 0) THEN
		ExecuteDisconnect_0 := 0;
		IF (UA_Disconnect_0.Done = 1) THEN
			ErrorID := 0;
			ConnectionHdl := 0;
		END_IF
		IF (UA_Disconnect_0.Error = 1) THEN 
			ErrorID := UA_Disconnect_0.ErrorID;
		END_IF
	END_IF

END_PROGRAM
