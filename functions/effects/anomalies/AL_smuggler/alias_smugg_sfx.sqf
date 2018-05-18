// by ALIAS

fnc_effecte_princ_smug = {
private ["_obj_princ_effect","_bule_smugg","_fct_lit","_dust_smug","_sursa_princ_center","_brit_burp","_b_col_burp","_g_col_burp","_r_col_burp","_sp_dist_smug","_spot_lit"];
_obj_princ_effect 	= _this select 0;
_sursa_princ_center	= _this select 1;

	waitUntil {!isNil{player getVariable "has_detector_smug"}};
//	while {(player distance _obj_princ_effect > 1000)} do {sleep 3};
	while {!check_pass_smug} do {sleep 3};
	
	_obj_princ_effect hideObject false; _sursa_princ_center hideObject false;
	
	[_obj_princ_effect] spawn {
		_obj_princ_voice = _this select 0;
		while {player distance _obj_princ_voice <1000} do {
		_obj_princ_voice say3D ["smugg_03", 500];
		sleep 13;
		};
	};

	[_obj_princ_effect,_sursa_princ_center] spawn 
	{
	_obj_princ_sfx = _this select 0;
	_obj_center_sfx = _this select 0;
	
	_bule_smugg = "#particlesource" createVehicleLocal (getPosATL _obj_princ_sfx);
	_bule_smugg setParticleCircle [0, [0, 0, 0]];
	_bule_smugg setParticleRandom [0.3, [0.9,0.9,0.9], [0,0,0], 0, 0.25, [0, 0, 0, 1], 1, 0];
	_bule_smugg setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 0.3, [0, 0, 0], [0, 0, -0.3], 17, 10, 7.9, 0.001, [0.8,0.5,0.5], [[0,0,0,0],[0,0,0,1],[0,0,0,0]], [0.08], 1, 0, "", "", _obj_princ_sfx];
	_bule_smugg setDropInterval 0.002;

	_sp_dist_smug = "#particlesource" createVehicleLocal (getPosATL _obj_center_sfx);
	_sp_dist_smug setParticleCircle [0, [0, 0, 0]];
	_sp_dist_smug setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
	_sp_dist_smug setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0], 7, 10, 7.9, 0.007, [3,0.1,3], [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _obj_center_sfx];
	_sp_dist_smug setDropInterval 0.5;	

	_dust_smug = "#particlesource" createVehicleLocal (getPosATL _obj_princ_sfx);
	_dust_smug setParticleCircle [0, [0, 0, 0]];
	_dust_smug setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
	_dust_smug setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0], 15, 10, 7.9, 0.001, [15, 5, 0.1], [[1, 1, 1, 0], [1, 1, 1, 0.05], [0, 0, 0, 0.01]], [0.08], 1, 0, "", "", _obj_princ_sfx];
	_dust_smug setDropInterval 2;
	
	waitUntil {!check_pass_smug or (player distance _obj_princ_sfx > 1000)};
	deleteVehicle _bule_smugg; deleteVehicle _dust_smug; deleteVehicle _sp_dist_smug;
	_obj_princ_sfx hideObject true; _obj_center_sfx hideObject true;
	};

	if (sunOrMoon==0) then 
	{
	[_sursa_princ_center] spawn 
	{
	_obj_lit = _this select 0;
		_spot_lit = "#lightpoint" createVehicle (getPosATL _obj_lit); 
		_spot_lit lightAttachObject [_obj_lit, [random 1,random 1,1]];
		_spot_lit setLightUseFlare false;
		_spot_lit setLightFlareSize 1;
		_spot_lit setLightFlareMaxDistance 1500;
		_spot_lit setLightAttenuation [0,0,50,1000,1,50];
		_spot_lit setLightDayLight true;	
	
		while {(sunOrMoon==0) and (player distance _obj_lit < 1000) and check_pass_smug} do 
		{
		_fct_lit = [1,-1] call BIS_fnc_selectRandom;
		sleep 0.2+ random 1;
		_spot_lit lightAttachObject [_obj_lit, [random _fct_lit,random _fct_lit,1]];
		_r_col_burp=random 1;
		_g_col_burp=random 1;
		_b_col_burp=random 1;
		_brit_burp =10+random 30;
		_spot_lit setLightColor [_r_col_burp,_g_col_burp,_b_col_burp];
		_spot_lit setLightAmbient [_g_col_burp,_r_col_burp,_b_col_burp];
		_spot_lit setLightBrightness _brit_burp;
		sleep 0.3+ random 1;
		_spot_lit setLightBrightness 0;
		};
		detach _spot_lit; deleteVehicle _spot_lit
	};
	};
	waitUntil {player distance _obj_princ_effect > 1000 or !check_pass_smug};
	_obj_princ_effect hideObject true; _sursa_princ_center hideObject true;
};

