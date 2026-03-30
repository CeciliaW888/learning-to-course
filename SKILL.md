---
name: learning-to-course
description: Turn any learning topic into a structured course with installable PWA website, comprehensive daily study guides, quizzes, and GitHub repo. Supports English and Simplified Chinese. Use when user wants to create a learning course, curriculum, study plan, or interactive learning path for any topic. Triggers on "create a course", "turn X into a course", "make a learning path", "build a curriculum".
---

# learning-to-course

**Turn any learning topic into an installable PWA course app with GitHub repo**

## What it does

Point it at a learning topic (AI Agents, product strategy, investing, etc.). Get back:

1. **GitHub repo** - Structured learning path with resources, notes, quizzes
2. **Comprehensive daily study guides** - 800-1500 word markdown files per day with 8 structured sections
3. **Installable PWA** - Beautiful course app that works offline, installs to home screen
4. **Quiz system** - Interactive quizzes, flashcards, progress checkpoints
5. **Dual output** - Content in GitHub (markdown), website reads from it
6. **Offline-first** - Service worker caches everything; learn anywhere without internet

Perfect for:

- **Vibe learners** - Learn by doing, not by reading textbooks
- **Build in public** - Share your learning journey on social media
- **Self-assessment** - Track progress with quizzes and checkpoints
- **Offline learners** - Install on phone/tablet, learn on the train or plane
- **Mobile-first** - Standalone app experience, no browser chrome

## Usage

```
Turn [topic] into an interactive learning course
```

Examples:

- "Turn AI Agents into an interactive learning course"
- "Create a course for product management fundamentals"
- "Make a learning path for investing strategies"

## What you get

### GitHub Repo Structure

```
ai-agent-learning/
├── README.md (overview + progress)
├── week-01/
│   ├── day-01-foundations.md          # Comprehensive daily guide (800-1500 words)
│   ├── day-02-core-concepts.md        # 8 structured sections each
│   ├── day-03-tools-apis.md
│   ├── day-04-implementation.md
│   ├── day-05-review.md
│   ├── quiz-01.json
│   └── resources.md
├── week-02/
│   ├── day-06-advanced-patterns.md
│   ├── day-07-multi-agent.md
│   ├── ...
├── flashcards/ (Anki deck exports)
├── projects/ (hands-on builds)
├── diagrams/ (Excalidraw source files)
│   ├── week-01-concept-map.excalidraw
│   ├── week-01-pda-loop.excalidraw
│   └── README.md (how to edit diagrams)
└── website/
    ├── index.html (generated course site + PWA)
    ├── manifest.json (PWA manifest)
    ├── sw.js (service worker)
    ├── offline.html (offline fallback page)
    ├── diagrams/ (exported SVG/PNG — MUST be here, not parent)
    │   ├── week-01-concept-map.svg
    │   ├── week-01-concept-map.png
    │   └── ...
    ├── icons/ (PWA icons: 192, 512, maskable, apple-touch)
    └── assets/ (other static assets)
```

### Comprehensive Daily Study Guides (NEW)

Every day in the course gets a **dedicated markdown file** (800-1500 words) with **8 mandatory sections**:

1. **🎯 Learning Objectives** - 3-5 measurable goals for the day
2. **📚 Core Concepts** - 800-1200 words of clear, well-structured explanations
3. **🔑 Key Terminology** - 5-10 terms defined with examples
4. **💻 Code Examples** - Working, commented Python/JS code (copy-paste ready)
5. **✏️ Hands-On Exercises** - 3-5 practical activities with clear instructions
6. **📖 Curated Resources** - Verified links with specific sections/timestamps
7. **🤔 Reflection Questions** - 3-5 comprehension and application checks
8. **➡️ Next Steps** - Preview of tomorrow's topic + navigation links

**Requirements:**

- Every daily guide must be **comprehensive, not a placeholder**
- Code examples must be **working and explained** (not pseudo-code)
- Resources must link to **specific sections or timestamps** (not just homepages)
- Progressive difficulty: Day 1 = beginner concepts → final days = advanced application
- Navigation links between days: `[← Previous: Day X](./day-X.md)` | `[Next: Day Z →](./day-Z.md)`

See `references/daily-guide-template.md` for the full template with examples.

### Research Checklist

