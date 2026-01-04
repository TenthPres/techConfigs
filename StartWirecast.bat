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

echo Setting Date Variables...

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-3 delims=/:/ " %%a in ('time /t') do (set mytime=%%a%%c)


echo Launching YouTube Studio...
start http://west.tenth.org/live/json/YouTubeStudio.php


echo Copying template for this service...
mkdir "%userprofile%\videos\Wirecast Documents"
copy "%cd%\Wirecast\TEMPLATE.wcst" "%userprofile%\videos\Wirecast Documents\%mydate% %mytime%.wcst"

start "" "%userprofile%\videos\Wirecast Documents\%mydate% %mytime%.wcst"
