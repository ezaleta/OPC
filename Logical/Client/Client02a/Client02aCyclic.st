(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client02a
 * File: Client02aCyclic.st
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
			ErrorID := 0;
			NamespaceIndex := UA_GetNamespaceIndex_0.NamespaceIndex;
		END_IF
		IF (UA_GetNamespaceIndex_0.Error = 1) THEN
			ErrorID := UA_GetNamespaceIndex_0.ErrorID;
			NamespaceIndex := 0;
		END_IF
	END_IF
		
	(* UA_NodeGetHandleList - get handles for required nodes *)
	
	NodeIDs_0[0].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[0].Identifier := '::ServerTask:VarX';
	NodeIDs_0[0].IdentifierType := UAIdentifierType_String;

	NodeIDs_0[1].NamespaceIndex := NamespaceIndex;
	NodeIDs_0[1].Identifier := '::ServerTask:VarY';
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
			NodeHdls[1] := 0;
			NodeHdls[2] := 0;
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

	(* UA_MonitoredItemAddList - Add Monitored Items *)

	NodeAddInfos_0[0].AttributeId := UAAI_Value;
	NodeAddInfos_0[0].IndexRangeCount := 0;
	NodeAddInfos_0[1].AttributeId := UAAI_Value;
	NodeAddInfos_0[1].IndexRangeCount := 0;
	NodeAddInfos_0[2].AttributeId := UAAI_Value;
	NodeAddInfos_0[3].IndexRangeCount := 0;
	Variables_0[0] := '::Client02a:VarA';
	Variables_0[1] := '::Client02a:VarB';
	Variables_0[2] := '::Client02a:VarC';
	MonitoringSettings_0[0].SamplingInterval := T#1s;
	MonitoringSettings_0[0].QueueSize := 10;
	MonitoringSettings_0[1].SamplingInterval := T#1s;
	MonitoringSettings_0[1].QueueSize := 10;
	MonitoringSettings_0[2].SamplingInterval := T#1s;
	MonitoringSettings_0[2].QueueSize := 10;

	UA_MonitoredItemAddList_0(Execute := ExecuteMonitoredItemAdd_0,
		SubscriptionHdl := SubscriptionHdl,
		NodeHdlCount := 3,
		NodeHdls := NodeHdls,
		NodeAddInfos := NodeAddInfos_0,
		Timeout := T#10s,
	Variables := Variables_0,
	MonitoringSettings := MonitoringSettings_0,
	ValuesChanged := ValuesChanged,
	RemainingValueCount := RemainingValueCount,
	TimeStamps := TimeStamps,
	NodeQualityIDs := NodeQualityIDs);
	IF (UA_MonitoredItemAddList_0.Busy = 0) THEN
		ExecuteMonitoredItemAdd_0 := 0;
		IF (UA_MonitoredItemAddList_0.Done = 1) THEN
			ErrorID := 0;
			MonitoredItemHdls := UA_MonitoredItemAddList_0.MonitoredItemHdls;
		END_IF
		IF (UA_MonitoredItemAddList_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemAddList_0.ErrorID;
			MonitoredItemHdls[0] := 0;
		END_IF
	END_IF
	
	(* UA_MonitoredItemAddList - Add Monitored Items *)
	
	UA_MonitoredItemOperateList_0(Execute := ExecuteMonitoredItemOperate_0,
		SubscriptionHdl := SubscriptionHdl,
		MonitoredItemHdlCount := 3,
		MonitoredItemHdls := MonitoredItemHdls);
	IF (UA_MonitoredItemOperateList_0.Busy = 0) THEN
		ExecuteMonitoredItemOperate_0 := 0;
		IF (UA_MonitoredItemOperateList_0.Done = 1) THEN
			ErrorID := 0;
		END_IF
		IF (UA_MonitoredItemOperateList_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemOperateList_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_MonitoredItemRemove - Remove Monitored Items *)

	UA_MonitoredItemRemoveList_0(Execute := ExecuteMonitoredItemRemove_0,
		SubscriptionHdl := SubscriptionHdl,
		MonitoredItemHdlCount := 3,
		MonitoredItemHdls := MonitoredItemHdls,
		Timeout := T#10s);
	IF (UA_MonitoredItemRemoveList_0.Busy = 0) THEN
		ExecuteMonitoredItemRemove_0 := 0;
		IF (UA_MonitoredItemRemoveList_0.Done = 1) THEN
			ErrorID := 0;
			MonitoredItemHdls[0] := 0;
		END_IF
		IF (UA_MonitoredItemRemoveList_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemRemoveList_0.ErrorID;
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
			ErrorID := 0;
			ConnectionHdl := 0;
		END_IF
		IF (UA_Disconnect_0.Error = 1) THEN 
			ErrorID := UA_Disconnect_0.ErrorID;
		END_IF
	END_IF
		
END_PROGRAM
