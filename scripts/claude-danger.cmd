@echo off
setlocal

rem ============================================
rem  Claude Code one-click danger-mode launcher
rem  Usage: claude-danger.cmd
rem  Locates claude.exe via %CLAUDE_DIR% or nearby node_modules
rem ============================================

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

rem Auto-restore the exe if the auto-updater renamed it
if not exist "%BIN%\claude.exe" (
    for %%f in ("%BIN%\claude.exe.old.*") do (
        if exist "%%f" ren "%%f" "claude.exe"
    )
)

echo [DANGER MODE] Bypassing all permission checks!
"%BIN%\claude.exe" --dangerously-skip-permissions %*
