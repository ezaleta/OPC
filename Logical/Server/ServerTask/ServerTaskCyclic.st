(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: ServerTask
 * File: ServerTaskCyclic.st
 * Created: August 07, 2014
 ********************************************************************
 * Implementation of program ServerTask
 ********************************************************************)

PROGRAM _INIT

	VarArr[0] := 0;
	Enum1 := Green;
	TestStructA.a := 0;
	   
END_PROGRAM
                  

PROGRAM _CYCLIC

	VarX := VarX + 1;
	VarY := VarY + 1;
	VarZ := VarZ + 1;
	
	VarArr[0] := VarArr[0] +1;
	VarArr[1] := VarArr[1] +2;
	VarArr[2] := VarArr[2] +3;

	TestStructA.a := 	TestStructA.a + 1;

END_PROGRAM
