@echo off

@if not "%OS" == "Windows_NT" goto :EXIT
@if "%1" == "" (set INFO=echo && set ScriptExit=1) else (set INFO=REM && set ScriptExit =0)

net stop McAfeeFramework

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Network Associates\ePolicy\Orchestrator\Agent" /v AgentGUID /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Network Associates\ePolicy\Orchestrator\Agent" /v MacAddress /f

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Network Associates\ePolicy\Orchestrator\Agent" /v AgentGUID /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Network Associates\ePolicy\Orchestrator\Agent" /v MacAddress /f
pause

:EXIT

%INFO% ********************************
%INFO% Script: Sysprep McAfee
%INFO% Creation Date: June 7th, 2016
%INFO% Last Modified: June 7th, 2016
%INFO% Author: Andrew S. Keller
%INFO% E-mail: arindrew@runbox.com
%INFO% ********************************
%INFO% Description: Prepares computer for 
%INFO% sysprep by removing the appropriate
%INFO% registry keys
%INFO% ********************************