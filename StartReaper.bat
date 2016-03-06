c:

@echo off

echo "updating configurations..."
git pull --rebase



echo "Setting date variables..."

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
For /f "tokens=1-3 delims=/:/ " %%a in ('time /t') do (set mytime=%%a%%c)


echo "Creating directory for service..."

mkdir "C:\Users\User\Google Drive\SundayServices\%mydate% %mytime%"


echo "Starting Reaper..."

Start "" "c:\Program Files\REAPER\reaper.exe" -template "C:\Users\User\Google Drive\Configurations\template.rpp" -saveas "C:\Users\User\Google Drive\SundayServices\%mydate% %mytime%\%mydate% %mytime%.rpp" -newinst