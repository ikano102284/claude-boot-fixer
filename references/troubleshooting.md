# Claude 命令打不开 - 错误对照表 / Claude Command Launch Failures — Error Lookup

> 🇬🇧 **EN:** Every table below is followed by its English version. Commands work in both languages.

<a id="start-errors"></a>

## 启动类错误 / Startup Errors

| 错误提示 | 原因 | 修复 |
|---|---|---|
| `无法将"claude"项识别为 cmdlet、函数、脚本文件或可运行程序的名称` | PATH 未配置或未安装 | 把 `node_modules\.bin`（本地）或 npm 全局 bin 加入用户 PATH |
| `系统找不到指定的文件` / `无法识别 ...\bin\claude.exe` | 自动更新把 exe 改名成 `.old.*` | 改回 `claude.exe`（启动器脚本自动处理） |
| `无法加载文件 ...claude.ps1，因为在此系统上禁止运行脚本` | PowerShell 执行策略 | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force` |
| `node 不是内部或外部命令` / `无法将"node"项识别为...` | Node.js 未安装或不在 PATH | 安装 Node.js 18+，确认 bin 目录在 PATH |
| `cluade : 无法将"cluade"项识别为...` | 拼写错误 | Profile 中添加 `Set-Alias cluade claude` |
| 启动后一直卡住/无响应 | 更新锁残留 | 删除 `%USERPROFILE%\.claude\.update.lock` 后重试 |
| 启动即退出，exe 消失 | 杀毒软件/Defender 拦截 | 安全中心加排除目录 `%CLAUDE_DIR%`，恢复文件 |
| `git 不是内部或外部命令` | 未安装 Git for Windows | 安装 Git for Windows（Claude Code 依赖） |
| 版本与预期不符 | 全局/本地安装冲突 | `Get-Command claude -All` 查看所有匹配，删除冗余或调 PATH 顺序 |

**🇬🇧 English version:**

| Error message | Cause | Fix |
|---|---|---|
| `'claude' is not recognized as a cmdlet, function, script file, or operable program` | PATH not configured or not installed | Add `node_modules\.bin` (local) or the npm global bin to the user PATH |
| `The system cannot find the file specified` / `not recognized ...\bin\claude.exe` | Auto-update renamed the exe to `.old.*` | Rename back to `claude.exe` (launcher scripts do this automatically) |
| `...claude.ps1 cannot be loaded because running scripts is disabled on this system` | PowerShell execution policy | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force` |
| `'node' is not recognized as an internal or external command` | Node.js missing or not on PATH | Install Node.js 18+, make sure its bin is on PATH |
| `'cluade' is not recognized...` | Typo | Add `Set-Alias cluade claude` to the profile |
| Hangs after launch / no response | Stale update lock | Delete `%USERPROFILE%\.claude\.update.lock` and retry |
| Launches then exits, exe gone | Antivirus / Defender blocking | Add `%CLAUDE_DIR%` exclusion in Windows Security, restore the file |
| `'git' is not recognized as an internal or external command` | Git for Windows not installed | Install Git for Windows (a Claude Code dependency) |
| Version differs from expected | Global/local install conflict | `Get-Command claude -All` to list matches, remove extras or reorder PATH |

<a id="install-errors"></a>

## 安装类错误 / Install Errors

| 错误提示 | 原因 | 修复 |
|---|---|---|
| `[ERR_PNPM_META_FETCH_FAIL]` / `EACCES` | 网络无法访问 npm 仓库 | 检查网络/代理后重试 `pnpm add @anthropic-ai/claude-code` |
| `[ERR_PNPM_IGNORED_BUILDS]` | 构建脚本被跳过 | `pnpm approve-builds @anthropic-ai/claude-code` |
| `npm ERR! code EPERM` | 权限不足 | 用管理员 PowerShell 重试 |
| `ENOTFOUND / ECONNRESET / fetch failed` | DNS/代理问题 | 检查代理配置，`npm config get proxy`，必要时设置 `HTTPS_PROXY` |
| 磁盘空间不足 | 安装包 ~250MB | 清理磁盘或换安装目录 |

**🇬🇧 English version:**

| Error message | Cause | Fix |
|---|---|---|
| `[ERR_PNPM_META_FETCH_FAIL]` / `EACCES` | Network cannot reach the npm registry | Check network/proxy and retry `pnpm add @anthropic-ai/claude-code` |
| `[ERR_PNPM_IGNORED_BUILDS]` | Build scripts skipped | `pnpm approve-builds @anthropic-ai/claude-code` |
| `npm ERR! code EPERM` | Insufficient permissions | Retry in an elevated PowerShell |
| `ENOTFOUND / ECONNRESET / fetch failed` | DNS / proxy issue | Check proxy config, `npm config get proxy`, set `HTTPS_PROXY` if needed |
| Not enough disk space | Package is ~250MB | Clean up disk or change the install directory |

<a id="api-errors"></a>

## API / 连接类错误 / API & Connection Errors

| 错误提示 | 原因 | 修复 |
|---|---|---|
| `401 Unauthorized` | `ANTHROPIC_AUTH_TOKEN` 无效/过期 | 重新获取并 `setx ANTHROPIC_AUTH_TOKEN "..."` |
| `403 Forbidden` | Key 无权限或额度不足 | 检查账户余额/权限 |
| `timeout / ECONNREFUSED` | base URL 不可达 | `Test-NetConnection api.deepseek.com -Port 443`，检查 `ANTHROPIC_BASE_URL` |
| `model not found` | 模型名拼写错误 | 确认 `ANTHROPIC_MODEL` 等变量值正确 |

