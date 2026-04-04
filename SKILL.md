---
name: learning-to-course
description: Turn any learning topic into a structured course with installable PWA website, comprehensive daily study guides, quizzes, and GitHub repo. Course length is dynamic based on user's goals, experience level, and available time. Supports English and Simplified Chinese. Use when user wants to create a learning course, curriculum, study plan, or interactive learning path for any topic. Triggers on "create a course", "turn X into a course", "make a learning path", "build a curriculum".
---

# learning-to-course

**Turn any learning topic into a dynamic, installable PWA course app with GitHub repo**

## Step 1: Ask the User

Before generating anything, ask these 6 questions:

1. **Topic** — "What do you want to learn?"
2. **Experience level** — "Complete beginner, some background, or experienced?"
3. **Time per day** — "30 min / 1 hour / 2 hours?"
4. **Duration** — "1 week / 2 weeks / 3 weeks / 1 month / custom?"
5. **Language** — "English, Simplified Chinese, or bilingual?"
6. **Goal** — "What do you want to be able to do by the end?"

Do NOT default to 21 days — match the user's needs.

| User Says | Days | Structure |
|-----------|------|-----------|
| "Quick intro" / "1 week" | 5-7 | Foundations only |
| "Solid understanding" / "2 weeks" | 10-14 | Foundations + building |
| "Comprehensive" / "3 weeks" | 15-21 | Foundations + building + advanced + capstone |
| "Deep dive" / "1 month" | 21-30 | Full curriculum with multiple projects |

30-min sessions = lighter content per day. 2-hour sessions = dense content, fewer days.

## What it generates

1. **GitHub repo** — Daily guides, quizzes, projects, flashcards
2. **Daily study guides** — 800-1500 word markdown files with 8 mandatory sections
3. **Installable PWA** — Tab-based course website, offline-capable, uses pre-built `styles.css` + `main.js`
4. **Quiz system** — Interactive quizzes, flashcards, progress tracking
5. **Diagrams** — Excalidraw source files + SVG exports

## Repo Structure

```
[topic-name]/
├── README.md
├── week-01/
│   ├── day-01-[topic].md       # 800-1500 words, 8 sections each
│   ├── day-02-[topic].md
│   ├── quiz-01.json
│   └── ...
├── week-02/ (if applicable)
├── projects/
├── flashcards/
├── diagrams/                    # .excalidraw source files
└── website/
    ├── styles.css         ← copied from assets/styles.css (NEVER regenerate)
    ├── main.js            ← copied from assets/main.js (NEVER regenerate)
    ├── index.html         ← built from assets/tab-index-template.html (see Build Process)
    ├── manifest.json
    ├── sw.js
    ├── offline.html
    ├── modules/           ← day/module content HTML files (lazy-loaded)
    │   ├── 01-topic.html
    │   └── ...
    ├── diagrams/          ← SVG/PNG exports (MUST be here, NOT ../diagrams/)
    └── icons/
```

## Daily Study Guide Format

Every day gets a markdown file with **8 mandatory sections** — no placeholders:

1. **Learning Objectives** — 3-5 measurable goals
2. **Core Concepts** — 800-1200 words
3. **Key Terminology** — 5-10 terms with examples
4. **Code Examples** — Working, copy-paste ready, commented
5. **Hands-On Exercises** — 3-5 practical activities
6. **Curated Resources** — Verified links (see oEmbed protocol below)
7. **Reflection Questions** — 3-5 comprehension checks
8. **Next Steps** — Preview of next topic + navigation links

See `references/daily-guide-template.md` for the full template. Read `references/design-philosophy.md` when writing content.

## Video Link Verification — MANDATORY oEmbed Protocol

For EVERY YouTube video:

1. Search live — never generate URLs from memory
2. Verify via oEmbed: `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json`
3. Copy the EXACT `title` and `author_name` fields — do not paraphrase
4. If oEmbed returns 404 — video is dead, do NOT include it
5. Check the video actually covers the lesson topic
6. Never use the same video twice in the same section

**Why this matters:** In a previous course, 13/21 videos had wrong titles and 5 were dead — all from LLM memory.

Also: verify every doc link loads via `web_fetch`. Link to top-level/stable URLs. See `references/quality-checklist.md`.

## Excalidraw Diagrams

- Source: `diagrams/*.excalidraw` | Exports: `website/diagrams/*.svg`
- HTML references: `src="diagrams/file.svg"` (relative to `website/`, not `../diagrams/`)

See `references/excalidraw.md` for MCP commands, export steps, and ready-to-use templates.

## PWA Requirements

Every course is a PWA. Required files: `manifest.json`, `sw.js`, `offline.html`, icons (192, 512, maskable, apple-touch).

- Always `await` async cache operations in the service worker
- Include ALL icon files in the pre-cache list
- If no icons provided, generate with Python + Pillow (required sizes: 192, 512, 192-maskable, 512-maskable, 180 apple-touch)

See `references/pwa-setup.md` for complete implementation.

