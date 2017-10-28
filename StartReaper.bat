@echo off

echo updating configurations...
git checkout master
git pull --rebase

echo Making sure Dante is running...

:: ptp is the Dante Clock Sync process, which appears to be the only process that runs only when DVS is running. 
QPROCESS "ptp.exe">NUL
IF %ERRORLEVEL% EQU 1 msg "%username%" Dante Virtual Soundcard needs to be manually started.

echo Setting date variables...

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-3 delims=/:/ " %%a in ('time /t') do (set mytime=%%a%%c)


echo Creating directory for service...

if not exist "%UserProfile%\Google Drive\SundayServices" mkdir "%UserProfile%\Google Drive\SundayServices"

mkdir "%UserProfile%\Google Drive\SundayServices\%mydate% %mytime%"


echo Starting Reaper...

:: for x32 computers
if exist "c:\Program Files\REAPER" (
	Start "" "c:\Program Files\REAPER\reaper.exe" -template "%cd%\template.rpp" -saveas "%UserProfile%\Google Drive\SundayServices\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst

) else (
:: for x64 computers
	if exist "c:\Program Files (x86)\REAPER" (
		Start "" "c:\Program Files (x86)\REAPER\reaper.exe" -template "%cd%\template.rpp" -saveas "%UserProfile%\Google Drive\SundayServices\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst
	) else (

:: for computers that don't have Reaper
		msg "%username%" Reaper appears to not be installed.  No Bueno. 
	)
)

exit
