(********************************************************************
 * COPYRIGHT -- B&R Industrial Automation
 ********************************************************************
 * PROGRAM: SrvMethod
 * File: SrvMethodCyclic.st
 * Created: Oct 13, 2016
 ********************************************************************)

PROGRAM _INIT
	Step := 0;
	VarA := 0.0;
	VarB := 0.0;
	VarResult := 0;
END_PROGRAM

PROGRAM _CYCLIC

	(* UaSrv_MethodOperate - check and execute method code *)
	
	CASE Step OF
		1: // prepare UaSrv_MethodOperate
			UaSrv_MethodOperate_0.Action  := UaMoa_CheckIsCalled; 
			UaSrv_MethodOperate_0.MethodName := 'Multiply';
			UaSrv_MethodOperate_0.Execute := TRUE;
			Step := 2;
		2: // check if method called
			UaSrv_MethodOperate_0();
			IF UaSrv_MethodOperate_0.Busy THEN
				UaSrv_MethodOperate_0.Execute := FALSE;
			ELSE
				IF UaSrv_MethodOperate_0.Done THEN
					ErrorID:= 0;
					IF UaSrv_MethodOperate_0.IsCalled THEN 		// check if method is called from OPC UA client
						Step := 3; 								// method is called
					END_IF
					UaSrv_MethodOperate_0.Execute := TRUE;
				END_IF
				IF UaSrv_MethodOperate_0.Error THEN
					ErrorID:= UaSrv_MethodOperate_0.ErrorID;
					Step := 0;
				END_IF
			END_IF
		3: // execute method code
			VarResult := VarA * VarB;  							// method code
			Step := 4;
		4: // start operate
			UaSrv_MethodOperate_0.Action  := UaMoa_Finished;	// method is finished, wait again for call
			UaSrv_MethodOperate_0.MethodName := 'Multiply';
			UaSrv_MethodOperate_0.Execute := TRUE;
			Step := 5;
		5: // finish method 
			UaSrv_MethodOperate_0();
			IF UaSrv_MethodOperate_0.Busy THEN
				UaSrv_MethodOperate_0.Execute := FALSE;
			ELSE
				IF UaSrv_MethodOperate_0.Done THEN
					ErrorID:= 0;
					Step := 1; // method is finished, wait again for call
				END_IF
				IF UaSrv_MethodOperate_0.Error THEN
					ErrorID:= UaSrv_MethodOperate_0.ErrorID;
					Step := 0;
				END_IF
			END_IF
	END_CASE;
	
	(* UaSrv_MethodCreate - create method on OPC-UA Server *)

	InputArguments[0].Name := 'x'; 
	InputArguments[0].Value := 'VarA'; 
	InputArguments[1].Name := 'y'; 
	InputArguments[1].Value := 'VarB'; 
	InputArguments[2].Name := ''; 

	OutputArguments[0].Name := 'result'; 
	OutputArguments[0].Value := 'VarResult'; 
	OutputArguments[1].Name := ''; 
	
	UaSrv_MethodCreate_0(Execute := ExecuteMethodCreate_0,
		MethodName := 'Add', 
	InputArguments := InputArguments, 
	OutputArguments := OutputArguments);
	IF (UaSrv_MethodCreate_0.Busy = 0) THEN
		ExecuteMethodCreate_0 := 0;
		IF (UaSrv_MethodCreate_0.Done = 1) THEN
			ErrorID:= 0;
		END_IF
		IF (UaSrv_MethodCreate_0.Error = 1) THEN
			ErrorID:= UaSrv_MethodCreate_0.ErrorID;
		END_IF
	END_IF

	(* UaSrv_Methoddelete - delete method *)
	
	UaSrv_MethodDelete_0(Execute := ExecuteMethodDelete_0,
		MethodName := 'Add');
	IF (UaSrv_MethodDelete_0.Busy = 0) THEN
		ExecuteMethodDelete_0 := 0;
		IF (UaSrv_MethodDelete_0.Done = 1) THEN
			ErrorID:= 0;
		END_IF
		IF (UaSrv_MethodDelete_0.Error = 1) THEN
			ErrorID:= UaSrv_MethodDelete_0.ErrorID;
		END_IF
	END_IF

		
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

