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
6. **Build script** — `build.sh` assembles the final `index.html` from `_base.html` + module files + `_footer.html`

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
    ├── _base.html         ← customized from assets/_base.html
    ├── _footer.html       ← copied from assets/_footer.html
    ├── build.sh           ← copied from scripts/build.sh
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
- Always `await` async cache operations — `caches.match()` returns a Promise
- Include ALL icon files in pre-cache list
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

### Option A: Scrollable single-page (courses with 7 or fewer days)
Use the `build.sh` concatenation approach. All modules render as full-viewport sections in one scrollable page. Suitable for short courses where all content is manageable in a single scroll.

### Option B: Tab-based layout (recommended for 10+ day courses)
Create a self-contained `index.html` with inline CSS/JS that provides:
- **Hero section** — course title, subtitle, tags, PWA install button
- **Progress card** — day grid (7 columns x N rows), progress bar, week labels
- **Sticky tab navigation** — Curriculum, Learning Content, Diagrams, Flashcards, Quiz, Resources
- **Curriculum tab** — expandable week cards with day items linking to full guides
- **Learning Content tab** — lazy-loads `modules/*.html` with interactive features from `styles.css`/`main.js`
- **Quiz/Flashcard tabs** — load from `website/data/*.json`
- **Resources tab** — curated external links

This approach loads `styles.css` and `main.js` for interactive features while providing better navigation than a 21-screen scroll. See `references/tab-website-template.html` for the reference implementation.

When using Option B:
- The `build.sh` step is not needed in the GitHub Actions workflow
- Module files in `modules/` are fetched dynamically when the Learning Content tab is activated
- Override `.module { min-height: auto; }` since modules are embedded, not full-viewport (the CSS includes `.section .module` override for this)
- After loading modules dynamically, call `initIndexQuizzes()` to re-initialize quiz handlers on the new DOM elements

## Website Build Process (Option A)

The PWA website uses a pre-built runtime. Do NOT generate CSS or JS from scratch.

1. Copy `assets/styles.css` → `website/styles.css` (verbatim, never modify)
2. Copy `assets/main.js` → `website/main.js` (verbatim, never modify)
3. Copy `assets/_footer.html` → `website/_footer.html`
4. Copy `scripts/build.sh` → `website/build.sh`
5. Customize `assets/_base.html` → `website/_base.html`:
   - Replace COURSE_TITLE (2 places) with actual title
   - Replace ACCENT_COLOR/HOVER/LIGHT/MUTED with chosen palette
   - Replace NAV_DOTS with one button per day/module
6. Write module content to `website/modules/01-topic.html`, `02-topic.html`, etc.
   - Each file contains ONLY a `<section class="module" id="module-N">` block
   - NO <html>, <head>, <body>, <style>, or <script> tags
   - Use class names and data-* attributes documented in interactive-elements.md
7. Run `cd website && bash build.sh` to assemble index.html

**Module HTML must follow this exact structure:**

```html
<section class="module" id="module-N" data-module="Day N: Title">
<div class="module-inner">

  <h2>Day N: Title</h2>
  <p class="module-meta">Difficulty · Estimated time: 1 hour</p>

  <div class="step-cards">
    <div class="step-card">
      <div class="step-num">1</div>
      <div class="step-body">
        <strong>Concept title</strong>
        <p>Explanation</p>
      </div>
    </div>
  </div>

  <div class="callout-accent">
    <strong>Key insight:</strong> Summary...
  </div>

  <h3>Code Example</h3>
  <pre><code class="language-typescript">// code</code></pre>

  <h3>Knowledge Check</h3>
  <div class="quiz-card" data-correct="1" data-explanation-0="Wrong" data-explanation-1="Correct" data-explanation-2="Wrong">
    <p class="quiz-question">Question?</p>
    <div class="quiz-options">
      <button class="quiz-option">A</button>
      <button class="quiz-option">B (correct)</button>
      <button class="quiz-option">C</button>
    </div>
  </div>

  <h3>Key Terms</h3>
  <p><span class="term" data-definition="Definition here">Term</span></p>

</div>
</section>
```

