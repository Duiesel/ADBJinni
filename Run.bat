@echo off


::setup the window size
mode con:cols=80 lines=60
::setup background and foreground color
rem cls
color 0B

::set some PATH variables
set WORKINGDIR="" 
set WORKINGDIR=%~dp0
set ADB="%WORKINGDIR%adb\adb.exe"
set TEMP_FILE="%WORKINGDIR%temp_file"
set LOG_FILE="%WORKINGDIR%log"
set CONFIG_FILE="%WORKINGDIR%config"



::Checking config file in working directory
if not exist %CONFIG_FILE% (
	echo NO CONFIG FILE IN WORKING DIRECTORY!
	echo CLOSING!
	pause
	goto :EOF 
)

@echo Starting of log file! %DATE% %TIME% > %LOG_FILE%

::Setting up programm name
set PROGRAM_NAME=ZTE_CUSTOMIZER_TOOL >> %LOG_FILE%

::Some global variables
set error_count=0

::check adb device authorized or unauthorized
echo.Starting...
call %ADB% kill-server
call %ADB% devices > %TEMP_FILE% & call :TO_LOG
findstr /m "unauthorized" %TEMP_FILE%
if %ERRORLEVEL%==0 (
	echo =======================================================================
    echo.
    echo.              Press "OK" on the phones screen
    echo.              and press any key on PC keyboard
    echo.
    echo =======================================================================
    echo.^Find unautorized device!>>%LOG_FILE%
    pause
) else (
	call %ADB% devices > %TEMP_FILE% & call :TO_LOG
	findstr /m "device" %TEMP_FILE%
	if %ERRORLEVEL%==0 (
		@echo. Device finded okey! >> %LOG_FILE%
	)
)

:FIRST_SCREEN
	call %default-color%
    cls
::  echo *                                  *                                  * ::this line is used as a centering reference nothing prints here
    echo =======================================================================
    echo.
    echo.              WITH GREAT POWER COMES GREAT RESPONSIBILITY.
    echo.
    echo.                     by proceeding you accept that
    echo.                  it is carried out ^at your own risk
    echo.             and you will not hold anyone ^else responsible
    echo.
    echo.              WITH GREAT POWER COMES GREAT RESPONSIBILITY.
    echo.
    echo.          Connect Phone and make sure ^for usb debugging ^mode ON
    echo.
    echo.
    echo. . ^type " GO " ^for ^start customizing ZTE BLADE L5 Phone . . .
    echo.
    echo. . ^type quit or ^exit to cancel and close this window
    echo.                             
    echo.                     developed by Alan Mologorskiy
    echo.                           duiesel^@gmail.com
    echo.                            in Rambler^&Co
    echo.                                  2016
    echo =======================================================================
	set choice=
    echo.&set /p choice=:

    :: alternative platform-tools
    rem if %choice% == ALTTOOLS1 set PLATFORM_TOOLS=%FUNCTION%platform-tools_alt1\&set default-color=color 0D &goto:FIRST_SCREEN

    :: the only accepted answer to continue
    if %choice% == GO (goto:CLEANING_SCREEN)

    ::remap commonly used commands for exiting
    if %choice% == e GOTO:CLOSE_TOOL
    if %choice% == q GOTO:CLOSE_TOOL
    if %choice% == exit GOTO:CLOSE_TOOL
    if %choice% == quit GOTO:CLOSE_TOOL
goto :FIRST_SCREEN


:CLEANING_SCREEN
cls
echo ***********************************************************************
echo.                          WORKING PLEASE WAIT
echo ***********************************************************************
call :PARSE_CONFIG_DO_ADB
goto :CLOSE_TOOL



rem 	rem cls
rem 	echo.
rem     echo ***********************************************************************
rem     echo.                          CLEANING PLEASE WAIT
rem     echo ***********************************************************************
rem     echo.
rem 	call ADB uninstall store.antivirus ##Antivirus package:/system/vendor/operator/app/antivirus-store-4.4.1-213646-328_-_ZTE_-_AV_v4.4.1_MPC-937/antivirus-store-4.4.1-213646-328_-_ZTE_-_AV_v4.4.1_MPC-937.apk=store.antivirus > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB uninstall com.cleanmaster.mguard ##Clean Masterpackage:/system/vendor/operator/app/CleanMaster/CleanMaster.apk=com.cleanmaster.mguard > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB uninstall com.accuweather.android ##AccuWeather package:/system/vendor/operator/app/Accuweather/Accuweather.apk=com.accuweather.android > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB uninstall com.UCMobile.intl ## UC package:/system/vendor/operator/app/UCBrowser_Mini/UCBrowser_Mini.apk=com.UCMobile.intl > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB uninstall com.android.MiEasyMode ##package:/system/vendor/operator/app/Mi-EasyMode/Mi-EasyMode.apk=com.android.MiEasyMode > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ERROR_COUNT_CHECK

