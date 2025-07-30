@echo off
echo Starting Railway Project...
echo.

REM Set Tomcat environment
set CATALINA_HOME=C:\Users\jihyu\Downloads\apache-tomcat-9.0.107-windows-x64\apache-tomcat-9.0.107

echo Setting CATALINA_HOME to: %CATALINA_HOME%
echo.

REM Start Tomcat
echo Starting Tomcat server...
cd "%CATALINA_HOME%\bin"
call startup.bat

echo.
echo Tomcat is starting up...
echo Wait a moment, then open your browser to:
echo http://localhost:8080/railway/login.jsp
echo.
echo Press any key to exit this window...
pause > nul