**Critical class names (CSS will break if wrong):**
- `module-inner` — required wrapper inside every `<section class="module">`
- `step-cards` — required wrapper around `step-card` elements
- `step-num` — NOT `step-badge` or `step-number`
- `step-body` — NOT a bare `<div>`, must have this class
- `quiz-card` with `data-correct="INDEX"` — 0-based index of correct option
- `data-explanation-N` — per-option explanation attributes on quiz-card

### Accent Color Palettes

| Palette | --color-accent | --color-accent-hover | --color-accent-light | --color-accent-muted |
|---------|---------------|---------------------|---------------------|---------------------|
| Terracotta (default) | #c4825a | #b07149 | rgba(196,130,90,0.12) | rgba(196,130,90,0.06) |
| Coral | #D94F30 | #C4432A | rgba(217,79,48,0.12) | rgba(217,79,48,0.06) |
| Teal | #2A7B9B | #236A86 | rgba(42,123,155,0.12) | rgba(42,123,155,0.06) |
| Amber | #B8860B | #9E7309 | rgba(184,134,11,0.12) | rgba(184,134,11,0.06) |
| Forest | #4a7c59 | #3d6849 | rgba(74,124,89,0.12) | rgba(74,124,89,0.06) |

## Parallel Generation (10+ Day Courses)

For longer courses, use day briefs to enable parallel generation:

1. Research and verify all resources upfront
2. Write briefs for each day using the "Day Brief Template" section in `references/daily-guide-template.md`
3. Dispatch 2-3 briefs per batch to subagents
4. Each subagent receives: its brief + relevant reference files
5. Each subagent produces: one daily guide markdown + one website module HTML
6. Main agent does consistency check after all days complete

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

## Quality Gates — MANDATORY

Every course must pass before delivery:

1. **Link verification** — all YouTube videos verified via oEmbed, all docs links reachable
2. **Placeholder replacement** — no YOUR_USERNAME/YOUR_REPO remaining
3. **Diagram paths** — exports in `website/diagrams/`, HTML uses relative paths
4. **Daily guide completeness** — all days have 8 sections, 800+ word core concepts
5. **Deployment readiness** — HTML loads, service worker registers, manifest valid
6. **Quiz answer distribution** — correct answer positions must vary across questions. No single index should hold more than 40% of correct answers. Verify: `grep -o '"answer": [0-9]' week-*/quiz-*.json | sort | uniq -c`

**Run `references/quality-checklist.md` as the final step.**

## Multi-Language Support

Specify language when creating: `"Turn AI Agents into a course in Simplified Chinese"`

**Supported:** English (default), Simplified Chinese, Bilingual (both)

**Chinese courses:** `lang="zh-CN"`, load Noto Serif SC font, Chinese punctuation, translate UI labels, keep technical terms in English with Chinese explanation: `ReAct（推理与行动结合）`, keep code comments in English.

**Bilingual:** Primary language first, section headers in both: `## 核心概念 Core Concepts`. Find Chinese-language videos on Bilibili where available.

**Resource localization:** RedNote/小红书 templates for Chinese, Twitter/X for English.

## Design Philosophy

Every design decision serves one goal: the learner understands faster and retains longer.

### Visual-First Design

The screen is a canvas, not a page. Learners should *see* concepts before they read about them.

- **Max 2-3 sentences per text block.** If you're writing a fourth sentence, you need a visual break — a diagram, card, code snippet, or interactive element.
- **Every screen must be at least 50% visual content.** Measure by vertical space. If text dominates, convert something.
- **Convert lists to cards.** Bullet points become step cards, icon-label rows, or pattern cards.
- **Convert sequences to flow diagrams.** Any "first... then... finally..." narrative becomes a visual flow.
- **Convert comparisons to visual grids.** Side-by-side tables become styled comparison cards.
- **Replace bullet paragraphs with icon rows.** Each point gets an icon, a label, and one sentence.

When in doubt: if a learner squints at the screen and sees a wall of grey text, redesign it.

