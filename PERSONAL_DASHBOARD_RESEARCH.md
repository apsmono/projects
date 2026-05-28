# Personal Workspace / Dashboard Design Research Report

## Executive Summary

This report synthesizes the best personal workspace/dashboard designs from across the internet, focusing on **personal use** (not team/business dashboards). It covers 6 categories with concrete UI/UX patterns, layout ideas, widget types, navigation structures, and specific URLs for reference.

---

## 1. Notion-Style Personal Dashboards ("Life OS")

### Core Design Patterns

#### A. Dashboard-as-Hub Architecture
The most successful Notion personal dashboards use a **single master page** as the digital home base, acting as a command center that surfaces information from across the workspace.

**Key Layout Pattern:**
```
┌─────────────────────────────────────────────┐
│  BANNER / COVER IMAGE                        │
│  [Quote / Daily Affirmation / Date]          │
├──────────────┬──────────────┬───────────────┤
│  QUICK LINKS │   CALENDAR   │   WEATHER/    │
│  [buttons]   │   [widget]   │   CLOCK       │
├──────────────┴──────────────┴───────────────┤
│  TODAY'S FOCUS                              │
│  [Top 3 priorities]                         │
├─────────────────────┬───────────────────────┤
│  HABITS TRACKER     │   TASKS / INBOX       │
│  [progress bars]    │   [database view]     │
├─────────────────────┼───────────────────────┤
│  GOALS (Quarterly)  │   JOURNAL / NOTES     │
│  [linked database]  │   [quick capture]     │
├─────────────────────┴───────────────────────┤
│  LIFE AREAS NAVIGATION                       │
│  [Health] [Work] [Finance] [Learning] ...   │
└─────────────────────────────────────────────┘
```

**Concrete Examples:**
- **"Personal Life Dashboard" by myaestheticnotion** — Combines daily/weekly/monthly planner views, goal setting, and vision board in one layout with dark mode option.
  - URL: https://bullet.so/blog/best-notion-templates-for-personal-use/

- **"Second Brain / PKM Template" by Cloud Play Studio** — Built on PARA method with goals, project tracking, habit-building integration, and knowledge organization.
  - URL: https://bullet.so/blog/best-notion-templates-for-personal-use/

- **"2025 Life Planner + 2024 Reflection" by beegalactica** — Full 2024 review section, personal branding page, detailed physical health page, custom journal template. Rated 4.7/5.
  - URL: https://www.notion.com/templates/2025-life-planner

- **"Feel-Good Productivity Dashboard" (Ali Abdaal-inspired)** — Prioritizes tasks, goals, and personalized productivity systems.
  - URL: https://www.notion.com/templates/feel-good-productivity-dashboard-inspired-by-ali-abdaal

### Widget Types That Work Well in Notion

| Widget | Purpose | Provider |
|--------|---------|----------|
| Calendar | Month/week view for planning | WidgetBox, Google Calendar embed |
| Clock | Time display (digital/analog) | FlipClock, Notion Avenue |
| Weather | Daily forecast | Indify |
| Pomodoro Timer | Focus sessions | Built-in or Indify |
| Habit Tracker | Visual progress rings | Progress bars via formulas |
| Countdown | Event anticipation | Indify |
| Quote Generator | Daily motivation | Various |
| Spotify | Music player embed | Spotify embed |
| Calculator | Quick math | Minimal Calculator widget |

**Key Design Rationale:**
- **Dark mode is essential** — Most popular templates offer it; users expect it
- **Use columns (2-3 max)** to create visual hierarchy without clutter
- **Quick-links as button blocks** at the top for instant navigation to sub-pages
- **Embed live widgets** via `/embed` blocks for real-time data (weather, calendar)
- **Vision boards** with image galleries for long-term motivation
- **Consistency matters more than complexity** — "The best Notion templates are the ones you'll actually use consistently"

---

## 2. Obsidian / Second Brain Workflows

### Tiago Forte's PARA Method