fnc_sec_effect_smug = {
private ["_obj_sec_effect","_suck_frunze","_suck_dust","_obj_sec_center","_rafala_smug"];
_obj_sec_effect = _this select 0;
_obj_sec_center = _this select 1;

	_rafala_smug = ["rafala_smug_01","rafala_smug_02","rafala_smug_03"] call BIS_fnc_selectRandom;
	_obj_sec_center say3D [_rafala_smug, 500];

	_suck_frunze = "#particlesource" createVehicleLocal (getPosATL _obj_sec_effect);
	_suck_frunze setParticleCircle [5, [0,0,0]];
	_suck_frunze setParticleRandom [1, [6, 6, 0], [-7, -7, 0], 0.25, 1, [0, 0, 0, 1], 1, 0];
	_suck_frunze setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Leaves_Green.p3d", 1, 0, 1], "", "SpaceObject", 1, 1, [0, 0, 0], [0, 0, 1], 0, 12, 7.9, 0.0001, [2, 2, 2], [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _obj_sec_effect];
	_suck_frunze setDropInterval 0.01;

	_suck_dust = "#particlesource" createVehicleLocal (getPosATL _obj_sec_effect);
	_suck_dust setParticleCircle [6, [-3, -3, 0]];
	_suck_dust setParticleRandom [1, [2, 2, 0], [-7, -7, 0], 3, 1, [0, 0, 0, 1], 1, 1];
	_suck_dust setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, 0, 0.1], 0, 10, 7.9, 0.075, [1, 3, 5], [[0.3, 0.27, 0.15, 0.1], [0.3, 0.27, 0.15, 0.01], [0.3, 0.27, 0.15, 0]], [0.08], 1, 0, "", "", _obj_sec_effect];
	_suck_dust setDropInterval 0.01;
	sleep 2;
	deleteVehicle _suck_frunze;
	deleteVehicle _suck_dust;
};

fnc_check_detector_smug = {
if ((headgear _this  == detect_smug)or(goggles _this ==detect_smug)or(uniform _this ==detect_smug)or(vest _this ==detect_smug)or(Backpack _this ==detect_smug) or (detect_smug in (assigneditems _this  + items _this ))) then 
{_this setVariable ["has_detector_smug", true, true]} else {_this setVariable ["has_detector_smug", false, true]};
};

