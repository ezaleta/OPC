(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client03b
 * File: Client03bCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT

	Authorizations.Length := 0;
	NodeIdsStatus.Length := 0;
	AuthorizationsStatus.Length := 0;

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

	(* UA_GetNamespaceIndex - read index of required namespace for PLC *)
	
	UA_GetNamespaceIndex_PLC(Execute := ExecuteGetnamespaceindex_PLC,
		ConnectionHdl := ConnectionHdl,
		NamespaceUri := 'http://br-automation.com/OpcUa/PLC/',
		Timeout := T#5s);
	IF (UA_GetNamespaceIndex_PLC.Busy = 0) THEN
		ExecuteGetnamespaceindex_PLC := 0;
		IF (UA_GetNamespaceIndex_PLC.Done = 1) THEN
			ErrorID:= 0;
			NamespaceIndex_PLC := UA_GetNamespaceIndex_PLC.NamespaceIndex;
			itoa(NamespaceIndex_PLC,ADR(NamespaceIndex_PLC_Str));
		END_IF
		IF (UA_GetNamespaceIndex_PLC.Error = 1) THEN
			ErrorID:= UA_GetNamespaceIndex_PLC.ErrorID;
			NamespaceIndex_PLC := 0;
		END_IF
	END_IF
	
	(* UA_GetNamespaceIndex - read index of required namespace for PV *)
	
	UA_GetNamespaceIndex_PV(Execute := ExecuteGetnamespaceindex_PV,
		ConnectionHdl := ConnectionHdl,
		NamespaceUri := 'http://br-automation.com/OpcUa/PLC/PV/',
	Timeout := T#5s);
	IF (UA_GetNamespaceIndex_PV.Busy = 0) THEN
		ExecuteGetnamespaceindex_PV := 0;
		IF (UA_GetNamespaceIndex_PV.Done = 1) THEN
			ErrorID:= 0;
			NamespaceIndex_PV := UA_GetNamespaceIndex_PV.NamespaceIndex;
			itoa(NamespaceIndex_PV,ADR(NamespaceIndex_PV_Str));
		END_IF
		IF (UA_GetNamespaceIndex_PV.Error = 1) THEN
			ErrorID:= UA_GetNamespaceIndex_PV.ErrorID;
			NamespaceIndex_PV := 0;
		END_IF
	END_IF
	
	(* UA_TranslatePath - get ObjectNodeID *)

	StartNodeID_Root.NamespaceIndex := 0;
	StartNodeID_Root.Identifier := '84';
	StartNodeID_Root.IdentifierType := UAIdentifierType_Numeric;
	// Path= /0:Objects/4:PLC/4:AccessAndSecurity/4:Authorization/4:OpcUA';
	RelativePath_ObjectNode := '/0:Objects/';
	strcat(ADR(RelativePath_ObjectNode),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_ObjectNode),ADR(':PLC/'));
	strcat(ADR(RelativePath_ObjectNode),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_ObjectNode),ADR(':AccessAndSecurity/'));
	strcat(ADR(RelativePath_ObjectNode),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_ObjectNode),ADR(':Authorization/'));
	strcat(ADR(RelativePath_ObjectNode),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_ObjectNode),ADR(':OpcUA'));
	
	UA_TranslatePath_0(Execute := ExecuteTranslatePath_0,
		ConnectionHdl := ConnectionHdl,
		StartNodeID := StartNodeID_Root,
		RelativePath := RelativePath_ObjectNode,
		Timeout := T#10s);
	IF (UA_TranslatePath_0.Busy = 0) THEN
		ExecuteTranslatePath_0 := 0;
		IF (UA_TranslatePath_0.Done = 1) THEN
			ErrorID := 0;
			ObjectNodeID := UA_TranslatePath_0.TargetNodeID;
		END_IF
		IF (UA_TranslatePath_0.Error = 1) THEN
			ErrorID := UA_TranslatePath_0.ErrorID;
		END_IF
	END_IF

	(* UA_TranslatePath - get MethodNodeID GetAuthorizations*)

	StartNodeID_ObjectNode.NamespaceIndex := ObjectNodeID.NamespaceIndex;
	StartNodeID_ObjectNode.Identifier := ObjectNodeID.Identifier;
	StartNodeID_ObjectNode.IdentifierType := ObjectNodeID.IdentifierType;
	RelativePath_GetAuthorizations := '/';
	strcat(ADR(RelativePath_GetAuthorizations),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_GetAuthorizations),ADR(':GetAuthorizations'));
	
	UA_TranslatePath_1(Execute := ExecuteTranslatePath_1,
		ConnectionHdl := ConnectionHdl,
		StartNodeID := StartNodeID_ObjectNode,
		RelativePath := RelativePath_GetAuthorizations,
		Timeout := T#10s);
	IF (UA_TranslatePath_1.Busy = 0) THEN
		ExecuteTranslatePath_1 := 0;
		IF (UA_TranslatePath_1.Done = 1) THEN
			ErrorID := 0;
			MethodNodeID_GetAuthorizations := UA_TranslatePath_1.TargetNodeID;
		END_IF
		IF (UA_TranslatePath_1.Error = 1) THEN
			ErrorID := UA_TranslatePath_1.ErrorID;
		END_IF
	END_IF

	(* UA_TranslatePath - get MethodNodeID SetAuthorizations*)

	StartNodeID_ObjectNode.NamespaceIndex := ObjectNodeID.NamespaceIndex;
	StartNodeID_ObjectNode.Identifier := ObjectNodeID.Identifier;
	StartNodeID_ObjectNode.IdentifierType := ObjectNodeID.IdentifierType;
	RelativePath_SetAuthorizations := '/';
	strcat(ADR(RelativePath_SetAuthorizations),ADR(NamespaceIndex_PLC_Str));
	strcat(ADR(RelativePath_SetAuthorizations),ADR(':SetAuthorizations'));
	
	UA_TranslatePath_2(Execute := ExecuteTranslatePath_2,
		ConnectionHdl := ConnectionHdl,
		StartNodeID := StartNodeID_ObjectNode,
		RelativePath := RelativePath_SetAuthorizations,
		Timeout := T#10s);
	IF (UA_TranslatePath_2.Busy = 0) THEN
		ExecuteTranslatePath_2 := 0;
		IF (UA_TranslatePath_2.Done = 1) THEN
			ErrorID := 0;
			MethodNodeID_SetAuthorizations := UA_TranslatePath_2.TargetNodeID;
		END_IF
		IF (UA_TranslatePath_2.Error = 1) THEN
			ErrorID := UA_TranslatePath_2.ErrorID;
		END_IF
	END_IF

	(* UA_MethodGetHandle - get a handle for required methode GetAuthorizations*)
		
	UA_MethodGetHandle_0(Execute := ExecuteMethodGetHandle_0,
		ConnectionHdl := ConnectionHdl,
		ObjectNodeID := ObjectNodeID,
		MethodNodeID := MethodNodeID_GetAuthorizations,
		Timeout := T#10s);
	IF (UA_MethodGetHandle_0.Busy = 0) THEN
		ExecuteMethodGetHandle_0 := 0;
		IF (UA_MethodGetHandle_0.Done = 1) THEN
			ErrorID := 0;
			MethodHdl_GetAuthorizations := UA_MethodGetHandle_0.MethodHdl;
		END_IF
		IF (UA_MethodGetHandle_0.Error = 1) THEN
			ErrorID := UA_MethodGetHandle_0.ErrorID;
			MethodHdl_GetAuthorizations := 0;
		END_IF
	END_IF
	
	(* UA_MethodGetHandle - get a handle for required methode SetAuthorizations*)
		
	UA_MethodGetHandle_1(Execute := ExecuteMethodGetHandle_1,
		ConnectionHdl := ConnectionHdl,
		ObjectNodeID := ObjectNodeID,
		MethodNodeID := MethodNodeID_SetAuthorizations,
		Timeout := T#10s);
	IF (UA_MethodGetHandle_1.Busy = 0) THEN
		ExecuteMethodGetHandle_1 := 0;
		IF (UA_MethodGetHandle_1.Done = 1) THEN
			ErrorID := 0;
			MethodHdl_SetAuthorizations := UA_MethodGetHandle_1.MethodHdl;
		END_IF
		IF (UA_MethodGetHandle_1.Error = 1) THEN
			ErrorID := UA_MethodGetHandle_1.ErrorID;
			MethodHdl_SetAuthorizations := 0;
		END_IF
	END_IF
	
	(* UA_MethodCall - call method GetAuthorizations*)
	
	NodeIds.Value[0].NamespaceIndex := NamespaceIndex_PV;
	NodeIds.Value[0].Identifier := '::ServerTask:VarX';
	NodeIds.Value[0].IdentifierType := UAIdentifierType_String;
	NodeIds.Value[1].NamespaceIndex := NamespaceIndex_PV;
	NodeIds.Value[1].Identifier := '::ServerTask:VarY';
	NodeIds.Value[1].IdentifierType := UAIdentifierType_String;
	NodeIds.Length := 2;

	InputArguments0[0].Name := 'NodeIds';
	InputArguments0[0].Value := '::Client03b:NodeIds';
	InputArguments0[1].Name := '';

	OutputArguments0[0].Name := 'Authorizations';
	OutputArguments0[0].Value := '::Client03b:Authorizations';
	OutputArguments0[1].Name := 'NodeIdsStatus';
	OutputArguments0[1].Value := '::Client03b:NodeIdsStatus';
	OutputArguments0[2].Name := '';

	UA_MethodCall_0(Execute := ExecuteMethodCall_0,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl_GetAuthorizations,
		Timeout := T#10s,
	InputArguments := InputArguments0,
	OutputArguments := OutputArguments0);
	IF (UA_MethodCall_0.Busy = 0) THEN
		ExecuteMethodCall_0 := 0;
		IF (UA_MethodCall_0.Done = 1) THEN
			ErrorID := 0;
			Authorizations.Value[1].Inherit := FALSE; // switch off inheritance for the node 'VarY' for the User 'Everyone'  
			Authorizations.Value[1].Nodes[0].Roles[1].Rights[5].Allow := TRUE; // Allow for the node 'VarY' for the User 'Everyone' the Right 'Write' 
		END_IF
		IF (UA_MethodCall_0.Error = 1) THEN
			ErrorID := UA_MethodCall_0.ErrorID;
		END_IF
	END_IF

	(* UA_MethodCall - call method SetAuthorizations*)
	
	InputArguments1[0].Name := 'Authorizations';
	InputArguments1[0].Value := '::Client03b:Authorizations';
	InputArguments1[1].Name := '';

	OutputArguments1[0].Name := 'AuthorizationsStatus';
	OutputArguments1[0].Value := '::Client03b:AuthorizationsStatus';
	OutputArguments1[1].Name := '';

	UA_MethodCall_1(Execute := ExecuteMethodCall_1,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl_SetAuthorizations,
		Timeout := T#10s,
	InputArguments := InputArguments1,
	OutputArguments := OutputArguments1);
	IF (UA_MethodCall_1.Busy = 0) THEN
		ExecuteMethodCall_1 := 0;
		IF (UA_MethodCall_1.Done = 1) THEN
			ErrorID := 0;
		END_IF
		IF (UA_MethodCall_1.Error = 1) THEN
			ErrorID := UA_MethodCall_1.ErrorID;
		END_IF
	END_IF

	(* UA_MethodReleaseHandle - release a handle for method GetAuthorizations*)

	UA_MethodReleaseHandle_0(Execute := ExecuteMethodReleaseHandle_0,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl_GetAuthorizations,
		Timeout := T#10s);
	IF (UA_MethodReleaseHandle_0.Busy = 0) THEN
		ExecuteMethodReleaseHandle_0 := 0;
		IF (UA_MethodReleaseHandle_0.Done = 1) THEN
			ErrorID := 0;
			MethodHdl_GetAuthorizations := 0;
		END_IF
		IF (UA_MethodReleaseHandle_0.Error = 1) THEN
			ErrorID := UA_MethodReleaseHandle_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_MethodReleaseHandle - release a handle for methode SetAuthorizations*)

	UA_MethodReleaseHandle_1(Execute := ExecuteMethodReleaseHandle_1,
		ConnectionHdl := ConnectionHdl,
		MethodHdl := MethodHdl_SetAuthorizations,
		Timeout := T#10s);
	IF (UA_MethodReleaseHandle_1.Busy = 0) THEN
		ExecuteMethodReleaseHandle_1 := 0;
		IF (UA_MethodReleaseHandle_1.Done = 1) THEN
			ErrorID := 0;
			MethodHdl_SetAuthorizations := 0;
		END_IF
		IF (UA_MethodReleaseHandle_1.Error = 1) THEN
			ErrorID := UA_MethodReleaseHandle_1.ErrorID;
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
