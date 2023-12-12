rem In both Edge and Chrome, goto the URL chrome://version and take note of the "profile" path. Then close both.

rem In Chrome's profile folder, delete all files in the "Sessions" folder. Then, copy all files in Edge's Sessions
rem folder over to Chrome's. Then, when you start Chrome, you should be good to go. This should work since both
rem Edge and Chrome are based on Chromium and use the same type or storage for their sessions.

set EDGE_PROFILE="C:\Users\PhilipBranning\AppData\Local\Microsoft\Edge\User Data\Default"
set CHROME_PROFILE="C:\Users\PhilipBranning\scoop\apps\googlechrome\current\User Data\Default"

echo Deleting Chrome profile: %CHROME_PROFILE%
rmdir %CHROME_PROFILE% /S /Q

echo Copying Edge profile to Chrome: %EDGE_PROFILE
xcopy /E /K /H /I /Q %EDGE_PROFILE% %CHROME_PROFILE%

echo Done
pause
