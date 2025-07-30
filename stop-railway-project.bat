@echo off
echo Stopping Railway Project...
echo.

REM Set Tomcat environment
set CATALINA_HOME=C:\Users\jihyu\Downloads\apache-tomcat-9.0.107-windows-x64\apache-tomcat-9.0.107

echo Setting CATALINA_HOME to: %CATALINA_HOME%
echo.

REM Stop Tomcat
echo Stopping Tomcat server...
cd "%CATALINA_HOME%\bin"
call shutdown.bat

echo.
echo Tomcat server stopped.
echo Press any key to exit...
pause > nul
