# AI Productivity Master Guide 2026
## Maximizing Claude Code, Kimi Code API & AI Tools for Work, Income & Self-Understanding

**Compiled:** 2026-05-29  
**Scope:** Technical setup, monetization, daily routines, research workflows, personal development  
**Sources:** Official docs, community guides, industry research (cited throughout)

---

## TABLE OF CONTENTS

1. [Claude Code: Advanced Setup & Efficiency](#1-claude-code-advanced-setup--efficiency)
2. [Kimi Code API: Setup & Integration](#2-kimi-code-api-setup--integration)
3. [Integration Tools Deep Dive](#3-integration-tools-deep-dive)
   - 3.1 n8n Workflow Automation
   - 3.2 OpenClaw Autonomous Agents
   - 3.3 Google Environments (Apps Script, Colab, Workspace)
   - 3.4 NotebookLM for Research
4. [Monetization: Getting Work & Making Money](#4-monetization-getting-work--making-money)
5. [Daily AI-Assisted Routines](#5-daily-ai-assisted-routines)
6. [Research & Information Management](#6-research--information-management)
7. [Book Recommendations by Goal](#7-book-recommendations-by-goal)
8. [Quick-Start Action Plan](#8-quick-start-action-plan)

---

## 1. CLAUDE CODE: ADVANCED SETUP & EFFICIENCY

### 1.1 Installation & Access Methods

Claude Code is available across multiple surfaces:

| Platform | Best For | Installation |
|----------|----------|-------------|
| **Terminal/CLI** | Power users, keyboard-driven workflow | `npm install -g @anthropic-ai/claude-code` |
| **Desktop App** | Visual diff review, multiple sessions side-by-side | [macOS](https://claude.ai/api/desktop/darwin/universal/dmg/latest/redirect) / [Windows](https://claude.ai/api/desktop/win32/x64/setup/latest/redirect) |
| **Web (claude.ai/code)** | No local setup, long-running tasks, multiple parallel tasks | Browser + paid subscription |
| **JetBrains Plugin** | IntelliJ, PyCharm, WebStorm users | JetBrains Marketplace |
| **VS Code** | VS Code ecosystem users | Extension marketplace |

### 1.2 Essential Configuration Files

Create these files in your project root or `~/.claude/`:

**`CLAUDE.md`** — Project-specific instructions:
```markdown
# Project Context
- Tech stack: Python 3.13 + FastAPI + vanilla JS frontend
- Absolute imports with `src.` prefix
- Use `from __future__ import annotations`
- Test with `python -m unittest`

## Conventions
- Secrets never enter git
- Commit style: `<type>(<scope>): <summary>`
- Bahasa Indonesia for wedding-invitation and koperasi frontend copy
```

**`~/.claude/settings.json`** — Global preferences:
```json
{
  "permissions": {
    "allow": [
      "Bash: npm install",
      "Bash: pip install",
      "Bash: uvicorn",
      "Bash: python -m unittest",
      "Bash: git add",
      "Bash: git commit",
      "Bash: git push",
      "Bash: docker compose"
    ]
  }
}
```

### 1.3 Cost Optimization (Critical)

Claude Code charges by token consumption. Key strategies from [official cost docs](https://code.claude.com/docs/en/costs):

| Strategy | Implementation | Savings |
|----------|---------------|---------|
| **Model tiering** | Main session on Opus, sub-agents on Sonnet/Haiku | 50-70% |
| **Subagent model env var** | `export CLAUDE_CODE_SUBAGENT_MODEL="claude-sonnet-4-5-20250929"` | Significant |
| **Disable unused MCP servers** | Run `/mcp` → disable idle servers | 10-20% |
| **Prefer CLI tools over MCP** | `gh`, `aws`, `gcloud` vs MCP servers | Context-efficient |
| **Use `/model` to switch mid-session** | `/model sonnet` for simple tasks | 30-50% |
| **Code intelligence plugins** | Install LSP for typed languages | Reduces file reads |

**Context window check:** Run `/context` anytime to see what's consuming tokens.

### 1.4 MCP (Model Context Protocol) Servers

MCP extends Claude with external tools. Setup patterns:

**stdio transport** (local process):
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_..." }
    }
  }
}
```

**HTTP/SSE transport** (remote service):
```json
{
  "mcpServers": {
    "claude-code-docs": {
      "url": "https://code.claude.com/docs/mcp"
    }
  }
}
```

**Agent SDK (in-process)**:
```python
from anthropic_agent_sdk import query

for msg in query({
    "prompt": "Query the database...",
    "options": {
        "mcpServers": { "my-db": { "url": "http://localhost:3000/sse" } },
        "allowedTools": ["my-db:*"]  # Wildcard for all tools from server
    }
}):
    print(msg)
```

**Top MCP servers to install:**
- `@modelcontextprotocol/server-github` — GitHub issues, PRs, repos
- `@modelcontextprotocol/server-postgres` — Database queries
- `@modelcontextprotocol/server-slack` — Slack messaging
- `@modelcontextprotocol/server-filesystem` — File operations (scoped)

### 1.5 Skills, Hooks & Plugins

**Skills** (`~/.claude/skills/` or project `skills/`):
- Reusable prompts/patterns for specific tasks
- Auto-discovered by Claude in the project
- Example: A `deploy.md` skill with deployment checklist

**Hooks** (`~/.claude/hooks/`):
- Intercept agent behavior at key points
- Use cases: Pre-process prompts, log actions, enforce policies

**Plugins** (via Agent SDK):
- Extend Claude Code with custom skills, agents, hooks, MCP servers
- Loaded through the SDK's plugin system

### 1.6 Sub-Agents & Parallelization

Use sub-agents for multi-part tasks:

```bash
# Sequential (default) — one after another
# Parallel — run simultaneously for independent tasks

# Env var for subagent model
export CLAUDE_CODE_SUBAGENT_MODEL="claude-sonnet-4-5-20250929"
```

**Best practice:** Main agent on Opus for architecture → sub-agents on Sonnet for implementation → Haiku for simple transformations.

### 1.7 Key Slash Commands

| Command | Purpose |
|---------|---------|
| `/model` | Switch model mid-session |
| `/config` | Open configuration |
| `/context` | See what's in context window |
| `/mcp` | Manage MCP servers |
| `/cost` | View token usage and cost |
| `/init` | Generate AGENTS.md for project |
| `/login` | Configure API provider |

---

## 2. KIMI CODE API: SETUP & INTEGRATION

### 2.1 What is Kimi Code

[Kimi Code](https://www.kimi.com/code/docs/en/) is an intelligent programming service from Moonshot AI (Kimi), included in Kimi membership. It provides:

- **Kimi Code CLI** (`kimi`) — Terminal AI agent
- **Kimi Code for VS Code** — IDE extension
- **Third-party integrations** — Cline, RooCode, JetBrains, Zed, Zsh

### 2.2 Installation

```bash
# Linux / macOS
curl -LsSf https://code.kimi.com/install.sh | bash

# Windows (PowerShell)
Invoke-RestMethod https://code.kimi.com/install.ps1 | Invoke-Expression

# Verify
kimi --version
```

Requires: Python 3.12–3.14 (3.13 recommended), macOS/Linux/Windows.

### 2.3 Authentication

```bash
# Start Kimi Code CLI
cd your-project
kimi

# Configure API source
/login
```

**Recommended setup:** Select "Kimi Code platform" → browser OAuth (auto-saves).

**Alternative:** Use Moonshot API key for Kimi K2.5 model:
- API Provider: Moonshot
- Entrypoint: `api.moonshot.ai`
- Model: `kimi-k2.5`

### 2.4 Core Usage Modes

| Mode | Command | Use Case |
|------|---------|----------|
| Interactive CLI | `kimi` | Natural language coding tasks |
| Browser UI | `kimi web` | GUI with session management |
| Agent Protocol | `kimi acp` | IDE integration via Agent Client Protocol |

### 2.5 Key Commands

| Command | Description |
|---------|-------------|
| `kimi` | Start interactive conversation |
| `kimi web` | Open browser graphical interface |
| `/login` | Configure or switch API source |
| `/usage` | View remaining quota and limits |
| `/help` | View all commands and shortcuts |
| `/init` | Generate AGENTS.md for project |
| `Ctrl+J` | Newline (without submitting) |
| `Ctrl+C / Ctrl+D` | Interrupt / Exit |

### 2.6 Kimi Code Configuration

Config files location: `~/.config/kimi/` (macOS/Linux) or `%APPDATA%\kimi\` (Windows)

Key customization areas:
- **Providers and Models** — Switch between Kimi, OpenAI, Anthropic, etc.
- **MCP Integration** — Connect external tools (same protocol as Claude)
- **Hooks (Beta)** — Customize behavior
- **Skills** — Custom prompt templates
- **Sub-agents** — Parallel task execution
- **Official Plugins** — Pre-built extensions

### 2.7 Claude Code vs Kimi Code: When to Use Which

| Scenario | Recommended Tool | Why |
|----------|-----------------|-----|
| Complex architecture, large codebase | Claude Code (Opus) | Superior reasoning |
| Fast iteration, cost-sensitive | Kimi Code (K2.5) | Competitive performance, lower cost |
| Agent SDK / production deployment | Claude Code | Mature SDK, hosting docs |
| VS Code native experience | Kimi Code for VS Code | Deep IDE integration |
| MCP ecosystem depth | Claude Code | Larger server directory |
| Chinese language context | Kimi Code | Native Chinese support |

**Pro tip:** Use both. Claude Code for architecture and complex reasoning, Kimi Code for rapid implementation and cost-sensitive tasks.

---

## 3. INTEGRATION TOOLS DEEP DIVE

### 3.1 n8n Workflow Automation

[n8n](https://docs.n8n.io/) is a fair-code workflow automation tool with deep AI integrations.

#### Self-Hosting with Docker

```bash
# Basic Docker deployment
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n

# With Docker Compose (recommended)
# docker-compose.yml:
version: '3'
services:
  n8n:
    image: n8nio/n8n
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=yourpassword
    volumes:
      - ~/.n8n:/home/node/.n8n
```

#### AI Agent Node

n8n's LangChain-powered AI Agent node enables:
- Autonomous task execution with tool calling
- Integration with OpenAI, Anthropic, Google Gemini
- Custom tool definitions
- Memory and conversation context

**Typical AI workflow:**
1. **Trigger** (Webhook, Schedule, Email)
2. **AI Agent** (process intent, decide action)
3. **Tools** (HTTP requests, database queries, API calls)
4. **Response** (Send email, Slack message, update database)

#### AI Workflow Builder

Natural language workflow creation: describe your goal in plain English, and n8n generates the workflow.

#### Use Cases for Solo Developers

| Workflow | Components |
|----------|-----------|
| **Lead capture → AI qualification → CRM** | Webhook → AI Agent (qualify) → HubSpot/Salesforce |
| **Content curation → AI summary → Publish** | RSS → OpenAI (summarize) → WordPress/Twitter |
| **GitHub issue → AI triage → Assign** | GitHub trigger → AI (classify) → Slack + assign |
| **Email → AI draft → Send** | IMAP trigger → AI (draft reply) → Gmail send |

### 3.2 OpenClaw Autonomous Agents

[OpenClaw](https://github.com/openclaw/openclaw) is a rapidly growing open-source AI agent framework (160K+ GitHub stars).

#### What Makes OpenClaw Different

| Feature | Description |
|---------|-------------|
| **Heartbeat Scheduling** | Agent "wakes up" autonomously without user prompts |
| **Messaging-First** | Native Telegram, WhatsApp, Slack, Discord, iMessage integration |
| **Local-First** | Self-hosted; data stays on your hardware |
| **Persistent Memory** | Human-readable `SOUL.md` / `MEMORY.md` protocol |
| **Browser Automation** | Screenshot capture, mouse/keyboard control |
| **BYOK Model Router** | OpenAI, Anthropic, Google, local models |

#### Quick Setup

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm openclaw setup      # First run only
pnpm ui:build            # Optional: build Control UI
pnpm gateway:watch       # Dev loop with auto-reload
```

#### Cost Structure

| Component | Cost |
|-----------|------|
| OpenClaw Software | **$0** (MIT License) |
| LLM API Usage | ~$30-60/month (Claude 3.5 Sonnet recommended) |
| VPS Hosting | ~$5/month (optional) |

#### Integration with Your Workflow

OpenClaw shines as a **24/7 autonomous layer**:
- Monitor RSS feeds, GitHub repos, email for opportunities
- Auto-respond to Telegram/WhatsApp business inquiries
- Schedule and execute routine tasks (backups, reports, data collection)
- Maintain persistent memory across sessions

### 3.3 Google Environments

#### Google Apps Script + AI

Apps Script enables deep Google Workspace automation with AI integration:

**Direct AI API calls from Sheets:**
```javascript
function callOpenAI(prompt) {
  const apiKey = PropertiesService.getScriptProperties().getProperty('OPENAI_KEY');
  const response = UrlFetchApp.fetch('https://api.openai.com/v1/chat/completions', {
    method: 'post',
    headers: { 'Authorization': 'Bearer ' + apiKey, 'Content-Type': 'application/json' },
    payload: JSON.stringify({
      model: 'gpt-4o-mini',
      messages: [{ role: 'user', content: prompt }]
    })
  });
  return JSON.parse(response.getContentText()).choices[0].message.content;
}

function onEdit(e) {
  const sheet = e.range.getSheet();
  if (sheet.getName() === 'Content' && e.range.getColumn() === 1) {
    const aiResponse = callOpenAI('Summarize: ' + e.value);
    e.range.offset(0, 1).setValue(aiResponse);
  }
}
```

**Gemini/Vertex AI Integration:**
- Call Vertex AI APIs directly from Apps Script
- Gmail classification, content summarization
- Custom AI assistants embedded in Workspace tools

#### Google Colab for AI Workflows

- Free GPU/TPU access for ML workloads
- Perfect for prototyping AI pipelines
- Integrate with Google Drive for data storage
- Schedule notebooks to run periodically

#### Recommended Hybrid Architecture

| Layer | Tool | Purpose |
|-------|------|---------|
| Google-native triggers | Apps Script | onEdit, onFormSubmit, time-driven triggers |
| Cross-platform orchestration | n8n / Make | Multi-app workflows, monitoring, retries |
| AI processing | Gemini / Claude / OpenAI | Content generation, classification |
| Data storage | Google Sheets / Drive | Structured data, file storage |

### 3.4 NotebookLM for Research

[NotebookLM](https://notebooklm.google.com/) is Google's AI research assistant.

#### Supported Source Types

| Category | Formats |
|----------|---------|
| Documents | PDF, Google Docs, Google Slides, DOCX, TXT |
| Audio | MP3, WAV |
| Web Content | URLs, YouTube videos |
| Images | Text-bearing images (OCR) |

#### Limits (2026)

| Metric | Free Tier | Plus Tier |
|--------|-----------|-----------|
| Sources per notebook | ~20-30 | ~100-200 |
| Words per source | ~500,000 | ~500,000+ |
| Individual file size | 50MB | 500MB |
| Total storage | ~2GB | ~20GB |
| Daily queries | ~50 | Expanded |

#### Key Features

- **AI-powered summaries** with inline citations
- **Audio Overviews** — podcast-style summaries
- **Source-grounded responses** — answers based only on your uploaded sources
- **Notebook organization** — categorize by project/subject

#### Research Workflow

1. **Collect** — Dump PDFs, URLs, notes into a notebook
2. **Synthesize** — Ask NotebookLM for summaries, connections, gaps
3. **Audio Overview** — Generate podcast for commute listening
4. **Export insights** — Copy key findings to your knowledge base

#### Pro Tips

- Split long documents into sections for better organization
- One notebook per project/topic (no cross-notebook sharing)
- Use YouTube URLs for video research (auto-transcribes)
- Combine with Google Scholar: download PDFs → upload to NotebookLM

---

## 4. MONETIZATION: GETTING WORK & MAKING MONEY

### 4.1 Proven Monetization Paths (2026)

| Method | Time to First $ | Income Range | Best For |
|--------|----------------|--------------|----------|
| **AI freelance services** | 1-2 weeks | $1K-$15K/month | Existing skill + AI leverage |
| **AI chatbots for businesses** | 2-4 weeks | $500-$5K/project | Prompt design + basic dev |
| **AI workflow automation** | 2-4 weeks | $1K-$8K/month | n8n/Make/Zapier skills |
| **Micro-SaaS / AI tools** | 4-8 weeks | $500-$20K+/month | Product-minded builders |
| **AI consulting/training** | 2-4 weeks | $2K-$20K/month | Domain experts |
| **Content + affiliate** | 4-8 weeks | $500-$5K/month | Writers, creators |

### 4.2 Micro-SaaS: Highest Upside for Solo Developers

**Formula:** Narrow niche + specific repetitive problem + professional audience

**Example niches:**
- Property listing generator for real estate agents ($39/mo)
- Legal document reviewer for small law firms ($99/mo)
- Social media carousel generator for dentists ($29/mo)
- Invoice parser for freelancers ($19/mo)

**Tech stack:**
- Frontend: v0 by Vercel, Bubble, or vanilla JS
- Backend: FastAPI (Python) + your `solo-leveling` brain pattern
- AI: Claude API or Gemini API
- Auth: Firebase Auth
- Hosting: Vercel (frontend) + Railway/Render (backend)
- Payments: Stripe

### 4.3 AI Freelance Services

**High-demand services (2026):**
1. **AI workflow automation** — n8n/Make/Zapier + AI nodes
2. **Custom chatbot development** — RAG-powered customer support bots
3. **AI content systems** — Blog pipelines, newsletter automation
4. **Code migration** — AI-assisted legacy code modernization
5. **Data processing pipelines** — AI extraction, classification, enrichment

**Rate optimization:**
- Charge project-based, not hourly (AI makes you faster)
- Specialize in regulated industries (healthcare, legal, finance) — rates hold better
- Bundle: Setup + 3 months maintenance
- Target: $2K-$10K per project

### 4.4 AI Consulting/Training

**Offerings:**
- Half-day AI workflow audit ($500-$1,500)
- Team AI training workshop ($2K-$5K)
- Monthly AI advisory retainer ($1K-$3K)
- Custom AI tool deployment ($5K-$20K)

**Marketing channels:**
- LinkedIn content (daily AI tips)
- YouTube tutorials (n8n workflows, Claude Code demos)
- Newsletter (weekly AI tools roundup)
- Local business meetups

### 4.5 Your Existing Projects as Income Streams

| Project | Monetization Path |
|---------|-------------------|
| `solo-leveling` brain | SaaS API for AI command center; consulting on AI agent architecture |
| `dashboard` | Template for Firebase + static dashboard SaaS |
| `wedding-invitation` | Customizable template for event planners |
| `koperasi` | Landing page template for local businesses |
| `scrapers` | Data extraction service for market research |
| `microservices` | Template for FastAPI microservices consulting |

### 4.6 Essential AI Dev Stack for Income Generation

| Tool | Cost | Purpose |
|------|------|---------|
| Claude Code / Kimi Code | $20/month | Primary development |
| Cursor | $20/month | IDE with AI (optional, can use Kimi for VS Code) |
| n8n self-hosted | $0 | Workflow automation for clients |
| Vercel | $0-$20/month | Frontend hosting |
| Railway/Render | $5-$25/month | Backend hosting |
| Firebase | Pay-as-you-go | Auth, database, hosting |
| Stripe | 2.9% + $0.30 | Payments |

**Total monthly stack cost:** ~$50-70 → delivers ROI of "dozens of times over"

---

## 5. DAILY AI-ASSISTED ROUTINES

### 5.1 The "AI-First Daily Architecture"

| Time Block | AI Optimization | Tools |
|------------|----------------|-------|
| **6:00-6:30 Morning Planning** | AI reviews overnight emails, auto-schedules priorities | Claude Code + Motion/Reclaim |
| **6:30-7:00 Learning** | NotebookLM audio overview during commute/exercise | NotebookLM |
| **7:00-10:00 Deep Work #1** | Calendar AI protects focus blocks; Claude Code handles coding | Reclaim + Claude Code |
| **10:00-10:30 Break** | AI-generated mindfulness prompt or stoic meditation | The Daily Stoic (book) |
| **10:30-12:00 Deep Work #2** | Kimi Code for rapid implementation; sub-agents for parallel tasks | Kimi Code |
| **12:00-13:00 Lunch + Light Reading** | AI-summarized articles from Pocket/Readwise | NotebookLM |
| **13:00-15:00 Communication Block** | AI-drafted emails, meeting summaries, Slack responses | Superhuman AI + Otter |
| **15:00-16:00 Admin/Automation** | n8n workflows run; Apps Script automations execute | n8n + Apps Script |
| **16:00-17:00 Client Work / Brainstorming** | Claude Code for architecture; OpenClaw for monitoring | Claude Code + OpenClaw |
| **17:00-17:30 Evening Review** | AI aggregates daily accomplishments; suggests tomorrow | Claude Code custom skill |

### 5.2 Weekly Review Framework

**Sunday Evening (30 minutes):**
1. **Review** — What did I ship this week? (Ask Claude Code: `/review`)
2. **Metrics** — Revenue, leads, content published, code shipped
3. **Learning** — What did I learn? (Review NotebookLM highlights)
4. **Planning** — Top 3 priorities for next week (Use Claude Code to break down)
5. **Automation check** — What repetitive task can I automate this week?

### 5.3 Monthly Retrospective

**Last day of month (1 hour):**
1. Income vs. goal analysis
2. Time audit — Where did my hours go?
3. Tool ROI review — Am I getting value from each subscription?
4. Skill gap analysis — What should I learn next?
5. System improvements — What can be automated/delegated?

### 5.4 Brainstorming Framework with AI

**The "AI Amplified Ideation" Process:**

1. **Seed** — Write 3 rough ideas in a notebook (analog)
2. **Expand** — Feed each to Claude Code: "Expand this idea into 10 variations"
3. **Evaluate** — Ask: "For each variation, what's the MVP, market size, and my unfair advantage?"
4. **Combine** — Ask: "What happens if we combine idea #3 with idea #7?"
5. **Validate** — Use Claude Code to build a landing page prototype in 30 minutes
6. **Test** — Share with 5 people; collect feedback
7. **Decide** — AI-assisted decision matrix: effort vs. impact vs. excitement

### 5.5 Information Capture System

**Inputs → Processing → Outputs:**

| Input | Tool | Processing | Output |
|-------|------|-----------|--------|
| Books | Audible/Kindle | NotebookLM → AI summary | Knowledge base note |
| Articles | Pocket/Readwise | Claude Code → key insights | Project ideas doc |
| YouTube videos | YouTube | NotebookLM → transcript + summary | Learning log |
| Podcasts | Podcast app | Otter AI → transcript | Action items list |
| Meeting notes | Otter/Fireflies | Claude Code → summary + tasks | Todo list + follow-ups |
| Random ideas | Phone voice memo | Whisper → text → Claude Code | Idea backlog |
| Code snippets | Claude Code sessions | Auto-saved in project | Reusable components |

---

## 6. RESEARCH & INFORMATION MANAGEMENT

### 6.1 Multi-Source Research Workflow

**For any research topic (books, business ideas, tech trends):**

1. **Google Scholar** — Academic foundations
   - Search: `topic + "review" + 2024..2026`
   - Download 5-10 key PDFs
   - Upload to NotebookLM for synthesis

2. **Medium** — Practitioner perspectives
   - Search: `tag:topic`
   - Save to Pocket/Readwise
   - Weekly batch: summarize with Claude Code

3. **Reddit** — Ground truth from practitioners
   - Subreddits: r/Entrepreneur, r/SaaS, r/LocalLLaMA, r/ClaudeAI
   - Search: `site:reddit.com/r/subreddit "topic"`
   - Extract patterns with Claude Code

4. **YouTube** — Visual explanations
   - Search + transcript extraction
   - Upload transcripts to NotebookLM
   - Generate audio overview for commute

5. **Twitter/X** — Real-time trends
   - Follow key accounts in niche
   - Weekly: Claude Code summarizes trending discussions

6. **Books** — Deep knowledge
   - Read with AI companion (ask Claude Code questions about concepts)
   - Summarize chapters with NotebookLM
   - Create implementation checklist

### 6.2 Claude Code as Research Assistant

**Custom research skill** (`~/.claude/skills/research.md`):
```markdown
# Research Protocol

When asked to research a topic:
1. Search the web for 5 authoritative sources
2. Fetch and summarize each
3. Identify 3 conflicting viewpoints
4. Synthesize a balanced summary with citations
5. Suggest 3 actionable takeaways
6. Flag any claims that need verification
```

### 6.3 Knowledge Base Architecture

Recommended stack:
- **Capture:** Readwise (articles), Notion (notes), Obsidian (linked thinking)
- **Process:** NotebookLM (synthesis), Claude Code (analysis)
- **Store:** Notion or Obsidian (organized by project/topic)
- **Retrieve:** AI-powered search (Notion AI or Obsidian plugins)

### 6.4 Automated Research Pipeline (n8n)

```
RSS Feeds (10 sources)
    → n8n Filter (keywords match)
    → AI Agent (summarize + categorize)
    → Notion Database (store with tags)
    → Weekly Digest (email to you)
```

---

## 7. BOOK RECOMMENDATIONS BY GOAL

### 7.1 Getting Work / Making Money

| Book | Author | Key Takeaway |
|------|--------|-------------|
| **Atomic Habits** | James Clear | Systems > goals; 1% daily improvement compounds |
| **Deep Work** | Cal Newport | Focused work is the superpower of the 21st century |
| **Buy Back Your Time** | Dan Martell | Money's purpose is purchasing time |
| **$100M Offers** | Alex Hormozi | Create irresistible offers, not just products |
| **The Minimalist Entrepreneur** | Sahil Lavingia | Build small, profitable businesses |

### 7.2 Brainstorming & Creativity

| Book | Author | Key Takeaway |
|------|--------|-------------|
| **Thinking in Bets** | Annie Duke | Decisions under uncertainty; separate outcome from process |
| **Same As Ever** | Morgan Housel | Human nature is constant; study the past |
| **The Creative Act** | Rick Rubin | Creativity is a practice, not a talent |
| **Steal Like an Artist** | Austin Kleon | Nothing is original; remix with attribution |

### 7.3 Recording & Organizing Information

| Book | Author | Key Takeaway |
|------|--------|-------------|
| **Building a Second Brain** | Tiago Forte | CODE method: Capture, Organize, Distill, Express |
| **How to Take Smart Notes** | Sönke Ahrens | Zettelkasten method for connected thinking |
| **The PARA Method** | Tiago Forte | Projects, Areas, Resources, Archives |

### 7.4 Mindfulness & Self-Understanding

| Book | Author | Key Takeaway |
|------|--------|-------------|
| **The Power of Now** | Eckhart Tolle | Presence enhances performance |
| **The Daily Stoic** | Ryan Holiday | 366 meditations for resilience |
| **The Let Them Theory** | Mel Robbins | Detachment as strength |
| **Four Thousand Weeks** | Oliver Burkeman | Mortality-aware time management |
| **The Comfort Crisis** | Michael Easter | Voluntary discomfort builds resilience |

### 7.5 Reading Strategy

**The Stack Method (pairings):**
- Habits + Mindset: Atomic Habits + Grit
- Philosophy + Practice: Think and Grow Rich + Atomic Habits
- Productivity + Sustainability: Deep Work + Feel-Good Productivity
- Achievement + Peace: Essentialism + The Power of Now

**Format optimization:**
- Audiobooks for commute/exercise
- AI summaries (BookFlow, NotebookLM) for pre-reading
- Physical/digital with annotations for implementation books

---

## 8. QUICK-START ACTION PLAN

### Week 1: Foundation
- [ ] Install/update Claude Code and Kimi Code CLI
- [ ] Create `CLAUDE.md` for your main project
- [ ] Set up `~/.claude/settings.json` with allowed permissions
- [ ] Install 3 MCP servers (GitHub, filesystem, one database)
- [ ] Configure cost optimization (`CLAUDE_CODE_SUBAGENT_MODEL`)
- [ ] Set up NotebookLM account; create first notebook

### Week 2: Automation
- [ ] Deploy n8n locally with Docker
- [ ] Build first workflow: RSS → AI summary → Notion
- [ ] Create Google Apps Script for one Sheets automation
- [ ] Set up OpenClaw (if 24/7 agent monitoring desired)
- [ ] Configure Readwise/Pocket for article capture

### Week 3: Monetization Prep
- [ ] List 10 micro-SaaS ideas using AI brainstorming framework
- [ ] Validate top 3 with 5 potential users each
- [ ] Build landing page for #1 idea (use v0 + Claude Code)
- [ ] Set up Stripe account
- [ ] Create content calendar (LinkedIn/YouTube/newsletter)

### Week 4: Optimization
- [ ] Run first weekly review with AI assistance
- [ ] Audit tool subscriptions for ROI
- [ ] Document one repeatable process as n8n workflow
- [ ] Publish first piece of content (tutorial, case study, or tool)
- [ ] Set up OpenClaw heartbeat for business monitoring

### Daily Checklist (5 minutes each morning)
- [ ] Review AI-generated priority list
- [ ] Check n8n workflow dashboards
- [ ] Review OpenClaw notifications (if deployed)
- [ ] Set 3 MITs (Most Important Tasks)
- [ ] Block deep work time in calendar

---

## APPENDIX A: COST COMPARISON

| Tool | Monthly Cost | Value Metric |
|------|-------------|-------------|
| Claude Code (Pro) | $20 | Hours saved in coding |
| Kimi Code | $20 (membership) | Alternative/supplement to Claude |
| Cursor | $20 | IDE enhancement (optional) |
| n8n self-hosted | $0 | Workflow automation |
| NotebookLM Plus | ~$10-20 | Research synthesis |
| OpenClaw | $0 | Autonomous agents |
| Vercel Pro | $20 | Hosting |
| **Total recommended** | **~$60-80/month** | **Replaces $500+/month in contractor time** |

## APPENDIX B: KEY URLs

- [Claude Code Docs](https://code.claude.com/docs/en/overview)
- [Claude Code LLMs.txt Index](https://code.claude.com/docs/llms.txt)
- [Kimi Code Docs](https://www.kimi.com/code/docs/en/)
- [n8n Docs](https://docs.n8n.io/)
- [n8n AI Workflow Builder](https://docs.n8n.io/advanced-ai/ai-workflow-builder/)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [OpenClaw Production Guide](https://www.contextstudios.ai/blog/the-complete-openclaw-guide-how-we-run-an-ai-agent-in-production-2026)
- [NotebookLM](https://notebooklm.google.com/)
- [Google Apps Script](https://developers.google.com/apps-script)
- [MCP Servers Directory](https://github.com/modelcontextprotocol/servers)

---

*This guide was compiled from official documentation, community resources, and industry research. Verify all commands and pricing before implementation as tools evolve rapidly.*