**The Framework:**
- **P**rojects — Active initiatives with deadlines
- **A**reas — Ongoing responsibilities (health, finance, relationships)
- **R**esources — Topics of interest for reference
- **A**rchive — Completed/inactive items

**Design Implication for Dashboards:**
Instead of organizing by topic (which creates silos), organize by **actionability**. A PARA-based dashboard would have:

```
┌─────────────────────────────────────────────┐
│  ACTIVE PROJECTS (highest priority)          │
│  [List with progress + due dates]            │
├─────────────────────────────────────────────┤
│  AREAS OF RESPONSIBILITY                     │
│  [Health] [Work] [Finance] [Relationships]  │
├─────────────────────────────────────────────┤
│  RESOURCES & KNOWLEDGE                       │
│  [Recently captured] [Frequently accessed]   │
├─────────────────────────────────────────────┤
│  INBOX (quick capture) -> Weekly Review      │
└─────────────────────────────────────────────┘
```

**Concrete Example:**
- **"My Second Brain — PARA Dashboard" by Jessica** — Notion template built directly on Tiago Forte's PARA method from his book *Building a Second Brain*.
  - URL: https://www.notion.com/templates/my-second-brain-para-dashboard

### Obsidian Dashboard Gallery

Obsidian dashboards leverage the **Dataview plugin** to create live, query-based dashboards that aggregate information from across the vault.

**Three Dashboard Styles from the Community:**

1. **Brutalist Home Dashboard** — Bold, vibrant colors, weather widget, clock, interactive cards. Requires Dataview + OpenWeatherMap API.
   - URL: https://github.com/InlitX/Obsidian-Dashboard-Gallery

2. **Zen Home Dashboard** — Minimal, ultra-premium with glassmorphism aesthetics, habit tracking, task pipeline with scroll, full banner customization. "Designed to feel like a personal OS."
   - URL: https://github.com/InlitX/Obsidian-Dashboard-Gallery

3. **Komorebi Home Dashboard** — Nature-inspired, soft organic aesthetic, calm color palette, distraction-free.
   - URL: https://github.com/InlitX/Obsidian-Dashboard-Gallery

**Dataview Dashboard Query Examples:**
```dataview
// Recently edited notes
LIST FROM "" SORT file.mtime DESC LIMIT 5

// Active projects table
TABLE status, priority, due FROM #project SORT due ASC

// Habit tracking from daily notes inline fields
TABLE sum(amount) as Total, category FROM "Expenses" GROUP BY category

// Calendar view of deadlines
CALENDAR due FROM #project WHERE due
```

**Key Design Rationale:**
- **Flat folder structure + links over rigid hierarchy** — Some power users (like Matt Giaro with 4,819 notes) use zero folders, relying entirely on bi-directional links
- **Dashboard synthesizes, doesn't duplicate** — The dashboard aggregates from other notes; content lives in its native location
- **Use Canvas plugin** for spatial mind-map style layouts
- **Meta Bind plugin** for interactive buttons that modify other notes' metadata
- **Homepage plugin** to auto-open dashboard on launch
- **"No folders" method** — Let structure emerge naturally from connections rather than forcing classification

### The CODE Framework (UI Translation)
| Step | User Action | Dashboard UI Pattern |
|------|-------------|---------------------|
| **C**apture | Quick-add idea | Floating action button, global hotkey, inbox widget |
| **O**rganize | File by project | Drag-to-project cards, PARA sidebar |
| **D**istill | Summarize note | Progressive summarization UI (bold -> highlight -> summary) |
| **E**xpress | Create output | "Create from note" button, publish/export actions |

---

## 3. Famous Productivity Setups

### Ali Abdaal

**System:**
- **Quarterly goal-setting** (every 3 months)
- **Weekly Reset** — Review goals and progress every week
- **Daily Top 3 Priorities**
- **Three life categories:** Health, Relationships, Work
- **Visual progress tracking** — Gamified with charts, word counts, level-up metaphors
- **"Feel-Good Productivity" philosophy** — System should feel enjoyable, not punitive

