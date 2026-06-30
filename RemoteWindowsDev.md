# Remote Windows Dev (.NET / C#) from macOS

Set up VS Code **Remote-SSH** coding against a Windows host for .NET / C#
development, driven from a Mac. The **Windows App** (RDP) is used on the Mac for
the initial GUI bootstrap; after that, day-to-day work happens over SSH from
VS Code on the Mac.

```
┌─────────────┐   RDP (Windows App)  ┌──────────────────────────┐
│             │ ───────────────────► │  Windows host "winhost"  │
│   macOS     │                      │  - OpenSSH Server (:22)  │
│  VS Code    │   SSH (Remote-SSH)   │  - .NET SDK / dotnet     │
│  Windows App│ ───────────────────► │  - VS Code (remote svr)  │
└─────────────┘                      └──────────────────────────┘
```

> All Windows commands below are PowerShell, run **as Administrator** unless
> noted.
>
> **Placeholders:** swap in your own values for `devuser` (Windows user),
> `winhost` (machine name), `your-org` (GitHub org) and `ExampleApp` (project).

---

## 1. macOS side

| App | Source |
|-----|--------|
| Windows App (RDP client) | [App Store](https://apps.apple.com/app/windows-app/id1295203466) |
| Visual Studio Code | [code.visualstudio.com](https://code.visualstudio.com/download) |

Install the VS Code **Remote - SSH** extension:

```bash
code --install-extension ms-vscode-remote.remote-ssh
```

Use **Windows App** to open an RDP session to the Windows host for the one-time
bootstrap in the next sections.

---

## 2. Windows side — core tooling (winget)

```powershell
# GNU coreutils (ls, etc.)
winget install -e --id Microsoft.Coreutils --source winget

# Git + GitHub CLI
winget install -e --id Git.Git    --source winget
winget install -e --id GitHub.cli --source winget

# Editor + AI assistant
winget install -e --id Microsoft.VisualStudioCode --source winget
winget install -e --id Anthropic.ClaudeCode       --source winget

# Neovim (quick edits over SSH)
winget install -e --id Neovim.Neovim --source winget

# Nmap / ncat (handy for connectivity testing)
winget install -e --id Insecure.Nmap --source winget
```

### SSH client capability

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
ssh -V
git --version
```

### GitHub auth + VS Code extensions

```powershell
gh auth login                         # interactive; or: gh auth login -h github.com

code --install-extension GitHub.vscode-pull-request-github
code --install-extension ms-python.python
# C#/.NET work also wants:
code --install-extension ms-dotnettools.csdevkit
```

### .NET SDK

```powershell
winget install -e --id Microsoft.DotNet.SDK.9 --source winget   # match your project's target
```

> **Tip:** If `dotnet` isn't found in a fresh shell, prepend it to `PATH`:
> ```powershell
> $env:Path = "$env:ProgramFiles\dotnet;$env:Path"
> ```

---

## 3. OpenSSH Server (so the Mac can reach in)

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Start-Service sshd
Set-Service -Name sshd -StartupType Automatic

# Confirm it installed
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
```

> If `Add-WindowsCapability` fails on a flaky image, repair it first:
> ```powershell
> DISM /Online /Cleanup-Image /RestoreHealth
> sfc /scannow
> ```

### Firewall + network profile

```powershell
New-NetFirewallRule -Name OpenSSH-Server-In-TCP -DisplayName "OpenSSH Server (sshd)" `
  -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
Get-NetFirewallRule -Name OpenSSH-Server-In-TCP

# The default OpenSSH rule only allows Private networks — mark the NIC Private
Set-NetConnectionProfile -InterfaceAlias "Ethernet" -NetworkCategory Private
```

### Default SSH shell → PowerShell 7

So Remote-SSH and interactive sessions land in `pwsh` (see §4 for the install):

```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell `
  -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force
Restart-Service sshd
```

### Test locally

```powershell
ssh devuser@localhost
```

---

## 4. PowerShell 7 + shell profile

```powershell
winget install -e --id Microsoft.PowerShell --source winget
Test-Path "C:\Program Files\PowerShell\7\pwsh.exe"
```

> **Tip:** If the default installer drops `pwsh.exe` somewhere unexpected (so the
> path above is missing), reinstall with the MSI/wix installer:
> ```powershell
> winget uninstall -e --id Microsoft.PowerShell --source winget
> winget install   -e --id Microsoft.PowerShell --source winget --installer-type wix
> Test-Path "C:\Program Files\PowerShell\7\pwsh.exe"
> ```

### Profile + `vi` → `nvim` alias

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
New-Item -ItemType File -Path $PROFILE -Force
Add-Content $PROFILE "`nSet-Alias -Name vi -Value nvim"
. $PROFILE
```

---

## 5. Host identity

```powershell
Rename-Computer -NewName "winhost" -Restart
```

---

## 6. Clone & build the .NET project

```powershell
cd ~
mkdir Git\your-org
cd Git\your-org

git clone git@github.com:your-org/ExampleApp-Windows.git
git clone git@github.com:your-org/ExampleApp-OSX.git

code .\ExampleApp-Windows\
```

### Run / package

```powershell
cd ~\Git\your-org\ExampleApp-Windows

# Run the app
dotnet run --project src\ExampleApp.App

# Build an MSIX package
powershell -ExecutionPolicy Bypass -File packaging\build-msix.ps1 -Version 1.0.0.0

# Install locally for testing
powershell -ExecutionPolicy Bypass -File packaging\install-local.ps1

# Remove a previously installed package
Get-AppxPackage *ExamplePublisher.ExampleApp* | Remove-AppxPackage
```

---

## 7. Connect from the Mac

On the **Mac**, add the host to `~/.ssh/config`:

```sshconfig
Host winhost
    HostName winhost.local           # or the host's IP / WireGuard address
    User devuser
```

Then in VS Code on the Mac:

1. **Cmd-Shift-P → Remote-SSH: Connect to Host… → `winhost`**
2. Open `~/Git/your-org/ExampleApp-Windows` on the remote.
3. Let the C# Dev Kit install into the remote VS Code server, then `dotnet run`
   from the integrated terminal — all executing on Windows, edited from the Mac.

> **Tip:** Use key-based auth — copy your Mac public key into the Windows
> `C:\Users\devuser\.ssh\authorized_keys` (and, for admin users,
> `C:\ProgramData\ssh\administrators_authorized_keys`) to skip password prompts.
