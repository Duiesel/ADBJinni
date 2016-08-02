@echo off
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
	goto :EOF 
) else echo.OKEEEEEEY

echo.Starting log & TYPE CON > %LOG_FILE%
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
	echo. %%a %%c> %TEMP_FILE% & call :TO_LOG
	if %%a==install (
		echo.        installing %WORKINGDIR%%%b
	)
)
exit /B %ERRORLEVEL%

:TO_LOG
	TYPE %TEMP_FILE% >> %LOG_FILE%
exit /B %ERRORLEVEL%