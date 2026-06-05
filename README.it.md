<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain: memoria condivisa per qualsiasi AI

**Dai a Claude, Cursor, ChatGPT, Gemini e a qualsiasi assistente compatibile con MCP un'unica memoria condivisa e persistente, basata sulle tue note [SecondBrain](https://secondbrain.icu).**

Salva un'informazione in un assistente, ritrovala in un altro. Basta ricominciare da zero ogni sessione.

[Sito](https://secondbrain.icu) · [Avvio rapido](#-avvio-rapido-2-minuti) · [Installa Node](#step-1-installa-nodejs) · [Guide per app](#-collega-la-tua-app) · [Problemi](#-risoluzione-problemi)

[🇬🇧 English](README.md) · **🇮🇹 Italiano**

<br>

<img src="assets/how-it-works.svg" alt="Come funziona: i tuoi assistenti AI ricordano e richiamano tramite un'unica memoria SecondBrain condivisa" width="820">

</div>

---

## Cos'è

SecondBrain è la tua memoria personale e persistente. Questo repository è la **guida completa** (con la skill pronta da installare) per collegare qualsiasi assistente AI o agente di coding alla tua memoria.

Una volta collegato, il tuo assistente può:

- **Ricordare** quello che gli hai detto nelle sessioni passate, su *ogni* assistente che colleghi.
- **Salvare** fatti duraturi, decisioni, fix, preferenze e note di progetto nelle *tue* cartelle SecondBrain.
- **Collegare** note correlate tra loro e creare **eventi a calendario / promemoria** che compaiono nell'app.

Tutto gira **lato server** nel tuo SecondBrain. Le tue memorie sono normali note nel tuo albero di cartelle, visibili e modificabili nell'app SecondBrain, e condivise da tutti i tuoi assistenti. Una nota salvata da Claude compare nella ricerca di ChatGPT, e viceversa.

> **Un solo comando configura tutto:** `npx secondbrain-connect`

<div align="center">

<table>
<tr>
<td align="center" width="25%"><img src="assets/screenshots/app-chat.png" width="200" alt="Parlaci"><br><sub><b>Chiedi e basta</b>, parlaci</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-notes.png" width="200" alt="Note perfette"><br><sub><b>Note perfette</b>, strutturate</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-folders.png" width="200" alt="Archiviate da sole"><br><sub><b>Archiviate</b> nelle cartelle</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-calendar.png" width="200" alt="Calendario e promemoria"><br><sub><b>Calendario</b> e promemoria</sub></td>
</tr>
</table>

<sub>La tua memoria vive nell'app SecondBrain: i tuoi assistenti leggono e scrivono le stesse note.</sub>

</div>

---

## Prima di iniziare (prerequisiti)

Ti servono due cose:

1. **L'app SecondBrain con abbonamento Pro.** La memoria condivisa è una funzione **Pro**. Scarica l'app e passa a Pro al suo interno: [secondbrain.icu](https://secondbrain.icu). (Il Pro si attiva solo dall'app.)
2. **Node.js 18 o superiore**, che ti fornisce i comandi `npm` e `npx`. Se non ce l'hai ancora, vedi lo [Step 1](#step-1-installa-nodejs) qui sotto: bastano 2 minuti su Windows, macOS o Linux.

Tutto qui. **Non** devi copiare nessun token, modificare file JSON a mano o essere tecnico. Fa tutto il comando di connessione.

---

## ⚡ Avvio rapido (2 minuti)

Apri un **terminale** (vedi [come aprire un terminale](docs/install-node.md#how-to-open-a-terminal) se non sei sicuro) ed esegui:

```bash
npx secondbrain-connect
```

Questo singolo comando farà:

1. Aprire il browser per il **login** (Google o Apple): niente password, niente token da copiare.
2. Creare un **token di accesso revocabile** legato al tuo account.
3. **Configurare automaticamente** ogni assistente che trova sul tuo computer (Claude Code, Claude Desktop, Cursor).
4. **Installare la skill di memoria**, così Claude sa *quando* usare la memoria.

<div align="center">
<img src="assets/screenshots/terminal.png" width="640" alt="Output di npx secondbrain-connect: ti fa il login, configura Claude Code, Claude Desktop e Cursor, installa la skill">
</div>

Poi **chiudi del tutto e riapri** il tuo assistente (chiudi l'app, non solo la finestra). Fatto: il tuo assistente ora ha memoria.

> Prova: chiedi al tuo assistente *"Cosa ti ricordi di me?"* oppure digli *"Ricorda che preferisco i tab agli spazi"*, poi richiediglielo in una nuova chat.

Se non hai ancora `npx`, fai prima lo [Step 1](#step-1-installa-nodejs). Per un'app specifica, vai a [Collega la tua app](#-collega-la-tua-app).

---

## Step 1: Installa Node.js

`npx` arriva insieme a Node.js. Installare Node.js una volta ti dà tutto. Scegli il tuo sistema operativo.

> **Controlla prima:** potresti averlo già. Esegui `node -v` in un terminale. Se stampa `v18.x` o superiore, salta allo [Step 2](#step-2-connetti).

<details open>
<summary><b>🪟 Windows</b></summary>

**Il modo più semplice, installer ufficiale:**
1. Vai su **<https://nodejs.org/en/download>** e scarica il **Windows Installer (.msi)**, versione **LTS**.
2. Avvialo e clicca **Next** lungo la procedura (i valori predefiniti vanno bene).
3. Apri un nuovo **PowerShell** o **Prompt dei comandi** e verifica:
   ```powershell
   node -v
   npm -v
   ```

**Oppure con un package manager (opzionale):**
```powershell
winget install OpenJS.NodeJS.LTS
```
(In alternativa: `choco install nodejs-lts` se usi Chocolatey.)

</details>

<details open>
<summary><b>🍎 macOS</b></summary>

**Il modo più semplice, installer ufficiale:**
1. Vai su **<https://nodejs.org/en/download>** e scarica il **macOS Installer (.pkg)**, versione **LTS**.
2. Aprilo e segui la procedura.
3. Apri il **Terminale** e verifica:
   ```bash
   node -v
   npm -v
   ```

**Oppure con Homebrew (opzionale):**
```bash
brew install node
```
(Non hai Homebrew? Installalo da <https://brew.sh>.)

</details>

<details open>
<summary><b>🐧 Linux</b></summary>

**Consigliato, nvm (funziona su ogni distro, senza sudo, facile da aggiornare):**
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# chiudi e riapri il terminale, poi:
nvm install --lts
node -v
```
Documentazione nvm: <https://github.com/nvm-sh/nvm>

**Oppure i pacchetti della tua distro:**
```bash
# Debian / Ubuntu (potrebbero essere vecchi; nvm o NodeSource danno versioni più recenti)
sudo apt update && sudo apt install -y nodejs npm

# Fedora
sudo dnf install -y nodejs

# Arch
sudo pacman -S nodejs npm
```
Per la versione più recente su Debian/Ubuntu usa **NodeSource**: <https://github.com/nodesource/distributions>

</details>

> **Perché Node?** `npx` è uno strumento incluso in `npm`, e `npm` arriva con Node.js. Non c'è nient'altro da installare: appena `node -v` funziona, funziona anche `npx`. Guida completa: [docs/install-node.md](docs/install-node.md) (in inglese).

---

## Step 2: Connetti

Nel terminale:

```bash
npx secondbrain-connect
```

- La prima volta, npx chiede di installare il pacchetto: premi **Invio** per accettare.
- Scegli **Google** (consigliato) o **Apple** quando richiesto, poi completa il login nel browser.
- Quando vedi **"Done. Your assistant can now use SecondBrain memory."**, la configurazione è completa.

<div align="center">
<img src="assets/screenshots/connect-signin.png" width="300" alt="Pagina di login SecondBrain: Continua con Apple o Google">
<br><sub>La pagina di login che si apre nel browser.</sub>
</div>

> 💡 Non sei ancora Pro? Il comando te lo dirà e ti darà un link per l'upgrade. Passa a Pro nell'app SecondBrain, poi rilancialo.

---

## Step 3: Riavvia e verifica

1. **Chiudi del tutto** il tuo assistente (Claude Desktop, Cursor, ecc.): *chiudi l'app, non solo la finestra*, e riaprilo. (Per Claude Code nel terminale, basta avviare una nuova sessione.)
2. Chiedigli qualcosa che usi la memoria:
   - *"Salva una nota: il mio colore preferito è il verde acqua."*
   - Apri una nuova chat: *"Qual è il mio colore preferito?"*

Se se lo ricorda tra chat diverse, sei connesso. 🎉

---

## 🔌 Collega la tua app

`npx secondbrain-connect` configura già automaticamente le app qui sotto. Queste sezioni mostrano cosa ha fatto e come farlo **manualmente**, se preferisci o se la tua app non è stata rilevata.

### Claude Code

**Automatico:** `npx secondbrain-connect` esegue `claude mcp add` per te (a livello utente).

**Manuale:**
```bash
claude mcp add --transport http secondbrain \
  https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer IL_TUO_TOKEN" \
  --scope user
```
- Vuoi configurarlo per singolo progetto invece che globale? Usa `--scope project` (scrive `.mcp.json` nel repo), oppure esegui `npx secondbrain-connect --project`.
- Verifica con `claude mcp list`. Avvia una nuova sessione per caricarlo.

👉 Guida completa: [docs/claude-code.md](docs/claude-code.md) (in inglese)

### Claude Desktop

**Automatico:** il comando scrive il tuo `claude_desktop_config.json` usando il bridge `mcp-remote` (Claude Desktop parla con i server remoti tramite questo).

**Manuale:** apri il file di configurazione e aggiungi il server:

| Sistema | File di configurazione |
|----|-------------|
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

```json
{
  "mcpServers": {
    "secondbrain": {
      "command": "npx",
      "args": [
        "-y", "mcp-remote",
        "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
        "--header", "Authorization: Bearer IL_TUO_TOKEN"
      ]
    }
  }
}
```
Poi **chiudi del tutto e riapri** Claude Desktop.

👉 Guida completa: [docs/claude-desktop.md](docs/claude-desktop.md) (in inglese)

### Cursor

**Automatico:** scrive `~/.cursor/mcp.json`.

**Manuale**, in `~/.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "secondbrain": {
      "type": "http",
      "url": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
      "headers": { "Authorization": "Bearer IL_TUO_TOKEN" }
    }
  }
}
```
Riavvia Cursor (oppure attiva/disattiva il server in **Settings → MCP**).

👉 Guida completa: [docs/cursor.md](docs/cursor.md) (in inglese)

### Tutto il resto (VS Code, Windsurf, Gemini CLI, ChatGPT, ...)

Qualsiasi client che supporti **server MCP remoti** può collegarsi con gli stessi due valori:

- **URL:** `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`
- **Header:** `Authorization: Bearer IL_TUO_TOKEN`

I client che parlano solo **stdio** possono usare il bridge:
```bash
npx -y mcp-remote https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer IL_TUO_TOKEN"
```

👉 Ricette per ogni client: [docs/other-clients.md](docs/other-clients.md) (in inglese)

> **Dov'è `IL_TUO_TOKEN`?** Vedi [Come ottenere il tuo token](docs/manual-setup.md#how-to-get-your-token): il modo più facile è `npx secondbrain-connect --project` in una cartella vuota, che scrive un `.mcp.json` contenente il token.

---

## 🧠 La skill di memoria (per Claude)

Il comando di connessione installa anche una piccola **skill** che insegna a Claude *quando* richiamare e salvare: all'inizio di un task, quando si raggiunge una decisione o un fix, quando esprimi una preferenza duratura o quando fai riferimento a qualcosa di una sessione passata.

- **Installata automaticamente in:** `~/.claude/skills/secondbrain-memory/SKILL.md`
- **Installazione manuale:** copia [`skill/secondbrain-memory/SKILL.md`](skill/secondbrain-memory/SKILL.md) da questo repo in quella cartella.

| Sistema | Cartella della skill |
|----|--------------|
| Windows | `%USERPROFILE%\.claude\skills\secondbrain-memory\` |
| macOS / Linux | `~/.claude/skills/secondbrain-memory/` |

La skill è opzionale ma consigliata: fa sembrare la memoria automatica, invece di qualcosa che devi chiedere ogni volta.

---

## 🔧 Gestisci la connessione

```bash
npx secondbrain-connect status          # elenca i tuoi token connessi (id, etichetta, ultimo uso)
npx secondbrain-connect revoke <id>     # revoca un token (vedi gli id con `status`)
npx secondbrain-connect revoke --all    # revoca tutti i token
npx secondbrain-connect logout          # rimuove le credenziali locali su questo computer
```

**Flag utili per `connect`:**

| Flag | Cosa fa |
|------|--------------|
| `--google` / `--apple` | Sceglie il provider di login (predefinito: Google). |
| `--project` | Scrive `./.mcp.json` nella cartella corrente invece della configurazione globale. |
| `--agent <nome>` | Cartella in cui salvare le note di questo assistente (predefinito: `claude`). |
| `--label <testo>` | Un'etichetta per il token (compare in `status`). |
| `--port <n>` | Porta loopback per il login (predefinito: `8788`). |

**Più assistenti o più computer?** Esegui `npx secondbrain-connect` su ognuno. Ogni connessione crea il proprio token revocabile, ma puntano tutti alla **stessa memoria**: così il Claude del portatile e il Cursor del fisso condividono tutto.

---

## 🛠️ Cosa può fare il tuo assistente (tool)

| Tool | A cosa serve |
|------|---------|
| `memory_search` | Ricerca per parole chiave in tutto il tuo SecondBrain (con possibilità di limitarla a una cartella). |
| `memory_get` | Legge il contenuto completo di una nota. |
| `memory_list` | Sfoglia l'albero delle cartelle e le note recenti. |
| `memory_save` | Salva una nuova nota nel tuo albero di cartelle esistente. |
| `memory_update` | Modifica una nota sul posto. |
| `memory_link` | Collega note correlate (link incrociati tappabili nell'app). |
| `memory_delete` | Elimina una nota (dopo tua conferma). |
| `calendar_create_event` | Crea un evento a calendario (inizio + fine). |
| `reminder_create` | Crea un promemoria singolo. |
| `calendar_search` | Cerca tra eventi e promemoria. |
| `secondbrain_login` | Login in chat di riserva, se non hai usato la CLI. |

👉 Dettagli: [docs/tools.md](docs/tools.md) (in inglese)

---

## 🔒 Privacy e sicurezza

- **I tuoi dati, le tue note.** Le memorie vengono salvate nelle tue cartelle SecondBrain: niente silo separato. Vedi e modifichi tutto nell'app.
- **Token revocabili.** La CLI crea un token opaco (`sbm_…`) salvato sul server solo come hash, limitato **solo** ai tool di memoria, e revocabile in qualsiasi momento con `revoke`.
- **Nessuna password condivisa.** Il login usa direttamente Apple/Google; la CLI non vede mai la tua password e scrive solo i file di configurazione MCP locali.
- **Pro ricontrollato a ogni chiamata.** L'accesso segue il tuo abbonamento.
- Le credenziali locali stanno in `~/.secondbrain/credentials.json` (leggibile solo da te).

---

## 🩹 Risoluzione problemi

<details>
<summary><b>"command not found: npx" / "node non riconosciuto"</b></summary>

Node.js non è installato o il terminale è stato aperto prima dell'installazione. Fai lo [Step 1](#step-1-installa-nodejs), poi **apri un nuovo terminale** ed esegui `node -v`.
</details>

<details>
<summary><b>Il login nel browser non si è aperto</b></summary>

Il terminale stampa un URL: incollalo nel browser a mano. Se la pagina non riesce a raggiungere la porta loopback, esegui `npx secondbrain-connect --port 8799` (qualsiasi porta libera).
</details>

<details>
<summary><b>"pro_required" / dice che mi serve Pro</b></summary>

La memoria condivisa è una funzione Pro. Apri l'**app SecondBrain**, passa a **Pro** (l'unico posto dove farlo), poi rilancia `npx secondbrain-connect`.
</details>

<details>
<summary><b>Il login con Apple non funziona</b></summary>

Usa **Google**: `npx secondbrain-connect --google`. Collega lo stesso account e la stessa memoria.
</details>

<details>
<summary><b>Dopo la connessione il mio assistente non vede la memoria</b></summary>

**Chiudi del tutto e riapri** l'app (chiudi l'applicazione, non solo la finestra). Per Claude Code avvia una nuova sessione. Verifica che il server sia presente (`claude mcp list`, oppure controlla le impostazioni MCP dell'app).
</details>

<details>
<summary><b>Voglio ricominciare da capo</b></summary>

`npx secondbrain-connect logout` (cancella le credenziali locali) e `npx secondbrain-connect revoke --all` (disabilita i token lato server), poi riconnetti.
</details>

👉 Altro: [docs/troubleshooting.md](docs/troubleshooting.md) (in inglese)

---

## ❓ Domande frequenti

**È gratis?** L'app è gratuita; la **memoria condivisa è Pro**. Passa a Pro dall'app.

**Quali assistenti sono supportati?** Tutto ciò che parla MCP. Configurazione automatica di prima classe per **Claude Code, Claude Desktop e Cursor**; tutto il resto si collega con URL + token (vedi [altri client](docs/other-clients.md)).

**I miei dati escono da SecondBrain?** No. Le memorie sono le tue note nel tuo account. Solo l'assistente che colleghi può leggerle/scriverle, usando il tuo token revocabile.

**Posso usarlo su più di un computer?** Sì, esegui `npx secondbrain-connect` su ciascuno. Condividono un'unica memoria.

**Devo usare il terminale per sempre?** No. Lo usi una volta per connetterti. Dopo, la memoria funziona da sola dentro il tuo assistente.

---

## 📁 Contenuto del repo

```
README.md                          guida in inglese
README.it.md                       questa guida (italiano)
skill/secondbrain-memory/SKILL.md  la skill di memoria per Claude (pronta da installare)
docs/install-node.md               installazione di Node/npm/npx (Windows · macOS · Linux)
docs/claude-code.md                guida completa Claude Code
docs/claude-desktop.md             guida completa Claude Desktop
docs/cursor.md                     guida completa Cursor
docs/other-clients.md              VS Code · Windsurf · Gemini CLI · ChatGPT · generico
docs/manual-setup.md               ottenere il token + configurazione manuale
docs/tools.md                      i tool di memoria, in dettaglio
docs/troubleshooting.md            soluzioni ai problemi comuni
```

---

<div align="center">

Fatto con 🧠 da **SecondBrain** · [secondbrain.icu](https://secondbrain.icu)

</div>
