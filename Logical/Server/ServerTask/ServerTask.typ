(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: ServerTask
 * File: ServerTask.typ
 * Created: August 07, 2014
 ********************************************************************
 * Local data types of program ServerTask
 ********************************************************************)

TYPE
	EnumTyp1 : 
		(
		Red := 0,
		Green := 1,
		Blue := 2
		);

	TestStructA_Typ : 	STRUCT 
		a : INT;
		b : REAL;
		c : STRING[80];
	END_STRUCT;

END_TYPE

