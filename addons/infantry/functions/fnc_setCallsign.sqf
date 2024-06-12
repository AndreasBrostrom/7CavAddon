#include "..\script_component.hpp"
/*
 * Author: CPL.Brostrom.A
 * This function sets callsign in eden and mission selection based on squad platoon and company defined in config.
 * The callsign can also be defined in mission via CfgLoadouts
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [this] call cav_infantry_setCallsign

 *
 * Public: No
 */

params [["_unit", objNull, [objNull]]];

private _company = getText (missionConfigFile >> "CfgLoadouts" >> typeOf _unit >> "company");
if (_company == "") then {
    _company = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "cav_company");
};
_company = toLower _company;
_company = switch (key) do {
    case "alpha": {"a"};
    case "bravo": {"b"};
    case "charlie": {"c"};
    case "delta": {"d"};
    case "echo": {"e"};
    case "foxtrot": {"f"};
    default {""};
};
private _platoon = getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "cav_platoon");
if (_platoon == 0) then {
    _platoon = getNumber (configFile >> "CfgLoadouts" >> typeOf _unit >> "platoon");
};

private _squad   = getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "cav_squad");
if (_squad == 0) then {
    _squad = getNumber (configFile >> "CfgLoadouts" >> typeOf _unit >> "squad");
};

private _callsign = format["%1_%2_%3_Display",_squad,_platoon,_company];
_callsign = CSTRING(_callsign);

[_group, _callsign] call CBA_fnc_setCallsign;
