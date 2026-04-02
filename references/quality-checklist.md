# Quality Checklist

**Run this checklist before delivering ANY course. Every item is MANDATORY.**

This is not a "nice to have" — it's a gate. If any check fails, fix it before delivery.

---

## Quick Gotchas Reference

**Scan this section before delivery. These are the most common failure points.**

### Visual Density Errors

- Do not leave walls of text without visual breaks (>3 paragraphs without an image, diagram, or interactive element)
- Every screen must be at least 50% visual content
- Convert bullet point lists to cards or visual grids
- Replace long explanations with diagrams where possible
- Fix: Convert to step cards, icon rows, pattern cards, or diagrams
- Fix: Break text blocks at 2-3 sentences max, insert visuals between them

### Tooltip Issues

- Do not under-tooltip: define technical terms non-experts won't know
- Watch for tooltips clipped by parent containers with `overflow: hidden`
- Do not assume the learner remembers a term defined three days ago
- Fix: Use `position: fixed` tooltips appended to `document.body`
- Fix: When in doubt, add a tooltip — over-definition beats under-definition
- Fix: Re-define terms on first use per section, not just per course

### Quiz Design Flaws

- No memory-based questions ("What does API stand for?")
- No syntax recall ("What's the correct import statement?")
- No true/false questions with no practical context
- Every answer (correct and incorrect) must have an explanation
- Fix: Scenario-based questions ("User reports X, where do you look?")
- Fix: Decision-making questions ("Which approach and why?")
- Fix: Encouraging tone — "Good instinct, but..." not "Wrong."

### Code Block Issues

