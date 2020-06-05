(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: Client03b
 * File: Client03b.typ
 * Created: July 03, 2014
 ********************************************************************)

TYPE
	UaAccessRightType : 	STRUCT 
		Name : STRING[16];
		Allow : BOOL;
		Reserved : BOOL;
	END_STRUCT;
	UaRoleAccessType : 	STRUCT 
		Name : STRING[32];
		Length : UANoOfElements;
		Rights : ARRAY[0..8]OF UaAccessRightType;
	END_STRUCT;
	UaNodeAccessType : 	STRUCT 
		Length : UANoOfElements;
		Roles : ARRAY[0..4]OF UaRoleAccessType;
	END_STRUCT;
	UaAuthorizationType : 	STRUCT 
		NodeId : UANodeID;
		Inherit : BOOL;
		Length : UANoOfElements;
		Nodes : ARRAY[0..1]OF UaNodeAccessType;
	END_STRUCT;
	AuthorizationArray : 	STRUCT 
		Length : UAArrayLength;
		Value : ARRAY[0..4]OF UaAuthorizationType;
	END_STRUCT;
	NodeIdArray : 	STRUCT 
		Length : UAArrayLength;
		Value : ARRAY[0..4]OF UANodeID;
	END_STRUCT;
	NodeIdStatusArray : 	STRUCT 
		Length : UAArrayLength;
		Value : ARRAY[0..4]OF UDINT;
	END_STRUCT;
	AuthorizationsStatusArray : 	STRUCT 
		Length : UAArrayLength;
		Value : ARRAY[0..4]OF UDINT;
	END_STRUCT;
END_TYPE
