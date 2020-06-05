(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client01b
 * File: Client01bCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA := 0;
	VarB[0] := 0;
	VarB[1] := 0;
	VarB[2] := 0;
	VarC := 0; 
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
		
	(* UA_NodeGetHandleList - get handles for required nodes *)
	
	NodeIDs_0[0].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[0].Identifier := '::ServerTask:VarX';
	NodeIDs_0[0].IdentifierType := UAIdentifierType_String;

	NodeIDs_0[1].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[1].Identifier := '::ServerTask:VarArr';
	NodeIDs_0[1].IdentifierType := UAIdentifierType_String;

	NodeIDs_0[2].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[2].Identifier := '::ServerTask:VarZ';
	NodeIDs_0[2].IdentifierType := UAIdentifierType_String;

	UA_NodeGetHandleList_0(Execute := ExecuteNodeGetHandleList_0,
		ConnectionHdl := ConnectionHdl,
		NodeIDCount := 3,
		NodeIDs := NodeIDs_0,
		Timeout := T#10s);
	IF (UA_NodeGetHandleList_0.Busy = 0) THEN
		ExecuteNodeGetHandleList_0 := 0;
		IF (UA_NodeGetHandleList_0.Done = 1) THEN
			ErrorID:= 0;
			NodeHdls := UA_NodeGetHandleList_0.NodeHdls;
		END_IF
		IF (UA_NodeGetHandleList_0.Error = 1) THEN
			ErrorID:= UA_NodeGetHandleList_0.ErrorID;
			NodeHdls[0] := 0;
		END_IF
	END_IF			
	
	(* UA_ReadList - read required nodes from OPC-UA Server and write it in local plc variables *)

	NodeAddInfo_0[0].AttributeId := UAAI_Value;
	NodeAddInfo_0[0].IndexRangeCount := 0;

	NodeAddInfo_0[1].AttributeId := UAAI_Value;
	NodeAddInfo_0[1].IndexRangeCount := 1;
	NodeAddInfo_0[1].IndexRange[0].StartIndex := 0;
	NodeAddInfo_0[1].IndexRange[0].EndIndex := 2;

	NodeAddInfo_0[2].AttributeId := UAAI_Value;
	NodeAddInfo_0[2].IndexRangeCount := 0;

	Variables_Rd0[0] := '::Client01b:VarA';
	Variables_Rd0[1] := '::Client01b:VarB';
	Variables_Rd0[2] := '::Client01b:VarC';

	UA_ReadList_0(Execute := ExecuteReadList_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdlCount := 3,
		NodeHdls := NodeHdls,
		NodeAddInfo := NodeAddInfo_0,
		Timeout := T#10s,
		Variables := Variables_Rd0);
	IF (UA_ReadList_0.Busy = 0) THEN
		ExecuteReadList_0 := 0;
		IF (UA_ReadList_0.Done = 1) THEN
			ErrorID:= 0;
		END_IF
		IF (UA_ReadList_0.Error = 1) THEN
			ErrorID:= UA_ReadList_0.ErrorID;
		END_IF
	END_IF

	(* UA_NodeReleaseHandleList - release the handles for the nodes *)
	
    UA_NodeReleaseHandleList_0(Execute := ExecuteNodeReleaseHandleList_0,
		ConnectionHdl := ConnectionHdl,
		NodeHdlCount := 3,
		NodeHdls := NodeHdls,
		Timeout := T#10s);
	IF (UA_NodeReleaseHandleList_0.Busy = 0) THEN
		ExecuteNodeReleaseHandleList_0 := 0;
		IF (UA_NodeReleaseHandleList_0.Done = 1) THEN
			ErrorID:= 0;
			NodeHdls[0] := 0;
			NodeHdls[1] := 0;
			NodeHdls[2] := 0;
		END_IF
		IF (UA_NodeReleaseHandleList_0.Error = 1) THEN
			ErrorID:= UA_NodeReleaseHandleList_0.ErrorID;
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
