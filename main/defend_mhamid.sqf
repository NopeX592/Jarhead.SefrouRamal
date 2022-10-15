_run_1 = true;
_run_2 = true;
task_4_1_skip = false;
task_4_1_qrf = true;
task_4_1_fin = true;
task_4_1_qrf_spawned = false;
publicVariable "task_4_1_skip";
publicVariable "task_4_1_qrf";
publicVariable "task_4_1_fin";
publicVariable "task_4_1_qrf_spawned";

task_4_1 = player createSimpleTask ["Defend the town of Mhamid"];
	task_4_1 setSimpleTaskDescription ["Defend the town of Mhamid.","Defend the town of Mhamid",""];
	task_4_1 setSimpleTaskDestination (getMarkerPos "defend_Mhamid");
	task_4_1 setSimpleTaskType "defend";
	task_4_1 setTaskState "Assigned";
	["TaskAssigned",["","Defend the town of Mhamid"]] call BIS_fnc_showNotification;

_marker_defend_mhamid = createMarker ["Dropoff POI", getMarkerPos "defend_area_marker"];
	_marker_defend_mhamid setMarkerShape "ELLIPSE";
	_marker_defend_mhamid setMarkerSize [2000, 1350];
	_marker_defend_mhamid setMarkerDir 23.618;
	_marker_defend_mhamid setMarkerAlpha 0.5;

//Get initial units
while {_run_2} do {
	if ((task_4_1_qrf_spawned) || (task_4_1_skip)) then {
		initial_unitsNumber = { !(isPlayer _x) and { (side _x) == independent } and { _x inArea _marker_defend_mhamid } } count allUnits;
		initial_unitsNumber = initial_unitsNumber * 0.2;
		publicVariable "initial_unitsNumber";
		_run_2 = false;
	};
};

while {_run_1} do {
	if ((task_4_1_qrf_spawned) || (task_4_1_skip)) then {
		curr_unitsNumber = { !(isPlayer _x) and { (side _x) == independent } and { _x inArea _marker_defend_mhamid } } count allUnits;
		publicVariable "curr_unitsNumber";

		if ((curr_unitsNumber <= initial_unitsNumber) || (task_4_1_skip)) then {
			task_4_1 setTaskState "Succeeded";
			["TaskSucceeded",["","Defend the town of Mhamid"]] call BIS_fnc_showNotification;
			_run_1 = false;
			if (task_2_1_fin) then {
				[] execVM "main\pickup_POI.sqf";
			} else {
				if (task_3_1_fin) then {
					[] execVM "main\support_EOD.sqf";
				};
			};
			task_2_1_fin = false;
			task_3_1_fin = false;
			task_4_1_skip = true;
			publicVariable "task_2_1_fin";
			publicVariable "task_3_1_fin";
			publicVariable "task_4_1_skip";
		};
	};
};