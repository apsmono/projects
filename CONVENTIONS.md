# Conventions

Cross-project conventions for the `apsmono/projects` workspace. Each submodule may add stricter rules in its own `CONVENTIONS.md` (e.g. `solo-leveling/CONVENTIONS.md`); when they conflict, the submodule's rules win **inside that submodule**.

## Repository model

- The parent repo is a **submodule container**. There is **no monorepo sync** — each submodule is an independent repo with its own CI/CD and deploy target.
- Edit code **directly inside the submodule**, commit and push there, then return to the parent and record the new SHA.
- The two scaffolding dirs (`scrapers/`, `microservices/`) are tracked directly in the parent and committed like normal files.

### Submodule workflow

```bash
# clone with everything
git clone --recurse-submodules git@github-apsmono:apsmono/projects.git
# or, after a plain clone
git submodule update --init --recursive

# change a submodule
cd <submodule>
git checkout -b <branch>      # work, commit, push
git push origin <branch>
cd ..
git add <submodule>           # records the new SHA in the parent
git commit -m "chore: bump <submodule>"

# pull latest of every submodule
git submodule update --recursive --remote
```

Never commit a submodule pointer that references an unpushed commit — collaborators won't be able to fetch it.

## Git remote

This workspace uses the SSH host alias **`github-apsmono`** (see `.gitmodules`). URLs look like `git@github-apsmono:apsmono/<repo>.git`. This implies a matching `Host github-apsmono` entry in `~/.ssh/config`.

## Commit messages

Conventional-commit style: `<type>(<scope>): <summary>`. Common types seen in history: `feat`, `fix`, `chore`, `docs`, `init`. Bumping a submodule pin uses `chore: bump <submodule>` or `chore: update submodules`.

AI-generated commits in the brain follow an extended format (see `AGENTS.md`):

```
<type>(<scope>): <summary>

Files:
- add|modify|remove: <file>

Changes:
- <what changed>
- <why it changed>
```

## Branch naming (brain / agent work)

From `solo-leveling/CONVENTIONS.md` — used when AI agents do governed work:

- `agent/<name>/<slug>` — individual agent work
- `lead/<reviewer>/<slug>` — review/lead branches
- `program/<milestone>` — milestone integration branches

## Python (solo-leveling, microservices)

- Python **3.13** for the brain (Docker base `python:3.13-slim`); the microservice scaffold targets 3.11+.
- Use absolute imports with the `src.` prefix (e.g. `from src.core import router`).
- Start modules with `from __future__ import annotations`.
- Tests use the stdlib `unittest` framework under `tests/`, named `test_*.py`. Live-integration tests are gated behind env flags (e.g. `ENABLE_LIVE_SMOKE_TESTS=1`) so the default suite runs offline.

## Frontend

- **dashboard / koperasi** — pure HTML5 + CSS3 + vanilla JS, **no build step**. Keep dependencies CDN-loaded.
- **wedding-invitation** — Vite 6 + React 19 + TypeScript 5.7 + Tailwind 3.4; `npm run build` runs the TS check then the Vite build into `dist/`.
- When a site is served under a sub-path, set the framework `base` accordingly (e.g. Vite `base: '/wedding-invitation/'`).
- User-facing copy for `wedding-invitation` and `koperasi` is **Bahasa Indonesia** — keep it that way.

## Secrets

- **No secrets anywhere in git** — parent or submodule. `.env`, `.credentials/`, `.venv/` are gitignored workspace-wide.
- Each submodule manages its own secrets and deploy tokens. The brain reads everything from `.env` (template: `solo-leveling/.env.example`).
- Frontend Firebase config is public web config, but backend service-account JSON and API keys must never be committed.

## Documentation

- Keep workspace-level docs (`README`, `ARCHITECTURE`, `CONVENTIONS`, `GLOSSARY`, `REPO_MAP`, `AI_AGENTS`, `CLAUDE`) about the **whole workspace**; push project-specific depth into the submodule's own docs and link to it.
- Timestamps in brain docs use `YYYY-MM-DD HH-mm-ss`.
- After non-trivial brain changes, update `solo-leveling/CHANGELOG.md` and, when the active phase/priorities shift, `solo-leveling/AI_CONTEXT.md`.
