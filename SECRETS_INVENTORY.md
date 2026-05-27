# Secrets Inventory — apsmono/projects

> One place to see every secret needed across the workspace.
> **No secrets are committed to git.** This file lists *names* and *where to get them*,
> not values.
>
> After a fresh clone, follow the per-project sections below in order.

---

## Bootstrap Order

1. [Firebase project](#firebase-project) — every other project depends on this
2. [solo-leveling (brain)](#solo-leveling) — backend kernel
3. [dashboard](#dashboard) — consumes brain API
4. [wedding-invitation](#wedding-invitation) — independent, but may use Firebase later
5. [koperasi](#koperasi) — independent, but may use Firebase later

---

## Firebase Project

One project — **`apsmono-projects`** — backs auth and Firestore for the entire workspace.

| Secret / Config | Where to get it | Needed by |
|-----------------|-----------------|-----------|
| Firebase project creation | [Firebase Console](https://console.firebase.google.com) | All projects using Auth / Firestore |
| Web app config (apiKey, authDomain, projectId, storageBucket, messagingSenderId, appId, measurementId) | Project Settings → General → Your apps → Web | dashboard, wedding-invitation, koperasi (client-side) |
| Service account JSON | Project Settings → Service accounts → Generate new private key | solo-leveling (server-side Admin SDK) |
| reCAPTCHA v3 site key | App Check → reCAPTCHA Enterprise | Any client using App Check |
| FCM VAPID key | Cloud Messaging → Web Push certificates | Future push notifications |

> **Console-only steps** (cannot be scripted):
> - Register each deployed frontend origin in **Auth → Settings → Authorized domains**
> - Enable App Check enforcement after reCAPTCHA key is added
> - Set custom claim `admin: true` on the owner UID (one-time script in solo-leveling)

---

## solo-leveling

Source of truth: `solo-leveling/.env.example` + `solo-leveling/docs/SETUP_SECRETS.md`

| Variable | Required? | Used for | How to obtain |
|----------|-----------|----------|---------------|
| `NOTION_API_TOKEN` | Yes (for Notion) | Notion integration | Notion → My integrations → New integration |
| `NOTION_WORKFLOW_PARENT_ID` | Yes (for Stage 8) | Notion page for workflow output | Open target Notion page → copy 32-char page ID from URL |
| `GOOGLE_DRIVE_CREDENTIALS_JSON` | Yes (for Drive) | Google Drive service account | GCP → IAM → Service Accounts → Create key (JSON) |
| `GMAIL_CREDENTIALS_JSON` | Yes (for Gmail) | Gmail OAuth2 client | GCP → APIs & Services → Credentials → OAuth 2.0 Client ID (Desktop app) |
| `GMAIL_TOKEN_PATH` | No (default: `.gmail_token.json`) | Gmail OAuth token cache | Auto-created on first interactive Gmail call |
| `GMAIL_ENABLED` | No (default: `true`) | Feature flag to disable Gmail | Set to `false` if Gmail is not configured |
| `GEMINI_API_KEY` | Yes (for AI) | Primary LLM (Gemini) | [Google AI Studio](https://aistudio.google.com/app/apikey) |
| `GEMINI_MODEL` | No (default: `gemini-2.0-flash`) | Model override | — |
| `AGENT_PROVIDER` | No (default: `gemini`) | LLM provider selection | — |
| `GITHUB_PAT` | Yes (for GitHub) | GitHub integration | GitHub → Settings → Developer settings → Personal access tokens |
| `FIREBASE_CREDENTIALS_JSON` | Yes (for Firestore/Auth) | Firebase Admin SDK | Firebase Console → Project Settings → Service accounts → Generate key |
| `USE_FIRESTORE_REMINDERS` | No (default: `false`) | Toggle Firestore backend for reminders | Set to `true` after Firebase is configured |
| `FRONTEND_ORIGIN` | Yes (for CORS) | Dashboard GitHub Pages origin | e.g. `https://apsmono.github.io` |
| `ALLOWED_USER_EMAIL` | Yes (for Auth) | Single-user Firebase Auth gate | Your Google account email |
| `TELEGRAM_BOT_TOKEN` | Yes (for Telegram) | Telegram bot integration | @BotFather → `/newbot` |
| `TELEGRAM_WEBHOOK_SECRET` | Yes (for Telegram) | Webhook validation | Choose a random secret string |
| `AUTOPILOT_RL_LEVEL` | No (default: `1`) | Autopilot responsibility level | `1` (assisted) → `5` (program lead) |
| `AUTOPILOT_MAX_STEPS_PER_TASK` | No (default: `10`) | Autopilot step limit | — |
| `AUTOPILOT_ENABLED` | No (default: `false`) | Autopilot scheduler tick | Set to `true` to enable background autopilot |
| `AUTOPILOT_TICK_SECONDS` | No (default: `60`) | Autopilot tick interval | — |
| `REMINDER_STORE_PATH` | No (default: `data/reminders.json`) | JSON reminder file path | — |
| `SCHEDULER_POLL_SECONDS` | No (default: `30`) | Scheduler poll interval | — |
| `DAILY_GMAIL_DIGEST_ENABLED` | No (default: `false`) | Daily digest feature flag | — |
| `DAILY_GMAIL_DIGEST_HOUR` | No (default: `8`) | Digest send hour | — |
| `DAILY_GMAIL_DIGEST_MINUTE` | No (default: `0`) | Digest send minute | — |
| `META_PHONE_NUMBER_ID` | Paused | WhatsApp Business API | Paused — see `docs/PLAN-WITHOUT-WHATSAPP-2026-04-22.md` |
| `META_ACCESS_TOKEN` | Paused | WhatsApp Business API | Paused |
| `META_VERIFY_TOKEN` | Paused | WhatsApp webhook | Paused |

### Verification commands (solo-leveling)

```bash
cd solo-leveling
source .venv/bin/activate

# Offline tests (should pass without any secrets)
python -m unittest tests.test_stage9_libraries tests.test_integration_smoke -v

# Health check (shows ✅/❌ per integration)
python -c "from src.core.router import route_command; print(route_command('health'))"

# Live integration tests (requires credentials)
ENABLE_LIVE_SMOKE_TESTS=1 python -m unittest tests.test_integration_smoke -v
```

---

## dashboard

Source of truth: `dashboard/README.md` + `dashboard/shared/firebase-config.js`

| Secret / Config | Required? | Where | How to obtain |
|-----------------|-----------|-------|---------------|
| Firebase web app config | Yes | `shared/firebase-config.js` | Firebase Console → Project Settings → Web app config |
| `API_BASE` | Yes | `shared/firebase-config.js` | Set to brain live URL (Railway or MacMini) |
| `SYNC_PAT` | No | GitHub secret (if using sync workflow) | GitHub Personal Access Token with `repo` scope |

### Verification

1. Serve locally: `python -m http.server 8080`
2. Open `http://localhost:8080`
3. Sign in with Google (same email as `ALLOWED_USER_EMAIL` in brain)
4. Dashboard should show library stats and integration health from brain `/api/v1/dashboard`

---

## wedding-invitation

Source of truth: `wedding-invitation/README.md` + `wedding-invitation/CONTENT_GUIDE.md`

| Config | Required? | Where |
|--------|-----------|-------|
| Content (names, dates, venues, contacts) | Yes | `src/lib/constants.ts` |
| Gallery photos | Yes | `public/images/gallery/` |
| Music (optional) | No | `public/music/background.mp3` |
| Firebase client SDK (optional, for RSVP/guestbook later) | No | Add `npm i firebase`, copy config from Console |

> **No secrets in code.** All content is public by design.

---

## koperasi

Source of truth: `koperasi/README.md`

| Config | Required? | Where |
|--------|-----------|-------|
| Content (address, phone, email, legal number) | Yes | `index.html` |
| Brand colors | Yes | `css/base.css` `:root` |
| Photos/illustrations | Yes | `assets/images/` |
| Firebase client SDK (optional, for contact form later) | No | Add `npm i firebase` or CDN, copy config from Console |

> **No secrets in code.** All content is public by design.

---

## Cold-Start Checklist

Use this after a fresh `git clone --recurse-submodules`:

- [ ] Create `.env` in `solo-leveling/` from `.env.example`
- [ ] Fill Firebase service account → `FIREBASE_CREDENTIALS_JSON`
- [ ] Fill Notion token → `NOTION_API_TOKEN`
- [ ] Fill Google Drive service account → `GOOGLE_DRIVE_CREDENTIALS_JSON`
- [ ] Fill Gmail OAuth client → `GMAIL_CREDENTIALS_JSON`
- [ ] Fill Gemini key → `GEMINI_API_KEY`
- [ ] Fill GitHub PAT → `GITHUB_PAT`
- [ ] Set `FRONTEND_ORIGIN` to dashboard URL
- [ ] Set `ALLOWED_USER_EMAIL` to your Google email
- [ ] Configure `dashboard/shared/firebase-config.js` with Firebase web config + brain `API_BASE`
- [ ] Run solo-leveling tests: `python -m unittest tests.test_stage9_libraries tests.test_integration_smoke -v`
- [ ] Run health check: `curl -s -X POST http://localhost:8000/command -H 'Content-Type: application/json' -d '{"text":"health"}'`
