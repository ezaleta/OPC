(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * Program: tank
 * File: tank.st
 * Author: mayrk
 * Created: June 18, 2015
 ********************************************************************)

PROGRAM _INIT
	TankStates.FillingLevel := 0;
	TankStates.HighestLevel := 100;
	TankCommands.Fill := TRUE;
END_PROGRAM


PROGRAM _CYCLIC

	IF TankCommands.Stop = FALSE THEN
		IF TankCommands.Fill THEN
			TankStates.FillingLevel := TankStates.FillingLevel + 1;
			TankStates.Filling := TRUE;
			TankStates.Emptying := FALSE;
		END_IF;
		IF TankCommands.Empty THEN
			TankStates.FillingLevel := TankStates.FillingLevel - 1;
			TankStates.Filling := FALSE;
			TankStates.Emptying := TRUE;
		END_IF;
	END_IF;
	
	IF TankStates.FillingLevel > TankStates.HighestLevel THEN
		TankStates.FillingLevel := TankStates.HighestLevel;
		TankCommands.Fill := FALSE;
		TankCommands.Empty := TRUE;
	END_IF;
	IF TankStates.FillingLevel < 0 THEN
		TankStates.FillingLevel := 0;
		TankCommands.Fill := TRUE;
		TankCommands.Empty := FALSE;
	END_IF;
	
END_PROGRAM
