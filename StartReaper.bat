@echo off

echo Purging Configurations file.  If there's a file you would like to see not deleted in the future, add it to the config repository. 
git clean -fd


echo Updating Configurations...
git checkout master
git remote prune origin
git pull --rebase

echo Making sure Dante is running...

:: ptp is the Dante Clock Sync process, which appears to be the only process that runs only when DVS is running. 
QPROCESS "ptp.exe">NUL
IF %ERRORLEVEL% EQU 1 msg "%username%" Dante Virtual Soundcard needs to be manually started.

echo Setting Date Variables...

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-3 delims=/:/ " %%a in ('time /t') do (set mytime=%%a%%c)


echo Creating directory for service...

if not exist "%cd%\..\Recordings\" mkdir "%cd%\..\Recordings\"

mkdir "%cd%\..\Recordings\%mydate% %mytime%"


echo Starting Reaper...

:: for x32 computers
if exist "c:\Program Files\REAPER" (
	Start "" "c:\Program Files\REAPER\reaper.exe" -template "%cd%\template.rpp" -saveas "%cd%\..\Recordings\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst

) else (
:: for x64 computers
	if exist "c:\Program Files (x86)\REAPER" (
		Start "" "c:\Program Files (x86)\REAPER\reaper.exe" -template "%cd%\template.rpp" -saveas "%cd%\..\Recordings\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst
	) else (

:: for computers that don't have Reaper
		msg "%username%" Reaper appears to not be installed.  No Bueno. 
	)
)

exit
