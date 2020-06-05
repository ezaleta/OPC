/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASOPCUAS_
#define _ASOPCUAS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <runtime.h>
#include <AsOpcUac.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef enum UaMethodOperateAction
{	UaMoa_CheckIsCalled = 0,
	UaMoa_Finished = 1
} UaMethodOperateAction;

typedef struct UaSrv_MethodOperateInternal
{	plcbit Busy;
	plcbit Execute;
	unsigned long TaskId;
	unsigned long CallId;
	unsigned short NamespaceIndex;
	unsigned char Reserved[30];
} UaSrv_MethodOperateInternal;

typedef struct UaSrv_MethodCreateInternal
{	plcbit Busy;
	plcbit Execute;
	unsigned long TaskId;
	unsigned char Reserved[32];
} UaSrv_MethodCreateInternal;

typedef struct UaSrv_MethodDeleteInternal
{	plcbit Busy;
	plcbit Execute;
	unsigned long TaskId;
	unsigned char Reserved[32];
} UaSrv_MethodDeleteInternal;

typedef struct UaSrv_MethodOperate
{
	/* VAR_INPUT (analog) */
	plcstring MethodName[256];
	enum UaMethodOperateAction Action;
	/* VAR_OUTPUT (analog) */
	plcdword ErrorID;
	/* VAR (analog) */
	struct UaSrv_MethodOperateInternal Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit IsCalled;
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} UaSrv_MethodOperate_typ;

typedef struct UaSrv_MethodCreate
{
	/* VAR_INPUT (analog) */
	plcstring MethodName[256];
	struct UAMethodArgument InputArguments[10];
	struct UAMethodArgument OutputArguments[10];
	/* VAR_OUTPUT (analog) */
	plcdword ErrorID;
	/* VAR (analog) */
	struct UaSrv_MethodCreateInternal Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} UaSrv_MethodCreate_typ;

typedef struct UaSrv_MethodDelete
{
	/* VAR_INPUT (analog) */
	plcstring MethodName[256];
	/* VAR_OUTPUT (analog) */
	plcdword ErrorID;
	/* VAR (analog) */
	struct UaSrv_MethodDeleteInternal Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} UaSrv_MethodDelete_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void UaSrv_MethodOperate(struct UaSrv_MethodOperate* inst);
_BUR_PUBLIC void UaSrv_MethodCreate(struct UaSrv_MethodCreate* inst);
_BUR_PUBLIC void UaSrv_MethodDelete(struct UaSrv_MethodDelete* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASOPCUAS_ */

