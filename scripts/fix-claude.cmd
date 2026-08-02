@echo off
setlocal

rem ============================================
rem  Claude Code stable launcher
rem  Usage: fix-claude.cmd [--danger] [args]
rem  Locates claude.exe via %CLAUDE_DIR% or nearby node_modules
rem ============================================

rem 1. Locate claude.exe
set "BIN="

rem Via CLAUDE_DIR env var
if defined CLAUDE_DIR if exist "%CLAUDE_DIR%\node_modules\@anthropic-ai\claude-code\bin\claude.exe" set "BIN=%CLAUDE_DIR%\node_modules\@anthropic-ai\claude-code\bin"

rem Via local node_modules
if not defined BIN if exist "%~dp0node_modules\@anthropic-ai\claude-code\bin\claude.exe" set "BIN=%~dp0node_modules\@anthropic-ai\claude-code\bin"

rem Via parent directory node_modules
if not defined BIN if exist "%~dp0..\node_modules\@anthropic-ai\claude-code\bin\claude.exe" set "BIN=%~dp0..\node_modules\@anthropic-ai\claude-code\bin"

rem Not found
if not defined BIN (
    echo [ERROR] claude.exe not found.
    echo Set CLAUDE_DIR to your Claude Code install root, e.g.:
    echo     setx CLAUDE_DIR "D:\tools\claude-code"
    exit /b 1
)

rem 2. Auto-restore the exe if the auto-updater renamed it
if not exist "%BIN%\claude.exe" (
    for %%f in ("%BIN%\claude.exe.old.*") do (
        if exist "%%f" ren "%%f" "claude.exe"
    )
)

rem 3. --danger flag = danger mode
if /I "%~1"=="--danger" (
    echo [DANGER MODE] Bypassing all permission checks!
    shift
    "%BIN%\claude.exe" --dangerously-skip-permissions %*
    exit /b
)

rem 4. Args passed = run directly
if not "%~1"=="" (
    "%BIN%\claude.exe" %*
    exit /b
)

rem 5. No args = interactive mode menu
echo ========================================
echo   Claude Code Launcher
echo ========================================
echo   [1] Normal mode
echo   [2] Danger mode (bypass all permission checks)
echo   [3] Plan mode
echo ========================================
set /p choice=Choose [1/2/3]:

if "%choice%"=="2" (
    echo.
    echo [DANGER MODE] Bypassing all permission checks!
    "%BIN%\claude.exe" --dangerously-skip-permissions
    exit /b
)
if "%choice%"=="3" (
    "%BIN%\claude.exe" --permission-mode plan
    exit /b
)
"%BIN%\claude.exe"
