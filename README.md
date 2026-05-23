# Development Workspace

Personal development workspace managed as a parent repository with git submodules.

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
| `dashboard/` | submodule | `apsmono/dashboard` | Portfolio + authenticated command center (GitHub Pages) |
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
| dashboard | GitHub Pages | `.github/workflows/deploy.yml` |
| wedding-invitation | GitHub Pages | `.github/workflows/deploy.yml` |
| koperasi | Cloudflare Pages | Connect repo to Cloudflare Dashboard |