**Dashboard Implications:**
- Quarterly goals widget with progress indicators
- Weekly review template with structured prompts
- Three-pillar layout (Health / Relationships / Work)
- Book notes database (he reads extensively)
- Visual charts for habit streaks and goal progress

**URL:** https://www.notion.com/@aliabdaal

### Tim Ferriss

**System:**
- **Morning Pages** — 750 words of stream-of-consciousness journaling ("brain vomit") to clear anxiety
- **Fear-Setting** — Define worst-case scenarios in writing to neutralize them
- **Five-Minute Journal** — 3 things grateful for, 3 things that would make today great
- **Thematic days** — Each day dedicated to one type of activity (calls on Tuesday, writing on Wednesday, etc.)
- **"What would this look like if it were easy?"** — Framing question for simplification

**Dashboard Implications:**
- Morning journaling widget with word counter
- Fear-setting template with structured prompts:
  - What am I afraid of?
  - What's the worst that could happen?
  - How could I prevent this?
  - How could I recover?
  - What's the cost of inaction?
- Gratitude log with daily prompts
- Multiple-pass review system — Flag entries to revisit later

**URLs:**
- Morning Pages article: https://tim.blog/2015/01/15/morning-pages/
- Framework details: https://blog.mylifenote.ai/journaling-prompts-for-mental-health-by-tim-ferris/

### Naval Ravikant

**System:**
- **"Productize yourself"** — Build once, sell forever
- **Leverage** — Code, media, capital, labor
- **Specific knowledge** — Knowledge that cannot be trained for
- **High-density insights** — Principle-based content, no fluff
- **Reading + meditation** — Deep reflection over shallow productivity

**Dashboard Implications:**
- Principles/knowledge database (tweetstorm-style short insights)
- Reading list with key takeaways and connections
- Minimalist design — "High-density, low-clutter"
- Focus on compounding metrics (skills, knowledge, wealth) over daily task counts
- Identity-based tracking: "I am a reader/writer/meditator" not "I need to read/write/meditate"

**URL:** His content philosophy: https://blog.postful.ai/thought-leadership-content-examples/

### Tiago Forte

**System:**
- **PARA** (covered above)
- **CODE** framework (covered above)
- **Progressive Summarization** — Bold on first review, highlight bolded text on second, write summary on third
- **Intermediate Packets (IPs)** — Small reusable units of work

**Dashboard Implications:**
- Inbox widget for quick capture
- Project cards with linked notes count
- Review queue (notes ready for progressive summarization)
- Output tracker (what you created from your notes)
- Weekly/Monthly review cycles built into the UI

**URL:** https://www.aftertone.io/productivity-guides/second-brain-para-method

---

## 4. Personal Journaling Interfaces

### Day One

**Design Patterns:**
- **Timeline view** — Chronological scroll of entries with thumbnails
- **Map view** — Entries pinned to locations
- **Photos-first** — Rich media embedding with auto-metadata (weather, location, activity)
- **Templates** — "5-minute morning" and "night recap" structured prompts
- **On-this-day** — Historical entries resurfaced
- **End-to-end encryption** — Privacy as a core feature

**Dashboard/Widget Ideas to Steal:**
- Timeline widget showing recent entries
- "On this day" resurfacing module
- Photo grid for visual memory browsing
- Quick-capture floating button
- Mood/weather auto-tagging on entries

**URL:** https://dayoneapp.com/

### Stoic App

**Design Patterns:**
- **Morning prep + Evening reflection** — Two daily touchpoints
- **Guided journaling** — 50+ structured prompts covering emotional well-being, goal-setting, therapy progress
- **Voice note journaling** with automatic transcription
- **Drawing interface** for visual expression
- **Meditation + breathing exercises** integrated
- **Stoic quotes library** with favoriting/sharing
- **Streak counters + statistics** for habit motivation
- **Lock screen widget** for daily quote
- **Extremely calming UI** — "Unbelievably calming to use it"

