@echo off

echo Purging Configurations file.  If there's a file you would like to see not deleted in the future, add it to the config repository. 
git clean -fd


echo Updating Configurations...
git checkout master
git reset --hard
git remote prune origin
git pull --rebase

echo Making sure Dante is running...

:: ptp is the Dante Clock Sync process, which appears to be the only process that runs only when DVS is running. 
QPROCESS "ptp.exe">NUL
IF %ERRORLEVEL% EQU 1 msg "%username%" Dante Virtual Soundcard needs to be manually started.


start "OBS for Facebook" /D "C:\Program Files\obs-studio\bin\64bit\" /MIN "obs64.exe" --multi --collection "1 Only" --profile "Sunday" --scene "Sunday" --startstreaming

timeout 4

start "OBS for Phones" /D "C:\Program Files\obs-studio\bin\64bit\" /MAX "obs64.exe" --multi --collection "1 Only" --profile "Phone Streaming" --scene "Audio Only"
