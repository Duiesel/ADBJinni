@echo off
rem File used for experiments and for visual checking configuration

set WORKINGDIR=""
set WORKINGDIR=%~dp0
set TEST="%WORKINGDIR%testing.bat"
set LOG_FILE="%WORKINGDIR%log"
set TEMP_FILE="%WORKINGDIR%temp_file"
set CONFIG_FILE="%WORKINGDIR%config"


if not exist %CONFIG_FILE% (
	echo NO CONFIG FILE IN WORKING DIRECTORY!
	echo CLOSING!
	pause
	del %TEMP_FILE%
	del %LOG_FILE%
	goto :EOF 
) else echo.OKEEEEEEY

echo.Starting log > %LOG_FILE%
call :myfunc_1
goto :EOF
rem CALL %TEST% %1 > temp_file
rem set /p result= <temp_file
rem del temp_file
rem echo.&set /p result=: 
echo.
echo.
rem echo Result is %result%

rem CALL adb devices > temp_file
rem set /p result= < temp_file
rem echo. Take the result is:&echo. %result%

rem call adb kill-server

:myfunc_1
FOR /F "tokens=1,2,3 delims=: skip=12 usebackq" %%a IN (%CONFIG_FILE%) DO (
	echo. %%a %%c 
	rem > %TEMP_FILE% & call :TO_LOG
	rem if %%a==install (
	rem 	echo.        installing %WORKINGDIR%%%b
	rem )
)
exit /B %ERRORLEVEL%

:TO_LOG
	TYPE %TEMP_FILE% >> %LOG_FILE%
exit /B %ERRORLEVEL%