**Dashboard Implications:**
- Split morning/evening journaling sections
- Prompt-of-the-day widget
- Streak visualization
- Mood tracking over time
- Quote-of-the-day display
- Voice memo quick-capture

**URL:** https://www.producthunt.com/products/stoic

### Reflectly

**Design Patterns:**
- **3-part daily check-in** — What happened, how you felt, what's next
- **Takes under 2 minutes** — Reduces blank-page anxiety
- **Mood-activity correlation tracking**
- **Beautiful UI with polished animations** — Used as a Flutter showcase app by Google
- **10M+ downloads**

**Limitations (design lessons):**
- No free-form journaling (structure helps beginners but becomes a ceiling)
- Aggressive upsell UX with countdown timers
- Mobile only

**Dashboard Implications:**
- Quick daily check-in widget (2-minute max)
- Mood trend chart
- Activity-mood correlation insights
- Minimal, beautiful animations

**URL:** https://blog.mylifenote.ai/day-one-journal-alternative/

### Key Journaling UI Principles for Personal Dashboards

| Principle | Implementation |
|-----------|---------------|
| **Reduce blank-page anxiety** | Provide structured prompts/templates |
| **Two daily touchpoints** | Morning prep + evening reflection |
| **Multi-modal input** | Text, voice, drawing, photo |
| **Streak psychology** | Visual progress, gamification |
| **Resurfacing memories** | "On this day", random entry |
| **Privacy signals** | Lock icon, encryption badges |
| **Calming aesthetics** | Soft colors, ample whitespace, no clutter |

---

## 5. Developer / Technical Personal Dashboards

### Self-Hosted Homelab Dashboards

The developer community has created an entire ecosystem of personal dashboards for organizing self-hosted services. These are functionally "personal command centers" and offer excellent UI patterns.

**Top Platforms:**

1. **Dashy** — Feature-rich homepage with easy YAML configuration, status-checking, widgets, themes, icon packs, UI editor.
   - 25,248 GitHub stars
   - URL: https://dashy.to/

2. **Glance** — Highly customizable dashboard that puts all feeds in one place. Fast, lightweight, RSS/reddit/weather/stock widgets.
   - 34,383 GitHub stars
   - URL: https://github.com/glanceapp/glance

3. **Homepage by gethomepage** — Highly customizable with Docker and service API integrations.
   - 30,330 GitHub stars
   - URL: https://gethomepage.dev/

4. **Homarr** — Sleek, modern dashboard with drag-and-drop tiles, auto-icon fetching, service status checks.
   - 3,893 GitHub stars
   - URL: https://homarr.dev/

5. **Homer** — Dead simple static homepage, YAML config, PWA, connectivity checks.
   - 11,362 GitHub stars

6. **Flame** — Self-hosted startpage with built-in GUI editors, weather widget, Docker integration.
   - URL: https://github.com/pawelmalak/flame

### Common Layout Pattern (Homelab Dashboards)
```
┌─────────────────────────────────────────────┐
│  SEARCH BAR                                  │
├──────────────┬──────────────┬───────────────┤
│  ┌────────┐  │  ┌────────┐  │  ┌────────┐  │
│  │Service │  │  │Service │  │  │Service │  │
│  │ [icon] │  │  │ [icon] │  │  │ [icon] │  │
│  │Status● │  │  │Status● │  │  │Status● │  │
│  └────────┘  │  └────────┘  │  └────────┘  │
├──────────────┴──────────────┴───────────────┤
│  CATEGORY: MEDIA                             │
│  ┌────────┐  ┌────────┐  ┌────────┐        │
│  │ Plex   │  │Sonarr  │  │Radarr  │        │
│  └────────┘  └────────┘  └────────┘        │
├─────────────────────────────────────────────┤
│  CATEGORY: DEV                               │
│  ┌────────┐  ┌────────┐  ┌────────┐        │
│  │GitLab  │  │Jenkins │  │Portainer│       │
│  └────────┘  └────────┘  └────────┘        │
└─────────────────────────────────────────────┘
```

