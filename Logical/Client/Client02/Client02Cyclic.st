(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: Client02
 * File: Client02Cyclic.st
 * Created: July 03, 2014
 ********************************************************************)

PROGRAM _INIT
	VarA := 0;
	MonitoringSettingsOperate_0.SamplingInterval := T#5s;
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
	
	(* UA_NodeGetHandle - get a handle for required node *)

	NodeID_0.NamespaceIndex := NamespaceIndex;
	NodeID_0.Identifier := '::ServerTask:VarX';
	NodeID_0.IdentifierType := UAIdentifierType_String;

	UA_NodeGetHandle_0(Execute := ExecuteNodeGetHandle_0,
		ConnectionHdl := ConnectionHdl,
		NodeID := NodeID_0,
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

	(* UA_MonitoredItemAdd - Add Monitored Items *)

	NodeAddInfo_0.AttributeId := UAAI_Value;
	NodeAddInfo_0.IndexRangeCount := 0;
	Variable_0 := '::Client02:VarA';
	MonitoringSettings_0.SamplingInterval := T#1s;

	UA_MonitoredItemAdd_0(Execute := ExecuteMonitoredItemAdd_0,
		SubscriptionHdl := SubscriptionHdl,
		NodeHdl := NodeHdl,
		NodeAddInfo := NodeAddInfo_0,
		Timeout := T#10s,
		Variable := Variable_0,
		MonitoringSettings := MonitoringSettings_0);
	IF (UA_MonitoredItemAdd_0.Busy = 0) THEN
		ExecuteMonitoredItemAdd_0 := 0;
		IF (UA_MonitoredItemAdd_0.Done = 1) THEN
			ErrorID := 0;
			MonitoredItemHdl := UA_MonitoredItemAdd_0.MonitoredItemHdl;
		END_IF
		IF (UA_MonitoredItemAdd_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemAdd_0.ErrorID;
			MonitoredItemHdl := 0;
		END_IF
	END_IF
	
	(* UA_MonitoredItemOperate -  Change Monitored Items *)

	UA_MonitoredItemOperate_0(Execute := ExecuteMonitoredItemOperate_0,
		MonitoredItemHdl := MonitoredItemHdl,
		Timeout := T#10s,
		MonitoringSettings := MonitoringSettingsOperate_0);
	IF (UA_MonitoredItemOperate_0.Busy = 0) THEN
		ExecuteMonitoredItemOperate_0 := 0;
		IF (UA_MonitoredItemOperate_0.Done = 1) THEN
			ValueChanged := UA_MonitoredItemOperate_0.ValueChanged;
			TimeStamp := UA_MonitoredItemOperate_0.TimeStamp;
			ErrorID := 0;
		END_IF
		IF (UA_MonitoredItemOperate_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemOperate_0.ErrorID;
		END_IF
	END_IF
	
	(* UA_MonitoredItemRemove - Remove Monitored Items *)

	UA_MonitoredItemRemove_0(Execute := ExecuteMonitoredItemRemove_0,
		MonitoredItemHdl := MonitoredItemHdl,
		Timeout := T#10s);
	IF (UA_MonitoredItemRemove_0.Busy = 0) THEN
		ExecuteMonitoredItemRemove_0 := 0;
		IF (UA_MonitoredItemRemove_0.Done = 1) THEN
			ErrorID := 0;
			MonitoredItemHdl := 0;
		END_IF
		IF (UA_MonitoredItemRemove_0.Error = 1) THEN
			ErrorID := UA_MonitoredItemRemove_0.ErrorID;
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
