#!/bin/bash
# validate-course.sh — Run against a generated course repo to catch common issues
# Usage: cd my-course-repo && bash path/to/validate-course.sh

set +e

PASS=0
FAIL=0
WARN=0

pass() { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
warn() { echo "  ⚠ $1"; WARN=$((WARN+1)); }

echo ""
echo "═══════════════════════════════════════"
echo "  Course Validation Report"
echo "═══════════════════════════════════════"
echo ""

# ── 1. Structure ──
echo "1. Repository Structure"

[ -f README.md ] && pass "README.md exists" || fail "README.md missing"
[ -d website ] && pass "website/ directory exists" || fail "website/ directory missing"
[ -f website/index.html ] && pass "website/index.html exists" || fail "website/index.html missing"
[ -f website/styles.css ] && pass "website/styles.css exists" || fail "website/styles.css missing"
[ -f website/main.js ] && pass "website/main.js exists" || fail "website/main.js missing"
[ -f website/manifest.json ] && pass "website/manifest.json exists" || fail "website/manifest.json missing"
[ -f website/sw.js ] && pass "website/sw.js exists" || fail "website/sw.js missing"
[ -f website/offline.html ] && pass "website/offline.html exists" || fail "website/offline.html missing"

WEEK_COUNT=$(ls -d week-*/ 2>/dev/null | wc -l)
[ "$WEEK_COUNT" -gt 0 ] && pass "Found $WEEK_COUNT week directories" || fail "No week-*/ directories found"

MODULE_COUNT=$(ls website/modules/*.html 2>/dev/null | wc -l)
[ "$MODULE_COUNT" -gt 0 ] && pass "Found $MODULE_COUNT module HTML files" || fail "No module files in website/modules/"

GUIDE_COUNT=$(find week-*/ -name "*.md" 2>/dev/null | wc -l)
[ "$GUIDE_COUNT" -gt 0 ] && pass "Found $GUIDE_COUNT daily guide markdown files" || fail "No daily guide .md files in week-*/"

[ "$MODULE_COUNT" -eq "$GUIDE_COUNT" ] && pass "Module count ($MODULE_COUNT) matches guide count ($GUIDE_COUNT)" || warn "Module count ($MODULE_COUNT) != guide count ($GUIDE_COUNT)"

echo ""

# ── 2. Module Format ──
echo "2. Module Format (must be fragments, not full HTML documents)"

BAD_DOCTYPE=$(grep -l "<!DOCTYPE" website/modules/*.html 2>/dev/null | wc -l)
[ "$BAD_DOCTYPE" -eq 0 ] && pass "No <!DOCTYPE> in modules" || fail "$BAD_DOCTYPE modules contain <!DOCTYPE> (must be fragments)"

BAD_HTML=$(grep -l "<html" website/modules/*.html 2>/dev/null | wc -l)
[ "$BAD_HTML" -eq 0 ] && pass "No <html> tags in modules" || fail "$BAD_HTML modules contain <html> tags"

BAD_SCRIPT=$(grep -l 'script src=' website/modules/*.html 2>/dev/null | wc -l)
[ "$BAD_SCRIPT" -eq 0 ] && pass "No external <script src=> in modules" || fail "$BAD_SCRIPT modules contain external script tags (will overwrite global functions)"

BAD_NAV=$(grep -l 'class="day-nav"' website/modules/*.html 2>/dev/null | wc -l)
[ "$BAD_NAV" -eq 0 ] && pass "No day-nav in modules (accordion handles navigation)" || warn "$BAD_NAV modules contain day-nav (accordion should handle Prev/Next)"

echo ""

# ── 3. Data Files ──
echo "3. Data Files (quiz + flashcards)"

[ -d website/data ] && pass "website/data/ directory exists" || fail "website/data/ directory missing"

if [ -f website/data/flashcards.json ]; then
  FC_COUNT=$(python3 -c "import json; print(len(json.load(open('website/data/flashcards.json'))))" 2>/dev/null || python -c "import json; print(len(json.load(open('website/data/flashcards.json'))))" 2>/dev/null || echo "0")
  [ "$FC_COUNT" -gt 0 ] && pass "flashcards.json has $FC_COUNT cards" || fail "flashcards.json is empty or invalid"
else
  fail "website/data/flashcards.json missing"
fi

QUIZ_COUNT=$(ls website/data/quiz-*.json 2>/dev/null | wc -l)
if [ "$QUIZ_COUNT" -gt 0 ]; then
  pass "Found $QUIZ_COUNT quiz JSON files"
  [ "$QUIZ_COUNT" -eq "$MODULE_COUNT" ] && pass "Quiz count matches module count" || warn "Quiz count ($QUIZ_COUNT) != module count ($MODULE_COUNT)"

  # Check answer distribution
  TOTAL=$(cat website/data/quiz-*.json 2>/dev/null | grep -c '"answer"' || echo "0")
  if [ "$TOTAL" -gt 0 ]; then
    MAX_PCT=$(cat website/data/quiz-*.json 2>/dev/null | grep -oh '"answer": [0-9]' | sort | uniq -c | sort -rn | head -1 | awk '{print $1}')
    PCT=$((MAX_PCT * 100 / TOTAL))
    [ "$PCT" -le 40 ] && pass "Quiz answer distribution OK (max $PCT% on one index)" || warn "Quiz answer distribution skewed: $PCT% on one index (target: ≤40%)"
  fi
else
  fail "No quiz JSON files found"
fi

echo ""

# ── 4. Placeholders ──
echo "4. Placeholder Replacement"

PLACEHOLDERS=$(grep -r "YOUR_USERNAME\|YOUR_REPO\|GITHUB_USERNAME\|GITHUB_REPO" --include="*.html" --include="*.md" --include="*.json" . 2>/dev/null | wc -l)
[ "$PLACEHOLDERS" -eq 0 ] && pass "No unreplaced placeholders" || fail "$PLACEHOLDERS lines with unreplaced placeholders (YOUR_USERNAME, YOUR_REPO, etc.)"

# Extract repo URLs from day-link hrefs and README clone URLs (ignore external repos)
if [ -f website/index.html ]; then
  OWNER=$(grep -oh "github\.com/[^/\"']*/[^/\"']*" README.md 2>/dev/null | head -1 | sed 's/\.git$//')
  if [ -n "$OWNER" ]; then
    pass "Primary repo: $OWNER"
    MISMATCHED=$(grep -oh "github\.com/[^/\"']*/[^/\"']*" website/index.html 2>/dev/null | grep -v "$OWNER" | grep -v "KhronosGroup\|mrdoob\|anthropics\|openai\|polyhaven\|easings\|json-schema\|learnopengl\|refactoring" | sort -u)
    [ -z "$MISMATCHED" ] && pass "No mismatched repo URLs in index.html" || warn "Unexpected repo URLs: $MISMATCHED"
  else
    warn "Could not detect primary repo from README"
  fi
fi

echo ""

# ── 5. Ephemeral Files ──
echo "5. Ephemeral File Cleanup"

[ ! -d briefs ] && pass "No briefs/ directory (cleaned up)" || fail "briefs/ directory still exists — delete before delivery"

PLAYGROUNDS=$(find . -name "*.playground.html" -o -name "progress-playground.html" 2>/dev/null | wc -l)
[ "$PLAYGROUNDS" -eq 0 ] && pass "No playground files in repo" || fail "$PLAYGROUNDS playground files found — move to /tmp/"

BRIEFS_IN_README=$(grep -c "briefs" README.md 2>/dev/null)
[ "${BRIEFS_IN_README:-0}" -eq 0 ] && pass "README does not reference briefs/" || warn "README still mentions briefs/"

echo ""

# ── 6. Service Worker ──
echo "6. Service Worker Strategy"

if [ -f website/sw.js ]; then
  SW_NAVIGATE=$(grep -c "request.mode.*navigate\|\.endsWith.*\.html" website/sw.js 2>/dev/null || echo "0")
  [ "$SW_NAVIGATE" -gt 0 ] && pass "SW has network-first for HTML/navigation" || warn "SW may not use network-first for HTML"

  SW_OFFLINE_NAV=$(grep -c "offline.html" website/sw.js 2>/dev/null || echo "0")
  [ "$SW_OFFLINE_NAV" -le 2 ] && pass "SW offline fallback is scoped (not blanket)" || warn "SW may return offline.html for non-navigation requests"

  # Strict precache coverage checks (offline-first UX contract)
  # Check if a relative asset path appears in SW as either:
  # './path/file.ext' or 'path/file.ext' (single or double quotes)
  in_sw_precache() {
    local rel="$1"
    grep -qF "'./$rel'" website/sw.js && return 0
    grep -qF "\"./$rel\"" website/sw.js && return 0
    grep -qF "'$rel'" website/sw.js && return 0
    grep -qF "\"$rel\"" website/sw.js && return 0
    return 1
  }

  MISSING_PRECACHE=0

  # Modules should be offline-available immediately after install
  for f in website/modules/*.html; do
    [ -f "$f" ] || continue
    rel="${f#website/}"
    if ! in_sw_precache "$rel"; then
      fail "SW precache missing module asset: $rel"
      MISSING_PRECACHE=1
    fi
  done

  # Learning data files should be offline-available (quiz + flashcards)
  for f in website/data/*.json; do
    [ -f "$f" ] || continue
    rel="${f#website/}"
    if ! in_sw_precache "$rel"; then
      fail "SW precache missing data asset: $rel"
      MISSING_PRECACHE=1
    fi
  done

  # Diagram SVGs rendered by the course UI
  for f in website/diagrams/*.svg; do
    [ -f "$f" ] || continue
    rel="${f#website/}"
    if ! in_sw_precache "$rel"; then
      fail "SW precache missing diagram asset: $rel"
      MISSING_PRECACHE=1
    fi
  done

  # Maskable icons are required for install-quality PWA behavior
  for rel in icons/icon-192-maskable.png icons/icon-512-maskable.png; do
    if [ -f "website/$rel" ] && ! in_sw_precache "$rel"; then
      fail "SW precache missing maskable icon: $rel"
      MISSING_PRECACHE=1
    fi
  done

  [ "$MISSING_PRECACHE" -eq 0 ] && pass "SW precache includes modules, data, diagrams, and maskable icons"
fi

echo ""

# ── 7. Website Config ──
echo "7. Website Configuration"

if [ -f website/index.html ]; then
  # Check MODULE_FILES array
  MF_COUNT=$(grep -o "modules/" website/index.html | wc -l)
  [ "$MF_COUNT" -ge "$MODULE_COUNT" ] && pass "MODULE_FILES references $MF_COUNT modules" || fail "MODULE_FILES array incomplete ($MF_COUNT < $MODULE_COUNT)"

  # Check scoped CSS
  SCOPED_CSS=$(grep -c "main > .section\|main>\.section" website/index.html 2>/dev/null || echo "0")
  UNSCOPED_CSS=$(grep -c "^[[:space:]]*\.section {" website/index.html 2>/dev/null)
  UNSCOPED_CSS=${UNSCOPED_CSS:-0}
  [ "$SCOPED_CSS" -gt 0 ] && pass "CSS .section rules are scoped to main >" || fail "CSS .section rules are not scoped to main > (could hide module internals)"

  # Check no Curriculum tab
  CURRICULUM_TAB=$(grep -c 'data-tab="curriculum"' website/index.html 2>/dev/null)
  [ "${CURRICULUM_TAB:-0}" -eq 0 ] && pass "No Curriculum tab (accordion is the curriculum)" || fail "Curriculum tab still exists (must be removed)"

  # Check resp.ok validation
  RESP_OK=$(grep -c "resp.ok\|response.ok" website/index.html 2>/dev/null || echo "0")
  [ "$RESP_OK" -gt 0 ] && pass "Module loader validates resp.ok" || fail "Module loader does not validate resp.ok before injection"
fi

echo ""

# ── 8. Icons ──
echo "8. PWA Icons"

[ -d website/icons ] && pass "website/icons/ exists" || fail "website/icons/ missing"
for ICON in icon-192.png icon-512.png; do
  [ -f "website/icons/$ICON" ] && pass "$ICON exists" || warn "$ICON missing"
done

echo ""

# ── 9. Diagrams ──
echo "9. Diagrams"

DIAGRAM_COUNT=$(ls website/diagrams/*.svg 2>/dev/null | wc -l)
[ "$DIAGRAM_COUNT" -gt 0 ] && pass "Found $DIAGRAM_COUNT SVG diagrams" || warn "No diagrams in website/diagrams/ (optional but recommended)"

echo ""

# ── Summary ──
echo "═══════════════════════════════════════"
echo "  Results: $PASS passed, $FAIL failed, $WARN warnings"
echo "═══════════════════════════════════════"

if [ "$FAIL" -gt 0 ]; then
  echo "  ❌ FAILED — fix $FAIL issues before delivery"
  exit 1
elif [ "$WARN" -gt 0 ]; then
  echo "  ⚠️  PASSED with $WARN warnings — review before delivery"
  exit 0
else
  echo "  ✅ ALL CHECKS PASSED"
  exit 0
fi