### GitHub Profile READMEs as Personal Dashboards

Developers have turned their GitHub profile READMEs into personal dashboards using dynamic widgets:

| Widget | What It Shows | Example |
|--------|--------------|---------|
| GitHub Stats | Stars, commits, PRs, issues | github-readme-stats.vercel.app |
| Streak Stats | Contribution streak | github-readme-streak-stats |
| WakaTime | Weekly coding breakdown | Language %, time per project |
| Spotify Now Playing | Currently playing track | Real-time music widget |
| Activity Graph | 31-day contribution graph | Green activity heatmap |
| Trophy | GitHub achievement trophies | Animated trophy case |
| Blog Posts | Latest articles via RSS | Auto-updating list |

**URL:** https://github.com/abhisheknaiidu/awesome-github-profile-readme

### Developer Dashboard UI Principles

- **Status indicators** — Green/Red dots for service health
- **Icon-first navigation** — Recognizable app icons over text labels
- **Search/Command palette** — Cmd+K to jump anywhere
- **Category grouping** — Media, Dev, Monitoring, etc.
- **Keyboard shortcuts** — Essential for power users
- **Docker integration** — Auto-discover services by labels
- **Dark mode default** — Almost universal in dev tools
- **Minimal text** — Icons + status + maybe a subtitle

---

## 6. Design Principles from Linear, Raycast, Cron (Notion Calendar)

### Linear

**Design Philosophy:** "Linear design" = straightforward, sequential, highlighting logical progression.

**Key Patterns:**

1. **Command Palette (Cmd+K)** — Universal search + action. Not just finding, but DOING.
   - Create issue, jump to team/project, run commands
   - URL: https://www.morgen.so/blog-posts/linear-project-management

2. **Left Sidebar Navigation**
   - Inbox (updates from followed issues)
   - My Issues (grouped by status or cycle)
   - Team Views (Engineering, Design sections)
   - Projects, Roadmap, Custom Views
   - URL: https://www.morgen.so/blog-posts/linear-project-management

3. **Views as Saved Filters**
   - Personal dashboards ("All my open bugs")
   - Role-based lists ("Open QA issues")
   - Team-wide boards ("Bugs this week")
   - URL: https://linear.app/docs/dashboards

4. **Dashboards with Insight-Level Filters**
   - Dashboard-level filters apply globally
   - Insight-level filters refine individual widgets
   - Personal dashboards visible only to creator
   - URL: https://linear.app/docs/dashboards

**Linear Design Principles for Personal Dashboards:**
- **No zig-zagging content** — One-dimensional scrolling
- **Consistently aligned text**
- **Minimal CTAs** — One clear way forward per section
- **List vs Board toggle** — Let users choose their view
- **Custom statuses** — Triage -> Backlog -> In Progress -> Done

### Raycast

**Design Philosophy:** "Your shortcut to everything." Command palette as the primary interface.

**Key Patterns:**

1. **Keyboard-First Everything**
   - Invoke with hotkey (Alt+Space on Windows, Cmd+Space on Mac)
   - Type -> act -> done (no mouse required)
   - URL: https://windowsforum.com/threads/raycast-on-windows-a-keyboard-first-command-palette-for-fast-actions.395552/

2. **Search -> Act Model**
   - Find a file -> rename, move, open in specific app, pipe to another action
   - Kill a process without opening Task Manager
   - URL: https://windowsforum.com/threads/raycast-on-windows-a-keyboard-first-command-palette-for-fast-actions.395552/

3. **Built-in Utilities (All in One Palette)**
   - Clipboard history with searchable previews
   - Snippets (text expansion, 65,536 char limit)
   - Window management
   - Quicklinks for parameterized searches
   - Calculator (15% of 123.45)
   - URL: https://windowsforum.com/threads/raycast-on-windows-a-keyboard-first-command-palette-for-fast-actions.395552/