### Show, Don't Tell

Explanation is a last resort. Prefer, in order:

1. **Diagrams over descriptions.** A system architecture diagram replaces 500 words of "Component A talks to Component B."
2. **Code examples over theory.** Show what happens, then explain why.
3. **Interactive elements over passive reading.** A clickable flowchart beats a static one. A quiz beats a summary.
4. **Animations over static images where data flows.** If the concept involves movement (request/response, pipeline stages, message passing), animate it.

Every visual must carry information that would otherwise require text.

### Quiz Philosophy

Quizzes test whether learners can *apply* knowledge, not whether they can *recall* it.

**Good question patterns:**
- "What would you do?" — Present a realistic scenario and ask for the next step.
- "Where would you look?" — A user reports an error. Which log, config, or component do you investigate first?
- Debugging scenarios, architectural decisions, tradeoff analysis.

**Never ask:** acronym recall, syntax recall, list memorization, context-free true/false.

**Feedback:** Every question includes an explanation for both correct and incorrect answers. Encouraging tone: "Good instinct, but..." not "Wrong."

### Metaphor Strategy

- **Ground in everyday life first.** Introduce the metaphor before revealing technical details.
- **One metaphor per concept.** Never reuse a metaphor across different sections.
- **Avoid recycled cliches.** No "restaurant for APIs." No "library for databases."
- **Pick metaphors that feel inevitable.** The right metaphor makes the learner say "oh, it's *exactly* like that."
- **Introduce, connect, release.** Start with the metaphor, map it to the technical concept, then let the learner work with the real thing.

### Code and English Translations

- **Pair real code with plain-language line-by-line explanations.** Every code block gets a "what this does in English" companion.
- **Focus on "why" over "what."** Don't say "this line imports requests." Say "we need requests because we're about to make HTTP calls."
- **Use actual working code.** Never pseudo-code. Copy-paste ready.
- **Keep snippets naturally short: 5-15 lines.** Don't truncate — find a naturally short section.
- **Language tags on every code block** for syntax highlighting.

### Glossary and Terminology

- **Define every technical term on first use per section.** If a term appeared in Day 3 and appears again in Day 7, define it again.
- **Use the dashed-underline tooltip pattern.** Terms get a subtle underline; hovering reveals the definition.
- **When in doubt, add a tooltip.** Over-definition beats under-definition.
- **For bilingual courses:** `ReAct（推理与行动结合）` — English term with Chinese explanation.

### Motivation Before Mechanism

Every section must answer **"why should I care?"** before **"how does it work?"**

- The answer to "why" is always practical — it helps the learner do something specific.
- Connect to the learner's stated goal from the intake questionnaire.
- **Structure every section as:** motivation (1-2 sentences) -> concept (visual + explanation) -> application (code or exercise).
- Never start a section with a definition. Start with a problem the learner will recognize.

### Progressive Disclosure

Reveal complexity in layers. Never dump everything at once.

- **Start with what learners already know.** Begin from user-facing behavior or everyday concepts.
- **Peel back layers gradually:** experience -> mechanism -> implementation.
- **One concept per screen or section.** If covering two ideas, split into two sections.
- **Use "you already know this" bridges** to connect new material to previous sections.
- **Hide advanced details behind expandable sections.**

### Resource Integrity

Every external link in the course must be verified. No exceptions.

- **All links verified via `web_fetch` before inclusion.** If a link doesn't load, it doesn't go in.
- **YouTube videos verified via oEmbed API.** Copy exact `title` and `author_name` — never paraphrase.
- **No hallucinated references.** Search for real resources, verify they exist, then include them.
- **Dead links replaced or removed.** Never leave a broken link as a placeholder.
- **Prefer stable, top-level URLs** over deep paths that break when docs restructure.

See `references/quality-checklist.md` for the full verification workflow and common gotchas.

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
- `_base.html` — HTML template shell (customize per course)
- `_footer.html` — HTML closing tags (copy verbatim)

### `scripts/` — Executable code
- `build.sh` — Website assembly script (copy into course, run to produce index.html)
