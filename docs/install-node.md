# Install Node.js (npm + npx) - Windows · macOS · Linux

`npx secondbrain-connect` needs **Node.js 18 or newer**. Node ships with `npm` and `npx`, so installing Node is all you need.

> **Already have it?** Open a terminal and run `node -v`. If it prints `v18.x` or higher, you're done - go [connect](../README.md#step-2-connect).

---

## How to open a terminal

- **Windows:** press `Win`, type **PowerShell**, hit Enter. (Or **Windows Terminal** / **Command Prompt**.)
- **macOS:** press `Cmd + Space`, type **Terminal**, hit Enter.
- **Linux:** `Ctrl + Alt + T`, or open your **Terminal** app.

---

## 🪟 Windows

### Option A - Official installer (easiest)
1. Open **<https://nodejs.org/en/download>**.
2. Download the **Windows Installer (.msi)** - choose the **LTS** version.
3. Run it. Click **Next** through the wizard; the defaults are correct. Keep **"Add to PATH"** checked.
4. Close any open terminals, open a **new** PowerShell, and verify:
   ```powershell
   node -v
   npm -v
   npx -v
   ```

### Option B - winget (Windows 10/11)
```powershell
winget install OpenJS.NodeJS.LTS
```

### Option C - Chocolatey
```powershell
choco install nodejs-lts
```

---

## 🍎 macOS

### Option A - Official installer (easiest)
1. Open **<https://nodejs.org/en/download>**.
2. Download the **macOS Installer (.pkg)** - choose the **LTS** version (works on Apple Silicon and Intel).
3. Open the `.pkg` and click through the installer.
4. Open **Terminal** and verify:
   ```bash
   node -v
   npm -v
   npx -v
   ```

### Option B - Homebrew
```bash
brew install node
```
No Homebrew yet? Install it from **<https://brew.sh>**, then run the command above.

---

## 🐧 Linux

### Option A - nvm (recommended: no sudo, newest version, easy upgrades)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# close and reopen your terminal (or: source ~/.bashrc), then:
nvm install --lts
node -v
```
nvm project & latest install command: **<https://github.com/nvm-sh/nvm>**

### Option B - NodeSource (system-wide, newest LTS)
Follow the distro instructions at **<https://github.com/nodesource/distributions>** (Debian/Ubuntu/RHEL/Fedora).

### Option C - Distro package manager (may be older)
```bash
# Debian / Ubuntu
sudo apt update && sudo apt install -y nodejs npm

# Fedora
sudo dnf install -y nodejs

# Arch
sudo pacman -S nodejs npm
```
If `node -v` shows something below v18, use **nvm** or **NodeSource** instead.

---

## Verify

```bash
node -v     # v18.0.0 or higher
npm -v
npx -v
```

All three printing a version = you're ready. Next: [Step 2 - Connect](../README.md#step-2-connect).

---

## Notes

- **`npx` is not a separate install.** It comes with `npm`, which comes with Node.js.
- **Restart your terminal** after installing - a terminal opened *before* the install won't see the new `PATH`.
- **Corporate proxy / offline machine?** `npm` honors `HTTP_PROXY` / `HTTPS_PROXY` env vars. If `npx` can't download, set those, or install via your IT-approved package mirror.