4. **Extension Ecosystem**
   - 15,000+ community extensions
   - Integrations: Slack, Google Calendar, Obsidian, GitHub
   - Built with React + TypeScript
   - URL: https://dev.to/simplr_sh/raycast-more-than-a-launcher-its-your-development-command-center-48o1

**Raycast's Visual Design System (from DESIGN.md analysis):**
```
Colors:
  Canvas:     #07080a (pure near-black)
  Surface:    #0d0d0d
  Elevated:   #101111
  Card:       #121212
  Hairline:   #242728 (1px borders, NO drop shadows)
  Primary:    #ffffff (white pill CTA)
  Body text:  #cdcdcd
  Muted:      #9c9c9d

Typography: Inter with ss03 stylistic set (alternate 'g')
Radii: 6px (keycaps), 8px (buttons), 10px (cards), 16px (hero)
Spacing: 96px section rhythm
Elevation: Built from surface-color ladder, NEVER drop shadows
```

URL for full design spec: https://github.com/VoltAgent/awesome-design-md/blob/main/design-md/raycast/DESIGN.md

### Cron (Notion Calendar)

**Design Philosophy:** "Skip the persuasion if the buyer already self-selected. Show the product. Get out of the way."

**Key Patterns:**

1. **Grid-Based Calendar UX**
   - Moving items on grid is "as fluid as in no other calendar app"
   - Drag-and-drop with precise snapping
   - Multi-select and drag multiple items
   - URL: https://www.cron.com/changelog

2. **Keyboard-First Navigation**
   - Cmd+K for command palette
   - E then C to change event color
   - E then E to email participants
   - T to go to today
   - URL: https://cronhq.notion.site/Calendars-events-customization-935cbc088ec34d1b824e1865a2d68d34

3. **Dark Mode Excellence**
   - "Gorgeous new dark mode"
   - Uses CIECAM02 color space for accurate transforms
   - Custom colors generate families that tint event chips (ribbons, background, title, time)
   - URL: https://www.cron.com/changelog

4. **Context Panel (Right Side)**
   - Event details in right-hand panel
   - Participant management
   - RSVP status
   - Location, visibility, conferencing
   - URL: https://cronhq.notion.site/Calendars-events-customization-935cbc088ec34d1b824e1865a2d68d34

5. **Time Zone Handling**
   - Pull time zone column to "travel to any city"
   - Auto-detect travel and prompt timezone change
   - Multiple time zones always visible
   - URL: https://www.cron.com/changelog

6. **Event Blocking**
   - Block events from personal calendar onto work calendar
   - One-click sync between calendars
   - URL: https://www.cron.com/changelog

**Cron Visual Design:**
- Intentionally neutral interface (light/dark)
- Fiery orange accents on neutral chrome
- Calendar content "really pops" against subdued background
- Bold colors and higher contrast in light mode
- Week numbers in grid header

---

## Synthesis: Recommended Personal Dashboard Architecture

Based on all research, here's a synthesized ideal personal dashboard:

### Layout Structure
```
┌──────────────────────────────────────────────────────────┐
│  COMMAND PALETTE (Cmd+K) — Universal search + actions    │
├──────────────────────────────────────────────────────────┤
│  LEFT SIDEBAR    │         MAIN CONTENT AREA             │
│                  │                                       │
│  Inbox           │  ┌─────────────────────────────────┐  │
│  My Tasks        │  │  TODAY'S FOCUS                   │  │
│  Goals           │  │  [Top 3 priorities]              │  │
│  Journal         │  └─────────────────────────────────┘  │
│  Reading         │                                       │
│  Health          │  ┌───────────────┬─────────────────┐  │
│  Finance         │  │ HABITS        │ CALENDAR        │  │
│  Knowledge       │  │ [streaks]     │ [week view]     │  │
│                  │  └───────────────┴─────────────────┘  │
│  ─────────────── │                                       │
│  Projects        │  ┌───────────────┬─────────────────┐  │
│  [Active]        │  │ QUICK CAPTURE │ STATS/OVERVIEW  │  │
│  [Active]        │  │ [voice/text]  │ [coding/health] │  │
│  [Active]        │  └───────────────┴─────────────────┐  │
│                  │                                       │
└──────────────────┴───────────────────────────────────────┘
```

