(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsOpcUas
 * File:    AsOpcUas.typ
 * Author:  B+R
 ********************************************************************
 * Data types of library AsOpcUas
 ********************************************************************)
                                                                      
TYPE
	(* Actions for UaSrv_MethodOperate *)
	UaMethodOperateAction :
	(
    	UaMoa_CheckIsCalled 	:= 0,							(* Check if a method call is pending 	*)
	  	UaMoa_Finished         	:= 1							(* Finish method call					*)
	);
	UaSrv_MethodOperateInternal : STRUCT
		Busy					: BOOL;
		Execute					: BOOL;
		TaskId					: UDINT;
		CallId					: UDINT;
		NamespaceIndex			: UINT;
		Reserved				: ARRAY[0..29] OF USINT;
	END_STRUCT;
	UaSrv_MethodCreateInternal : STRUCT
		Busy					: BOOL;
		Execute					: BOOL;
		TaskId					: UDINT;
		Reserved				: ARRAY[0..31] OF USINT;
	END_STRUCT;
	UaSrv_MethodDeleteInternal : STRUCT
		Busy					: BOOL;
		Execute					: BOOL;
		TaskId					: UDINT;
		Reserved				: ARRAY[0..31] OF USINT;
	END_STRUCT;
END_TYPE
