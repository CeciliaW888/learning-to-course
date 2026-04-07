---
name: learning-to-course
description: Turn any learning topic into a structured course with installable PWA website, comprehensive daily study guides, quizzes, and GitHub repo. Course length is dynamic based on user's goals, experience level, and available time. Supports English and Simplified Chinese. Use when user wants to create a learning course, curriculum, study plan, or interactive learning path for any topic. Triggers on "create a course", "turn X into a course", "make a learning path", "build a curriculum".
---

# learning-to-course

**Turn any learning topic into a dynamic, installable PWA course app with GitHub repo**

## Step 1: Ask the User

Before generating anything, ask these questions to determine course structure:

1. **What topic?** — "What do you want to learn?"
2. **Experience level?** — "Are you a complete beginner, have some background, or experienced?"
3. **Time commitment?** — "How much time per day? (30 min / 1 hour / 2 hours)"
4. **Duration?** — "How long do you want the course? (1 week / 2 weeks / 3 weeks / 1 month / custom)"
5. **Language?** — "English, Simplified Chinese, or bilingual?"
6. **Goal?** — "What do you want to be able to do by the end?"

Use answers to dynamically generate the curriculum. Do NOT default to 21 days — match the user's needs.

## Step 2: Design Playground (Optional but Recommended)

Before generating the full course, offer the user a **design playground** — a single HTML file they can open in their browser to explore and customize the website look. This lets users choose their preferred style before you generate hundreds of files.

**What the playground shows:**
- **Progress card styles** — donut ring + streak combo with adjustable ring size, stroke, cell height, colors
- **Accent color palette** — live preview of terracotta, teal, forest, coral, amber, or custom color
- **Dark/light mode** — toggle to see both themes
- **Typography** — font pairing preview (heading + body fonts)

**How to generate it:**
1. Create the playground as a single self-contained HTML file (inline CSS/JS, no dependencies)
2. Save to `/tmp/course-playground.html` (ephemeral — NEVER in the course repo)
3. Open it in the user's browser: `start /tmp/course-playground.html` (Windows) or `open /tmp/course-playground.html` (macOS)
4. Include a "Copy" button that outputs a natural-language prompt describing the user's chosen settings
5. User pastes the prompt back, and you apply those settings when generating the course

**Playground controls:**
- Accent color picker + presets (Terracotta, Teal, Forest, Coral, Amber)
- Ring size slider (60-140px)
- Ring stroke slider (3-12px)
- Cell height slider (12-36px)
- Card border-radius slider (0-24px)
- Dark mode toggle
- Show/hide: day numbers, header, week labels

**When to skip:** If the user says "just use defaults" or "whatever looks good", skip the playground and use terracotta palette with default settings.

## Step 3: Generate Content

1. Create repo structure (`week-01/`, `website/`, `website/modules/`, `website/data/`, `website/diagrams/`, `website/icons/`)
2. Copy `assets/styles.css` → `website/styles.css` and `assets/main.js` → `website/main.js` (verbatim)
3. Generate daily study guides (`.md` files in `week-XX/`) — 8 sections each, 800-1500 words
4. Generate module HTML fragments (`website/modules/XX-topic.html`) — NO DOCTYPE, NO `<html>`, NO `<script src>`
5. Generate `website/data/flashcards.json` (5+ cards per day) and `website/data/quiz-01.json` through `quiz-{DAY_COUNT}.json` (3+ questions each)
6. Build `website/index.html` from `assets/tab-index-template.html` (replace tokens)
7. Create PWA files: `manifest.json`, `sw.js` (network-first for HTML), `offline.html`, icons
8. Create `README.md` from `assets/README-template.md`
9. Create `.github/workflows/deploy.yml` for GitHub Pages deployment
10. Create diagrams (Excalidraw → SVG exports in `website/diagrams/`)

For 10+ day courses, use parallel generation — see "Parallel Generation" section below.

## Step 4: Validate

Run the validation script against the generated course:

```bash
bash path/to/learning-to-course/scripts/validate-course.sh
```