Before writing daily guides, research each topic using these sources:

**Primary Sources (check ALL for every topic):**

- **Official Docs** - Anthropic (https://www.anthropic.com/engineering/building-effective-agents), OpenAI, Google, etc.
- **Academic Posts** - Lilian Weng (https://lilianweng.github.io/posts/2023-06-23-agent/), Chip Huyen, etc.
- **Framework Docs** - LangChain (https://python.langchain.com/docs/), LlamaIndex, CrewAI, etc.
- **ArXiv Papers** - Search for recent papers (2023-2026) on the specific topic
- **Production Examples** - AutoGPT, BabyAGI, Devin, real-world implementations

**Secondary Sources:**

- YouTube tutorials from official channels (verify all links with `web_fetch`)
- Blog posts from practitioners
- GitHub repos with working examples
- Conference talks (NeurIPS, ICML, etc.)

**Research Standard:** Every claim in a daily guide should be traceable to a real source. No hallucinated references.

### Installable PWA Course App

- **Progressive Web App** - Installable on any device (iOS, Android, desktop)
- **Offline mode** - Full course available without internet via service worker
- **Standalone experience** - No browser chrome, feels like a native app
- **Home screen icon** - Custom app icon with splash screen
- **Scroll-based navigation** - Progress bar, keyboard shortcuts
- **Resource cards** - Links to articles, videos, courses
- **Interactive quizzes** - Multiple choice, code challenges, reflections
- **Progress tracking** - Checkpoints, completion status (persisted offline)
- **Flashcard mode** - Spaced repetition for key concepts
- **Visual learning** - Excalidraw diagrams, animations, knowledge maps
- **Editable diagrams** - "Edit this diagram" links to .excalidraw source files
- **Mobile-friendly** - Responsive diagrams and layouts for on-the-go learning
- **Install prompt** - Smart banner that invites users to install (dismissible, respects choice)

## Design Philosophy

### Show, Don't Tell

Every screen is at least 50% visual. Max 2-3 sentences per text block. If something can be a diagram, animation, or interactive element — it shouldn't be a paragraph.

### Test Application, Not Memorization

No "What does AI stand for?" Instead: "You want to build a research agent. Which tools would you need?" Quizzes test whether you can use what you learned.

### Real Resources, Real Examples

All links to actual courses, articles, repos. No made-up examples. The learner should be able to click through and learn from the best sources.

### Progress Over Perfection

Show the learning journey — what worked, what didn't, what you built. Not a polished textbook, but a real person learning in public.

## Output

1. **GitHub repo** created at ~/Repos/[topic-name]/
2. **Comprehensive daily study guides** - One .md file per day (800-1500 words each, 8 sections)
3. **Installable PWA** - HTML + manifest.json + service worker + icons
4. **Deploy instructions** for GitHub Pages or Vercel (PWA works on both)
5. **README** with setup and contribution guide
6. **PWA assets** - Icons (192, 512, maskable, apple-touch-icon), offline page
7. **Diagrams** - Both .excalidraw source AND exported SVG in `website/diagrams/`
8. **Quality verification** - All checks from `references/quality-checklist.md` passed

## Behind the scenes

1. Analyzes topic and creates structured learning path
2. **Researches each day's topic** using the research checklist (official docs, papers, etc.)
3. **Writes comprehensive daily guides** (800-1500 words, 8 sections per day)
4. Researches best free resources (courses, articles, videos) and verifies all links with `web_fetch`
5. Generates quizzes based on key concepts
6. Creates GitHub repo with markdown content
7. Builds installable PWA (HTML + manifest + service worker + icons)
8. Creates Excalidraw diagrams → exports to SVG → copies to `website/diagrams/`
9. Generates PWA icons (192×192, 512×512, maskable, apple-touch-icon)
10. Configures service worker with smart caching strategies
11. Adds install prompt banner with user preference tracking
12. **Replaces ALL placeholders** (YOUR_USERNAME, YOUR_REPO, etc.) with actual values
13. **Runs quality checklist** before delivery (see `references/quality-checklist.md`)
14. Sets up deployment (GitHub Pages or Vercel — PWA works on both)

## ⚠️ MANDATORY Quality Gates

**These are NOT optional. Every course MUST pass before delivery:**

### 1. Link Verification (CRITICAL — ALL EXTERNAL LINKS)

**MANDATORY:** ALL files with external links MUST be verified before delivery.

**YouTube/Video Links:**

- Extract ALL YouTube/video links from generated HTML and markdown
- For each link: verify the video exists and the title matches what you claim
- **Never trust LLM-generated video IDs** — they are almost always wrong
- Use `web_fetch` to verify each video URL
- Fix or remove any broken/mismatched links

**Documentation/Resource Links:**

- Extract ALL `https://` links from all generated files
- Verify each link loads without 404
- Check that link destinations match descriptions
- Common issues:
  - Outdated documentation URLs (e.g., docs.anthropic.com → www.anthropic.com/engineering)
  - Moved API documentation pages
  - Deleted or private GitHub repos
  - Typos in domain names

**Verification Workflow:**

```bash
# Extract all links from generated files
find . -name "*.md" -o -name "*.html" | \
  xargs grep -oh 'https\?://[^)]\+' | \
  sort -u > /tmp/all-links.txt

# Check each link (manual or automated)
while read url; do
  curl -I "$url" 2>&1 | head -1
done < /tmp/all-links.txt
```

**Verification is automated during generation:**

- Use `web_fetch` to verify each link as you add it
- Fix or remove broken links immediately
- Do NOT create a LINK-AUDIT.md file (goes stale and becomes misleading)
- See `references/quality-checklist.md` for step-by-step process

**This is NOT optional.** Broken links = broken learning experience.

### 2. GitHub Placeholder Replacement

- Search all files for `YOUR_USERNAME`, `YOUR_REPO`, `USER/REPO`, etc.
- Auto-detect actual GitHub username from `git remote -v` or ask the user
- Replace ALL instances with real values
- Verify no placeholder strings remain: `grep -r "YOUR_" .` should return nothing

### 3. Diagram Path Validation

- All diagram files MUST exist in `website/diagrams/` (not `diagrams/` or `assets/diagrams/`)
- Image paths in HTML MUST be `src="diagrams/file.svg"` (relative to website/)
- **NOT** `src="../diagrams/file.svg"` or `src="assets/diagrams/file.svg"`
- Always copy exported diagrams to `website/diagrams/` during generation
- Verify: every `<img src="diagrams/...">` has a corresponding file

### 4. Daily Guide Completeness

- Every day file exists and has all 8 sections
- Core Concepts section is 800+ words (not a stub)
- Code examples are complete and runnable
- Resources link to real, accessible URLs
- Navigation links work (previous/next day)

### 5. Deployment Readiness

- `website/index.html` loads without errors
- Service worker registers correctly
- Manifest is valid JSON
- All referenced files exist
- No broken internal links

**Run `references/quality-checklist.md` as a final step before marking complete.**

## Examples

**Input:** "Turn AI Agents into an interactive learning course"

**Output:**

- Repo: ai-agent-learning/
- Website: beautiful single-page course
- 3-week curriculum with daily topics
- **15+ comprehensive daily study guides** (800-1500 words each)
- 20+ curated resources (DeepLearning.AI, LangChain docs, YouTube — ALL VERIFIED)
- 15+ interactive quizzes
- Progress dashboard
- Flashcard deck (50 cards)
- **SVG diagrams** in website/diagrams/ with .excalidraw sources

## Tech Stack

- **Content:** Markdown (GitHub repo) — daily guides with 8 structured sections
- **Website:** HTML + CSS + vanilla JS (PWA, no build step)
- **PWA:** manifest.json + service worker + offline fallback
- **Icons:** SVG-generated or image-based (192, 512, maskable, apple-touch)
- **Diagrams:** Excalidraw (.excalidraw source) → SVG export (preferred) + PNG fallback
- **Deploy:** GitHub Pages or Vercel (both support PWA out of the box)
- **Quiz data:** JSON format
- **Flashcards:** Anki-compatible exports
- **Offline:** Service worker with stale-while-revalidate + cache-first strategies

## Excalidraw Diagram Integration

Every course includes auto-generated knowledge maps and architecture diagrams using Excalidraw. Diagrams are stored in dual format for maximum usability.

### Dual Format Storage

```
ai-agent-learning/
├── diagrams/                    # Source files (editable, version controlled)
│   ├── week-01-concept-map.excalidraw
│   ├── week-01-pda-loop.excalidraw
│   ├── week-02-tool-architecture.excalidraw
│   ├── week-02-agent-comparison.excalidraw
│   ├── week-03-multi-agent.excalidraw
│   └── README.md                # How to edit diagrams
├── website/
│   └── diagrams/                # ⚠️ MUST be website/diagrams/ (not assets/diagrams/)
│       ├── week-01-concept-map.svg    # SVG preferred (scalable, smaller, searchable)
│       ├── week-01-concept-map.png    # PNG fallback
│       ├── week-01-pda-loop.svg
│       └── ...
```

**⚠️ CRITICAL: Diagram Path Rules**

- Source files: `diagrams/*.excalidraw` (repo root)
- Exported files: `website/diagrams/*.svg` and `website/diagrams/*.png`
- HTML references: `src="diagrams/file.svg"` (relative to website/, NOT `../diagrams/`)
- **Always copy exports to `website/diagrams/`** — the website cannot reference parent directories

**Why SVG preferred over PNG:**

- **Scalable** — crisp at any zoom level, perfect for mobile
- **Smaller file size** — typically 50-80% smaller than PNG
- **Searchable** — text in SVGs is indexable and selectable
- **Accessible** — screen readers can parse SVG content
- **Version-friendly** — SVG diffs are human-readable in Git

**Why dual format:**

- `.excalidraw` files are JSON — easy to version control, diff, and edit
- SVG exports are embedded in website HTML for fast loading and mobile support
- PNG fallback for contexts that don't render SVG well
- Contributors can edit source files; exports are regenerated on build

### SVG Export Workflow

**Step 1:** Create `.excalidraw` source files (JSON format)

```bash
# Via Excalidraw MCP
mcporter call excalidraw.export_scene format=excalidraw \
  outputPath="diagrams/week-01-pda-loop.excalidraw"
```

**Step 2:** Export to SVG (preferred) AND PNG (fallback)

```bash
# Export SVG (preferred)
mcporter call excalidraw.export_to_image format=svg \
  outputPath="website/diagrams/week-01-pda-loop.svg"

# Export PNG (fallback)
mcporter call excalidraw.export_to_image format=png \
  outputPath="website/diagrams/week-01-pda-loop.png"
```

**Step 3:** Always store BOTH source + export

```
diagrams/week-01-pda-loop.excalidraw    → Source (editable)
website/diagrams/week-01-pda-loop.svg   → Export (website embed, preferred)
website/diagrams/week-01-pda-loop.png   → Export (fallback)
```

### Diagram Types (Auto-Generated Per Course)

Each course gets diagrams matched to its content. For AI/Agent courses, standard set:

| Diagram                       | Purpose                          | When to Use             |
| ----------------------------- | -------------------------------- | ----------------------- |
| **Perceive-Decide-Act Loop**  | Core agent cycle flowchart       | Week 1: Foundations     |
| **Agent vs Chatbot vs RAG**   | Comparison matrix with features  | Week 1: Key Differences |
| **Tool Calling Architecture** | How agents invoke external tools | Week 2: Tools & APIs    |
| **Multi-Agent Networks**      | Agent collaboration patterns     | Week 3: Advanced        |
| **Concept Relationship Map**  | Weekly knowledge graph           | Every week (auto)       |

For non-AI topics, the skill generates topic-appropriate diagram types (e.g., decision trees for strategy courses, system diagrams for engineering courses).

### Creating Diagrams via Excalidraw MCP

**Prerequisites:** Excalidraw MCP server running (`http://localhost:3000`)

**Step 1: Start the canvas**

```bash
# Ensure Excalidraw MCP server is running
cd ~/.agents/skills/excalidraw-mcp && npm start
```

**Step 2: Create diagram elements via MCP**

```bash
# Create a flowchart node
mcporter call excalidraw.create_element \
  type=rectangle x:100 y:100 width:200 height:80 \
  backgroundColor="#a5d8ff" text="Perceive" roundness:8

# Create an arrow connecting nodes
mcporter call excalidraw.create_element \
  type=arrow startX:300 startY:140 endX:400 endY:140 \
  strokeColor="#495057"

# Verify with visual check
mcporter call excalidraw.get_canvas_screenshot
```

**Step 3: Export (SVG preferred)**

```bash
# Export as .excalidraw (source)
mcporter call excalidraw.export_scene format=excalidraw \
  outputPath="diagrams/week-01-pda-loop.excalidraw"

# Export as SVG (preferred — scalable, smaller, searchable)
mcporter call excalidraw.export_to_image format=svg \
  outputPath="website/diagrams/week-01-pda-loop.svg"

# Export as PNG (fallback)
mcporter call excalidraw.export_to_image format=png \
  outputPath="website/diagrams/week-01-pda-loop.png"
```

**Step 4: Embed in website HTML**

```html
<figure class="diagram-container" data-diagram="pda-loop">
  <img
    src="diagrams/week-01-pda-loop.svg"
    alt="Perceive-Decide-Act Loop: Agent observes environment, LLM decides next action, executes tools, checks if goal achieved"
    loading="lazy"
    class="diagram-img"
  />
  <figcaption>
    <span class="diagram-caption">The Perceive-Decide-Act Loop</span>
    <a
      href="https://github.com/USERNAME/REPO/blob/main/diagrams/week-01-pda-loop.excalidraw"
      class="edit-diagram-link"
      target="_blank"
      rel="noopener"
    >
      ✏️ Edit this diagram
    </a>
  </figcaption>
</figure>
```

> **Note:** Use `src="diagrams/file.svg"` — this is relative to `website/` where `index.html` lives. The SVG format is preferred; use PNG only as fallback with `<picture>` element if needed.

### Automated Diagram Generation Workflow

When building a course, the skill auto-generates diagrams:

1. **Analyze curriculum** — identify concepts that benefit from visual explanation
2. **Generate .excalidraw source** — create diagram JSON with proper layout
3. **Export to SVG (preferred) + PNG (fallback)** — render for website embedding
4. **Copy exports to `website/diagrams/`** — NOT to `assets/diagrams/` or parent `diagrams/`
5. **Embed in HTML** — insert `<figure>` blocks with `src="diagrams/file.svg"` paths
6. **Create diagrams/README.md** — contribution guide for diagram improvements

### Website Integration Details

**Responsive rendering:**

```css
.diagram-container {
  max-width: 100%;
  margin: var(--space-8) 0;
  text-align: center;
}

.diagram-img {
  max-width: 100%;
  height: auto;
  border-radius: 12px;
  border: 1px solid var(--border);
  background: white;
}

.edit-diagram-link {
  display: inline-block;
  margin-top: var(--space-2);
  font-size: var(--text-sm);
  color: var(--text-secondary);
  text-decoration: none;
}

.edit-diagram-link:hover {
  color: var(--primary);
}

/* Mobile: full width, no padding */
@media (max-width: 768px) {
  .diagram-container {
    margin: var(--space-4) calc(-1 * var(--space-4));
  }
  .diagram-img {
    border-radius: 0;
    border-left: none;
    border-right: none;
  }
}
```

**Dark mode support:**

```css
@media (prefers-color-scheme: dark) {
  .diagram-img {
    filter: invert(0.88) hue-rotate(180deg);
  }
}
```

### Diagram Editing Guide

Include in every repo's `diagrams/README.md` (editing instructions, NOT a CONTRIBUTING.md):

1. **Edit source files** — Open `.excalidraw` files at [excalidraw.com](https://excalidraw.com) or via MCP
2. **Keep it simple** — Max 8-10 elements per diagram. If it's complex, split into multiple
3. **Use consistent colors** — Follow the course color palette (see design-system.md)
4. **Add alt text** — Every diagram must have descriptive alt text in HTML
5. **Export to SVG first** — SVG is preferred; add PNG only as fallback
6. **Copy to website/diagrams/** — Exported files go in `website/diagrams/`, NOT `assets/diagrams/`
7. **Re-export after editing** — Run export script to update SVG/PNG
8. **PR with both formats** — Always commit both `.excalidraw` source AND exported images

### Template Reference

See `references/excalidraw-templates.md` for ready-to-use diagram templates including:

- PDA Loop flowchart
- Comparison matrices
- Architecture diagrams
- Concept maps
- Network topologies

---

## GitHub Placeholder Replacement (MANDATORY)

After generating all files, **before delivery**:

### Step 1: Detect GitHub Username

```bash
# Try auto-detect from git remote
GITHUB_USER=$(git remote get-url origin 2>/dev/null | sed -n 's/.*github.com[:/]\([^/]*\)\/.*/\1/p')

# If not in a git repo or no remote, ask the user
if [ -z "$GITHUB_USER" ]; then
  echo "What's your GitHub username?"
  # Wait for user response
fi
```

### Step 2: Replace ALL Placeholders

```bash
# Find all placeholder instances
grep -rn "YOUR_USERNAME\|YOUR_REPO\|USER/REPO\|USERNAME/REPO" .

# Replace in all files
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.json" \) \
  -exec sed -i '' "s/YOUR_USERNAME/$GITHUB_USER/g; s/YOUR_REPO/$REPO_NAME/g" {} +
```

### Step 3: Verify No Placeholders Remain

```bash
# This MUST return empty
grep -rn "YOUR_USERNAME\|YOUR_REPO\|YOUR_" --include="*.md" --include="*.html" --include="*.json" .
```

**Common placeholders to catch:**

- `YOUR_USERNAME` → actual GitHub username
- `YOUR_REPO` → actual repository name
- `USER/REPO` → `username/repo-name`
- `USERNAME` in URLs → actual username
- `your-email@example.com` → actual email (or remove)

---

## PWA (Progressive Web App) — Core Feature

**Every course website is a PWA by default.** No exceptions. Every generated site must include:

1. **`manifest.json`** — App name, icons, theme colors, display mode
2. **`sw.js`** — Service worker with smart caching (offline-first)
3. **`offline.html`** — Friendly offline fallback page
4. **Icons** — 192×192, 512×512, maskable, and 180×180 apple-touch-icon
5. **Install prompt** — Smart banner that only shows when not installed
6. **`<meta>` tags** — Apple-specific tags for iOS standalone experience

### Why PWA?

- **Learners can install the course** on their phone like an app
- **Works offline** — study on the train, plane, or anywhere without WiFi
- **No app store needed** — just visit the URL and install
- **Standalone mode** — no browser chrome, feels native
- **Auto-updates** — service worker serves cached content instantly, fetches fresh in background

### Default Theme Colors

Match the warm cream design system:

- `theme_color`: `#c4825a` (terracotta accent)
- `background_color`: `#f5f0eb` (warm cream)

### Implementation Reference

See `references/pwa-setup.md` for complete implementation guide including:

- manifest.json structure and all required fields
- Service worker strategies (stale-while-revalidate, cache-first, network-first)
- Icon requirements and generation (iOS vs Android differences)
- Install prompt UI patterns
- Offline fallback page template
- Testing checklist

---

## Link & Attribution Quality Rules

### Video Links — MANDATORY oEmbed Verification Protocol

**For EVERY YouTube video included in the output, follow this exact protocol:**

1. **Search for the video live** — use WebSearch, never generate URLs from memory
2. **Verify via oEmbed API** — for each video ID, fetch:
   ```
   https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json
   ```
3. **Copy the EXACT `title` field** — do not paraphrase, shorten, summarize, or "improve" it
4. **Copy the EXACT `author_name` field** — do not guess or assume the creator
5. **If oEmbed returns 404** — the video is dead, do NOT include it
6. **If oEmbed title doesn't match the topic** — the video is wrong for this lesson, find a different one

**Additional rules:**

- When adding YouTube links, always include the **exact video title AND exact channel name**
- **Prefer videos from official channels** (e.g., LangChain, IBM Technology) — less likely to be deleted
- **Do NOT use placeholder or fake URLs** — if you can't verify a video, leave it out entirely
- **NEVER trust LLM memory for video titles or creators** — even if you "remember" a video, verify it

**Why this matters:** In the ai-agent-learning project, 13 out of 21 videos had wrong titles or attributions, and 5 had completely dead links. Every single one was generated from LLM memory without verification.

### Video Deduplication & Curriculum Fit

- **Do NOT use the same video twice in the same section** — each section needs unique content
- **When reusing a video across different days**, note which specific section/timestamp to watch
- **Verify the video actually covers the topic** — a function calling video is NOT a "safety & guardrails" video, even if both are by the same creator
- **After generating all content**, run a deduplication check:
  ```bash
  grep -roh 'youtube.com/watch?v=[A-Za-z0-9_-]*' --include="*.md" --include="*.html" . | sort | uniq -d
  ```
  Any duplicates within the same file = error. Duplicates across files = verify they serve different purposes.

### Documentation Links

- **Link to top-level/stable documentation URLs** (e.g., `docs.langchain.com`) rather than deep paths like `/concepts/low_level/#state` which break when docs restructure
- For fast-moving projects (LangChain, LangGraph, etc.), **prefer linking to the official docs homepage or getting-started page** over deeply nested tutorial paths
- **Verify every external link loads successfully** before including it — use `web_fetch` to confirm
- **No broken links allowed** — every URL must be reachable at delivery time

### No Stale Tracking Docs

- **Do NOT generate audit files, link reports, or tracking documents** that require manual updates — they always go stale and become misleading
- **Do NOT generate CONTRIBUTING.md** for personal learning projects
- **Do NOT create TODO lists** that won't be maintained

### Service Worker / PWA

- **Always await async cache operations** — `caches.match()` returns a Promise, never use it directly with `||`
- **Include ALL icon files** (including maskable variants) in the service worker pre-cache list
- If generating a `vercel.json`, ensure `outputDirectory` matches the actual site folder and **add explicit routes for static assets before any catch-all route**

### General Quality Standards

- **Every external URL in the output must be verified as reachable** before finalizing
- **Do not duplicate the same link** in adjacent list items within a section
- **Use real examples, not placeholders** — if you don't have a real resource, leave it out
- **Test all links with `web_fetch`** — automation beats manual checking

---

## Multi-Language Support

Courses can be generated in multiple languages. Specify the language when creating:

```
Turn AI Agents into an interactive learning course in Simplified Chinese
Turn investing into a learning course in English and Chinese
```

### Supported Languages

- **English** (default)
- **Simplified Chinese** (简体中文)
- **Bilingual** (English + Simplified Chinese side by side)

### Language-Specific Rules

**For Simplified Chinese courses:**

- Use `lang="zh-CN"` in HTML
- Load `Noto Serif SC` or `Noto Sans SC` from Google Fonts for proper CJK rendering
- Set `font-family: 'Noto Serif SC', 'PingFang SC', 'Microsoft YaHei', serif` in CSS
- Use Chinese punctuation (，。、；：？！) not English punctuation
- Translate all UI labels, section headers, button text, and navigation
- Keep technical terms in English with Chinese explanation on first use: `ReAct（推理与行动结合）`
- Keep code comments in English (standard practice for Chinese developers)
- PWA manifest: set `"lang": "zh-CN"` and translate `name`/`short_name`/`description`

**For Bilingual courses:**

- Primary language first, secondary in parentheses or toggle
- Section headers in both languages: `## 核心概念 Core Concepts`
- Resource links: prefer Chinese resources for Chinese content, English for English
- Videos: find Chinese-language alternatives where available (Bilibili, etc.)

**For English courses:**

- Use `lang="en"` in HTML
- Standard `Inter` or `system-ui` font stack
- Keep all content in English

### Resource Localization

- **YouTube videos**: For Chinese courses, search for Chinese-language tutorials on Bilibili (bilibili.com) or Chinese YouTube channels. Verify these exist too.
- **Documentation**: Link to Chinese translations where available (e.g., LangChain has Chinese docs)
- **Build-in-public templates**: Generate templates for the target platform (RedNote/小红书 for Chinese, Twitter/X for English)

---

## Related Skills

- `codebase-to-course` - Turn code into interactive tutorials
- `skill-creator` - Create OpenClaw skills from documentation

---

## Reference Files

- `references/daily-guide-template.md` - Full template for daily study guides (8 sections with examples)
- `references/quality-checklist.md` - Pre-delivery verification checklist (video links, paths, placeholders)
- `references/interactive-elements.md` - Quiz types, flashcards, animations, PWA patterns
- `references/excalidraw-templates.md` - Ready-to-use diagram templates
- `references/pwa-setup.md` - Complete PWA implementation guide
- `references/design-system.md` - Visual design system (colors, typography, spacing)

---

Built with love for continuous learners 🚀
