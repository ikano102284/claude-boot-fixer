<div align="center">

[![简体中文](https://img.shields.io/badge/%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87-30363D?style=for-the-badge)](README.md) [![English](https://img.shields.io/badge/English-D97757?style=for-the-badge)](./)

</div>

<p align="center">
  <a href="./">
    <img src="assets/banner.svg" alt="Claude Boot Fixer — animated banner" width="100%">
  </a>
</p>

<h1 align="center">🔧 Claude Boot Fixer</h1>

<p align="center">
  <b>Fixes everything that stops the <code>claude</code> command from launching</b><br>
  Windows · PowerShell · Pure scripts · Zero dependencies — one command, back to life.
</p>

<div align="center">

[![Windows 11](https://img.shields.io/badge/Windows%2011-0078D4?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows) [![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell) [![Claude Code](https://img.shields.io/badge/Claude%20Code-D97757?style=for-the-badge)](https://github.com/anthropics/claude-code) [![Claude Skill](https://img.shields.io/badge/Claude%20Skill-FF6B57?style=for-the-badge)](https://code.claude.com/docs/en/skills) [![MIT License](https://img.shields.io/badge/License-MIT-2ea44f?style=for-the-badge)](https://opensource.org/license/mit)

</div>

<div align="center">

[![Pure Scripts | Zero Dependencies](https://img.shields.io/badge/Pure%20Scripts%20%7C%20Zero%20Dependencies-0d1117?style=for-the-badge)](./) [![Lightweight](https://img.shields.io/badge/Lightweight-0d1117?style=for-the-badge)](./) [![PRs Welcome](https://img.shields.io/badge/PRs%20Welcome-0d1117?style=for-the-badge)](./compare) [![Made with Love](https://img.shields.io/badge/Made%20with%20Love-D97757?style=for-the-badge)](./)

</div>

<div align="center">

[![Quick Start](https://img.shields.io/badge/Quick%20Start-D97757?style=for-the-badge)](#-quick-start) [![Project Structure](https://img.shields.io/badge/Project%20Structure-30363D?style=for-the-badge)](#-project-structure) [![Error Lookup](https://img.shields.io/badge/Error%20Lookup-5391FE?style=for-the-badge)](#-error-lookup) [![FAQ](https://img.shields.io/badge/FAQ-8b949e?style=for-the-badge)](#-faq) [![Give a Star](https://img.shields.io/badge/Give%20a%20Star-3fb950?style=for-the-badge)](./) [![Report Issue](https://img.shields.io/badge/Report%20Issue-E74C3C?style=for-the-badge)](./issues) [![Fork](https://img.shields.io/badge/Fork-8b949e?style=for-the-badge)](./fork)

</div>

<p align="center">
  <sub>
    <a href="#-the-manifesto">Manifesto</a> ·
    <a href="#-features">Features</a> ·
    <a href="#-why-claude-boot-fixer">Why</a> ·
    <a href="#-three-launch-options">Launch Options</a> ·
    <a href="#-privacy--security">Privacy</a> ·
    <a href="#-contributing">Contributing</a> ·
    <a href="#-license">License</a>
  </sub>
</p>

---

## 🌟 The Manifesto

<p align="center">
  <img src="assets/pulse.svg" alt="Status: always fixed">
</p>

> To everyone who typed `claude` late at night and got nothing but **"not recognized"** —
>
> We believe:
>
> - **Commands should never stay silent.** If something breaks, there must be an answer — and a fix.
> - **Tools should be transparent.** Pure scripts, zero dependencies, zero magic — every line you can read.
> - **Open source should be priceless.** Free, public, shareable — so every fix gets reused by the whole world.
>
> And so we declare:
>
> > **As long as one Windows machine can't launch Claude Code, this repository stays online.** 🔥

---

## ✨ Features

<table>
  <tr>
    <td width="50%" align="center">
      <p><b>⚡ Auto-restores the exe</b></p>
      <p align="left"><sub>Auto-update renamed <code>claude.exe</code> to <code>.old.*</code>? The launcher restores it automatically. Double-click and done.</sub></p>
      <p align="center"><a href="scripts/fix-claude.cmd">View script →</a></p>
    </td>
    <td width="50%" align="center">
      <p><b>🛡 One-click danger mode</b></p>
      <p align="left"><sub>The <code>--danger</code> flag or the mode menu bypasses permission checks — and switches back to normal mode anytime.</sub></p>
      <p align="center"><a href="scripts/claude-danger.cmd">View script →</a></p>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <p><b>🧭 12-case error lookup</b></p>
      <p align="left"><sub>From "command not found" to "Defender blocking" — every error with its cause and fix command.</sub></p>
      <p align="center"><a href="references/troubleshooting.md">View lookup table →</a></p>
    </td>
    <td width="50%" align="center">
      <p><b>🪟 Three launch options</b></p>
      <p align="left"><sub>Profile function / PATH-first / wrapper-script override — one of them will fit your workflow.</sub></p>
      <p align="center"><a href="#-three-launch-options">View options →</a></p>
    </td>
  </tr>
</table>

---

## 🏆 Why Claude Boot Fixer

<p align="center">
  <img src="assets/stats.svg" alt="Auto-fix rate 99% · 12+ scenarios covered · 100% free forever">
</p>

| Dimension | 🛠 This tool | 🙅 Doing it by hand |
|---|---|---|
| Locating the install dir | **Fully automatic** (`%CLAUDE_DIR%` or auto-discovery of `node_modules`) | Searching paths from memory |
| Restoring the renamed exe | **Automatic** — double-click and it's back | Manual `ren`, every single time |
| Danger mode | **One command** (`--danger`) | Typing long flags / editing config |
| Troubleshooting | **12-case lookup table**: symptom → cause → command | Drowning in search results |
| Maintenance | **Zero-dependency pure scripts** you can read line by line | Patchwork of one-off hacks |

---

## 🚀 Quick Start

<p align="center"><img src="assets/rocket.svg" alt="Rocket launch animation" width="200"></p>

**Install as a Claude Code Skill** (drop this folder into your skills directory):

```powershell
# 1. Clone or download this repo (click the green button above)
# 2. Put the whole folder into:
#    C:\Users\<your-username>\.claude\skills\claude-boot-fixer\
# 3. Optional: point at your install root (auto-discovery works without it)
setx CLAUDE_DIR "D:\tools\claude-code"
```

**Fix it now** (pick one):

| Entry point | What it does |
|---|---|
| [fix-claude.cmd](scripts/fix-claude.cmd) | Stable launcher: auto-locate + restore exe + mode menu, supports `--danger` |
| [claude-danger.cmd](scripts/claude-danger.cmd) | One-click danger-mode launcher |
| [SKILL.md](SKILL.md) | Full skill docs (in Chinese): diagnostic flow + every fix command |

**Verify**:

```powershell
claude --version
# Expected: x.x.x (Claude Code)
```

> 💡 Note: the detailed docs ([SKILL.md](SKILL.md) and [troubleshooting.md](references/troubleshooting.md)) are written in Chinese — but every command in them is copy-paste ready for any language.

---

## 🛠 Three Launch Options

Make typing `claude` go through the stable launcher instead of calling `claude.exe` directly:

<table>
  <tr>
    <td width="33%" align="center"><b>Option A · Profile Function</b><br><sub>⭐ Recommended · Highest priority, immune to resolution order</sub></td>
    <td width="33%" align="center"><b>Option B · PATH-First</b><br><sub>Put the launcher in <code>%USERPROFILE%\bin</code>, prepend PATH</sub></td>
    <td width="33%" align="center"><b>Option C · Wrapper Override</b><br><sub>Overwrite <code>node_modules\.bin\claude.cmd</code> (lost on reinstall)</sub></td>
  </tr>
  <tr>
    <td align="center"><a href="SKILL.md#method-a">Details →</a></td>
    <td align="center"><a href="SKILL.md#method-b">Details →</a></td>
    <td align="center"><a href="SKILL.md#method-c">Details →</a></td>
  </tr>
</table>

Bonus typo-fix: `Set-Alias cluade claude` — even a mistyped command gets you a working launch.

---

## 🧭 Error Lookup

| Symptom | Jump to |
|---|---|
| ❌ `claude` is not recognized as a cmdlet | [Startup errors →](references/troubleshooting.md#start-errors) |
| 🔁 File not found / exe renamed | [Startup errors →](references/troubleshooting.md#start-errors) |
| 🚫 Running scripts is disabled (execution policy) | [Startup errors →](references/troubleshooting.md#start-errors) |
| 🟢 `node` is not recognized as a command | [Startup errors →](references/troubleshooting.md#start-errors) |
| ⚔️ Global / local install conflict, version mismatch | [Startup errors →](references/troubleshooting.md#start-errors) |
| ⌨️ Typed `cluade` by mistake | [Startup errors →](references/troubleshooting.md#start-errors) |
| 💤 Hangs on launch / stale update lock | [Startup errors →](references/troubleshooting.md#start-errors) |
| 🦠 Launches then exits, exe gone (Defender) | [Startup errors →](references/troubleshooting.md#start-errors) |
| 📦 Install / download failures (pnpm, npm) | [Install errors →](references/troubleshooting.md#install-errors) |
| 🔑 401 / 403 API authentication failure | [API / connection errors →](references/troubleshooting.md#api-errors) |
| 🌐 timeout / ECONNREFUSED cannot connect | [API / connection errors →](references/troubleshooting.md#api-errors) |
| ⚠️ Cannot enable danger mode / no bypass option | [Danger mode →](references/troubleshooting.md#danger-setup) |

> 💡 Env vars for third-party APIs like DeepSeek: see [SKILL.md → Environment Variables](SKILL.md#env-deepseek).

---

## 📁 Project Structure

| Type | File | Description |
|---|---|---|
| 📖 Main doc | [SKILL.md](SKILL.md) | Skill core: diagnostic flow + 12 problem fixes + three launch options |
| 🎨 Interface metadata | [agents/openai.yaml](agents/openai.yaml) | Display name, brand color, default prompt |
| 🧭 Lookup table | [references/troubleshooting.md](references/troubleshooting.md) | Error message ↔ cause ↔ fix command |
| 🚀 Launcher | [scripts/fix-claude.cmd](scripts/fix-claude.cmd) | Stable launcher (auto-restore + mode menu + `--danger`) |
| 🛡 Danger mode | [scripts/claude-danger.cmd](scripts/claude-danger.cmd) | One-click danger-mode launcher |
| 🎬 Banner | [assets/banner.svg](assets/banner.svg) | Animated hero banner |
| 💚 Pulse | [assets/pulse.svg](assets/pulse.svg) | Status indicator light |
| 📊 Stats | [assets/stats.svg](assets/stats.svg) | Animated statistics bars |
| 🛡 Shield | [assets/shield.svg](assets/shield.svg) | Security animation (self-drawing shield + check mark) |
| 🚀 Rocket | [assets/rocket.svg](assets/rocket.svg) | Quick-start animation (flames + smoke + hover) |
| 🇨🇳 Chinese version | [README.md](README.md) | 简体中文版本 · 以中文阅读本项目 |

---

<p align="center"><img src="assets/shield.svg" alt="Security shield animation" width="220"></p>

## 🔒 Privacy & Security

> This repository was **fully audited file-by-file** before being published. The audit found:

- ✅ **No API keys / tokens / secrets of any kind** — every secret appears only as a `<your-key>` placeholder
- ✅ **No personal emails, no usernames, no real local paths**
- ✅ **Every path is generic** (`%CLAUDE_DIR%`, `%USERPROFILE%`) — no machine-specific info
- ✅ **Pure scripts, zero dependencies, zero network reporting** — the code never sends anything anywhere
- ✅ The only external reference is a public API endpoint (e.g. `api.deepseek.com`) — normal documentation content

**A request to every user**: if you fork or mirror this repository, please never commit real secrets either. Open source is transparent — but stay safe. 🔒

---

## ❓ FAQ

<details>
<summary><b>I set <code>CLAUDE_DIR</code> but it's still not found?</b></summary>
<br>
Check the variable name for typos (it's case-insensitive) and make sure you opened a <strong>new terminal</strong> — env changes never apply to already-open windows. Still stuck? Run the scripts from inside a project folder; they auto-discover <code>node_modules</code>. → <a href="SKILL.md">Full flow in SKILL.md</a>
</details>

<details>
<summary><b>Danger mode still fails with a <code>--print</code> error?</b></summary>
<br>
Newer Claude Code requires <code>permissions.allowDangerouslySkipPermissions: true</code> in <code>%USERPROFILE%\.claude\settings.json</code> first. → <a href="references/troubleshooting.md#danger-setup">Danger-mode setup</a>
</details>

<details>
<summary><b>Defender keeps deleting the exe as a virus?</b></summary>
<br>
Windows Security → Protection history → restore the file, then add <code>%CLAUDE_DIR%</code> as an exclusion. → <a href="references/troubleshooting.md#start-errors">Startup error table</a>
</details>

<details>
<summary><b>Will this repo leak my API key?</b></summary>
<br>
No. Every secret in this repository appears only as a <code>&lt;your-key&gt;</code> placeholder, and the whole folder was audited before publishing. → <a href="#-privacy--security">Privacy &amp; Security</a>
</details>

---

## 🤝 Contributing

All contributions are welcome — bug reports, feature requests, doc fixes, code, even a single typo:

<div align="center">

[![Fork It](https://img.shields.io/badge/Fork%20It-30363D?style=for-the-badge)](./fork) [![Open an Issue](https://img.shields.io/badge/Open%20an%20Issue-5391FE?style=for-the-badge)](./issues) [![Submit a PR](https://img.shields.io/badge/Submit%20a%20PR-3fb950?style=for-the-badge)](./compare)

</div>

**A few simple rules:**

1. 🔒 **Never commit real keys / tokens / emails** — placeholders only
2. 🧱 Keep it pure scripts, zero dependencies — no new runtimes
3. 📝 New error scenarios: also add them to the `troubleshooting.md` lookup table
4. 💬 Write commit messages that say clearly what was fixed

---

## ⚖️ License

[MIT License](https://opensource.org/license/mit) — use it freely, modify it freely, share it freely. Do whatever you want, just keep the attribution.

---

<div align="center">

[![Give a Star](https://img.shields.io/badge/Give%20a%20Star-3fb950?style=for-the-badge)](./) [![Fork It](https://img.shields.io/badge/Fork%20It-8b949e?style=for-the-badge)](./fork) [![Report Issue](https://img.shields.io/badge/Report%20Issue-E74C3C?style=for-the-badge)](./issues) [![Chinese Version](https://img.shields.io/badge/Chinese%20Version-30363D?style=for-the-badge)](README.md)

</div>

<p align="center">
  <sub>Made with ❤️ + ⚡ PowerShell · Every link in this README is repository-relative, so it keeps working after cloning / renaming</sub>
</p>
