<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain: una sola memoria per tutte le tue AI

**La tua AI dimentica tutto appena chiudi la chat. SecondBrain le dà una memoria.**

Diglielo una volta — ogni assistente che usi se lo ricorda, nella chat dopo e il mese prossimo.

[🇬🇧 English](README.md) · [🇮🇹 Italiano](README.it.md) · [secondbrain.icu](https://secondbrain.icu)

<br>

<img src="assets/secondbrain-flow.png" alt="I tuoi assistenti AI ricordano e richiamano grazie a un'unica memoria SecondBrain" width="780">

</div>

---

## Cos'è?

Di solito la tua AI riparte da zero a ogni conversazione: le rispieghi chi sei, a cosa stai lavorando, le tue preferenze. Ogni volta da capo.

**SecondBrain è una memoria condivisa per i tuoi assistenti.** Glielo dici una volta e resta: il tuo assistente se lo ricorda domani, la settimana prossima, e anche se passi a un'altra app di AI. La memoria sono semplicemente le tue note nell'app SecondBrain — privata, tua, leggibile e modificabile quando vuoi dal telefono.

<div align="center">

<table>
<tr>
<td align="center" width="25%"><img src="assets/screenshots/app-chat.png" width="190" alt="Parlaci e basta"><br><sub>Parlaci e basta</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-notes.png" width="190" alt="Scrive lui la nota"><br><sub>Scrive lui la nota</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-folders.png" width="190" alt="La archivia per te"><br><sub>La archivia per te</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-calendar.png" width="190" alt="E anche promemoria"><br><sub>E anche promemoria</sub></td>
</tr>
</table>

</div>

Gestisce anche **promemoria e calendario**: chiedi *"ricordami di chiamare il dentista domani alle 10"* e lo trovi nell'app, accanto alle tue note.

Scarica l'app: **[App Store (iPhone)](https://apps.apple.com/app/id6762130376)** · **[Google Play (Android)](https://play.google.com/store/apps/details?id=app.secondbrain.android)**

---

## Collega la tua AI — un solo accesso

1. **Scarica l'app e attiva Pro** — su [secondbrain.icu](https://secondbrain.icu). La memoria fa parte di Pro.
2. **Collega il tuo assistente** (qui sotto). Accedi **una volta dal browser** con Apple/Google — dopo, la tua AI ricorda ovunque, per sempre.

### Usi Claude? Installa il plugin

**Claude Code** — chiedi direttamente a Claude Code di installarlo, incollando il link del repo:

> *Installa il plugin SecondBrain da https://github.com/fed3c3sa/secondbrain-shared-memory*

Claude Code aggiunge il marketplace e installa il plugin per te. Poi accedi una volta: lancia `/mcp` → `secondbrain` → accedi. **Se non riesce a connettersi, lancia `npx secondbrain-connect` dal terminale** (serve [Node.js](docs/install-node.md)) e accedi dal browser.

**Cowork & Claude Desktop** — scarica il plugin e importalo:

1. Scarica **[secondbrain-plugin.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/dist/secondbrain-plugin.zip)** (dalla cartella [`dist/`](dist/)).
2. Importalo nell'app, poi accedi una volta: apri **Customize / Settings → Connectors → SecondBrain → Connect** → accedi con Apple/Google.

### Usi altro? Un comando

Per Cursor, ChatGPT, Gemini e altre app — lancia questo una volta (serve [Node.js](docs/install-node.md)), accedi dal browser, poi riavvia l'app:

```bash
npx secondbrain-connect
```

Configura da solo ogni assistente sul tuo computer e installa la skill della memoria.

> **Prova:** di' *"Ricorda che il mio colore preferito è il verde acqua."* Poi, in una chat nuova, chiedi *"Qual è il mio colore preferito?"* Se lo sa, è tutto a posto. 🎉

---

## Come gestirla

```bash
npx secondbrain-connect status        # vedi cosa è collegato
npx secondbrain-connect revoke --all  # scollega tutto
```

---

## Hai bisogno di aiuto?

- **Dice che serve Pro?** Attiva Pro nell'app SecondBrain, poi riprova.
- **L'accesso non si è aperto?** Prova `npx secondbrain-connect --google`, oppure incolla nel browser il link che stampa.
- **`npx` non trovato?** Installa Node.js — [guida](docs/install-node.md).
- **Non ricorda?** Chiudi del tutto e riapri l'app (e su Claude web, controlla che il connettore SecondBrain risulti **Connected**).

Altre soluzioni: **[Risoluzione problemi](docs/troubleshooting.md)** (in inglese).

---

## Domande frequenti

**È gratis?** L'app è gratuita. La memoria condivisa fa parte di Pro.

**I miei dati sono privati?** Sì — la memoria sono le tue note, nel tuo account. Solo l'assistente che colleghi può usarla, e lo scolleghi quando vuoi.

**Devo accedere ogni volta?** No. Un solo accesso dal browser, poi funziona e basta.

---

## Avanzate

- **Plugin Claude — guida completa** (accesso per ogni app, zip offline, troubleshooting): [docs/plugin.md](docs/plugin.md) (in inglese)
- **Aggiungere la connessione a mano** (qualsiasi app con MCP remoto): puntala su `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp` (transport `http`) e accedi dal browser quando richiesto.
- **Installare solo la skill** (senza plugin): metti [`skill/secondbrain-memory/SKILL.md`](skill/secondbrain-memory/SKILL.md) nella cartella skill del tuo strumento (es. `~/.claude/skills/`), oppure carica [secondbrain-memory.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/skill/secondbrain-memory.zip) in Claude Desktop (**Settings → Capabilities → Skills**).

---

<div align="center">

Fatto con 🧠 da **SecondBrain** · [secondbrain.icu](https://secondbrain.icu)

</div>