Fix any failures before proceeding. Common issues:
- Modules contain `<!DOCTYPE>` or `<script src>` tags (must be fragments)
- Missing quiz/flashcard data files
- Unreplaced placeholders
- Quiz answer distribution skewed (>40% on one index)

## Step 5: Clean Up

Delete all ephemeral files before delivery:
- `briefs/` directory (if parallel generation was used)
- Any playground HTML files (should be in `/tmp/`, not the repo)
- Any test scripts

## Step 6: Deploy & Deliver

1. Replace GitHub placeholders with actual username/repo
2. Commit, push, verify GitHub Pages deploys
3. Share the live URL with the user
4. Run validation one final time on the deployed site

### Duration Guidelines

| User Says | Days | Weeks | Structure |
|-----------|------|-------|-----------|
| "Quick intro" / "1 week" | 5-7 | 1 | Foundations only, no project |
| "Solid understanding" / "2 weeks" | 10-14 | 2 | Foundations + hands-on building |
| "Comprehensive" / "3 weeks" | 15-21 | 3 | Foundations + building + advanced + capstone |
| "Deep dive" / "1 month" | 21-30 | 4 | Full curriculum with multiple projects |

Adjust daily time per session based on user's availability. 30-min sessions = lighter content per day, more days. 2-hour sessions = dense content, fewer days.

## What it generates

1. **GitHub repo** — Structured learning path with daily guides, quizzes, projects
2. **Daily study guides** — 800-1500 word markdown files with 8 mandatory sections
3. **Installable PWA** — Course website that works offline, installs to home screen; uses pre-built `styles.css` + `main.js` copied from assets/
4. **Quiz system** — Interactive quizzes, flashcards, progress checkpoints
5. **Diagrams** — Excalidraw source files + SVG exports
6. **Validation script** — `validate-course.sh` checks the generated course for common issues

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
    ├── index.html         ← built from assets/tab-index-template.html
    ├── manifest.json
    ├── sw.js
    ├── offline.html
    ├── modules/           ← day/module content HTML files
    │   ├── 01-topic.html
    │   ├── 02-topic.html
    │   └── ...
    ├── diagrams/                # Exported SVG/PNG (MUST be here)
    └── icons/
