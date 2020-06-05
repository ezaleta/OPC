(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client01e
 * File: Client01eCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA.a := 0;
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
			ErrorID:= 0;
			ConnectionHdl := UA_Connect_0.ConnectionHdl;
		END_IF
		IF (UA_Connect_0.Error = 1) THEN
			ErrorID:= UA_Connect_0.ErrorID;
			ConnectionHdl := 0;
		END_IF
	END_IF

	(* UA_GetNamespaceIndex - read index of required namespace for PVs *)
	
	UA_GetNamespaceIndex_0(Execute := ExecuteGetnamespaceindex_0,
		ConnectionHdl := ConnectionHdl,
		NamespaceUri := 'http://br-automation.com/OpcUa/PLC/PV/',
		Timeout := T#5s);
	IF (UA_GetNamespaceIndex_0.Busy = 0) THEN
		ExecuteGetnamespaceindex_0 := 0;
		IF (UA_GetNamespaceIndex_0.Done = 1) THEN
			ErrorID:= 0;
			NamespaceIndex := UA_GetNamespaceIndex_0.NamespaceIndex;
		END_IF
		IF (UA_GetNamespaceIndex_0.Error = 1) THEN
			ErrorID:= UA_GetNamespaceIndex_0.ErrorID;
			NamespaceIndex := 0;
		END_IF
	END_IF
	
	(* UA_NodeGetHandle - get a handle for required node *)

	NodeID_0.NamespaceIndex := NamespaceIndex;
	NodeID_0.Identifier := '::ServerTask:TestStructA';
	NodeID_0.IdentifierType := UAIdentifierType_String;

	UA_NodeGetHandle_0(Execute := ExecuteNodeGetHandle_0,
		ConnectionHdl := ConnectionHdl,
		NodeID := NodeID_0,
		Timeout := T#10s);
	IF (UA_NodeGetHandle_0.Busy = 0) THEN
		ExecuteNodeGetHandle_0 := 0;
		IF (UA_NodeGetHandle_0.Done = 1) THEN
			ErrorID:= 0;
			NodeHdl := UA_NodeGetHandle_0.NodeHdl;
		END_IF
		IF (UA_NodeGetHandle_0.Error = 1) THEN
			ErrorID:= UA_NodeGetHandle_0.ErrorID;
			NodeHdl := 0;
		END_IF
	END_IF
	
	(* UA_Read - read required node from OPC-UA Server and write it in local plc variable *)
	
	NodeAddInfo_0.AttributeId := UAAI_Value;
	NodeAddInfo_0.IndexRangeCount := 0;
	
	Variable_Rd0 := '::Client01e:VarA';

	UA_Read_0(Execute := ExecuteRead_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdl := NodeHdl,
		NodeAddInfo := NodeAddInfo_0,
		Timeout := T#10s,
		Variable := Variable_Rd0);
	IF (UA_Read_0.Busy = 0) THEN
		ExecuteRead_0 := 0;
		IF (UA_Read_0.Done = 1) THEN
			ErrorID:= 0;
			VarB.a := VarA.a;
			TimestampVarA:=UA_Read_0.TimeStamp;
		END_IF
		IF (UA_Read_0.Error = 1) THEN
			ErrorID:= UA_Read_0.ErrorID;
		END_IF
	END_IF

	(* UA_Write - write local plc variable to required node from OPC-UA Server *)
	
	NodeAddInfo_0.AttributeId := UAAI_Value;
	NodeAddInfo_0.IndexRangeCount := 0;

	Variable_Wr0 := '::Client01e:VarB';

	UA_Write_0(Execute := ExecuteWrite_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdl := NodeHdl,
		NodeAddInfo := NodeAddInfo_0,
		Timeout := T#10s,
		Variable := Variable_Wr0);
	IF (UA_Write_0.Busy = 0) THEN
		ExecuteWrite_0 := 0;
		IF (UA_Write_0.Done = 1) THEN
			ErrorID:= 0;
			VarB.a := VarB.a + 1;
		END_IF
		IF (UA_Write_0.Error = 1) THEN
			ErrorID:= UA_Write_0.ErrorID;
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
			ErrorID:= 0;
			NodeHdl := 0;
		END_IF
		IF (UA_NodeReleaseHandle_0.Error = 1) THEN
			ErrorID:= UA_NodeReleaseHandle_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_Disconnect - disconnect from OPC-UA Server *)
	
	UA_Disconnect_0(Execute := ExecuteDisconnect_0,
		ConnectionHdl := ConnectionHdl,
		Timeout := T#10s);
	IF (UA_Disconnect_0.Busy = 0) THEN
		ExecuteDisconnect_0 := 0;
		IF (UA_Disconnect_0.Done = 1) THEN
			ErrorID:= 0;
			ConnectionHdl := 0;
		END_IF
		IF (UA_Disconnect_0.Error = 1) THEN 
			ErrorID:= UA_Disconnect_0.ErrorID;
		END_IF
	END_IF

END_PROGRAM