fnc_effecte_princ_smug_simplu = {
private ["_obj_princ_effect","_bule_smugg","_fct_lit","_dust_smug","_sursa_princ_center","_brit_burp","_b_col_burp","_g_col_burp","_r_col_burp","_sp_dist_smug","_spot_lit"];
_obj_princ_effect 	= _this select 0;
_sursa_princ_center	= _this select 1;

	[_obj_princ_effect] spawn {
		_obj_princ_voice = _this select 0;
		while {player distance _obj_princ_voice <1000} do {
		_obj_princ_voice say3D ["smugg_03", 500];
		sleep 13;
		};
	};

	[_obj_princ_effect,_sursa_princ_center] spawn 
	{
	_obj_princ_sfx = _this select 0;
	_obj_center_sfx = _this select 0;
	
	_bule_smugg = "#particlesource" createVehicleLocal (getPosATL _obj_princ_sfx);
	_bule_smugg setParticleCircle [0, [0, 0, 0]];
	_bule_smugg setParticleRandom [0.3, [0.9,0.9,0.9], [0,0,0], 0, 0.25, [0, 0, 0, 1], 1, 0];
	_bule_smugg setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 0.3, [0, 0, 0], [0, 0, -0.3], 17, 10, 7.9, 0.001, [0.8,0.5,0.5], [[0,0,0,0],[0,0,0,1],[0,0,0,0]], [0.08], 1, 0, "", "", _obj_princ_sfx];
	_bule_smugg setDropInterval 0.002;

	_sp_dist_smug = "#particlesource" createVehicleLocal (getPosATL _obj_center_sfx);
	_sp_dist_smug setParticleCircle [0, [0, 0, 0]];
	_sp_dist_smug setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
	_sp_dist_smug setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0], 7, 10, 7.9, 0.007, [3,0.1,3], [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _obj_center_sfx];
	_sp_dist_smug setDropInterval 0.5;	

	_dust_smug = "#particlesource" createVehicleLocal (getPosATL _obj_princ_sfx);
	_dust_smug setParticleCircle [0, [0, 0, 0]];
	_dust_smug setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
	_dust_smug setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0], 15, 10, 7.9, 0.001, [15, 5, 0.1], [[1, 1, 1, 0], [1, 1, 1, 0.05], [0, 0, 0, 0.01]], [0.08], 1, 0, "", "", _obj_princ_sfx];
	_dust_smug setDropInterval 2;
	
	//waitUntil {player distance _obj_princ_sfx > 1000};
	while {(player distance _obj_princ_sfx < 1000)} do {sleep 3};
	deleteVehicle _bule_smugg; deleteVehicle _dust_smug; deleteVehicle _sp_dist_smug;
	};

	if (sunOrMoon==0) then 
	{
	[_sursa_princ_center] spawn 
	{
	_obj_lit = _this select 0;
		_spot_lit = "#lightpoint" createVehicle (getPosATL _obj_lit); 
		_spot_lit lightAttachObject [_obj_lit, [random 1,random 1,1]];
		_spot_lit setLightUseFlare false;
		_spot_lit setLightFlareSize 1;
		_spot_lit setLightFlareMaxDistance 1500;
		_spot_lit setLightAttenuation [0,0,50,1000,1,50];
		_spot_lit setLightDayLight true;	
	
		while {(sunOrMoon==0) and (player distance _obj_lit < 1000)} do 
		{
		_fct_lit = [1,-1] call BIS_fnc_selectRandom;
		sleep 0.2+ random 1;
		_spot_lit lightAttachObject [_obj_lit, [random _fct_lit,random _fct_lit,1]];
		_r_col_burp=random 1;
		_g_col_burp=random 1;
		_b_col_burp=random 1;
		_brit_burp =10+random 30;
		_spot_lit setLightColor [_r_col_burp,_g_col_burp,_b_col_burp];
		_spot_lit setLightAmbient [_g_col_burp,_r_col_burp,_b_col_burp];
		_spot_lit setLightBrightness _brit_burp;
		sleep 0.3+ random 1;
		_spot_lit setLightBrightness 0;
		};
		detach _spot_lit; deleteVehicle _spot_lit
	};
	};
};

if (!hasInterface) exitwith {};

_obj_sursa_smugg = _this select 0;
_sursa_core		 = _this select 1;

if (detect_smug!="") then 
{
	[_obj_sursa_smugg] spawn {
		_check_player_det_smug = _this select 0;
		
		while {alive _check_player_det_smug} do 
		{
			//waitUntil {(player distance _check_player_det_smug)<1000};
			while {(player distance _check_player_det_smug)>1000} do {sleep 3};
			player call fnc_check_detector_smug;
			check_pass_smug = player getVariable "has_detector_smug";
			sleep 3;// hint str check_pass_smug;
		};
	};
	
	[_obj_sursa_smugg,_sursa_core] spawn 
	{
	_obj_sursa_sfx_sec = _this select 0;
	_obj_core_sfx_sec = _this select 1;
		while {player distance _obj_sursa_sfx_sec < 1000} do 
		{
			[_obj_sursa_sfx_sec,_obj_core_sfx_sec] call fnc_sec_effect_smug; 
			sleep (4+ random 4)
		};
	};
	
	waitUntil {!isNil{player getVariable "has_detector_smug"}};
	
	while {!isnull _obj_sursa_smugg} do
	{
		_obj_sursa_smugg hideObject true; _sursa_core hideObject true;
		while {player distance _obj_sursa_smugg > 1000} do {sleep 3};
		[_obj_sursa_smugg,_sursa_core] call fnc_effecte_princ_smug;
	};

} else 
{
	while {!isnull _obj_sursa_smugg} do 
	{
	_obj_sursa_smugg hideObject true; _sursa_core hideObject true;
	while {player distance _obj_sursa_smugg > 1000} do {sleep 3};
	_obj_sursa_smugg hideObject false; _sursa_core hideObject false;
	[_obj_sursa_smugg,_sursa_core] call fnc_effecte_princ_smug_simplu;
	while {player distance _obj_sursa_smugg < 1000} do {[_obj_sursa_smugg,_sursa_core] call fnc_sec_effect_smug; sleep (4+ random 4)};
	};
};