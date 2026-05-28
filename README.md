# Development Workspace

Personal development workspace managed as a parent repository with git submodules.

## Documentation

| Doc | Purpose |
|-----|---------|
| [ROADMAP.md](ROADMAP.md) | **General workspace plan** — cross-cutting roadmap, phase tracking, and per-project plan linkage |
| [SECRETS_INVENTORY.md](SECRETS_INVENTORY.md) | Unified secret/env inventory across all projects |
| [CLAUDE.md](CLAUDE.md) | Entry point for AI coding agents — links everything below |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Big-picture architecture (workspace + the brain's layers) |
| [REPO_MAP.md](REPO_MAP.md) | Where everything lives |
| [CONVENTIONS.md](CONVENTIONS.md) | Git, submodule, code-style, and docs rules |
| [GLOSSARY.md](GLOSSARY.md) | Shared terminology |
| [AI_AGENTS.md](AI_AGENTS.md) | AI & AI-agent environment (in-product agents + coding-agent rules) |
| [AGENTS.md](AGENTS.md) | Short agent operating rules (companion to the above) |

Each submodule keeps its own deeper docs — notably `solo-leveling/` (`CLAUDE.md`, `ARCHITECTURE.md`, `AI_CONTEXT.md`, `docs/`).

## Quick Start

```bash
# Clone everything (including all submodules)
git clone --recurse-submodules git@github-apsmono:apsmono/projects.git

# If already cloned without submodules
git submodule update --init --recursive
```

## Repository Layout

| Directory | Type | Repository | Description |
|-----------|------|------------|-------------|
| `solo-leveling/` | submodule | `apsmono/solo-leveling` | Python FastAPI backend brain & command center |
| `apsmono.github.io/` | submodule | `apsmono/apsmono.github.io` | Portfolio site (Vite + React + Tailwind) |
| `dashboard/` | submodule | `apsmono/dashboard` | Authenticated command center (GitHub Pages) |
| `wedding-invitation/` | submodule | `apsmono/wedding-invitation` | Vite + React + TS digital wedding invite |
| `koperasi/` | submodule | `apsmono/koperasi` | Koperasi KKS static landing page |
| `scrapers/` | tracked | this repo | Python scraping scripts (scaffolding) |
| `microservices/` | tracked | this repo | Standalone FastAPI services (scaffolding) |

## Submodule Workflow

### Update all submodules to latest
```bash
git submodule update --recursive --remote
```

### Update a single submodule
```bash
cd dashboard
git pull origin main
cd ..
git add dashboard
git commit -m "chore: bump dashboard"
```

### Check submodule status
```bash
git submodule status
```

## Per-Project Quick Refs

### solo-leveling (backend)
```bash
cd solo-leveling
source .venv/bin/activate
python -m unittest tests.test_stage9_libraries tests.test_integration_smoke -v
uvicorn src.app:app --port 8000 --reload
docker compose up -d
```

### wedding-invitation
```bash
cd wedding-invitation
bun install
bun run dev      # http://localhost:5173
bun run build    # outputs dist/
```

### apsmono.github.io (portfolio)
```bash
cd apsmono.github.io
npm install
npm run dev      # http://localhost:5173
npm run build    # outputs dist/
```

### dashboard (local preview)
```bash
cd dashboard
python -m http.server 8080
```

## Deployment Targets

| Project | Target | Method |
|---------|--------|--------|
| solo-leveling | Railway / MacMini Docker | `docker compose up -d` |
| apsmono.github.io | GitHub Pages | `.github/workflows/deploy.yml` |
| dashboard | GitHub Pages | `.github/workflows/deploy.yml` |
| wedding-invitation | GitHub Pages | `.github/workflows/deploy.yml` |
| koperasi | Cloudflare Pages | Connect repo to Cloudflare Dashboard |
