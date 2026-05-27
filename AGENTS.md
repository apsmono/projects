# Workspace Agent Guide

## Overview

This directory (`~/Documents/projects`) is the owner's development workspace, managed as a **parent git repository** with **git submodules** for each standalone project.

## Repository Layout

```
projects/                            ← Parent repo: apsmono/projects
├── solo-leveling/                   ← submodule: apsmono/solo-leveling
├── dashboard/                       ← submodule: apsmono/dashboard
├── wedding-invitation/              ← submodule: apsmono/wedding-invitation
├── koperasi/                        ← submodule: apsmono/koperasi
├── scrapers/                        ← tracked in parent repo
├── microservices/                   ← tracked in parent repo
└── .gitignore, README.md, AGENTS.md ← parent repo files
```

**Important:** `solo-leveling/` is the backend-only repository. It no longer contains subprojects. All frontend/static projects live as sibling submodules directly under `projects/`.

## Submodule Conventions

### After cloning
```bash
git clone --recurse-submodules git@github-apsmono:apsmono/projects.git
```

Or if already cloned without submodules:
```bash
git submodule update --init --recursive
```

### Updating submodules
```bash
# Update all submodules to their latest remote commit
git submodule update --recursive --remote

# Update a single submodule
cd <submodule>
git pull origin main
cd ..
git add <submodule>
git commit -m "chore: bump <submodule>"
```

### Making changes inside a submodule
1. `cd` into the submodule
2. Work on a branch, commit, and push as usual
3. Return to parent repo
4. `git add <submodule>` to record the new commit SHA
5. Commit and push the parent repo

## Project Quick Reference

### solo-leveling — Backend Brain

- **Stack:** Python 3.13, FastAPI, Uvicorn
- **Tests:** `python -m unittest tests.test_stage9_libraries tests.test_integration_smoke -v`
- **Run:** `uvicorn src.app:app --port 8000 --reload`
- **Deploy:** MacMini via Docker Compose, or Railway

### dashboard — Portfolio & Command Center

- **Stack:** Pure HTML5, CSS3, vanilla JavaScript
- **Auth:** Firebase Authentication (Google Sign-In)
- **Deploy:** GitHub Pages via `.github/workflows/deploy.yml`
- **Local preview:** `python -m http.server 8080`

### wedding-invitation — Digital Wedding Invite

- **Stack:** Vite 6 + React 19 + TypeScript 5.7 + Tailwind CSS 3.4
- **Language:** Bahasa Indonesia
- **Build:** `npm run build` → outputs to `dist/`
- **Deploy:** GitHub Pages via `.github/workflows/deploy.yml`

### koperasi — Koperasi KKS Landing Page

- **Stack:** Pure HTML5, CSS3, vanilla JavaScript
- **Language:** Bahasa Indonesia
- **Deploy:** Cloudflare Pages

## Sync Rule (Updated)

There is **no more monorepo sync**. Each submodule is an independent repository with its own CI/CD. Edit directly in the submodule, commit, and push. The parent repo records which commit each submodule is pinned to.

## Deployment Targets Summary

| Project | Deploy Target | Method |
|---------|--------------|--------|
| solo-leveling (brain) | Railway / MacMini Docker | `docker compose up -d` |
| dashboard | GitHub Pages | Workflow in `dashboard/.github/workflows/deploy.yml` |
| wedding-invitation | GitHub Pages | Workflow in `wedding-invitation/.github/workflows/deploy.yml` |
| koperasi | Cloudflare Pages | Connect `apsmono/koperasi` repo in Cloudflare Dashboard |

## Commit Message Format (AI-generated)

Adopted from `dashboard_2.0`: **Conventional Commits** with optional scope.

```text
<type>(<scope>): <subject>

<body>

<footer>
```

| Type | Use for |
|------|---------|
| `feat` | new feature |
| `fix` | bug fix |
| `chore` | tooling, deps, build changes |
| `refactor` | code restructuring, no behavior change |
| `style` | formatting, whitespace, semicolons |
| `docs` | documentation only |
| `test` | adding or updating tests |
| `ci` | CI/CD changes |
| `merge` | merge commits |
| `sync` | sync/update from another source |

- **Scope** (optional): component, module, or file group in parentheses — e.g. `feat(api):`, `fix(ui):`, `chore(ci):`
- **Subject**: imperative mood, lowercase, no trailing period, max 72 chars
- **Body** (optional): explain WHAT and WHY, wrap at 72 chars
- **Footer** (optional): reference ClickUp task ID — e.g. `CU-86dxxxxxx`

Each repo has a `.gitmessage` template configured via `git config commit.template .gitmessage`.

## Security

- No secrets in the parent repo or any submodule.
- `.env`, `.credentials/`, `.venv/` are gitignored everywhere.
- Each submodule manages its own secrets and deployment tokens.
