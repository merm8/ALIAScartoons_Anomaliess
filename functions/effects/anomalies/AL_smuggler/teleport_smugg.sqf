// by ALIAS

if (!isserver) exitWith {};
_obj_teleporter = _this select 0;
_list_teleport=[];
_list_vek_teleport=[];

while {alive _obj_teleporter} do 
{

_list_teleport = (position _obj_teleporter) nearEntities ["Man",15];

if (protection_smug !="") then {
if (count _list_teleport>0) then {
{
	if ((headgear _x == protection_smug)or(goggles _x==protection_smug)or(uniform _x==protection_smug)or(vest _x==protection_smug)or(Backpack _x==protection_smug) or (protection_smug in (assigneditems _x + items _x))) then {/*hint "protejat"*/} 
	else {
		_fresh_spawn = _x getVariable "teleported_in";
		if (isNil "_fresh_spawn") then 
		{
			[_obj_teleporter,["tele_message",100]] remoteExec ["say3d"];
			_x hideObjectGlobal true;
			sleep 0.2;
			_x hideObjectGlobal false;
			sleep 0.2;
			_x hideObjectGlobal true;
			sleep 0.1;
			_x hideObjectGlobal false;
			sleep 0.2;
			_x hideObjectGlobal true;
			sleep 0.2;
			_x hideObjectGlobal false;
			if (local _x) then 
				{
					_dest_tele = [getpos _obj_teleporter,300,-1,1,0,-1,0] call BIS_fnc_findSafePos; 
					_x setPos _dest_tele;
					_x setDammage ((getDammage _x) + (random 0.25));
				};
			if ((!local _x)or(_x==player)) then {null=[[_x,_obj_teleporter],"AL_smuggler\teleport_effect.sqf"] remoteExec ["execVM",_x]};
		};
	};		
} foreach _list_teleport;
};
}else{
	{
		_fresh_spawn = _x getVariable "teleported_in";
		if (isNil "_fresh_spawn") then 
		{
			[_obj_teleporter,["tele_message",100]] remoteExec ["say3d"];
			_x hideObjectGlobal true;
			sleep 0.2;
			_x hideObjectGlobal false;
			sleep 0.2;
			_x hideObjectGlobal true;
			sleep 0.1;
			_x hideObjectGlobal false;
			sleep 0.2;
			_x hideObjectGlobal true;
			sleep 0.2;
			_x hideObjectGlobal false;
			if (local _x) then 
				{
					_dest_tele = [getpos _obj_teleporter,300,-1,1,0,-1,0] call BIS_fnc_findSafePos; 
					_x setPos _dest_tele;
					_x setDammage ((getDammage _x) + (random 0.25));
				};
			if ((!local _x)or(_x==player)) then {null=[[_x,_obj_teleporter],"AL_smuggler\teleport_effect.sqf"] remoteExec ["execVM",_x]};
		};		
	} foreach _list_teleport;
};

_list_vek_teleport = (position _obj_teleporter) nearEntities ["LandVehicle",12];

if (count _list_vek_teleport>0) then {
{
	_fresh_spawn = _x getVariable "teleported_in";
	if (isNil "_fresh_spawn") then 
	{
		[_obj_teleporter,["tele_message",100]] remoteExec ["say3d"];
		_x hideObjectGlobal true;
		sleep 0.2;
		_x hideObjectGlobal false;
		sleep 0.2;
		_x hideObjectGlobal true;
		sleep 0.1;
		_x hideObjectGlobal false;
		sleep 0.2;
		_x hideObjectGlobal true;
		sleep 0.2;
		_x hideObjectGlobal false;
		if (local _x) then 
		{
			_dest_tele = [getpos _obj_teleporter,300,-1,1,0,-1,0] call BIS_fnc_findSafePos; 
			_x setPos _dest_tele;
			_x setDammage ((getDammage _x) + (random 0.25));
		};
	};
} foreach _list_vek_teleport;

_list_vek_teleport = [];
_list_teleport=[];
};
sleep 2;
};