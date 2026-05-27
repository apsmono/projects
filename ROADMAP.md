# Workspace Roadmap — apsmono/projects

> This is the **general plan** for the parent workspace. It governs cross-cutting concerns
> (deployment topology, submodule hygiene, auth contracts, secret inventory) and links to
> each submodule's own designated plan.
>
> **Rule:** If a task touches only one submodule, it lives in that submodule's plan.
> If it touches two or more (especially the dashboard ↔ brain boundary), it lives here.

---

## Quick Links

| Project | Local Plan | Repo |
|---------|-----------|------|
| **solo-leveling** (brain) | `docs/PLAN-WITHOUT-WHATSAPP-2026-04-22.md` + `AI_CONTEXT.md` | `apsmono/solo-leveling` |
| **dashboard** | `README.md` (config + deploy steps) | `apsmono/dashboard` |
| **wedding-invitation** | `README.md` deploy checklist + `CONTENT_GUIDE.md` | `apsmono/wedding-invitation` |
| **koperasi** | `README.md` | `apsmono/koperasi` |
| **scrapers** | None yet (scaffolding) | tracked in parent |
| **microservices** | None yet (scaffolding) | tracked in parent |

---

## Intent

This workspace is a **personal operating system constellation**. Each project serves a
distinct role, but they are architecturally coupled through shared auth (Firebase), shared
command surface (the brain's API), and shared deployment topology (MacMini + GitHub Pages +
Cloudflare).

```
                    solo-leveling (brain)
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
    dashboard      wedding-invitation    koperasi
   (calls /api/v1)   (independent)      (independent)
        │
   Firebase Auth ←───── shared project ─────→
```

**Critical coupling:** `dashboard` ↔ `solo-leveling` via `/api/v1/*` + Firebase Auth.
This is the only runtime dependency between submodules.

---

## Cross-Cutting Concerns

These span multiple submodules and belong in the parent repo.

### CC-1: Firebase Ecosystem Integrity
The brain verifies Firebase ID tokens; the dashboard sends them. Both must use the **same
Firebase project**. `ALLOWED_USER_EMAIL` in the brain must match the Google account used in
the dashboard.

### CC-2: Deployment Topology Consistency
The brain URL changes by target (Railway prod, `localhost:8000` dev, MacMini local net).
The dashboard's `API_BASE` must match. We need one source of truth for "where is the brain
right now?"

### CC-3: Submodule SHA Hygiene
The parent records exact submodule commits. Dirty or unpinned submodules make the workspace
non-reproducible. Always commit inside the submodule, then `git add <submodule>` in parent.

### CC-4: Secret Management Across Projects
Each submodule has its own `.env`. The parent maintains a unified inventory so a cold clone
is bootstrappable without reading 4+ separate docs.

→ See [`SECRETS_INVENTORY.md`](SECRETS_INVENTORY.md)

### CC-5: API Version Contract
Dashboard calls `/api/v1/reminders`, `/api/v1/commands`, etc. Brain changes to these
endpoints can break the dashboard. Contract awareness is required on both sides.

---

## Roadmap Phases

### Phase 1 — Workspace Hygiene (Immediate)
**Goal:** Parent repo accurately reflects current state of every submodule.

- [x] Pin submodules cleanly (no dirty `+`/`-` in `git submodule status`)
- [x] Create this `ROADMAP.md` + `SECRETS_INVENTORY.md`
- [ ] Audit parent-repo untracked files (`.firebaserc`, `firebase.json`, `firebase/`, `FIREBASE.md` are intentionally tracked; `graphify-out/` belongs in `.gitignore`)
- [ ] Link every submodule README back to this roadmap

### Phase 2 — Cross-Project Integration (Next)
**Goal:** Dashboard ↔ brain auth and API flow works end-to-end in production.

- [ ] Firebase project alignment — same project for brain Admin SDK and dashboard client
- [ ] Set `FRONTEND_ORIGIN` in brain `.env` to dashboard GitHub Pages URL
- [ ] Set `API_BASE` in dashboard to brain live URL
- [ ] Dashboard first deploy with real Firebase config + CORS verification
- [ ] Document the live URL contract in this repo

### Phase 3 — Content & Delivery (Parallel)
**Goal:** Real-world deliverables are content-complete and deployed.

**Wedding invitation**
- [ ] Add final venue name, full address, RSVP number, planner contact, maps
- [ ] Replace gallery placeholders with real photos
- [ ] Deploy via GitHub Pages workflow
- [ ] Test RSVP WhatsApp flow on mobile

**Koperasi landing**
- [ ] Replace all placeholder text/images with real koperasi data
- [ ] Deploy to Cloudflare Pages
- [ ] Verify contact form or Google Forms link

### Phase 4 — Growth Infrastructure (Future)
**Goal:** Workspace scales cleanly as new projects are added.

- [ ] Extract first microservice from brain (when a module outgrows the monolith)
- [ ] Add first scraper with clear input/output contract feeding the brain library
- [ ] API contract test that verifies dashboard-critical endpoint shapes before SHA bumps

---

## Success Criteria

- [ ] `git submodule status` shows clean pins (no `+`/`-`)
- [ ] Dashboard loads from GitHub Pages and successfully calls brain `/api/v1/dashboard`
- [ ] Wedding invitation deployed with real content and working RSVP
- [ ] Koperasi deployed with real content
- [ ] New clone + `git submodule update --init --recursive` + `SECRETS_INVENTORY.md` = working local dev
