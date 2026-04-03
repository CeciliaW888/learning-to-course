# Tab-Based Website Template

Reference implementation for courses with 10+ days. Creates a self-contained `index.html` with hero, progress grid, sticky tab navigation, expandable curriculum cards, interactive modules, flashcards, quizzes, and resources.

## When to Use

Use this template instead of the `build.sh` approach when the course has 10 or more days. The scrollable single-page layout becomes unwieldy at that length.

## Placeholders to Replace

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `COURSE_TITLE` | Course name | AI Agent Learning |
| `COURSE_SUBTITLE` | One-line description with duration | 21-Day Course · 1 hour/day |
| `COURSE_DESCRIPTION` | Meta description | Learn to build AI agents from scratch |
| `PWA_SHORT_NAME` | Max 12 chars for PWA | AI Agents |
| `HERO_EMOJI` | Large emoji for hero | 🤖 |
| `TAG_1` through `TAG_4` | Hero tags | 📖 Source-driven |
| `GITHUB_USERNAME` | GitHub username | your-username |
| `GITHUB_REPO` | Repository name | course-repo |
| `WEEK_N_LABEL` | Week section labels | Week 1: Foundations |
| `WEEK_N_COLOR` | Week accent colors | green-strong, yellow-strong, red-strong |

## Structure

```
website/
├── index.html              ← self-contained (inline CSS + JS)
├── styles.css              ← skill framework (for interactive modules)
├── main.js                 ← skill framework (for interactive modules)
├── manifest.json
├── sw.js
├── offline.html
├── data/                   ← quiz and flashcard JSON (copied here for deployment)
│   ├── quiz-01.json
│   ├── quiz-02.json
│   ├── flashcards.json
│   └── ...
├── modules/                ← interactive HTML modules (lazy-loaded)
│   ├── 01-topic.html
│   ├── 02-topic.html
│   └── ...
├── diagrams/               ← exported SVG diagrams
├── icons/                  ← PWA icons
```

## Key Design Patterns

### Hero Section
```html
<div class="hero">
  <div class="hero-emoji">HERO_EMOJI</div>
  <h1>COURSE_TITLE</h1>
  <p class="subtitle">COURSE_SUBTITLE</p>
  <div class="hero-tags">
    <span class="tag">TAG_1</span>
    <span class="tag">TAG_2</span>
    <span class="tag">TAG_3</span>
    <span class="tag">TAG_4</span>
  </div>
  <button class="install-btn-permanent hidden" id="install-btn-hero">
    Install App
  </button>
</div>
```

### Progress Card with Day Grid
```html
<div class="progress-section">
  <div class="progress-header">
    <h3>Progress</h3>
    <span class="progress-count" id="progress-text">0 / N days</span>
  </div>
  <div class="progress-bar-track">
    <div class="progress-bar-fill" id="progress-bar"></div>
  </div>
  <div class="day-grid" id="day-grid"></div>
  <div class="week-labels">
    <span>WEEK_1_LABEL</span>
    <span>WEEK_2_LABEL</span>
    <span>WEEK_3_LABEL</span>
  </div>
</div>
```

The day grid uses a 7-column CSS grid. JS generates N day dots with localStorage tracking.

### Sticky Tab Navigation
```html
<div class="nav">
  <div class="nav-inner">
    <div class="nav-tab active" data-section="curriculum">Curriculum</div>
    <div class="nav-tab" data-section="modules">Learning Content</div>
    <div class="nav-tab" data-section="diagrams">Diagrams</div>
    <div class="nav-tab" data-section="flashcards">Flashcards</div>
    <div class="nav-tab" data-section="quiz">Quiz</div>
    <div class="nav-tab" data-section="resources">Resources</div>
  </div>
</div>
```

### Expandable Week Cards
```html
<div class="week-card week-1">
  <div class="week-card-header" onclick="toggleCard(this)">
    <span class="week-card-title">Day 1: Topic Title</span>
    <div class="week-card-meta">
      <span class="week-card-type type-basics">Type</span>
      <span class="chevron">▼</span>
    </div>
  </div>
  <div class="week-card-body">
    <h4>Core Content</h4>
    <ul>
      <li>Topic point 1</li>
      <li>Topic point 2</li>
    </ul>
    <a class="day-link" href="https://github.com/USERNAME/REPO/blob/main/week-01/day-01-slug.md" target="_blank">
      Read Full Guide →
    </a>
  </div>
</div>
```

Color-code weeks with left borders:
```css
.week-1 .week-card-header { border-left: 4px solid var(--green-strong); }
.week-2 .week-card-header { border-left: 4px solid var(--yellow-strong); }
.week-3 .week-card-header { border-left: 4px solid var(--red-strong); }
```

### Lazy-Loading Interactive Modules
```javascript
async function loadModules() {
  const container = document.getElementById('modules-container');
  if (!container || container.children.length > 0) return;

  const moduleFiles = [
    'modules/01-topic.html',
    'modules/02-topic.html',
    // ... all module files
  ];

  for (const file of moduleFiles) {
    try {
      const resp = await fetch(file);
      if (resp.ok) {
        const html = await resp.text();
        const div = document.createElement('div');
        div.innerHTML = html;
        container.appendChild(div);
      }
    } catch (e) { console.warn('Failed to load', file); }
  }

  // Re-initialize quiz handlers for dynamically loaded content
  initIndexQuizzes(); // from main.js

  // Add copy buttons to code blocks
  container.querySelectorAll('pre').forEach(pre => {
    const btn = document.createElement('button');
    btn.textContent = 'Copy';
    btn.className = 'copy-btn-overlay';
    btn.addEventListener('click', () => {
      navigator.clipboard.writeText((pre.querySelector('code') || pre).textContent);
      btn.textContent = 'Copied!';
      setTimeout(() => { btn.textContent = 'Copy'; }, 2000);
    });
    pre.style.position = 'relative';
    pre.appendChild(btn);
  });
}
```

### CSS Overrides for Embedded Modules

When loading `styles.css` for interactive features, override these:

```css
/* In inline <style>, AFTER the styles.css link */
.nav { position: sticky !important; top: 0 !important; height: auto !important; }
.section .module { min-height: auto; padding: 32px 0; border-bottom: 1px solid var(--border); }
.section .module-inner { max-width: 100%; }
pre { color: #e0def4; }
code { color: inherit; }
```

### Quiz/Flashcard Data Loading

Data files must be in `website/data/` (not `../week-XX/`):

```javascript
// Flashcards
const res = await fetch('./data/flashcards.json');

// Quizzes
const urls = ['./data/quiz-01.json', './data/quiz-02.json', './data/quiz-03.json'];
```

### Dark Mode

```css
@media (prefers-color-scheme: dark) {
  :root {
    --cream: #1a1614;
    --white: #242220;
    --text-primary: #e8e0d8;
    --text-secondary: #a09890;
    --text-muted: #706860;
    --border: #3a3430;
    --shadow: rgba(0, 0, 0, 0.3);
  }
  .hero { background: linear-gradient(135deg, var(--cream) 0%, #221e1a 100%); }
}
```

### GitHub Actions (No build step needed)

```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v4
        with:
          enablement: true
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: 'website'
      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v4
```
