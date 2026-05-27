# Repository Map

Navigation guide for the `apsmono/projects` workspace. This is a **parent repository** that pins each standalone project as a **git submodule** (plus two tracked scaffolding directories).

```
projects/                              ← parent repo: apsmono/projects
├── solo-leveling/        (submodule)  apsmono/solo-leveling   — Python/FastAPI "brain" & AI command center
├── dashboard/            (submodule)  apsmono/dashboard       — portfolio + authenticated command-center UI
├── wedding-invitation/   (submodule)  apsmono/wedding-invitation — Vite + React 19 digital wedding invite
├── koperasi/             (submodule)  apsmono/koperasi        — static landing page (Koperasi KKS)
├── scrapers/             (tracked)    Python scraping scripts — scaffolding
├── microservices/        (tracked)    standalone FastAPI services — scaffolding
│
├── README.md             — workspace overview + quick start
├── ARCHITECTURE.md       — workspace + brain architecture (big picture)
├── CONVENTIONS.md        — git, code style, submodule, documentation rules
├── GLOSSARY.md           — shared terminology
├── AI_AGENTS.md          — AI & AI-agent environment guide
├── AGENTS.md             — short agent operating rules (legacy/companion)
├── CLAUDE.md             — entry point for Claude Code; links everything above
├── .gitmodules           — submodule registry
└── .gitignore
```

## Submodule pins

The parent repo records the exact commit SHA each submodule points at. `git submodule status` shows the current pins. Updating a submodule means committing inside it (or pulling) **and** committing the new SHA in the parent.

## Where things live

| If you need to... | Go to |
|---|---|
| Work on the AI brain / agents / autopilot / integrations | `solo-leveling/` (has its own `CLAUDE.md`, `ARCHITECTURE.md`, `docs/`) |
| Edit the portfolio or command-center frontend | `dashboard/` |
| Edit the wedding invite | `wedding-invitation/` |
| Edit the koperasi landing page | `koperasi/` |
| Add a scraping script | `scrapers/` |
| Add a standalone microservice | `microservices/example-service/` is the template |
| Understand cross-project conventions | `CONVENTIONS.md` (this repo) |
| Understand the deep brain internals | `solo-leveling/REPO_MAP.md` + `solo-leveling/docs/` |

## solo-leveling internal map (summary)

The brain is the only project with substantial internal structure. Full detail lives in `solo-leveling/REPO_MAP.md`; the essentials:

```
solo-leveling/
├── src/
│   ├── app.py              FastAPI app, lifespan, route registration, CORS
│   ├── core/
│   │   ├── router.py       intent detection + dispatch (INTENT_MAP)
│   │   ├── libraries.py    Stage 9 personal knowledge libraries
│   │   ├── workflows.py    Stage 8 multi-step integration chains
│   │   ├── scheduler.py    APScheduler — reminders, digests, maintenance
│   │   └── config.py       .env loader / typed config
│   ├── agents/
│   │   ├── dispatcher.py    Gemini REST wrapper (primary LLM)
│   │   └── kimi_client.py   Kimi client (Autopilot reasoning, via litellm)
│   ├── autopilot/
│   │   ├── loop.py          autonomous task state machine
│   │   ├── planner.py       goal → step plan (Gemini)
│   │   ├── governor.py      Responsibility-Level (RL1–RL5) safety gate
│   │   └── tools.py         tool registry for autonomous execution
│   ├── integrations/        notion/ gdrive/ gmail/ firebase/ github/ telegram/
│   └── api/                 v1_router.py, dashboard.py, reminders.py
├── library/                 markdown knowledge store + index.json (local-first)
├── data/                    reminders.json, autopilot_*.json (runtime state)
├── tests/                   test_stage9_libraries, test_integration_smoke, etc.
├── docs/architecture/       command-center.md, integrations.md
├── docs/decisions/          ADRs 001–006
├── Dockerfile, docker-compose.yml
└── requirements.txt
```
