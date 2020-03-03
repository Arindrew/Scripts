@echo off

@if not "%OS" == "Windows_NT" goto :EXIT
@if "%1" == "" (set INFO=echo && set ScriptExit=1) else (set INFO=REM && set ScriptExit =0)

start "" "C:\Program Files\Microsoft Office\Office16\OSPPREARM.EXE"
pause
cscript "C:\Program Files\Microsoft Office\Office16\OSPP.VBS" /act
pause

:EXIT

%INFO% ********************************
%INFO% Script: Sysprep Office 2016
%INFO% Creation Date: June 7th, 2016
%INFO% Last Modified: Mar 3rd, 2019
%INFO% Author: Andrew S. Keller
%INFO% E-mail: andrew@pm.me
%INFO% ********************************
%INFO% Description: Prepares computer for 
%INFO% sysprep 
%INFO% ********************************
