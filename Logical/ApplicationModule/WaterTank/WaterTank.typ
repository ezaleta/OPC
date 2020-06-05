(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: tank
 * File: tank.typ
 * Author: mayrk
 * Created: June 18, 2015
 ********************************************************************)

TYPE
	TankCommandsType :
		STRUCT 
			Fill : BOOL;
			Empty : BOOL;
			Stop : BOOL;
		END_STRUCT;
	TankStatesType :
		STRUCT 
		Filling : BOOL;
		Emptying : BOOL;
		HighestLevel : DINT;
		FillingLevel : DINT;
	END_STRUCT;

END_TYPE