rem :HIDING_SCREEN
rem 	rem cls
rem 	echo.
rem     echo ***********************************************************************
rem     echo.                          HIDING PLEASE WAIT
rem     echo ***********************************************************************
rem     echo.
rem 	call ADB shell pm hide com.ume.browser.international ##Ume browser package:/system/priv-app/Browser_P172A40/Browser_P172A40.apk=com.ume.browser.international > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB shell pm hide com.google.android.youtube ##YouTube package:/system/app/YouTube/YouTube.apk=com.google.android.youtube > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB shell pm hide com.google.android.talk ##package:/system/app/Hangouts/Hangouts.apk=com.google.android.talk > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB shell pm hide com.mediatek.appwidget.weather ##package:/system/app/MtkWeatherWidget/MtkWeatherWidget.apk=com.mediatek.appwidget.weather > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ADB shell pm hide com.mediatek.weather ##package:/system/app/MtkWeatherProvider/MtkWeatherProvider.apk=com.mediatek.weather > %TEMP_FILE%
rem 	call :CHECK_STATE
rem 	call ERROR_COUNT_CHECK

:INSTALLING_SCREEN
	rem cls
	rem echo.
 rem    echo ***********************************************************************
 rem    echo.                          INSTALLING PLEASE WAIT
 rem    echo ***********************************************************************
 rem    echo.
 rem    call ADB install %GOOGLE_NOW%  > %TEMP_FILE%
 rem    call :CHECK_STATE

 rem    call ADB install %VIBER%  > %TEMP_FILE%
 rem    call :CHECK_STATE

 rem    call ADB install %WHATSAPP%  > %TEMP_FILE%
 rem    call :CHECK_STATE
    
 rem    call ADB install %TELEGRAM%  > %TEMP_FILE%
 rem    call :CHECK_STATE
    
 rem    call ERROR_COUNT_CHECK
 rem    goto CLOSE_TOOL
rem adbpackage:/system/app/Music/Music.apk=com.android.music
rem ##Package com.google.android.youtube new hidden state: true

rem ##http://www.apkmirror.com/wp-content/themes/APKMirror/download.php?id=102529

::function to parse config file. TODO: Have got one param, that can be in 3 states: {install, uninstall, hide}
:PARSE_CONFIG_DO_ADB
	
	for /F "tokens=1,2,3 delims=: skip=12 usebackq" %%a in (%CONFIG_FILE%) do (
		if %%a==install (
			echo.Installing %%b
			echo.Installing %%b >> %LOG_FILE%			
			call %ADB% install %WORKINGDIR%%%c > %TEMP_FILE% & call :TO_LOG
			call :CHECK_STATE
		)
		if %%a==uninstall (
			echo.Uninstalling %%c
			echo.Uninstalling %%b %%c >>%LOG_FILE%
			call %ADB% uninstall %%c >%TEMP_FILE% & call :TO_LOG
			call :CHECK_STATE
		)
		if %%a==hide (
			echo.Hiding %%b
			echo.Hiding %%b >> %LOG_FILE%
			call %ADB% shell pm hide %%c > %TEMP_FILE% & call :TO_LOG
			call :CHECK_STATE
		)
	)
exit /B %ERRORLEVEL%

::Function to check Succesful of error state of operation
:CHECK_STATE
	setlocal
		set /p _adb_res= < %TEMP_FILE%
		rem DEL %1
		findstr /i "Success true" %TEMP_FILE% >> %LOG_FILE%
		if %ERRORLEVEL%==0 (
			echo.       Successfully & echo.
			(echo.       Successfully & echo.)>> %LOG_FILE%
		) else (
			echo.       FAILED
			(echo.       FAILED & echo.)>> %LOG_FILE%
			set error_count=error_count + 1
		)
	endlocal
exit /B %ERRORLEVEL%


::Call this function to send TEMP_FILE dat to LOG_FILE
:TO_LOG
	TYPE %TEMP_FILE% >> %LOG_FILE%
exit /B %ERRORLEVEL%
::

:ERROR_COUNT_CHECK
	setlocal
		if error_count > 0 (
			echo. Some errors while unninstalling.
			set error_count=0
			pause
		) else (
			rem cls
			echo.
		    echo ***********************************************************************
		    echo.                   OPERATION COMPLETE SUCCESFULLY
		    echo ***********************************************************************
		    echo.
		)
	endlocal
	exit /B %ERRORLEVEL%

:CLOSE_TOOL
    rem cls
    del %TEMP_FILE%
    echo.
    echo ***********************************************************************
    echo.                    %PROGRAM_NAME% FINISHED
    echo ***********************************************************************
    echo.
    call %ADB% kill-server &pause &exit
GOTO:EOF