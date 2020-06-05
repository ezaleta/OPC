                                                                      
TYPE
	AutoIdOperationStatus :
	(
		AIOS_SUCCESS					:= 0,
		AIOS_MISC_ERROR_TOTAL			:= 1,
		AIOS_MISC_ERROR_PARTIAL			:= 2,
		AIOS_PERMISSON_ERROR			:= 3,
		AIOS_PASSWORD_ERROR				:= 4,
		AIOS_REGION_NOT_FOUND_ERROR		:= 5,
		AIOS_OP_NOT_POSSIBLE_ERROR		:= 6,
		AIOS_OUT_OF_RANGE_ERROR			:= 7,
		AIOS_NO_IDENTIFIER				:= 8,
		AIOS_MULTIPLE_IDENTIFIERS		:= 9,
		AIOS_READ_ERROR					:= 10,
		AIOS_DECODING_ERROR				:= 11,
		AIOS_MATCH_ERROR				:= 12,
		AIOS_CODE_NOT_SUPPORTED			:= 13,
		AIOS_WRITE_ERROR				:= 14,
		AIOS_NOT_SUPPORTED_BY_DEVICE	:= 15,
		AIOS_NOT_SUPPORTED_BY_TAG		:= 16,
		AIOS_DEVICE_NOT_READY			:= 17,
		AIOS_INVALID_CONFIGURATION		:= 18,
		AIOS_RF_COMMUNICATION_ERROR		:= 19,
		AIOS_DEVICE_FAULT				:= 20,
		AIOS_TAG_HAS_LOW_BATTERY		:= 21
	);
	AutoIdDeviceStatus :
	(
		AIDS_Idle						:= 0,
		AIDS_Error						:= 1,
		AIDS_Scanning					:= 2,
		AIDS_Busy						:= 3
	);
	AutoIdLocationType :
	(
		AILT_NMEA						:= 0,
		AILT_LOCAL						:= 1,
		AILT_WGS84						:= 2,
		AILT_NAME						:= 3
	);
	AutoIdRfidLockOperation :
	(
		AILO_Lock						:= 0,
		AILO_Unlock						:= 1,
		AILO_PermanentLock				:= 2,
		AILO_PermanentUnlock			:= 3
	);
	AutoIdRfidLockRegion :
	(
		AIRLR_Kill						:= 0,
		AIRLR_Access					:= 1,
		AIRLR_EPC						:= 2,
		AIRLR_TID						:= 3,
		AIRLR_User						:= 4
	);
	AutoIdRfidPasswordType :
	(
		AIRPT_Access					:= 0,
		AIRPT_Kill						:= 1,
		AIRPT_Read						:= 2,
		AIRPT_Write						:= 3
	);

	AutoIdAntennaNameIdPair		: STRUCT
		AntennaId				: UDINT;
		AntennaName				: STRING[80];
	END_STRUCT;

	AutoIdLocalCoordinate : STRUCT
		X						: LREAL;
		Y						: LREAL;
		Z						: LREAL;
		Timestamp				: DATE_AND_TIME;
		DilutionOfPrecision		: LREAL;
		UsefulPrecision			: DINT;
	END_STRUCT;

	AutoIdPosition : STRUCT
		PositionX				: DINT;
		PositionY				: DINT;
		SizeX					: DINT;
		SizeY					: DINT;
		Rotation				: DINT;
	END_STRUCT;

	AutoIdRfidSighting : STRUCT
		Antenna					: DINT;
		Strength				: DINT;
		Timestamp				: DATE_AND_TIME;
		CurrentPowerLevel		: DINT;
	END_STRUCT;

	AutoIdRotation : STRUCT
		Yaw						: LREAL;
		Pitch					: LREAL;
		Roll					: LREAL;
	END_STRUCT;

	AutoIdScanDataEpc : STRUCT
		XPC_W1Specified			: BOOL;
		XPC_W2Specified			: BOOL;
		Reserved1				: UDINT;
		PC						: UINT;
		UId						: UAByteString;
		XPC_W1					: UINT;
		XPC_W2					: UINT;
	END_STRUCT;

	AutoIdScanResult : STRUCT
		LocationSpecified		: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
	END_STRUCT;

	AutoIdOcrScanResult : STRUCT
		LocationSpecified		: BOOL;
		FontSpecified			: BOOL;
		DecodingTimeSpecified	: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
		ImageId					: UANodeID;
		Quality					: USINT;
		Position				: AutoIdPosition;
		Font					: STRING[80];
		DecodingTime			: DATE_AND_TIME;
	END_STRUCT;

	AutoIdOpticalScanResult : STRUCT
		LocationSpecified		: BOOL;
		GradeSpecified			: BOOL;
		PositionSpecified		: BOOL;
		SmybologySpecified		: BOOL;
		ImageIdSpecified		: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
		Grade					: REAL;
		Position				: AutoIdPosition;
		Symbology				: STRING[16];
		ImageId					: UANodeID;
	END_STRUCT;

	AutoIdOpticalVerifierScanResult : STRUCT
		LocationSpecified		: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
		IsoGrade				: STRING[16];
		RMin					: INT;
		SymbolContrast			: INT;
		ECMin					: INT;
		Modulation				: INT;
		Defects					: INT;
		Decodability			: INT;
		Decode_					: INT;
		PrintGain				: INT;
	END_STRUCT;

	AutoIdRfidScanResult : STRUCT
		LocationSpecified		: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
		NoOfSighting			: UANoOfElements;
		Sighting				: ARRAY[0..31] OF AutoIdRfidSighting;
	END_STRUCT;

	AutoIdRtlsLocationResult : STRUCT
		LocationSpecified		: BOOL;
		Reserved				: UDINT;
		CodeType				: STRING[80];
		ScanData				: AutoIdScanData;
		Timestamp				: DATE_AND_TIME;
		Location				: AutoIdLocation;
		Speed					: LREAL;
		Heading					: LREAL;
		Rotation				: AutoIdRotation;
		ReceiveTime				: DATE_AND_TIME;
	END_STRUCT;

	AutoIdScanSettings : STRUCT
		LocationTypeSpecified	: BOOL;
		Reserved				: UDINT;
		Duration				: LREAL;
		Cycles					: DINT;
		DataAvailable			: BOOL;
		LocationType			: AutoIdLocationType;
	END_STRUCT;

	AutoIdLocation : STRUCT
		NMEA					: STRING[82];
		Local					: AutoIdLocalCoordinate;
		WGS84					: AutoIdWGS84Coordinate;
		LocationName			: STRING[80];
	END_STRUCT;

	AutoIdScanData : STRUCT
		SwitchField				: UDINT;
		ByteString				: UAByteString;
		String					: STRING[1024];
		Epc						: AutoIdScanDataEpc;
		Custom					: UAVariantData;
	END_STRUCT;

	AutoIdWGS84Coordinate : STRUCT
		N_S_Hemisphere			: STRING[1];
		Latitute				: LREAL;
		E_W_Hemisphere			: STRING[1];
		Longitude				: LREAL;
		Altitude				: LREAL;
		Timestamp				: DATE_AND_TIME;
		DilutionOfPrecision		: LREAL;
		UsefulPrecisionLatLon	: DINT;
		UsefulPrecisionAlt		: DINT;
	END_STRUCT;

END_TYPE