- Do not modify code snippets to fit (readers can't find them in real files)
- Avoid horizontal scrolling in code blocks (breaks reading flow)
- No pseudo-code disguised as real code
- Always use language tags on code blocks (for syntax highlighting)
- Do not truncate long functions with "..." — pick a shorter one
- Fix: Select naturally short code sections (5-15 lines)
- Fix: Use `white-space: pre-wrap` (handled by pre-built styles.css)
- Fix: Always use real, runnable code with language-tagged fences

### Metaphor Mistakes

- Do not reuse the same metaphor across different sections
- Avoid default "restaurant" analogy for APIs, "library" for databases
- Each concept gets a unique, inevitable-feeling metaphor
- Test the metaphor — does it hold up or create misconceptions?

### Scroll & Navigation

- Never use `scroll-snap-type: y mandatory` (traps users) — use `proximity` instead
- Ensure keyboard navigation works (pre-built main.js handles arrow keys)
- Include a section nav or progress indicator for long pages

### PWA Issues

- Always await async cache operations in service worker (`caches.match()` returns a Promise)
- Include all icon files in pre-cache list
- Include Apple meta tags for iOS (`apple-touch-icon`, `apple-mobile-web-app-capable`)
- Verify every file in `sw.js` PRECACHE_ASSETS actually exists
- Use pre-built `templates/_base.html` which includes all PWA boilerplate

### Content Generation

- Do not write all daily guides in one pass (quality degrades in later days)
- No placeholder content ("TODO: add exercises here")
- Every daily guide needs all 8 mandatory sections
- Core Concepts section must be 800+ words
- Always start sections with "why should I care?" motivation
- Fix: Generate in batches, verify completeness before delivery

### Resource Links

- Never use LLM-generated YouTube video IDs (they look plausible but 404)
- Avoid deep doc links that break when docs restructure
- Verify all links before inclusion
- Copy exact oEmbed title and author — never paraphrase
- Check for duplicate videos across sections

### Placeholder Remnants

- Replace all `YOUR_USERNAME`, `YOUR_REPO`, `USER/REPO` with actual values
- Check for `your-email@example.com` or `example.com` in config files
- Run `grep -r "YOUR_\|your-username\|your-repo" .` — must return empty

### Diagram Paths

- Exports go in `website/diagrams/`, not `diagrams/`
- HTML uses `src="diagrams/file.svg"` (relative to website/)
- Never use `../diagrams/` (parent path) or absolute `/diagrams/` paths
- Every `.excalidraw` source file needs a corresponding SVG export

---

## 1. Video Link Verification (CRITICAL) 🎥

**Why:** LLM-generated YouTube video IDs are almost always wrong. They look plausible but link to nonexistent or completely unrelated videos. This is the #1 source of broken courses.

### Process

**Step 1: Extract all video links**
```bash
# Find all YouTube links in the project
grep -rn "youtube.com\|youtu.be" --include="*.html" --include="*.md" --include="*.json" .
```

**Step 2: Verify EACH link via oEmbed API**
```bash
# For each YouTube video ID, verify via oEmbed:
web_fetch "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json"

# The response contains the EXACT title and author_name.
# Copy these EXACTLY into your course files.
# Do NOT paraphrase, shorten, or "improve" the title.
# Do NOT guess the creator name.

# Check:
# ✅ oEmbed returns 200 (not 404 = video dead)
# ✅ Copy exact "title" field into your course
# ✅ Copy exact "author_name" field into your course
# ✅ Video topic matches the lesson it's assigned to
```

**Step 3: Fix or replace**
- If oEmbed returns 404 → video is dead, search for a real replacement
- If the title doesn't match the lesson topic → wrong video, find a different one
- If you can't find a good video → remove the link entirely, do NOT leave a placeholder
- **NEVER leave an unverified video link**

**Step 4: Check for duplicates**
```bash
# Find duplicate video IDs within same file (ERROR)
grep -oh 'youtube.com/watch?v=[A-Za-z0-9_-]*' FILE | sort | uniq -d

# Find duplicate video IDs across files (WARNING — verify different context)
grep -roh 'youtube.com/watch?v=[A-Za-z0-9_-]*' --include="*.md" --include="*.html" . | sort | uniq -d
```

### Common Mistakes to Avoid
- ❌ Using a video ID that "looks right" without checking
- ❌ Assuming a popular creator has a video on a specific topic
- ❌ Trusting auto-generated timestamps (verify those too)
- ❌ Linking to playlists instead of specific videos without checking

---

## 2. GitHub Placeholder Check 🔗

**Why:** Generated files often contain `YOUR_USERNAME`, `YOUR_REPO`, and similar placeholders. These break links and look unprofessional.

### Process

**Step 1: Detect username**
```bash
# Auto-detect from git remote
GITHUB_USER=$(git remote get-url origin 2>/dev/null | sed -n 's/.*github.com[:/]\([^/]*\)\/.*/\1/p')
REPO_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)

echo "User: $GITHUB_USER"
echo "Repo: $REPO_NAME"

# If empty, ask the user
```

**Step 2: Find all placeholders**
```bash
# Search for common placeholder patterns
grep -rn \
  "YOUR_USERNAME\|YOUR_REPO\|YOUR_EMAIL\|USER/REPO\|USERNAME/REPO\|your-username\|your-repo\|GITHUB_USERNAME\|example\.com" \
  --include="*.md" --include="*.html" --include="*.json" --include="*.js" .
```

**Step 3: Replace all instances**
```bash
# Replace in all text files
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.json" -o -name "*.js" \) \
  -exec sed -i '' \
    -e "s/YOUR_USERNAME/$GITHUB_USER/g" \
    -e "s/your-username/$GITHUB_USER/g" \
    -e "s/YOUR_REPO/$REPO_NAME/g" \
    -e "s/your-repo/$REPO_NAME/g" \
    {} +
```

**Step 4: Verify clean**
```bash
# This MUST return empty
grep -rn "YOUR_\|your-username\|your-repo" --include="*.md" --include="*.html" --include="*.json" .
# If anything shows up, fix it manually
```

### Common Placeholders
| Placeholder | Replace With |
|------------|-------------|
| `YOUR_USERNAME` | Actual GitHub username |
| `YOUR_REPO` | Actual repository name |
| `USER/REPO` | `username/repo-name` |
| `your-email@example.com` | Actual email or remove |
| `https://your-site.github.io` | `https://username.github.io/repo` |

---

## 3. Diagram Path Validation 📐

**Why:** Incorrect diagram paths are the second most common issue. The website can only reference files relative to its own directory.

### Correct Structure
```
repo/
├── diagrams/                    # Source files (.excalidraw)
│   ├── concept-map.excalidraw
│   └── architecture.excalidraw
└── website/
    ├── index.html               # References: src="diagrams/file.svg"
    └── diagrams/                # ⚠️ Exported files MUST be HERE
        ├── concept-map.svg
        ├── concept-map.png
        └── architecture.svg
```

### Process

**Step 1: Verify export location**
```bash
# All diagram exports should be in website/diagrams/
ls -la website/diagrams/

# NOT in:
# ❌ diagrams/ (source only — .excalidraw files)
# ❌ website/assets/diagrams/ (old convention)
# ❌ assets/diagrams/ (wrong path)
```

**Step 2: Check HTML references**
```bash
# Find all diagram image references in HTML
grep -n 'src=".*diagram\|src=".*\.svg\|src=".*\.png' website/index.html

# Every reference MUST be: src="diagrams/filename.svg"
# NOT:
# ❌ src="../diagrams/filename.svg" (parent directory — won't work on deployed site)
# ❌ src="assets/diagrams/filename.svg" (wrong subfolder)
# ❌ src="/diagrams/filename.svg" (absolute path — breaks on GitHub Pages subpath)
```

**Step 3: Verify every referenced file exists**
```bash
# Extract all diagram references and check each exists
grep -oh 'src="diagrams/[^"]*"' website/index.html | \
  sed 's/src="//;s/"//' | \
  while read f; do
    if [ ! -f "website/$f" ]; then
      echo "❌ MISSING: website/$f"
    else
      echo "✅ Found: website/$f"
    fi
  done
```

**Step 4: Verify source files exist too**
```bash
# Every exported file should have a .excalidraw source
ls website/diagrams/*.svg 2>/dev/null | while read svg; do
  base=$(basename "$svg" .svg)
  if [ ! -f "diagrams/$base.excalidraw" ]; then
    echo "⚠️ No source file for: $svg"
  fi
done
```

### Path Quick Reference
| What | Path | Example |
|------|------|---------|
| Source files | `diagrams/*.excalidraw` | `diagrams/pda-loop.excalidraw` |
| Exported SVG | `website/diagrams/*.svg` | `website/diagrams/pda-loop.svg` |
| Exported PNG | `website/diagrams/*.png` | `website/diagrams/pda-loop.png` |
| HTML reference | `src="diagrams/file.svg"` | `<img src="diagrams/pda-loop.svg">` |

---

## 4. Daily Guide Completeness 📝

**Why:** Placeholder guides destroy the course experience. Every day must be a real, comprehensive learning experience.

### Process

**Step 1: Check all day files exist**
```bash
# List all expected day files
find . -name "day-*.md" | sort

# Verify count matches curriculum
# e.g., 3-week course = 15 day files
```

**Step 2: Verify all 8 sections present**
```bash
# For each day file, check sections
for f in $(find . -name "day-*.md" | sort); do
  echo "=== $f ==="
  grep -c "## 🎯\|## 📚\|## 🔑\|## 💻\|## ✏️\|## 📖\|## 🤔\|## ➡️" "$f"
  # Should output 8 for each file
done
```

**Step 3: Check Core Concepts length**
```bash
# Core Concepts should be 800+ words
for f in $(find . -name "day-*.md" | sort); do
  # Extract Core Concepts section and count words
  words=$(sed -n '/## 📚 Core Concepts/,/## 🔑 Key Terminology/p' "$f" | wc -w | tr -d ' ')
  if [ "$words" -lt 800 ]; then
    echo "⚠️ $f: Core Concepts only $words words (need 800+)"
  else
    echo "✅ $f: Core Concepts $words words"
  fi
done
```

**Step 4: Verify code examples work**
- Code blocks have language tags (```python, ```javascript)
- Comments explain what's happening
- Dependencies are noted at the top
- No pseudo-code masquerading as real code

**Step 5: Check navigation links**
```bash
# Every day file (except first and last) should have prev/next links
for f in $(find . -name "day-*.md" | sort); do
  prev=$(grep -c "← Previous" "$f")
  next=$(grep -c "Next.*→" "$f")
  home=$(grep -c "Course Home" "$f")
  echo "$f: prev=$prev next=$next home=$home"
done
```

---

## 5. File Structure Verification 📁

### Process

**Step 1: Verify repo structure**
```bash
# Check all required top-level directories/files exist
required=(
  "README.md"
  "website/index.html"
  "website/manifest.json"
  "website/sw.js"
  "website/offline.html"
  "website/diagrams"
  "website/icons"
  "diagrams"
  "flashcards"
  "projects"
)

for item in "${required[@]}"; do
  if [ -e "$item" ]; then
    echo "✅ $item"
  else
    echo "❌ MISSING: $item"
  fi
done
```

**Step 2: Validate manifest.json**
```bash
# Check manifest is valid JSON
python3 -c "import json; json.load(open('website/manifest.json'))" && echo "✅ Valid JSON" || echo "❌ Invalid JSON"

# Check required fields
python3 -c "
import json
m = json.load(open('website/manifest.json'))
required = ['name', 'short_name', 'start_url', 'display', 'icons']
for field in required:
    status = '✅' if field in m else '❌'
    print(f'{status} {field}')
"
```

**Step 3: Check icons exist**
```bash
# Required PWA icons
icons=(
  "website/icons/icon-192.png"
  "website/icons/icon-512.png"
  "website/icons/icon-192-maskable.png"
  "website/icons/icon-512-maskable.png"
)

for icon in "${icons[@]}"; do
  if [ -f "$icon" ]; then
    echo "✅ $icon ($(wc -c < "$icon" | tr -d ' ') bytes)"
  else
    echo "❌ MISSING: $icon"
  fi
done
```

**Step 4: Check service worker references valid files**
```bash
# Files listed in sw.js PRECACHE_ASSETS must all exist
grep -o "'[^']*'" website/sw.js | tr -d "'" | while read f; do
  target="website/${f#./}"
  if [ -f "$target" ] || [ "$f" = "./" ]; then
    echo "✅ $f"
  else
    echo "❌ MISSING in sw.js precache: $f → $target"
  fi
done
```

---

## 6. Deployment Readiness 🚀

### Final Checks

```bash
# 1. No broken internal links
grep -oh 'href="[^"]*"\|src="[^"]*"' website/index.html | \
  grep -v "http\|mailto\|#\|javascript" | \
  sed 's/href="//;s/src="//;s/"//' | \
  while read f; do
    if [ ! -f "website/$f" ]; then
      echo "❌ Broken link: $f"
    fi
  done

# 2. HTML is well-formed (basic check)
grep -c "<html\|</html>" website/index.html
# Should output 2 (opening + closing)

# 3. No console errors (manual)
# Open website/index.html in browser and check console

# 4. Service worker registers
# Check sw.js references exist (done above)

# 5. Responsive check
# Open in mobile viewport and verify layout works
```

---

## Pre-Delivery Summary

Run all checks and produce a summary:

```
📋 Quality Checklist Results
━━━━━━━━━━━━━━━━━━━━━━━━━━

🎥 Video Links:     ✅ X verified / ❌ Y broken
🔗 Placeholders:    ✅ None found / ❌ Y remaining
📐 Diagram Paths:   ✅ All valid / ❌ Y mismatched
📝 Daily Guides:    ✅ X complete / ❌ Y incomplete
📁 File Structure:  ✅ Complete / ❌ Missing Y files
🚀 Deploy Ready:    ✅ Yes / ❌ No (reason)

Overall: ✅ PASS — Ready for delivery
         ❌ FAIL — Fix items above before delivery
```

**The course is NOT ready until this summary shows all ✅.**
