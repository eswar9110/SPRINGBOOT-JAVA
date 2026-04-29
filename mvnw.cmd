@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.
@REM ----------------------------------------------------------------------------
@REM Begin all REM lines with @
@echo off

@REM Set JAVA_HOME to bundled JDK if not set
if "%JAVA_HOME%"=="" set "JAVA_HOME=C:\Program Files\Android\jdk\jdk-8.0.302.8-hotspot\jdk8u302-b08"

set WRAPPER_JAR="%~dp0.mvn\wrapper\maven-wrapper.jar"
set WRAPPER_PROPERTIES="%~dp0.mvn\wrapper\maven-wrapper.properties"

@REM Download Maven if not cached
set MAVEN_PROJECTBASEDIR=%~dp0
set MAVEN_HOME=%USERPROFILE%\.m2\wrapper\dists\apache-maven-3.8.8

if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
    echo Maven not found. Downloading Maven 3.8.8...
    if not exist "%MAVEN_HOME%" mkdir "%MAVEN_HOME%"
    powershell -Command "& { $ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.8.8/apache-maven-3.8.8-bin.zip' -OutFile '%TEMP%\maven.zip'; Expand-Archive -Path '%TEMP%\maven.zip' -DestinationPath '%USERPROFILE%\.m2\wrapper\dists' -Force; Remove-Item '%TEMP%\maven.zip' }"
    set MAVEN_HOME=%USERPROFILE%\.m2\wrapper\dists\apache-maven-3.8.8
)

set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

"%MAVEN_HOME%\bin\mvn.cmd" %*
