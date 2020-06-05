(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client03
 * File: Client03Cyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA := 2.0;
	VarB := 3.0;
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
			ErrorID := 0;
			NamespaceIndex := UA_GetNamespaceIndex_0.NamespaceIndex;
		END_IF
		IF (UA_GetNamespaceIndex_0.Error = 1) THEN
			ErrorID := UA_GetNamespaceIndex_0.ErrorID;
			NamespaceIndex := 0;
		END_IF
	END_IF
		
	(* UA_MethodGetHandle - get a handle for required methode *)
		
	ObjectNodeID.NamespaceIndex := NamespaceIndex;
	ObjectNodeID.Identifier := '::SrvMethod';
	ObjectNodeID.IdentifierType := UAIdentifierType_String;

	MethodNodeID.NamespaceIndex := NamespaceIndex;
	MethodNodeID.Identifier := '::SrvMethod:Multiply';
	MethodNodeID.IdentifierType := UAIdentifierType_String;

	UA_MethodGetHandle_0(Execute := ExecuteMethodGetHandle_0,
		ConnectionHdl := ConnectionHdl,
		ObjectNodeID := ObjectNodeID,
		MethodNodeID := MethodNodeID,
		Timeout := T#60s);
	IF (UA_MethodGetHandle_0.Busy = 0) THEN
		ExecuteMethodGetHandle_0 := 0;
		IF (UA_MethodGetHandle_0.Done = 1) THEN
			ErrorID := 0;
			MethodHdl := UA_MethodGetHandle_0.MethodHdl;
		END_IF
		IF (UA_MethodGetHandle_0.Error = 1) THEN
			ErrorID := UA_MethodGetHandle_0.ErrorID;
			MethodHdl := 0;
		END_IF
	END_IF
	
	(* UA_MethodCall - call methode *)
	
	InputArguments[0].Name := 'a';
	InputArguments[0].Value := '::Client03:VarA';
	InputArguments[1].Name := 'b';
	InputArguments[1].Value := '::Client03:VarB';

	OutputArguments[0].Name := 'result';
	OutputArguments[0].Value := '::Client03:VarC';

	UA_MethodCall_0(Execute := ExecuteMethodCall_0,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl,
		Timeout := T#10s,
	InputArguments := InputArguments,
	OutputArguments := OutputArguments);
	IF (UA_MethodCall_0.Busy = 0) THEN
		ExecuteMethodCall_0 := 0;
		IF (UA_MethodCall_0.Done = 1) THEN
			ErrorID := 0;
		END_IF
		IF (UA_MethodCall_0.Error = 1) THEN
			ErrorID := UA_MethodCall_0.ErrorID;
		END_IF
	END_IF

	(* UA_ConnectionGetStatus - get server status *)

	UA_ConnectionGetStatus_0(Execute := ExecuteConnectionGetStatus_0,
		ConnectionHdl := ConnectionHdl,
		Timeout := T#10s);
	IF (UA_ConnectionGetStatus_0.Busy = 0) THEN
		ExecuteConnectionGetStatus_0 := 0;
		IF (UA_ConnectionGetStatus_0.Done = 1) THEN
			ErrorID := 0;
			ConnectionStatus := UA_ConnectionGetStatus_0.ConnectionStatus;
			ServerState := UA_ConnectionGetStatus_0.ServerState;
			ServiceLevel := UA_ConnectionGetStatus_0.ServiceLevel;
		END_IF
		IF (UA_ConnectionGetStatus_0.Error = 1) THEN
			ErrorID := UA_ConnectionGetStatus_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_NodeGetInfo - get node info*)
		
	MethodNodeID.NamespaceIndex := NamespaceIndex;
	MethodNodeID.Identifier := '::SrvMethod:Multiply';
	MethodNodeID.IdentifierType := UAIdentifierType_String;

	UA_NodeGetInfo_0 (Execute := ExecuteNodeGetInfo_0,
		ConnectionHdl := ConnectionHdl,
		NodeID := MethodNodeID,
		Timeout := T#60s);
	IF (UA_NodeGetInfo_0.Busy = 0) THEN
		ExecuteNodeGetInfo_0 := 0;
		IF (UA_NodeGetInfo_0.Done = 1) THEN
			ErrorID := 0;
			NodeInfo := UA_NodeGetInfo_0.NodeInfo;
		END_IF
		IF (UA_NodeGetInfo_0.Error = 1) THEN
			ErrorID := UA_NodeGetInfo_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_MethodReleaseHandle - release a handle for a methode *)

	UA_MethodReleaseHandle_0(Execute := ExecuteMethodReleaseHandle_0,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl,
		Timeout := T#10s);
	IF (UA_MethodReleaseHandle_0.Busy = 0) THEN
		ExecuteMethodReleaseHandle_0 := 0;
		IF (UA_MethodReleaseHandle_0.Done = 1) THEN
			ErrorID := 0;
			MethodHdl := 0;
		END_IF
		IF (UA_MethodReleaseHandle_0.Error = 1) THEN
			ErrorID := UA_MethodReleaseHandle_0.ErrorID;
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