### Color Scheme (Raycast-Inspired)
```css
--canvas: #07080a;
--surface: #0d0d0d;
--elevated: #101111;
--card: #121212;
--hairline: #242728;
--text-primary: #f4f4f6;
--text-body: #cdcdcd;
--text-muted: #9c9c9d;
--accent: #ff5757; /* or user-chosen */
--cta: #ffffff;
```

### Navigation Patterns
1. **Command palette** as primary navigation (Raycast/Linear style)
2. **Left sidebar** for persistent sections (PARA-inspired)
3. **Quick links** at top of main area (Notion style)
4. **Context panel** on right for details (Cron style)
5. **Keyboard shortcuts** for everything

### Widget Types to Include
| Category | Widgets |
|----------|---------|
| **Productivity** | Task list, Pomodoro timer, Focus mode, Time tracker |
| **Health** | Habit streaks, Sleep, Mood chart, Activity rings |
| **Knowledge** | Recent notes, Reading list, Capture inbox, Quotes |
| **Life OS** | Calendar, Weather, Clock, Goals progress, Finance |
| **Developer** | GitHub stats, Coding time, PRs, Service status |
| **Journal** | Morning/evening prompts, Streak, On-this-day |

### Interaction Patterns
1. **Quick capture** — Global hotkey, floating button, voice memo
2. **Progressive disclosure** — Details on hover/click, not all at once
3. **Streak psychology** — Visual progress, gamification, identity-based
4. **Review cycles** — Daily/weekly/monthly review templates
5. **Search-first** — Everything searchable, Cmd+K everywhere
6. **Dark mode** — Default, with optional light
7. **Minimal text** — Icons > labels where possible
8. **No drop shadows** — Use surface ladder for elevation (Raycast)
9. **Hairline borders** — 1px for card separation
10. **Consistent radius** — 8-10px for cards, 6px for small elements

---

## Reference URLs Summary

### Notion / Life OS
- https://www.notion.com/templates/2025-life-planner
- https://www.notion.com/templates/my-second-brain-para-dashboard
- https://www.notion.com/templates/feel-good-productivity-dashboard-inspired-by-ali-abdaal
- https://bullet.so/blog/best-notion-templates-for-personal-use/
- https://www.notion4management.com/blog/best-notion-life-os-templates
- https://www.notion.com/@aliabdaal

### Obsidian / Second Brain
- https://github.com/InlitX/Obsidian-Dashboard-Gallery
- https://mattgiaro.com/second-brain-obsidian/
- https://www.aftertone.io/productivity-guides/second-brain-para-method
- https://github.com/mortydemption/Paratag

### Productivity Thinkers
- https://tim.blog/2015/01/15/morning-pages/ (Tim Ferriss)
- https://blog.mylifenote.ai/journaling-prompts-for-mental-health-by-tim-ferris/
- https://blog.postful.ai/thought-leadership-content-examples/ (Naval)

### Journaling Apps
- https://www.producthunt.com/products/stoic (Stoic)
- https://blog.mylifenote.ai/day-one-journal-alternative/ (Day One alternatives)

### Developer Dashboards
- https://awesome-selfhosted.net/tags/personal-dashboards.html
- https://dashy.to/
- https://github.com/glanceapp/glance
- https://gethomepage.dev/
- https://github.com/abhisheknaiidu/awesome-github-profile-readme

### Design Principles
- https://blog.logrocket.com/ux-design/linear-design/
- https://linear.app/docs/dashboards
- https://github.com/VoltAgent/awesome-design-md/blob/main/design-md/raycast/DESIGN.md
- https://www.cron.com/changelog
- https://cronhq.notion.site/Calendars-events-customization-935cbc088ec34d1b824e1865a2d68d34
- https://windowsforum.com/threads/raycast-on-windows-a-keyboard-first-command-palette-for-fast-actions.395552/
