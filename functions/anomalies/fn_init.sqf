/*
	Function: anomaly_fnc_init
	Description:
        Initialises the use of anomalies in the mission, called form init.sqf!
    Parameter:
    Returns:
        nothing
	Author:
	diwako 18-5-2018
*/

if(!hasInterface || missionNamespace getVariable ["anomaly_var_init",false]) exitWith {};
missionNamespace setVariable ["anomaly_var_init",true];


enableCamShake true;
[] spawn {
	if(isNil "ANOMALIES_HOLDER") then {
		ANOMALIES_HOLDER = [];
	};
	// respawn won't work with this, need better solution than {true}
	// while {alive player} do {
	while {true} do {
		FOUND_ANOMALIES = [];
		_pos = (positionCameraToWorld [0,0,0]);
		// find trigger
		{
			_type = _x getVariable ["anomaly_type", nil];
			// only accept triggers that are anomalies
			if(!(isNil "_type") && (_pos distance _x) <= ANOMALY_IDLE_DISTANCE) then {
				FOUND_ANOMALIES pushBackUnique _x;
				_source = _x getVariable ["anomaly_particle_source", objNull];
				if(isNull _source) then {
					// create idle effect
					private _proxy = "Land_HelipadEmpty_F" createVehicleLocal position _x;
					_proxy attachTo [_x, [0,0,0]];
					_source = "#particlesource" createVehicleLocal getPos _x;
					_arr = [_proxy, _source, "idle"];
					switch (_type) do {
						case "burper": {_arr call anomalyEffect_fnc_burper;};
						case "worm": {_arr call anomalyEffect_fnc_worm;};
						case "smuggler": 		{_arr call anomalyEffect_fnc_smuggler;};
						case "farty": 	{_arr call anomalyEffect_fnc_farty;};
						case "electra": 	{
							if(!(_x getVariable ["anomaly_cooldown", false])) then {
								_arr call anomalyEffect_fnc_electra;
							} else {
								deleteVehicle _proxy;
							};
						};
						default { };
					};
					_x setVariable ["anomaly_particle_source", _proxy];
				};
			};
		} forEach ANOMALIES_HOLDER;
		// old detection, now not needed anymore
		// } forEach ( (positionCameraToWorld [0,0,0]) nearObjects ["EmptyDetector", ANOMALY_IDLE_DISTANCE]);
		_diff = ACTIVE_ANOMALIES - FOUND_ANOMALIES;
		{
			deleteVehicle (_x getVariable "anomaly_particle_source");
		} forEach _diff;
		ACTIVE_ANOMALIES = FOUND_ANOMALIES;
		sleep 5;
	};
};

// add Ares modules for zeus
if(!isNil "Ares_fnc_RegisterCustomModule") then {
	["ALIAScartoons Anomalies", "Spawn Anomaly", 
		{
			_pos = _this select 0;
			private _anomalies = ["Smuggler","Electra","Burper","Worm","Farty"];

			private _dialogResult =
			[
				"Spawn anomaly",
				[
					["Anomaly", _anomalies]
				]
			] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith {};

			_dialogResult params ["_type"];

			switch (_type) do {
				case 0: { [_pos] remoteExec ["anomaly_fnc_createSmuggler",2] };
				case 1: { [_pos] remoteExec ["anomaly_fnc_createElectra",2] };
				case 2: { [_pos] remoteExec ["anomaly_fnc_createBurper",2] };
				case 3: { [_pos] remoteExec ["anomaly_fnc_createWorm",2] };
				case 4: {
					private _dialogResult =
					[
						"Teleport ID (Number)",
						[
							["ID", "NUMBER"]
						]
					] call Ares_fnc_ShowChooseDialog;
					if (count _dialogResult == 0) exitWith {};
					_dialogResult params ["_id"];
					_id = parseNumber _id;
					[_pos,_id] remoteExec ["anomaly_fnc_createTeleport",2] 
				};
				default { };
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	["ALIAScartoons Anomalies", "Delete Anomalies", 
		{
			_pos = _this select 0;
			private _radius = ["1","5","10","100","250","500"];

			private _dialogResult =
			[
				"Delete anomalies",
				[
					["Radius", _radius]
				]
			] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith {};
			_dialogResult params ["_selected"];
			
			_radius = parseNumber (_radius select _selected);
			_trigs = _pos nearObjects ["EmptyDetector", _radius];
			[_trigs] call anomaly_fnc_deleteAnomalies;
		}
	] call Ares_fnc_RegisterCustomModule;
};
