---
name: claude-boot-fixer
description: 诊断并修复 Claude Code 无法启动的问题。适用于 Windows 上 claude 命令报错的所有场景：提示"无法将 claude 项识别为 cmdlet"（命令未找到/PATH 未配置）、"claude.exe 找不到/系统找不到指定的文件"（自动更新把 claude.exe 改名成 claude.exe.old.*）、"禁止运行脚本"（PowerShell 执行策略限制）、node 不是内部或外部命令（Node.js 未安装）、全局/本地安装冲突、快捷方式失效、危险模式（--dangerously-skip-permissions）无法切换、cluade 打错命令、npm/pnpm 下载失败或构建脚本被跳过、API 认证错误、更新锁残留。还包含如何配置让输入 claude 命令直接启动稳定启动器脚本。使用时先检查 %CLAUDE_DIR%\node_modules\@anthropic-ai\claude-code\bin 下 claude.exe 是否存在，再检查 PATH、执行策略、settings.json 配置。This document is bilingual (中文 + English) — EN blocks are included under every section for international users.
---

# Fix Claude Launch / 修复 claude 命令打不开

> 🇬🇧 **EN:** This document is fully bilingual. Chinese first, English right after — pick the one you prefer.

## Overview / 概述

**中文：** 诊断并修复 Windows 上 Claude Code 启动失败的所有常见问题。本 skill 不依赖固定路径，通过 `%CLAUDE_DIR%` 环境变量定位安装目录；未设置时自动在项目目录中查找 `node_modules`。

**EN:** Diagnoses and fixes every common Claude Code launch failure on Windows. This skill does not rely on fixed paths — it locates the installation via the `%CLAUDE_DIR%` environment variable, or auto-discovers `node_modules` in the project directory when it is not set.

## 先决条件 / Prerequisites

**中文：**
- 设置 `CLAUDE_DIR` 环境变量指向 Claude Code 安装根目录（例如 `D:\tools\claude-code`），或在项目目录下运行（脚本会自动查找 `node_modules`）
- 安装方式（任选其一）：
  - npm 全局：`npm install -g @anthropic-ai/claude-code`（`claude` 命令自动进入 PATH）
  - pnpm 本地：`pnpm add @anthropic-ai/claude-code`（需把 `node_modules\.bin` 加入 PATH）
  - Windows 还需安装 Git for Windows（Claude Code 依赖）

**EN:**
- Set the `CLAUDE_DIR` environment variable to your Claude Code install root (e.g. `D:\tools\claude-code`), or run from inside a project directory (scripts auto-discover `node_modules`)
- Installation (pick one):
  - Global npm: `npm install -g @anthropic-ai/claude-code` (the `claude` command enters PATH automatically)
  - Local pnpm: `pnpm add @anthropic-ai/claude-code` (add `node_modules\.bin` to PATH)
  - Windows also requires Git for Windows (a Claude Code dependency)

## 让 `claude` 命令直接启动启动器 / Make `claude` launch via the launcher

**中文：** 目标：输入 `claude` 时走 `fix-claude.cmd` 稳定启动器（自动恢复 exe、可选危险模式），而不是直接调 `claude.exe`。

**EN:** Goal: typing `claude` routes through the `fix-claude.cmd` stable launcher (auto-restore of the exe, optional danger mode) instead of calling `claude.exe` directly.

<a id="method-a"></a>

### 方案 A（推荐）：PowerShell Profile 函数 / Option A (Recommended): PowerShell Profile Function

优先级最高（函数 > 外部命令），不受 `.ps1`/`.cmd` 解析顺序影响。

*Highest priority (function > external command), unaffected by `.ps1`/`.cmd` resolution order.*

```powershell
# 加到 $PROFILE.CurrentUserAllHosts
function claude {
    & "C:\path\to\fix-claude.cmd" @args
}
# 顺手修复拼写错误 / also fixes the typo
Set-Alias cluade claude
```

打开新终端后生效。若报"禁止运行脚本"，先执行：

