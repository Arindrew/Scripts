@echo off

@if not "%OS" == "Windows_NT" goto :EXIT
@if "%1" == "" (set INFO=echo && set ScriptExit=1) else (set INFO=REM && set ScriptExit =0)

:EXIT

%INFO% ********************************
%INFO% Script:
%INFO% Creation Date:
%INFO% Last Modified:
%INFO% Author: Andrew S. Keller
%INFO% E-mail: arindrew@runbox.com
%INFO% ********************************
%INFO% Description:
%INFO% 
%INFO% ********************************