**🇬🇧 English version:**

| Error message | Cause | Fix |
|---|---|---|
| `401 Unauthorized` | `ANTHROPIC_AUTH_TOKEN` invalid or expired | Get a new one and `setx ANTHROPIC_AUTH_TOKEN "..."` |
| `403 Forbidden` | Key lacks permission or quota exhausted | Check account balance / permissions |
| `timeout / ECONNREFUSED` | base URL unreachable | `Test-NetConnection api.deepseek.com -Port 443`, check `ANTHROPIC_BASE_URL` |
| `model not found` | Model name typo | Confirm `ANTHROPIC_MODEL` and related variables |

<a id="danger-setup"></a>

## 危险模式相关 / Danger Mode

| 错误提示 | 原因 | 修复 |
|---|---|---|
| `Error: Input must be provided either through stdin or as a prompt argument when using --print` | 未启用危险模式开关 | `%USERPROFILE%\.claude\settings.json` 添加 `permissions.allowDangerouslySkipPermissions: true` |
| 界面上看不到 `bypass permissions on` | 会话内模式未切换 | Claude Code 内按 Shift+Tab 循环切换权限模式 |

**🇬🇧 English version:**

| Error message | Cause | Fix |
|---|---|---|
| `Error: Input must be provided either through stdin or as a prompt argument when using --print` | Danger mode not enabled | Add `permissions.allowDangerouslySkipPermissions: true` to `%USERPROFILE%\.claude\settings.json` |
| `bypass permissions on` not visible in the UI | Session mode not toggled | Press Shift+Tab inside Claude Code to cycle permission modes |

## 让 `claude` 命令指向启动器 / Point the `claude` command at the launcher

### 方案 A：PowerShell Profile 函数（推荐）/ Option A: PowerShell profile function (recommended)

```powershell
# $PROFILE.CurrentUserAllHosts 中添加 / add to:
function claude {
    & "C:\path\to\fix-claude.cmd" @args
}
Set-Alias cluade claude
```

### 方案 B：PATH 前置目录 / Option B: PATH-first directory

```powershell
$bin = "$env:USERPROFILE\bin"
if (-not (Test-Path $bin)) { New-Item -Path $bin -ItemType Directory -Force }
Copy-Item fix-claude.cmd "$bin\claude.cmd" -Force
[Environment]::SetEnvironmentVariable("Path", "$bin;$([Environment]::GetEnvironmentVariable('Path','User'))", "User")
```

注意：同一目录下 `.ps1` 优先于 `.cmd`，若 PATH 前部有 `node_modules\.bin\claude.ps1`，删除它或改用方案 A。
*Note: a `.ps1` in the same directory takes precedence over a `.cmd`; if `node_modules\.bin\claude.ps1` is earlier in PATH, delete it or use Option A.*

### 方案 C：覆盖本地包装脚本 / Option C: Override the local wrapper

```powershell
Copy-Item fix-claude.cmd "$env:CLAUDE_DIR\node_modules\.bin\claude.cmd" -Force
```

缺点：`pnpm install` 会覆盖。*Downside: `pnpm install` overwrites it.*

## 关键路径（通用写法）/ Key Paths (generic)

- 安装根目录 / install root：`%CLAUDE_DIR%`（环境变量，例如 / e.g. `D:\tools\claude-code`）
- 可执行文件 / executable：`%CLAUDE_DIR%\node_modules\@anthropic-ai\claude-code\bin\claude.exe`
- 全局配置 / global config：`%USERPROFILE%\.claude\settings.json`
- 更新锁 / update lock：`%USERPROFILE%\.claude\.update.lock`
- PowerShell Profile：`$PROFILE.CurrentUserAllHosts`
- 启动器脚本 / launcher scripts：本 skill 的 `scripts\fix-claude.cmd`、`scripts\claude-danger.cmd`

## 设置 CLAUDE_DIR / Setting CLAUDE_DIR

```powershell
setx CLAUDE_DIR "D:\tools\claude-code"   # 换成你的安装目录 / use your own install path
```

> 提示 / Tip：在项目目录下运行（`node_modules` 与脚本同级或在其上级）时无需设置 `CLAUDE_DIR`，脚本会自动查找。
> *Running from inside a project directory (`node_modules` at the same level or above the scripts) makes `CLAUDE_DIR` unnecessary — scripts auto-discover it.*

## 危险模式配置 / Danger Mode Configuration

1. `%USERPROFILE%\.claude\settings.json` 必须包含 / *must contain:*
   ```json
   {
     "permissions": {
       "allowDangerouslySkipPermissions": true
     }
   }
   ```
2. 启动方式 / launch with：`fix-claude.cmd --danger` 或 / or `claude-danger.cmd`
3. Claude Code 内部 / inside Claude Code：Shift+Tab 循环切换权限模式，显示 `bypass permissions on` 即生效 / *cycle permission modes with Shift+Tab; `bypass permissions on` means it's active*

## 注意 / Notes

- 修改环境变量后必须新开终端窗口才生效 / *env var changes require a new terminal window*
- 不要用 `setx` 设置空值（会报 Invalid syntax），删除变量用 `[Environment]::SetEnvironmentVariable("NAME", $null, "User")` / *never `setx` an empty value (throws Invalid syntax); delete vars with `[Environment]::SetEnvironmentVariable("NAME", $null, "User")`*
- 自动更新会把 exe 改名导致"找不到文件"，启动器脚本已内置自动恢复逻辑 / *auto-update renames the exe, causing "file not found" — the launcher scripts have auto-restore logic built in*
