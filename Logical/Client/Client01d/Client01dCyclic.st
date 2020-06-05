(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client01d
 * File: Client01dCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA := 0;
	VarB := 0;
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
		
	(* UA_ReadBulk - read required nodes from OPC-UA Server and write it in local plc variables *)

	NodeIDs_0[0].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[0].Identifier := '::ServerTask:VarX';
	NodeIDs_0[0].IdentifierType := UAIdentifierType_String;
	NodeAddInfo_0[0].AttributeId := UAAI_Value;
	NodeAddInfo_0[0].IndexRangeCount := 0;

	NodeIDs_0[1].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[1].Identifier := '::ServerTask:VarY';
	NodeIDs_0[1].IdentifierType := UAIdentifierType_String;
	NodeAddInfo_0[1].AttributeId := UAAI_Value;
	NodeAddInfo_0[1].IndexRangeCount := 0;

	NodeIDs_0[2].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[2].Identifier := '::ServerTask:VarZ';
	NodeIDs_0[2].IdentifierType := UAIdentifierType_String;
	NodeAddInfo_0[2].AttributeId := UAAI_Value;
	NodeAddInfo_0[2].IndexRangeCount := 0;

	Variables_Rd0[0] := '::Client01d:VarA';
	Variables_Rd0[1] := '::Client01d:VarB';
	Variables_Rd0[2] := '::Client01d:VarC';
	
	UaClt_ReadBulk_0(Execute := ExecuteReadBulk_0,
		ConnectionHdl := ConnectionHdl,
		NodeIDCount := 3,
		NodeIDs := ADR(NodeIDs_0),
		NodeAddInfo := ADR(NodeAddInfo_0),
		Variables := ADR(Variables_Rd0),
		NodeErrorIDs := ADR(NodeErrorIDs_0),
		TimeStamps := ADR(TimeStamps_0),
		Timeout := T#10s);
		
	IF (UaClt_ReadBulk_0.Busy = 0) THEN
		ExecuteReadBulk_0 := 0;
		IF (UaClt_ReadBulk_0.Done = 1) THEN
			ErrorID:= 0;
		END_IF
		IF (UaClt_ReadBulk_0.Error = 1) THEN
			ErrorID:= UaClt_ReadBulk_0.ErrorID;
		END_IF
	END_IF

	(* UA_WriteBulk - write local plc variables to required nodes from OPC-UA Server *)
	
	Variables_Wr0[0] := '::Client01d:VarA';
	Variables_Wr0[1] := '::Client01d:VarB';
	Variables_Wr0[2] := '::Client01d:VarC';

	UaClt_WriteBulk_0(Execute := ExecuteWriteBulk_0,
		ConnectionHdl := ConnectionHdl,
		NodeIDCount := 3,
		NodeIDs := ADR(NodeIDs_0),
		NodeAddInfo := ADR(NodeAddInfo_0),
		Variables := ADR(Variables_Wr0),
		NodeErrorIDs := ADR(NodeErrorIDs_0),
		Timeout := T#10s);
		
	IF (UaClt_WriteBulk_0.Busy = 0) THEN
		ExecuteWriteBulk_0 := 0;
		IF (UaClt_WriteBulk_0.Done = 1) THEN
			ErrorID:= 0;
			VarA := VarA + 2;
			VarB := VarB + 4;
			VarC := VarC + 6;
		END_IF
		IF (UaClt_WriteBulk_0.Error = 1) THEN
			ErrorID:= UaClt_WriteBulk_0.ErrorID;
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