```

## Daily Study Guide Format

Every day gets a dedicated markdown file with **8 mandatory sections**:

1. **Learning Objectives** — 3-5 measurable goals
2. **Core Concepts** — 800-1200 words of explanations
3. **Key Terminology** — 5-10 terms with examples
4. **Code Examples** — Working, commented code (copy-paste ready)
5. **Hands-On Exercises** — 3-5 practical activities
6. **Curated Resources** — Verified links with sections/timestamps
7. **Reflection Questions** — 3-5 comprehension checks
8. **Next Steps** — Preview of next topic + navigation links

Every guide must be comprehensive, not a placeholder. See `references/daily-guide-template.md` for the full template.

## Research Checklist

Before writing daily guides, research using:

**Primary:** Official docs, academic posts (Lilian Weng, Chip Huyen), framework docs, ArXiv papers, production examples
**Secondary:** YouTube tutorials (verify all links), blog posts, GitHub repos, conference talks

**Standard:** Every claim must be traceable to a real source. No hallucinated references.

## Video Link Verification — MANDATORY oEmbed Protocol

**For EVERY YouTube video, follow this exact protocol:**

1. **Search for the video live** — use WebSearch, never generate URLs from memory
2. **Verify via oEmbed API** — fetch `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json`
3. **Copy the EXACT `title` field** — do not paraphrase, shorten, or "improve" it
4. **Copy the EXACT `author_name` field** — do not guess the creator
5. **If oEmbed returns 404** — video is dead, do NOT include it
6. **If title doesn't match the topic** — wrong video, find a different one
7. **Do NOT use the same video twice in the same section**
8. **Verify the video actually covers the lesson topic** — a function calling video is NOT a safety video

**Why:** In ai-agent-learning, 13/21 videos had wrong titles/attributions and 5 were dead. All from LLM memory.

See `references/quality-checklist.md` for the full verification workflow including deduplication checks.

## Documentation & Resource Links

- Link to **top-level/stable URLs** — deep paths break when docs restructure
- **Verify every link loads** with `web_fetch` before including it
- **Do NOT generate** audit files, CONTRIBUTING.md, or tracking docs that go stale

## Excalidraw Diagrams

Diagrams stored in dual format: `.excalidraw` source in `diagrams/`, SVG/PNG exports in `website/diagrams/`.

**Critical path rules:**
- Source: `diagrams/*.excalidraw` | Exports: `website/diagrams/*.svg`
- HTML: `src="diagrams/file.svg"` (relative to website/, NOT `../diagrams/`)
- SVG preferred over PNG (scalable, smaller, searchable)

See `references/excalidraw.md` for MCP commands, export steps, HTML templates, CSS, and ready-to-use diagram JSON.

## PWA — Core Feature

Every course website is a PWA. No exceptions. Required files: `manifest.json`, `sw.js`, `offline.html`, icons (192, 512, maskable, apple-touch), install prompt, Apple meta tags.

**Service worker rules:**
- **Network-first for HTML** (index.html + module files) — users always get latest content
- **Cache-first for static assets** (CSS, JS, images, fonts) — fast loads from cache
- **No offline fallback for non-navigation requests** — returning offline.html as module content breaks the accordion (it gets injected as lesson content and marked as loaded)
- Always `await` async cache operations — `caches.match()` returns a Promise
- Include ALL icon files in pre-cache list
- Validate `resp.ok` before injecting fetched HTML into the page
- Default theme: `#c4825a` (terracotta) / `#f5f0eb` (warm cream)

**Icon generation:** If the user doesn't provide icons, generate them programmatically:
- Use Python + Pillow to create simple branded icons with the accent color
- Required sizes: 192×192, 512×512 (regular), 192×192, 512×512 (maskable with full bleed), 180×180 (Apple touch)
- Maskable icons must have the safe zone (80% center area) containing the design
- Save to `website/icons/`

See `references/pwa-setup.md` for complete implementation guide.

### Interactive Elements (Pre-built)

The pre-built main.js auto-initializes these elements by scanning for CSS classes and data-* attributes:

- **Glossary tooltips** — `.term[data-definition]` on every technical term
- **Code translations** — `.translation-block` with code + English columns
- **Chat animations** — `.chat-window` with sequential message reveal
- **Data flow animations** — `.flow-animation[data-steps]`
- **Quizzes** — `.quiz-card` with `data-correct`, `data-explanation-*`
- **Flashcards** — `.flashcard` with flip animation
- **Drag-and-drop** — `.dnd-container` with chips and zones
- **Spot-the-bug** — `.bug-challenge` with clickable code lines
- **Callout boxes** — `.callout-accent`, `.callout-info`, `.callout-warning`
- **Step cards** — `.step-card` with numbered badges
- **File trees** — `.file-tree` with nested folders
- **Architecture diagrams** — `.arch-diagram` with clickable components

See `references/interactive-elements.md` for HTML patterns and `assets/styles.css` for styling.

## Website Architecture

All courses use a **tab-based accordion layout** regardless of length. The accordion adapts automatically:

| Course Length | Week Subtabs | Accordion Cards | Progress Card |
|--------------|-------------|----------------|---------------|
| 5-7 days (1 week) | None — all cards shown directly | 5-7 cards, no week grouping | Donut ring + single row of cells |
| 8-14 days (2 weeks) | Week 1 / Week 2 | 7 cards per week tab | Donut ring + 2×7 streak grid |
| 15-21 days (3 weeks) | Week 1 / Week 2 / Week 3 | 7 cards per week tab | Donut ring + 3×7 streak grid |
| 22-30 days (4 weeks) | Week 1 / Week 2 / Week 3 / Week 4 | 7-8 cards per week tab | Donut ring + 4×7 streak grid |

For short courses (≤7 days), skip the week subtabs entirely — show all cards in a single list. The accordion still lazy-loads content on click, keeping the page fast.

### What the website provides:
- **Hero section** — course title, subtitle, tags, PWA install button
- **Progress card** — donut ring (90px) on left + streak calendar grid on right. Ring shows percentage and day count. Cells are clickable to toggle completion, persisted in localStorage.
- **Sticky tab navigation** — Learning Content, Diagrams, Flashcards, Quiz, Resources (NO Curriculum tab — the accordion IS the curriculum)
- **Learning Content tab (DEFAULT)** — week subtabs (if 2+ weeks), each showing collapsible accordion cards. Content lazy-loads on card click. Prev/Next buttons added dynamically via `goToDay()`.
- **Quiz/Flashcard tabs** — load from `website/data/*.json`
- **Diagrams tab** — renders SVGs from `website/diagrams/`
- **Resources tab** — curated external links grouped by category

This approach loads `styles.css` and `main.js` for interactive features. See `references/tab-website-template.html` for the reference implementation.

### Implementation rules:
- Module files in `modules/` are fetched dynamically when accordion cards are expanded
- Override `.module { min-height: auto; }` since modules are embedded, not full-viewport
- After loading modules, call `initIndexQuizzes()` and `initChatWindows()` (both exposed on `window` by main.js)
- The `loadModules()` call MUST appear AFTER all `const` declarations (`MODULE_TITLES`, `WEEK_NAMES`, `WEEK_RANGES`) to avoid temporal dead zone errors
- CSS rule for tab sections must be scoped: `main > .section { display: none }` — NOT `.section { display: none }` which would hide sections inside injected modules

## Website Build Process

The PWA website uses a pre-built runtime. Do NOT generate CSS or JS from scratch.

1. Copy `assets/styles.css` → `website/styles.css` (verbatim, never modify)
2. Copy `assets/main.js` → `website/main.js` (verbatim, never modify)
3. Customize `assets/tab-index-template.html` → `website/index.html` (replace tokens)
4. Write module content to `website/modules/01-topic.html`, `02-topic.html`, etc.
   - Each file contains ONLY a `<section class="module" id="module-N">` block
   - NO `<!DOCTYPE>`, `<html>`, `<head>`, `<body>`, or `<script src>` tags
   - Use class names and data-* attributes documented in interactive-elements.md

> **CRITICAL: Module files are HTML FRAGMENTS, not full documents.**
> NO `<!DOCTYPE>`, `<html>`, `<head>`, `<body>`, or `<script src>` tags.
> See `references/interactive-elements.md` for the full module HTML structure, class names, and quiz patterns.
> See `references/tab-website-template.md` for accent color palettes.

## Parallel Generation (10+ Day Courses)

For longer courses, use day briefs to enable parallel generation:

1. Research and verify all resources upfront
2. Write briefs for each day using the "Day Brief Template" section in `references/daily-guide-template.md`
3. Dispatch 2-3 briefs per batch to subagents
4. Each subagent receives: its brief + relevant reference files
5. Each subagent produces: one daily guide markdown + one website module HTML
6. Main agent does consistency check after all days complete
7. Generate quiz JSON files (`website/data/quiz-01.json` through `quiz-{DAY_COUNT}.json`)
8. Generate flashcards JSON (`website/data/flashcards.json`)
9. Delete `briefs/` directory — these are build artifacts, not deliverables

For courses under 10 days, generate sequentially — brief overhead exceeds time saved.

## GitHub Placeholder Replacement

Before delivery, replace ALL `YOUR_USERNAME`, `YOUR_REPO`, `USER/REPO` with actual values. Auto-detect from `git remote -v` or ask. Verify with `grep -r "YOUR_" .` — must return empty.

See `references/quality-checklist.md` Section 2 for scripts.

## GitHub Pages Deployment

The `website/` directory is deployed as the site root. This means `../` paths will NOT resolve on the deployed site.

**Rules:**
- Quiz JSON, flashcard JSON, and any data files MUST be copied into `website/data/`
- Day guide links MUST use absolute GitHub URLs: `https://github.com/USERNAME/REPO/blob/main/week-XX/day-XX-slug.md`
- Diagram SVGs are fine — they live inside `website/diagrams/` already
- The GitHub Actions workflow should deploy `website/` as the artifact path
- Add `enablement: true` to `actions/configure-pages` to auto-enable Pages
- Add a concurrency group to prevent deployment races:

```yaml
concurrency:
  group: "pages"
  cancel-in-progress: false
```

## Ephemeral Files — Clean Up Before Delivery

These files are used during generation but must NOT appear in the final repo:

- **`briefs/`** — Day brief files used for parallel generation. Delete after all daily guides and modules are generated.
- **Playground HTML files** — Design exploration tools (e.g., `progress-playground.html`). Create in `/tmp/` or a gitignored location, never in the course repo.
- **Test scripts** — Playwright test files created during development. Keep in `/tmp/`.

Add to the final delivery checklist: `find . -name "*.playground.html" -o -name "briefs" -type d` must return empty.

## Quality Gates — MANDATORY

Every course must pass before delivery:

1. **Link verification** — all YouTube videos verified via oEmbed, all docs links reachable
2. **Placeholder replacement** — no YOUR_USERNAME/YOUR_REPO remaining
3. **Diagram paths** — exports in `website/diagrams/`, HTML uses relative paths
4. **Daily guide completeness** — all days have 8 sections, 800+ word core concepts
5. **Deployment readiness** — HTML loads, service worker registers, manifest valid
6. **Quiz answer distribution** — correct answer positions must vary across questions. No single index should hold more than 40% of correct answers. Verify: `grep -o '"answer": [0-9]' week-*/quiz-*.json | sort | uniq -c`
7. **Data files exist** — `website/data/flashcards.json` with 5+ cards per day, `website/data/quiz-01.json` through `quiz-{DAY_COUNT}.json` with 3+ questions each
8. **No empty tabs** — every visible tab has content. Hide tabs with no data rather than showing "Loading..." forever
9. **Ephemeral files removed** — no `briefs/` directory, no playground files, no test scripts in repo
10. **GitHub URL consistency** — all links use the same username/repo. Verify: `grep -roh "github.com/[^/]*/[^/\"]*" . | sort -u` returns exactly one repo

**Run `references/quality-checklist.md` as the final step.**

## Multi-Language Support

Specify language when creating: `"Turn AI Agents into a course in Simplified Chinese"`

**Supported:** English (default), Simplified Chinese, Bilingual (both)

**Chinese courses:** `lang="zh-CN"`, load Noto Serif SC font, Chinese punctuation, translate UI labels, keep technical terms in English with Chinese explanation: `ReAct（推理与行动结合）`, keep code comments in English.

**Bilingual:** Primary language first, section headers in both: `## 核心概念 Core Concepts`. Find Chinese-language videos on Bilibili where available.

