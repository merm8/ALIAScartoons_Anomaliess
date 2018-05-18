// by ALIAS
// null=[[_x,_obj_teleporter],"AL_smuggler\teleport_effect.sqf"] remoteExec ["execVM"]

fn_teleport ={
	private ["_unit","_pozitie"];
	
	_unit		= _this select 0;
	_pozitie	= _this select 1;
	if (hasInterface) then {
	["zoomin"] remoteExec ["playsound",_unit];
	[] spawn {[] execvm "AL_smuggler\video_effect.sqf"};
	_sound_in = ["halu_1","halu_2","halu_3","halu_4","halu_5","halu_6","halu_7","halu_8","halu_9","halu_91","halu_92","halu_93","halu_94","halu_95","halu_96","halu_97","halu_98","halu_99","halu_991","halu_992","halu_993","halu_994","halu_995","halu_996","halu_997","halu_998","halu_999","halu_9999"] call BIS_fnc_selectRandom;
	//hint str _sound_in;
	[_sound_in] remoteExec ["playsound",_unit];
	sleep 0.5;
	[_unit,[_pozitie select 0,_pozitie select 1,2]] remoteExec ["setPos",_unit];
	sleep (3 + random 6);
	};
};

_unit_check	= _this select 0;
_obj_tele	= _this select 1;

if (!hasInterface) exitWith {};

	cutText ["", "WHITE OUT", 1];	titleCut ["", "WHITE IN", 1];
	[] spawn {[] execvm "AL_smuggler\video_effect.sqf"};
	_dice_tele = random 6;
	_floor_dice = floor _dice_tele;
	_poz_1 = [];
	_poz_2 = [];
	_poz_3 = [];
	_poz_4 = [];
	_poz_5 = [];	
	
	switch (_floor_dice) do 
	{
    case 0: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];
			//playsound "puls";
			};
	case 1: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];
			//playsound "puls";
			};
	case 2: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_2 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			[_unit_check,_poz_2] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];			
			//playsound "puls";
			};
	case 3: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_2 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_3 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			[_unit_check,_poz_2] call fn_teleport;			
			[_unit_check,_poz_3] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];			
			//playsound "puls";
			};
	case 4: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_2 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_3 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_4 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			[_unit_check,_poz_2] call fn_teleport;			
			[_unit_check,_poz_3] call fn_teleport;		
			[_unit_check,_poz_4] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];			
			//playsound "puls";
			};
	case 5: {_poz_1 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_2 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_3 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_4 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;_poz_5 = [getpos _obj_tele,300,-1,1,0,-1,0] call BIS_fnc_findSafePos;
			[_unit_check,_poz_1] call fn_teleport;
			[_unit_check,_poz_2] call fn_teleport;			
			[_unit_check,_poz_3] call fn_teleport;		
			[_unit_check,_poz_4] call fn_teleport;			
			[_unit_check,_poz_5] call fn_teleport;
			sleep 0.1;
			_unit_check setDammage ((getDammage _unit_check) + (random 0.25));
			//["puls"] remoteExec ["playsound",_unit_check];
			//playsound "puls";
			};
	};