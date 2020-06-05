(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client04
 * File: Client04Cyclic.st
 * Created: July 03, 2014
 ********************************************************************)
PROGRAM _INIT

	FieldEventType := FieldEventType;
	FieldMessage := FieldMessage;
	FieldReceiveTime := FieldReceiveTime;
	FieldSeverity := FieldSeverity;
	FieldSourceName := FieldSourceName;
	FieldSourceNode := FieldSourceNode;
	FieldTime := FieldTime;
	FieldClientUserId := FieldClientUserId;
	FieldOldValue := FieldOldValue;
	FieldNewValue := FieldNewValue;
	FieldEventId := FieldEventId;
   
END_PROGRAM
      
 
PROGRAM _CYCLIC

	(* UA_Connect - establish connection to OPC-UA Server *)

	SessionConnectInfo_0.SecurityMsgMode := UASecurityMsgMode_SignEncrypt;
	SessionConnectInfo_0.SecurityPolicy := UASecurityPolicy_Basic256;
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

	(* UA_SubscriptionCreate - create subscription *)

	PublishingInterval := T#1s;
	PublishingEnable := TRUE;

	UA_SubscriptionCreate_0(Execute := ExecuteSubscriptionCreate_0, 
		ConnectionHdl := ConnectionHdl,
		PublishingEnable := PublishingEnable, 
		Priority := 10, 
		Timeout := T#10s, 
		PublishingInterval := PublishingInterval);

	IF (UA_SubscriptionCreate_0.Busy = 0) THEN
		ExecuteSubscriptionCreate_0 := 0;
		IF (UA_SubscriptionCreate_0.Done = 1) THEN
			ErrorID := 0;
			SubscriptionHdl := UA_SubscriptionCreate_0.SubscriptionHdl;
		END_IF
		IF (UA_SubscriptionCreate_0.Error = 1) THEN
			ErrorID := UA_SubscriptionCreate_0.ErrorID;
			SubscriptionHdl := 0;
		END_IF
	END_IF

	(* UA_NodeGetHandle - get a handle for the server object *)

	NodeID_Server.NamespaceIndex := 0;
	NodeID_Server.Identifier := '2253';	//Server Object
	NodeID_Server.IdentifierType := UAIdentifierType_Numeric;

	UA_NodeGetHandle_0(Execute := ExecuteNodeGetHandle_0, 
		ConnectionHdl := ConnectionHdl, 
		NodeID := NodeID_Server,
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
	
	(* UA_EventItemAdd - Add Event Items *)

	NodeID_EventType.NamespaceIndex := 0;
	NodeID_EventType.Identifier := '2052';	//AuditEventType
	NodeID_EventType.IdentifierType := UAIdentifierType_Numeric;
	
	EventFieldSelections_0[0].NoOfElements := 1;
	EventFieldSelections_0[0].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[0].Elements[0].TargetName.Name := 'EventType';
	EventFieldSelections_0[1].NoOfElements := 1;
	EventFieldSelections_0[1].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[1].Elements[0].TargetName.Name := 'Message';
	EventFieldSelections_0[2].NoOfElements := 1;
	EventFieldSelections_0[2].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[2].Elements[0].TargetName.Name := 'ReceiveTime';
	EventFieldSelections_0[3].NoOfElements := 1;
	EventFieldSelections_0[3].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[3].Elements[0].TargetName.Name := 'Severity';
	EventFieldSelections_0[4].NoOfElements := 1;
	EventFieldSelections_0[4].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[4].Elements[0].TargetName.Name := 'SourceName';
	EventFieldSelections_0[5].NoOfElements := 1;
	EventFieldSelections_0[5].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[5].Elements[0].TargetName.Name := 'SourceNode';
	EventFieldSelections_0[6].NoOfElements := 1;
	EventFieldSelections_0[6].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[6].Elements[0].TargetName.Name := 'Time';
	EventFieldSelections_0[7].NoOfElements := 1;
	EventFieldSelections_0[7].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[7].Elements[0].TargetName.Name := 'ClientUserId';
	EventFieldSelections_0[8].NoOfElements := 1;
	EventFieldSelections_0[8].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[8].Elements[0].TargetName.Name := 'OldValue';
	EventFieldSelections_0[9].NoOfElements := 1;
	EventFieldSelections_0[9].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[9].Elements[0].TargetName.Name := 'NewValue';
	EventFieldSelections_0[10].NoOfElements := 1;
	EventFieldSelections_0[10].Elements[0].TargetName.NamespaceIndex := 0;
	EventFieldSelections_0[10].Elements[0].TargetName.Name := 'EventId';

	EventFields_0[0] := '::Client04:FieldEventType';
	EventFields_0[1] := '::Client04:FieldMessage';
	EventFields_0[2] := '::Client04:FieldReceiveTime';
	EventFields_0[3] := '::Client04:FieldSeverity';
	EventFields_0[4] := '::Client04:FieldSourceName';
	EventFields_0[5] := '::Client04:FieldSourceNode';
	EventFields_0[6] := '::Client04:FieldTime';
	EventFields_0[7] := '::Client04:FieldClientUserId';
	EventFields_0[8] := '::Client04:FieldOldValue';
	EventFields_0[9] := '::Client04:FieldNewValue';
	EventFields_0[10] := '::Client04:FieldEventId';

	EventFieldSelectionCount := 11;

	UA_EventItemAdd_0(Execute := ExecuteEventItemAdd_0,
		SubscriptionHdl := SubscriptionHdl,
		NodeHdl := NodeHdl, 
		EventType := NodeID_EventType,
		EventFieldSelectionCount := EventFieldSelectionCount,
		EventFieldSelections := EventFieldSelections_0,
		EventFields := EventFields_0,
		Timeout := T#10s);

	IF (UA_EventItemAdd_0.Busy = 0) THEN
		ExecuteEventItemAdd_0 := 0;
		IF (UA_EventItemAdd_0.Done = 1) THEN
			ErrorID := 0;
			EventItemHdl := UA_EventItemAdd_0.EventItemHdl;
		END_IF
		IF (UA_EventItemAdd_0.Error = 1) THEN
			ErrorID := UA_EventItemAdd_0.ErrorID;
			EventItemHdl := 0;
		END_IF
	END_IF

	(* UA_EventItemOperate - Operate Event Items *)

	UA_EventItemOperate_0(Execute := ExecuteEventItemOperate_0,
		SubscriptionHdl := SubscriptionHdl,
		EventItemHdl := EventItemHdl,
		Timeout := T#10s);

	IF (UA_EventItemOperate_0.Busy = 0) THEN
		ExecuteEventItemOperate_0 := 0;
		IF (UA_EventItemOperate_0.Done = 1) THEN
			ErrorID := 0;
			EventProcessed := UA_EventItemOperate_0.EventProcessed;
			RemainingEventCount := UA_EventItemOperate_0.RemainingEventCount;
		END_IF
		IF (UA_EventItemOperate_0.Error = 1) THEN
			ErrorID := UA_EventItemOperate_0.ErrorID;
		END_IF
	END_IF

	(* UA_EventItemRemove - Remove Event Items *)

	UA_EventItemRemove_0(Execute := ExecuteEventItemRemove_0,
		SubscriptionHdl := SubscriptionHdl,
		EventItemHdl := EventItemHdl,
		Timeout := T#10s);
	
	IF (UA_EventItemRemove_0.Busy = 0) THEN
		ExecuteEventItemRemove_0 := 0;
		IF (UA_EventItemRemove_0.Done = 1) THEN
			ErrorID := 0;
			EventItemHdl := 0;
		END_IF
		IF (UA_EventItemRemove_0.Error = 1) THEN
			ErrorID := UA_EventItemRemove_0.ErrorID;
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

	(* UA_SubscriptionDelete - delete subscription *)
	
	UA_SubscriptionDelete_0(Execute := ExecuteSubscriptionDelete_0,
		SubscriptionHdl := SubscriptionHdl,
		Timeout := T#10s);

	IF (UA_SubscriptionDelete_0.Busy = 0) THEN
		ExecuteSubscriptionDelete_0 := 0;
		IF (UA_SubscriptionDelete_0.Done = 1) THEN
			ErrorID := 0;
			SubscriptionHdl := 0;
		END_IF
		IF (UA_SubscriptionDelete_0.Error = 1) THEN
			ErrorID := UA_SubscriptionDelete_0.ErrorID;
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