**Resource localization:** RedNote/小红书 templates for Chinese, Twitter/X for English.

## Design Philosophy

Read `references/design-philosophy.md` when writing daily guides and module HTML. Key principles: visual-first (50%+ visual content), show don't tell, motivation before mechanism, progressive disclosure, resource integrity (verify all links).

## Bundled Resources

### `references/` — Documentation for the AI (loaded into context as needed)
- `daily-guide-template.md` — Full template for daily study guides + day brief template for parallel generation
- `quality-checklist.md` — Pre-delivery verification checklist + gotchas quick reference
- `interactive-elements.md` — Quiz types, flashcards, animations, all interactive patterns
- `excalidraw.md` — Diagram workflow, MCP commands, export steps, ready-to-use templates
- `pwa-setup.md` — Complete PWA implementation guide
- `design-system.md` — Visual design system documentation (source of truth is `assets/styles.css`)

### `assets/` — Files used in output (copied into courses)
- `styles.css` — Pre-built CSS framework (copy verbatim, NEVER regenerate)
- `main.js` — Pre-built JS engine (copy verbatim, NEVER regenerate)
- `tab-index-template.html` — Tab-based index.html shell (copy + replace tokens)
- `README-template.md` — README template (copy + replace tokens)

### `scripts/` — Executable code
- `validate-course.sh` — Post-generation validation (run against course repo to check for issues)
