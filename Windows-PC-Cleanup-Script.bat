@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
	echo This script requires administrative privileges.
	exit /b 1
)

if defined temp if exist "%temp%\" (
	del /q /f /s "%temp%\*.*"
	echo Deleted files in %temp%
) else (
	echo %temp% directory does not exist or is not defined.
)

:: Delete user temp files
if defined temp if exist "%temp%\" (
	del /q /f /s "%temp%\*.*"
	echo Deleted files in %temp%
) else (
	echo %temp% directory does not exist or is not defined.
)

:: Delete Windows temp files
del /q /f /s C:\Windows\Temp\*.*
echo Deleted files in C:\Windows\Temp

:: Delete prefetch files
del /q /f /s C:\Windows\Prefetch\*.*
echo Deleted prefetch files

:: Warn user before deleting Windows Update cache
echo WARNING: Deleting the Windows Update cache may interfere with pending updates.
set /p delWU="Do you want to continue and delete the Windows Update cache? (Y/N): "
if /I "%delWU%"=="Y" (
:: Delete recent files
if exist "%userprofile%\Recent\" (
	del /s /f /q "%userprofile%\Recent\*.*"
	echo Deleted recent files
) else (
	echo Recent folder does not exist.
)
	echo Skipped deleting Windows Update cache
)

echo Cleanup completed successfully!
if /I "%1"=="pause" pause
echo Deleted recent files

echo Cleanup completed successfully!
pause
