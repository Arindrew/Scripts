@echo off

@if not "%OS" == "Windows_NT" goto :EXIT
@if "%1" == "" (set INFO=echo && set ScriptExit=1) else (set INFO=REM && set ScriptExit =0)

start "" "C:\Program Files (x86)\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform\OSPPREARM.EXE"
pause
cscript "C:\Program Files (x86)\Microsoft Office\Office14\OSPP.VBS" /act

:EXIT

%INFO% ********************************
%INFO% Script: Sysprep Office 2010
%INFO% Creation Date: June 7th, 2016
%INFO% Last Modified: June 7th, 2016
%INFO% Author: Andrew S. Keller
%INFO% E-mail: arindrew@runbox.com
%INFO% ********************************
%INFO% Description: Prepares computer for 
%INFO% sysprep 
%INFO% ********************************