private ["_spawn_obj_class","_object_anom_core","_gigi","_spawn_obj","_spawn_obj_classname"];

_spawn_obj_class = _this select 0;
_object_anom_core = _this select 1;

while {!isNull _object_anom_core} do 
{
_spawn_obj_classname= _spawn_obj_class call BIS_fnc_selectRandom;
	if (_spawn_obj_classname isKindOf "MAN") then {
	_grp_side = [EAST, WEST, CIVILIAN, INDEPENDENT] call BIS_fnc_selectRandom;
	_grp = createGroup _grp_side;
	_bounce_obj_temp = createVehicle ["Land_CanOpener_F",getposATL _object_anom_core,[],0,"CAN_COLLIDE"];
	[_bounce_obj_temp] remoteExec ["hideObject",-2];
	_tipat=["strigat_1","strigat_2","strigat_3","strigat_4","strigat_5","strigat_6","strigat_7","strigat_8","strigat_9","strigat_91","strigat_92"] call BIS_fnc_selectRandom;
	// sunet teleport in
	_telep_in = ["telep_01","telep_02","telep_03","telep_04","telep_05"] call BIS_fnc_selectRandom;
	[_object_anom_core ,[_telep_in,300]] remoteExec ["say3d",0];
	_gigi= _grp createUnit [_spawn_obj_classname,getposATL _object_anom_core, [], 0,"FORM"];
	_gigi setVariable ["teleported_in", 1, true];
	_gigi attachTo [_bounce_obj_temp,[0,0,1]];
	_bounce_obj_temp setVelocity [[-4,4]call BIS_fnc_selectRandom,[-4,4]call BIS_fnc_selectRandom,2];
	["tremor"] remoteExec ["playsound"];
	sleep 0.8;
	[_gigi,[_tipat,100]] remoteExec ["say3d",0];
	detach _gigi;
	deleteVehicle _bounce_obj_temp;
	sleep 0.5;
	_gigi setPosATL [getposATL _gigi select 0,getposATL _gigi select 1,0.0001];
//	_anim = ["ApanPercMstpSnonWnonDnon_ApanPpneMstpSnonWnonDnon","ApanPknlMrunSnonWnonDb","ApanPknlMrunSnonWnonDf","ApanPercMrunSnonWnonDf","ApanPercMsprSnonWnonDfr"] call BIS_fnc_selectRandom;
//	_gigi switchMove _anim;
	_run_poz = [getposATL _object_anom_core,100+random 500, random 360] call BIS_fnc_relPos;
	sleep 3;
//	_gigi switchMove "";
	_gigi setDamage (getdammage _gigi + (random 0.15));
	_gigi doMove _run_poz;
	sleep 30+ random spawn_delay_smugg; // delay between spawns
//	sleep 7;
	_gigi setVariable ["teleported_in", nil,true];
	} else {
	_bounce_obj_temp = createVehicle ["Land_CanOpener_F",getposATL _object_anom_core,[],0,"CAN_COLLIDE"];
	[_bounce_obj_temp] remoteExec ["hideObject",-2];
	// sunet teleport in
	_telep_in = ["telep_01","telep_02","telep_03","telep_04","telep_05"] call BIS_fnc_selectRandom;
	[_object_anom_core ,[_telep_in,300]] remoteExec ["say3d",0];	
	_spawn_obj = createVehicle [_spawn_obj_classname, [getposATL _object_anom_core select 0,getposATL _object_anom_core select 1,1], [], 0, "NONE"];
	_spawn_obj attachTo [_bounce_obj_temp,[0,0,0]];
	_bounce_obj_temp setVelocity [[-1,1]call BIS_fnc_selectRandom,[-1,1]call BIS_fnc_selectRandom, 10];
	_impact =["bodyfall_wood_3","bodyfall_wood_1","bodyfall_wood_2","bodyfall_metal_3"] call BIS_fnc_selectRandom;
	//_spawn_obj say3D [_impact,100];	
	["tremor"] remoteExec ["playsound"];
	waitUntil {(getPosATL _spawn_obj select 2) < 0.3};
	detach _spawn_obj;
	[_spawn_obj,[_impact,100]] remoteExec ["say3d",0];
	_spawn_obj setPosATL [getposATL _spawn_obj select 0,getposATL _spawn_obj select 1,0.0001];
	//sleep 0.5;
	deleteVehicle _bounce_obj_temp;
//	sleep 2;
	sleep 30+ random spawn_delay_smugg; // delay between spawns
	if ((_spawn_obj distance _object_anom_core < 10) and (local _spawn_obj)) then {deleteVehicle _spawn_obj};
	};
};