*Takes effect in a new terminal. If "running scripts is disabled" appears, run first:*

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
```

<a id="method-b"></a>

### 方案 B：把启动器放进 PATH 目录 / Option B: Put the Launcher in a PATH Directory

1. 把 `fix-claude.cmd` 复制为 `claude.cmd`，放到专用目录，如 `%USERPROFILE%\bin`
2. 把该目录加到 PATH **最前面**

*1. Copy `fix-claude.cmd` as `claude.cmd` into a dedicated directory like `%USERPROFILE%\bin`*
*2. Prepend that directory to PATH:*

```powershell
$bin = "$env:USERPROFILE\bin"
if (-not (Test-Path $bin)) { New-Item -Path $bin -ItemType Directory -Force }
[Environment]::SetEnvironmentVariable("Path", "$bin;$([Environment]::GetEnvironmentVariable('Path','User'))", "User")
```

3. 新开终端生效 / *takes effect in a new terminal*

注意：PowerShell 中同一目录下 `.ps1` 优先于 `.cmd` 执行。若 PATH 中已有 `node_modules\.bin\claude.ps1` 且位于更前，可删除该 `.ps1` 或改用方案 A。

*Note: in PowerShell, a `.ps1` in the same directory takes precedence over a `.cmd`. If a `node_modules\.bin\claude.ps1` sits earlier in PATH, delete it or switch to Option A.*

<a id="method-c"></a>

### 方案 C：替换 node_modules\.bin 包装脚本 / Option C: Override the node_modules\.bin Wrapper

本地 pnpm 安装时，把 `fix-claude.cmd` 覆盖到 `%CLAUDE_DIR%\node_modules\.bin\claude.cmd`：

*For local pnpm installs, overwrite `%CLAUDE_DIR%\node_modules\.bin\claude.cmd` with `fix-claude.cmd`:*

```powershell
Copy-Item fix-claude.cmd "$env:CLAUDE_DIR\node_modules\.bin\claude.cmd" -Force
```

缺点：重新 `pnpm install` 会覆盖，需重做。*Downside: re-running `pnpm install` overwrites it, so redo needed.*

## 问题诊断流程 / Diagnostic Flow

按顺序检查，命中即修复。*Check in order; fix on first match.*

### 1. 命令不存在 / Command not found

报错：`无法将"claude"项识别为 cmdlet、函数、脚本文件或可运行程序的名称`
- 原因 / **Cause**：PATH 未配置，或安装失败 / *PATH not configured, or install failed*
- 检查 / **Check**：`Get-Command claude -All -ErrorAction SilentlyContinue`
- 修复 / **Fix**：把 Claude Code 的 `node_modules\.bin`（本地）或 npm 全局 bin 目录加入用户 PATH / *add `node_modules\.bin` (local) or the npm global bin directory to the user PATH*

### 2. claude.exe 被改名 / claude.exe was renamed

报错：`系统找不到指定的文件` / `无法识别 ...\bin\claude.exe`
- 原因 / **Cause**：自动更新把 `claude.exe` 改名成 `claude.exe.old.<时间戳>` / *auto-update renamed it to `claude.exe.old.<timestamp>`*
- 检查 / **Check**：`Get-ChildItem "%CLAUDE_DIR%\node_modules\@anthropic-ai\claude-code\bin"`
- 修复 / **Fix**：把 `.old.*` 改回 `claude.exe`；或直接用 `fix-claude.cmd`（内置自动恢复）/ *rename `.old.*` back to `claude.exe`, or just use `fix-claude.cmd` (auto-restore built in)*

### 3. PowerShell 禁止运行脚本 / Script execution disabled

报错：`无法加载文件 ...claude.ps1，因为在此系统上禁止运行脚本`
- 修复 / **Fix**：`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force`

### 4. Node.js 未安装或不在 PATH / Node.js missing or not on PATH

报错：`node 不是内部或外部命令` / `无法将"node"项识别为...`
- 检查 / **Check**：`node --version`
- 修复 / **Fix**：安装 Node.js 18+，并确认其 bin 目录在 PATH 中 / *install Node.js 18+ and make sure its bin is on PATH*

### 5. 全局与本地安装冲突 / Global vs local install conflict

现象：`claude --version` 版本与预期不符，或执行的是全局旧版本 / *version differs from expectation, or a stale global version runs*
- 检查 / **Check**：`Get-Command claude -All` 列出所有匹配项
- 修复 / **Fix**：删除其中一个，或调整 PATH 顺序，或用方案 A 的 Profile 函数强制指定 / *remove one, reorder PATH, or pin with Option A's profile function*

### 6. PowerShell 打错命令 / Typo in PowerShell

报错：`cluade : 无法将"cluade"项识别为...`
- 修复 / **Fix**：Profile 中添加 `Set-Alias cluade claude`

### 7. 危险模式无法切换 / Danger mode cannot be toggled

报错：`Error: Input must be provided either through stdin or as a prompt argument when using --print`
- 原因 / **Cause**：新版需先在 `%USERPROFILE%\.claude\settings.json` 启用 / *newer versions require enabling it first in `%USERPROFILE%\.claude\settings.json`:*
  ```json
  {
    "permissions": {
      "allowDangerouslySkipPermissions": true
    }
  }
  ```

### 8. 安装/下载失败 / Install or download failure

- `[ERR_PNPM_META_FETCH_FAIL]` / `EACCES`：网络或代理问题，检查网络后重试 / *network or proxy issue — check and retry*
- `[ERR_PNPM_IGNORED_BUILDS]`：构建脚本被跳过，执行 `pnpm approve-builds @anthropic-ai/claude-code` / *build scripts skipped — run `pnpm approve-builds @anthropic-ai/claude-code`*
- `npm ERR! code EPERM`：权限不足，用管理员 PowerShell 重试 / *permission issue — retry in an elevated PowerShell*

### 9. API 认证/连接错误 / API auth or connection errors

- `401 / 403`：`ANTHROPIC_AUTH_TOKEN` 无效或过期，重新获取 / *invalid or expired — get a new one*
- `ECONNREFUSED / ENOTFOUND / timeout`：网络不通或代理未配置，检查 `ANTHROPIC_BASE_URL` 是否可达 / *network unreachable or proxy unconfigured — check that `ANTHROPIC_BASE_URL` is reachable*
- 修复 / **Fix**：重新执行环境变量配置（见下），确认 base URL 与 token 配对 / *re-run the env configuration (below), make sure the base URL and token match*

### 10. 更新锁残留导致启动卡死 / Stale update lock hangs launch

现象：启动后一直卡在更新/无响应 / *hangs on the update step or stays unresponsive*
- 检查 / **Check**：`%USERPROFILE%\.claude\.update.lock` 是否存在
- 修复 / **Fix**：删除该文件后重试 / *delete the file and retry*

### 11. 快捷方式失效 / Broken shortcut

- 原因 / **Cause**：快捷方式直接指向 `...\bin\claude.exe`，更新后路径失效 / *shortcut points straight at `...\bin\claude.exe`, which becomes stale after updates*
- 修复 / **Fix**：快捷方式指向 `fix-claude.cmd`（稳定路径，自带自动恢复）/ *point the shortcut at `fix-claude.cmd` (stable path, auto-restore built in)*

### 12. 杀毒软件/Defender 拦截 / Antivirus or Defender blocking

现象：exe 被删除或启动即退出 / *the exe gets deleted or exits right after launch*
- 检查 / **Check**：Windows 安全中心"保护历史记录" / *Windows Security "Protection history"*
- 修复 / **Fix**：添加排除目录 `%CLAUDE_DIR%`，重新安装或恢复文件 / *add `%CLAUDE_DIR%` as an exclusion, reinstall or restore the file*

## 标准修复步骤 / Standard Fix Steps

### 1. 设置 CLAUDE_DIR 环境变量（一次性）/ Set CLAUDE_DIR once

```powershell
setx CLAUDE_DIR "D:\tools\claude-code"   # 换成你的安装目录 / use your own install path
```

### 2. 恢复被改名的 claude.exe / Restore the renamed claude.exe

```powershell
$bin = "$env:CLAUDE_DIR\node_modules\@anthropic-ai\claude-code\bin"
$old = Get-ChildItem "$bin\claude.exe.old.*" -ErrorAction SilentlyContinue | Select-Object -First 1
if ($old) { Rename-Item $old.FullName -NewName "claude.exe" }
```

### 3. 使用稳定启动器 / Use the stable launcher

使用 `scripts/fix-claude.cmd`（支持模式菜单 + `--danger`）或 `scripts/claude-danger.cmd`（一键危险模式）。脚本会自动：

*Use `scripts/fix-claude.cmd` (mode menu + `--danger`) or `scripts/claude-danger.cmd` (one-click danger mode). The scripts automatically:*

- 通过 `%CLAUDE_DIR%` 或项目内 `node_modules` 定位 claude.exe / *locate claude.exe via `%CLAUDE_DIR%` or local `node_modules`*
- 自动恢复被更新改名的 `claude.exe` / *restore the `claude.exe` renamed by updates*
- 无参数时显示模式选择菜单（普通 / 危险 / 计划）/ *show a mode menu when called without arguments (normal / danger / plan)*

<a id="env-deepseek"></a>

### 4. 配置环境变量（DeepSeek API，可选）/ Configure env vars (DeepSeek API, optional)

```powershell
setx ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"
setx ANTHROPIC_AUTH_TOKEN "<你的 DeepSeek API Key>"   # <your DeepSeek API key>
setx ANTHROPIC_MODEL "deepseek-v4-pro[1m]"
setx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro[1m]"
setx ANTHROPIC_DEFAULT_SONNET_MODEL "deepseek-v4-pro[1m]"
setx ANTHROPIC_DEFAULT_HAIKU_MODEL "deepseek-v4-flash"
setx CLAUDE_CODE_SUBAGENT_MODEL "deepseek-v4-flash"
setx CLAUDE_CODE_EFFORT_LEVEL "max"
```

修改后必须**新开终端**才生效。*You must open a new terminal for the changes to take effect.*

### 5. 验证 / Verify

```powershell
claude --version
# 期望输出 / expected output: x.x.x (Claude Code)
```

## Resources / 资源

### scripts/ — 脚本
- `fix-claude.cmd` — 稳定启动器，自动定位安装目录、恢复被改名的 exe，支持模式菜单和 `--danger` 参数 / *stable launcher — auto-locates the install, restores the renamed exe, supports the mode menu and `--danger`*
- `claude-danger.cmd` — 一键危险模式启动器 / *one-click danger-mode launcher*

### references/ — 参考
- `troubleshooting.md` — 完整错误信息对照表与修复命令（均为通用路径写法，中英双语）/ *full error lookup table and fix commands (generic paths, bilingual)*
