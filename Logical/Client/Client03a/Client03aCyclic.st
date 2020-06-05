(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client03a
 * File: Client03aCyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	
	UA_Connect_0_ServerEndpointUrl := 'opc.tcp://10.43.98.95:4840';

	UA_ScanMethod_ObjectNodeID.NamespaceIndex := 4;
	UA_ScanMethod_ObjectNodeID.Identifier := 'rfr310';
	UA_ScanMethod_ObjectNodeID.IdentifierType := UAIdentifierType_String;

	UA_ScanMethod_MethodNodeID.NamespaceIndex := 4;
	UA_ScanMethod_MethodNodeID.Identifier := 'rfr310.Scan';
	UA_ScanMethod_MethodNodeID.IdentifierType := UAIdentifierType_String;

	UA_ScanMethod_Setting.LocationTypeSpecified := TRUE;
	UA_ScanMethod_Setting.Cycles := 1;
	UA_ScanMethod_Setting.LocationType := AILT_LOCAL;
	UA_ScanMethod_Results.Reserved := 0;
	UA_ScanMethod_Status := AIOS_MISC_ERROR_TOTAL;

	WriteTag_ScanData.SwitchField := 0;
	WriteTag_CodeType := 'EPC';
	WriteTag_Region := 1;
	WriteTag_Offset := 4;
	WriteTag_Data.Length := 3;
	WriteTag_Data.Data[0] := 49;
	WriteTag_Data.Data[1] := 50;
	WriteTag_Data.Data[2] := 51;
	WriteTag_Password.Length := 3;
	WriteTag_Password.Data[0] := 49;
	WriteTag_Password.Data[1] := 50;
	WriteTag_Password.Data[2] := 51;
	
	VarA := 2.0;
	VarB := 3.0;
	VarC := 0;
	

END_PROGRAM
      
PROGRAM _CYCLIC

	(* UA_Connect - establish connection to OPC-UA Server *)

	UA_Connect_0_SessionConnectInfo.SecurityMsgMode := UASecurityMsgMode_None;
	UA_Connect_0_SessionConnectInfo.SecurityPolicy := UASecurityPolicy_None;
	UA_Connect_0_SessionConnectInfo.TransportProfile := UATP_UATcp;
	UA_Connect_0_SessionConnectInfo.UserIdentityToken.UserIdentityTokenType := UAUITT_Anonymous;
	//SessionConnectInfo_0.UserIdentityToken.UserIdentityTokenType := UAUITT_Username;
	//SessionConnectInfo_0.UserIdentityToken.TokenParam1 := 'admin';
	//SessionConnectInfo_0.UserIdentityToken.TokenParam2 := 'password';
	UA_Connect_0_SessionConnectInfo.SessionTimeout := T#1m;
	UA_Connect_0_SessionConnectInfo.MonitorConnection := T#10s;

	UA_Connect_0 (Execute := UA_Connect_0_Execute,
		ServerEndpointUrl := UA_Connect_0_ServerEndpointUrl,
		SessionConnectInfo := UA_Connect_0_SessionConnectInfo,
		Timeout := T#10s);
	IF (UA_Connect_0.Busy = 0) THEN
		UA_Connect_0_Execute := 0;
		IF (UA_Connect_0.Done = 1) THEN
			ErrorID:= 0;
			UA_Connect_0_ConnectionHdl := UA_Connect_0.ConnectionHdl;
		END_IF
		IF (UA_Connect_0.Error = 1) THEN
			ErrorID:= UA_Connect_0.ErrorID;
			UA_Connect_0_ConnectionHdl := 0;
		END_IF
	END_IF

	(* UA_MethodGetHandle - get a handle for required methode *)
		
	UA_ScanMethodGetHandle (Execute := UA_ScanMethodGetHandle_Execute,
		ConnectionHdl := UA_Connect_0_ConnectionHdl,
		ObjectNodeID := UA_ScanMethod_ObjectNodeID,
		MethodNodeID := UA_ScanMethod_MethodNodeID,
		Timeout := T#60s);
	IF (UA_ScanMethodGetHandle.Busy = 0) THEN
		UA_ScanMethodGetHandle_Execute := 0;
		IF (UA_ScanMethodGetHandle.Done = 1) THEN
			ErrorID := 0;
			UA_ScanMethod_MethodHdl := UA_ScanMethodGetHandle.MethodHdl;
		END_IF
		IF (UA_ScanMethodGetHandle.Error = 1) THEN
			ErrorID := UA_ScanMethodGetHandle.ErrorID;
			UA_ScanMethod_MethodHdl := 0;
		END_IF
	END_IF
	
	(* UA_MethodCall - call methode *)
	
	UA_ScanMethod_InputArguments[0].Name := 'Setting';
	UA_ScanMethod_InputArguments[0].Value := '::Client03a:UA_ScanMethod_Setting';
	UA_ScanMethod_InputArguments[1].Name := '';

	UA_ScanMethod_OutputArguments[0].Name := 'Results';
	UA_ScanMethod_OutputArguments[0].Value := '::Client03a:UA_ScanMethod_Results';
	UA_ScanMethod_OutputArguments[1].Name := 'Status';
	UA_ScanMethod_OutputArguments[1].Value := '::Client03a:UA_ScanMethod_Status';
	UA_ScanMethod_OutputArguments[2].Name := '';
	
	//InputArguments[0].Name := 'Identifier'; // Scan Data (ExtensionObject)
	//InputArguments[0].Value := '::Client03c:WriteTag_ScanData';
	//InputArguments[1].Name := 'CodeType'; // CodeTypeDataType(String)
	//InputArguments[1].Value := '::Client03c:WriteTag_CodeType';
	//InputArguments[2].Name := 'Region'; // UInt16
	//InputArguments[2].Value := '::Client03c:WriteTag_Region'; 
	//InputArguments[3].Name := 'Offset'; // UInt32
	//InputArguments[3].Value := '::Client03c:WriteTag_Offset'; 
	//InputArguments[4].Name := 'Data'; //ByteString
	//InputArguments[4].Value := '::Client03c:WriteTag_Data';
	//InputArguments[5].Name := 'Password'; //ByteString
	//InputArguments[5].Value := '::Client03c:WriteTag_Password';
	//InputArguments[6].Name := '';

	//OutputArguments[0].Name := 'Status';
	//OutputArguments[0].Value := '::Client03c:Status';
	//OutputArguments[1].Name := '';

	UA_ScanMethodCall (Execute := UA_ScanMethodCall_Execute,
		ConnectionHdl := UA_Connect_0_ConnectionHdl,
		MethodHdl := UA_ScanMethod_MethodHdl,
		Timeout := T#10s,
	InputArguments := UA_ScanMethod_InputArguments,
	OutputArguments := UA_ScanMethod_OutputArguments);
	IF (UA_ScanMethodCall.Busy = 0) THEN
		UA_ScanMethodCall_Execute := 0;
		IF (UA_ScanMethodCall.Done = 1) THEN
			ErrorID := 0;
		END_IF
		IF (UA_ScanMethodCall.Error = 1) THEN
			ErrorID := UA_ScanMethodCall.ErrorID;
		END_IF
	END_IF

	(* UA_MethodReleaseHandle - release a handle for a methode *)

	UA_MethodReleaseHandle_0(Execute := ExecuteMethodReleaseHandle_0,
		ConnectionHdl := UA_Connect_0_ConnectionHdl,
		MethodHdl := UA_ScanMethod_MethodHdl,
		Timeout := T#10s);
	IF (UA_MethodReleaseHandle_0.Busy = 0) THEN
		ExecuteMethodReleaseHandle_0 := 0;
		IF (UA_MethodReleaseHandle_0.Done = 1) THEN
			ErrorID := 0;
			UA_ScanMethod_MethodHdl := 0;
		END_IF
		IF (UA_MethodReleaseHandle_0.Error = 1) THEN
			ErrorID := UA_MethodReleaseHandle_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_Disconnect - disconnect from OPC-UA Server *)
	
	UA_Disconnect_0(Execute := ExecuteDisconnect_0,
		ConnectionHdl := UA_Connect_0_ConnectionHdl,
		Timeout := T#10s);
	IF (UA_Disconnect_0.Busy = 0) THEN
		ExecuteDisconnect_0 := 0;
		IF (UA_Disconnect_0.Done = 1) THEN
			ErrorID := 0;
			UA_Connect_0_ConnectionHdl := 0;
		END_IF
		IF (UA_Disconnect_0.Error = 1) THEN 
			ErrorID := UA_Disconnect_0.ErrorID;
		END_IF
	END_IF
	
END_PROGRAM