## Interactive Elements (pre-built in main.js)

Use these CSS classes in module HTML — do NOT invent new ones:

| Element | Class / Attribute |
|---------|------------------|
| Glossary tooltip | `.term[data-definition]` |
| Chat animation | `.chat-window` > `.chat-message[data-msg][data-sender]` |
| Flow animation | `.flow-animation[data-steps]` |
| Quiz | `.quiz-card[data-correct][data-explanation-N]` > `.quiz-options` > `.quiz-option` |
| Flashcard | `.flashcard` > `.flashcard-front` / `.flashcard-back` |
| Callout | `.callout-accent` / `.callout-info` / `.callout-warning` |
| Step card | `.step-cards` > `.step-card` > `.step-num` + `.step-body` |

See `references/interactive-elements.md` for full HTML patterns.

## Website Build Process

Do NOT generate CSS or JS from scratch — use the pre-built assets.

1. Copy `assets/styles.css` → `website/styles.css` (verbatim, never modify)
2. Copy `assets/main.js` → `website/main.js` (verbatim, never modify)
3. Copy `assets/tab-index-template.html` → `website/index.html`, then replace these tokens:

   | Token | Replace with |
   |-------|-------------|
   | `LANG_CODE` | BCP-47 code: `en` or `zh-CN` |
   | `COURSE_TITLE` | Course name (2 places) |
   | `COURSE_DESCRIPTION` | Meta description |
   | `ACCENT_HEX` | Hex color for theme-color |
   | `PWA_SHORT_NAME` | Max 12 chars |
   | `FONT_IMPORT_LINE` | Full `<link>` tag for Google Fonts |
   | `FONT_OVERRIDE_CSS` | CSS font-family overrides (blank for English; for Chinese: `h1,h2,h3{font-family:'Noto Serif SC',serif;}`) |
   | `ACCENT_COLOR` / `ACCENT_HOVER` / `ACCENT_LIGHT` / `ACCENT_MUTED` | Palette values (see table below) |
   | `HERO_EMOJI` | Single emoji |
   | `COURSE_SUBTITLE` | e.g. `15-Day Course · 1 hour/day` |
   | `TAG_1`…`TAG_4` | Hero badge labels |
   | `DAY_COUNT` + `NUMBER_OF_DAYS` | Integer (appears in HTML and JS) |
   | `WEEK_LABELS_HTML` | One `<span>` per week |
   | `CURRICULUM_HTML` | Expandable week/day cards (see pattern below) |
   | `MODULE_FILES_JSON` | JS array: `['modules/01-intro.html', ...]` |
   | `DIAGRAM_FILES_JSON` | JS array: `['diagrams/overview.svg']` or `[]` |
   | `COURSE_STORAGE_KEY` | Unique localStorage key e.g. `'course-ai-agents-progress'` |
   | `RESOURCES_HTML` | Resource group HTML (see pattern below) |

4. Write module files to `website/modules/01-topic.html`, `02-topic.html`, etc.

**Curriculum HTML pattern:**
```html
<div class="week-section">
  <h3>Week 1: Foundations</h3>
  <div class="day-card">
    <div class="day-card-header">
      <span class="day-card-title">Day 1: Topic Title</span>
      <div class="day-card-meta">
        <span class="day-type type-foundations">Foundations</span>
        <span class="chevron">▼</span>
      </div>
    </div>
    <div class="day-card-body">
      <ul><li>Key point 1</li><li>Key point 2</li></ul>
      <a class="day-link" href="https://github.com/GITHUB_USERNAME/GITHUB_REPO/blob/main/week-01/day-01-slug.md" target="_blank">Read Full Guide →</a>
    </div>
  </div>
</div>
```
Day type classes: `type-foundations`, `type-concepts`, `type-advanced`, `type-project`, `type-review`

**Resources HTML pattern:**
```html
<div class="resource-group">
  <h3>📚 Books</h3>
  <a class="resource-link" href="URL" target="_blank">
    <span class="resource-icon">📖</span>
    <div class="resource-text"><strong>Title</strong><span>Description</span></div>
  </a>
</div>
```

## Module HTML Structure

> [!IMPORTANT]
> Every `<section class="module">` MUST have `<div class="module-inner">` as its first and only direct child. Missing this wrapper breaks all layout.

> [!CAUTION]
> Only use class names from the Interactive Elements table above or `references/interactive-elements.md`. Do NOT invent classes like `module-header`, `objectives`, `content-section`, `subtitle`, `difficulty`, or `comparison-table` — they don't exist in `styles.css`.

