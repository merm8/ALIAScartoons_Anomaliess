/*
	Function: anomaly_fnc_createSmuggler
	Description:
        Creates an anomaly of the type "Smuggler"
    Parameter:
        _pos - Position where the anomaly should be (default: [0,0,0]])
    Returns:
        Anomaly Trigger
	Author:
	merm8 18-5-2018
*/
params[["_pos",[0,0,0]]];

if(!isServer) exitWith {};
if(count _pos < 3) then {
	_pos set [2,0];
};
_trg = createTrigger ["EmptyDetector", _pos];
_trg setPosATL _pos;
_trg setVariable ["anomaly_cooldown", false, true];
_trg setVariable ["anomaly_type", "smuggler", true];
private _proxy = "Land_HelipadEmpty_F" createVehicle position _trg;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg, [0, 0, 0.5]];
_trg setVariable ["anomaly_sound", _proxy, true];
[_trg, [4, 4, 0, false,4]] remoteExec ["setTriggerArea",0,_trg];
[_trg, ["ANY", "PRESENT", true]] remoteExec ["setTriggerActivation",0,_trg];
[_trg, ["this and !(thisTrigger getVariable ['anomaly_cooldown',false])", "[thisTrigger,thisList] spawn anomaly_fnc_activateSmuggler", ""]] remoteExec ["setTriggerStatements",0,_trg];

if(isNil "ANOMALIES_HOLDER") then {
	ANOMALIES_HOLDER = [];
};

ANOMALIES_HOLDER pushBackUnique _trg;
publicVariable "ANOMALIES_HOLDER";

// set up idle sound speaker;
_trg2 = createTrigger ["EmptyDetector", _pos];
_trg2 setPosATL _pos;
_trg setVariable ["anomaly_idle_sound", _trg2, true];
_proxy = "Land_HelipadEmpty_F" createVehicle position _trg2;
_proxy enableSimulationGlobal false;
_proxy attachTo [_trg2, [0, 0, 0.5]];
_trg2 setVariable ["anomaly_idle_sound", _proxy, true];
[_trg2, [25, 25, 0, false, 2]] remoteExec ["setTriggerArea",0,_trg];
[_trg2, ["ANY", "PRESENT", true]] remoteExec ["setTriggerActivation",0,_trg];
// the random interval is there to no have two sounds play at the very same time
[_trg2, ["this && {([] call CBA_fnc_currentUnit) in thisList}", "[thisTrigger] spawn {params['_thisTrigger']; sleep random 5; while{!isNull _thisTrigger && {triggerActivated _thisTrigger}} do {(_thisTrigger getVariable 'anomaly_idle_sound') say3D 'fire_idle'; sleep 8.272060}}", ""]] remoteExec ["setTriggerStatements",0,_trg];

if(!isNil "ANOMALY_DEBUG" && {ANOMALY_DEBUG}) then {
	_marker = createMarkerLocal [str(_pos),_pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "hd_dot";
	_marker setMarkerTextLocal (_trg getVariable "anomaly_type");
};

_trg
