/*
#	File:     fn_insertLog.sqf
#	Author:   Martinezzz
#	Github:   https://github.com/MartinezDeveloper
#	Discord:  MartineZ#5762
#
#	Paramiters:
#	TYPE    = STRING
#	MESSAGE = STRING
#
#	Example:
#	["RPT", format ["%1 has killed %2", _caller, _killer]] remoteExecCall ["ServerName_fnc_insertLog", 2];
#	["Database", format ["%1 has killed %2", _caller, _killer]] remoteExecCall ["ServerName_fnc_insertLog", 2];
#	["Both", format ["%1 has killed %2", _caller, _killer]] remoteExecCall ["ServerName_fnc_insertLog", 2];
*/

params [
	[ "_type", "", [""] ],
	[ "_message", "", [""] ]
];

switch (_type) do {
	case "RPT": {
		diag_log "-";
		diag_log format ["[SERVER LOGGING SYSTEM] %1", _message];
		diag_log "-";
	};

	case "Database": {
		_query = format ["INSERT INTO Server_Logging (message) VALUES ('%1')",
			[_message] call DB_fnc_mresString
		];
		
		[_query, 1] call DB_fnc_asyncCall;
	};

	case "Both": {
		_query = format ["INSERT INTO Server_Logging (message) VALUES ('%1')",
			[_message] call DB_fnc_mresString
		];
		
		[_query, 1] call DB_fnc_asyncCall;

		diag_log "-";
		diag_log format ["[SERVER LOGGING SYSTEM] %1", _message];
		diag_log "-";
	};
};