```html
<section class="module" id="module-N" data-module="Day N: Title">
<div class="module-inner">

  <h2>Day N: Title</h2>
  <p class="module-meta">Difficulty · Estimated time: 1 hour</p>

  <div class="step-cards">
    <div class="step-card">
      <div class="step-num">1</div>
      <div class="step-body"><strong>Concept</strong><p>Explanation</p></div>
    </div>
  </div>

  <div class="callout-accent"><strong>Key insight:</strong> ...</div>

  <div class="quiz-card" data-correct="1" data-explanation-0="Wrong" data-explanation-1="Correct">
    <p class="quiz-question">Question?</p>
    <div class="quiz-options">
      <button class="quiz-option">A</button>
      <button class="quiz-option">B (correct)</button>
    </div>
  </div>

  <p><span class="term" data-definition="Definition">Term</span></p>

</div>
</section>
```

Module files contain ONLY this `<section>` block — no `<html>`, `<head>`, `<body>`, `<style>`, or `<script>` tags.

## Accent Color Palettes

| Palette | `ACCENT_COLOR` | `ACCENT_HOVER` | `ACCENT_LIGHT` | `ACCENT_MUTED` |
|---------|---------------|----------------|----------------|----------------|
| Terracotta (default) | `#c4825a` | `#b07149` | `rgba(196,130,90,0.12)` | `rgba(196,130,90,0.06)` |
| Coral | `#D94F30` | `#C4432A` | `rgba(217,79,48,0.12)` | `rgba(217,79,48,0.06)` |
| Teal | `#2A7B9B` | `#236A86` | `rgba(42,123,155,0.12)` | `rgba(42,123,155,0.06)` |
| Amber | `#B8860B` | `#9E7309` | `rgba(184,134,11,0.12)` | `rgba(184,134,11,0.06)` |
| Forest | `#4a7c59` | `#3d6849` | `rgba(74,124,89,0.12)` | `rgba(74,124,89,0.06)` |

## Parallel Generation (10+ Day Courses)

1. Research and verify all resources upfront
2. Write day briefs using the template in `references/daily-guide-template.md`
3. Dispatch 2-3 briefs per batch to subagents
4. Each subagent produces: one daily guide `.md` + one module `.html`
5. Main agent does a consistency check after all days complete

For courses under 10 days, generate sequentially — brief overhead exceeds time saved.

## GitHub Placeholder Replacement

Before delivery, replace ALL `YOUR_USERNAME`, `YOUR_REPO`, `USER/REPO` with actual values. Auto-detect from `git remote -v` or ask. Verify: `grep -r "YOUR_" .` must return empty.

## GitHub Pages Deployment — MANDATORY

**Every course MUST be deployed as a live PWA.**

### Step 1: Create Workflow File

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/configure-pages@v4
        with:
          enablement: true
      - uses: actions/upload-pages-artifact@v3
        with:
          path: website
      - id: deployment
        uses: actions/deploy-pages@v4
```

### Step 2: Enable GitHub Pages

After pushing the workflow file:

```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/OWNER/REPO/pages \
  -f "build_type=workflow"
```

### Step 3: Push and Verify

```bash
git add .github/workflows/deploy.yml
git commit -m "🚀 Add GitHub Pages deployment"
git push

# Check deployment
gh run list --limit 1
```

**Site will be live at:** `https://OWNER.github.io/REPO/`

### Important Constraints

The `website/` directory is the site root — `../` paths will NOT resolve.

- Quiz/flashcard JSON MUST be in `website/data/`
- Day guide links MUST use absolute GitHub URLs: `https://github.com/USERNAME/REPO/blob/main/week-XX/day-XX-slug.md`
- Include live URL in README

## Quality Gates — MANDATORY

Run `references/quality-checklist.md` before delivery. Every course must pass:

1. All YouTube videos verified via oEmbed
2. No `YOUR_USERNAME`/`YOUR_REPO` placeholders remaining
3. All diagram SVGs in `website/diagrams/`, HTML uses relative paths
4. All days have 8 sections, 800+ word core concepts
5. HTML loads, service worker registers, manifest valid
6. Quiz answer distribution: no single index >40% of correct answers

## Multi-Language Support

**Chinese courses:** Set `lang="zh-CN"`, load Noto Serif SC, translate all UI labels, keep technical terms in English with Chinese explanation: `ReAct（推理与行动结合）`, keep code comments in English.

**Bilingual:** Primary language first, section headers in both languages: `## 核心概念 Core Concepts`. Find Chinese-language videos on Bilibili.

## Bundled Resources

### `references/` — Load into context as needed
- `daily-guide-template.md` — Full daily guide template + day brief template for parallel generation
- `quality-checklist.md` — Pre-delivery checklist + gotchas
- `interactive-elements.md` — All interactive HTML patterns
- `excalidraw.md` — Diagram workflow, MCP commands, templates
- `pwa-setup.md` — Complete PWA implementation guide
- `design-system.md` — Visual design system (source of truth: `assets/styles.css`)
- `design-philosophy.md` — Content writing principles (read when writing daily guides and modules)

### `assets/` — Copy into courses
- `styles.css` — Pre-built CSS framework (copy verbatim, NEVER regenerate)
- `main.js` — Pre-built JS engine (copy verbatim, NEVER regenerate)
- `tab-index-template.html` — Tab-based index.html shell (copy + replace tokens, NEVER regenerate)
