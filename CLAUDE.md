# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

`apsmono/projects` is a **parent repository** that pins several standalone projects as **git submodules**, plus two tracked scaffolding directories. There is **no monorepo build or sync** — each submodule is independent, with its own history, CI/CD, and deploy target. The only runtime coupling is that the `dashboard` frontend calls the `solo-leveling` backend over HTTP.

| Path | Type | What it is |
|------|------|-----------|
| `solo-leveling/` | submodule | Python 3.13 / FastAPI "brain" & AI command center — the only architecturally significant project |
| `dashboard/` | submodule | Static (vanilla JS) portfolio + Firebase-auth'd command-center UI → GitHub Pages |
| `wedding-invitation/` | submodule | Vite 6 + React 19 + TS + Tailwind digital invite (Bahasa Indonesia) |
| `koperasi/` | submodule | Static landing page, Koperasi KKS (Bahasa Indonesia) → Cloudflare Pages |
| `scrapers/` | tracked | Python scraping scripts — scaffolding |
| `microservices/` | tracked | Standalone FastAPI services — `example-service/` is the template |

## Companion docs (read as needed)

- **[ARCHITECTURE.md](ARCHITECTURE.md)** — workspace shape + the brain's four-layer architecture and three execution patterns.
- **[REPO_MAP.md](REPO_MAP.md)** — directory map for the workspace and the brain.
- **[CONVENTIONS.md](CONVENTIONS.md)** — git/submodule workflow, code style, secrets, documentation rules.
- **[GLOSSARY.md](GLOSSARY.md)** — shared terminology (Brain, Intent, Stage, Library, Autopilot, RL, …).
- **[AI_AGENTS.md](AI_AGENTS.md)** — the AI environment: in-product agents (Gemini, Autopilot, RL governance) *and* rules for coding agents.
- **[AGENTS.md](AGENTS.md)** — short agent operating rules and the AI commit-message format.
- **Inside `solo-leveling/`** — its own `CLAUDE.md`, `ARCHITECTURE.md`, `CONVENTIONS.md`, `GLOSSARY.md`, `REPO_MAP.md`, and `AI_CONTEXT.md` are authoritative when working there. **`AI_CONTEXT.md` is the source of truth for the brain's current phase and priorities.**

## Working in a submodule workspace (read this first)

This is the single most important operating fact. Before editing, know which repo you are in:

- Project source lives **inside** its submodule. Commit there, push there, then return to the parent and run `git add <submodule>` + commit to record the new SHA.
- A "parent repo" change is normally a docs edit, a scaffolding edit, or a submodule SHA bump — not project source code.
- **Never** record a parent pointer to a submodule commit you have not pushed, or collaborators can't fetch it.
- The remote uses the SSH host alias `github-apsmono` (see `.gitmodules`).

```bash
git submodule update --init --recursive      # after a plain clone
git submodule update --recursive --remote    # pull latest of every submodule
git submodule status                          # show current pins
```

## Common commands

### solo-leveling (the brain)
```bash
cd solo-leveling
source .venv/bin/activate                      # or: pip install -r requirements.txt
uvicorn src.app:app --port 8000 --reload       # run locally; health at GET /healthz
docker compose up -d                           # run via Docker (port 8000)

# tests (offline by default)
python -m unittest tests.test_stage9_libraries tests.test_integration_smoke -v
python -m unittest tests.test_autopilot -v     # a single test module
ENABLE_LIVE_SMOKE_TESTS=1 python -m unittest tests.test_integration_smoke -v   # hit live integrations
```
Config comes from `.env` (template: `solo-leveling/.env.example`). The primary LLM is **Gemini** (`GEMINI_API_KEY`, `AGENT_PROVIDER=gemini`).

### wedding-invitation
```bash
cd wedding-invitation
npm install
npm run dev        # http://localhost:5173
npm run build      # TS check + Vite build → dist/
npm run preview
```

### dashboard / koperasi (static, no build)
```bash
cd dashboard   # or: cd koperasi
python -m http.server 8080
```

## Architecture in one breath

The brain is a single FastAPI process with four layers — **Command Interface** (`/command`, Telegram webhook, Firebase-auth'd `/api/v1/*`) → **Brain Core** (`router.py` intent detection/dispatch, `workflows.py`, `libraries.py`, `scheduler.py`) → **AI Agent Layer** (Gemini `dispatcher.py`, `autopilot/` with RL governance, Kimi) → **Integration Layer** (notion, gdrive, gmail, firebase, github, telegram). It handles work in three patterns: **synchronous dispatch**, **scheduled automation** (APScheduler), and the **autonomous Autopilot loop** (plan→execute→observe, gated by Responsibility Levels RL1–RL5). State is **local-first** (markdown `library/` + JSON in `data/`), with optional Firebase Firestore as a dual backend. Full detail: [ARCHITECTURE.md](ARCHITECTURE.md) and `solo-leveling/docs/`.

## Conventions that matter here

- **Secrets never enter git** — `.env`, `.credentials/`, service-account JSON, tokens are gitignored. Frontend Firebase *web* config is public; backend credentials are not.
- **Python (brain):** 3.13, absolute imports with `src.` prefix, `from __future__ import annotations`, stdlib `unittest` tests under `tests/`.
- **Frontend copy** for `wedding-invitation` and `koperasi` is **Bahasa Indonesia** — keep it.
- **Commit style:** `<type>(<scope>): <summary>`; submodule bumps use `chore: bump <submodule>`. AI commits use the extended format in `AGENTS.md`.
- **Verify before claiming done:** run the brain's unittest suite; for frontends, actually build/serve and check the browser.
- After non-trivial brain work, update `solo-leveling/CHANGELOG.md` and, if priorities shift, `solo-leveling/AI_CONTEXT.md`.
