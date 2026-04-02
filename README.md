[简体中文](README.zh-CN.md) | English

# Learning to Course

A Claude Code skill that turns **any learning topic** into a structured, installable PWA course with daily study guides, interactive quizzes, and a GitHub repository.

Point it at a topic. Get back a complete curriculum — with an offline-capable website, Excalidraw diagrams, flashcards, and verified resources.

## Who is this for?

Anyone who wants to learn something new — and wants a structured path instead of scattered tutorials.

**Your goals are practical:**
- Learn a new skill with a clear daily plan
- Get interactive quizzes that test *application*, not memorization
- Have an installable app that works offline
- Track progress across days and weeks

Works for any topic: AI agents, cooking, music theory, cloud architecture, language learning — you name it.

## What the course looks like

The output is a **GitHub repo + installable PWA website**:

- **Daily study guides** — 800-1500 word markdown files with 8 mandatory sections each
- **Installable PWA** — works offline, installs to home screen, tracks progress
- **Interactive quizzes** — scenario-based questions, flashcards, drag-and-drop matching
- **Code ↔ English translations** — real code paired with plain-language explanations
- **Animated visualizations** — data flow animations, component chat conversations
- **Glossary tooltips** — hover any technical term for a plain-English definition
- **Excalidraw diagrams** — source files + exported SVGs
- **Verified resources** — every YouTube link checked via oEmbed, every doc link verified

### Multi-language support

Courses can be generated in **English**, **Simplified Chinese**, or **bilingual** (both). Chinese courses use Noto Serif SC, Chinese punctuation, and localized resources (Bilibili, RedNote).

## How to use

### Quick install

```bash
npx skills add CeciliaW888/learning-to-course
```

### Manual install

1. Copy the `learning-to-course` folder into `~/.claude/skills/`
2. Open Claude Code
3. Say: *"Turn machine learning into a 2-week course"*

### Trigger phrases

- "Create a course about X"
- "Turn X into a course"
- "Make a learning path for X"
- "Build a curriculum for X"
- "I want to learn X — make me a study plan"

### What it asks you

Before generating, the skill asks 6 questions:

1. **What topic?** — What do you want to learn?
2. **Experience level?** — Beginner, intermediate, or advanced?
3. **Time commitment?** — 30 min, 1 hour, or 2 hours per day?
4. **Duration?** — 1 week, 2 weeks, 3 weeks, or 1 month?
5. **Language?** — English, Simplified Chinese, or bilingual?
6. **Goal?** — What do you want to be able to do by the end?

Course length is **dynamic** — a quick intro might be 5 days, a deep dive could be 30.

## Design philosophy

- **Show, don't tell** — every screen is at least 50% visual. Max 2-3 sentences per text block.
- **Test doing, not knowing** — no "What does API stand for?" Instead: "A user reports stale data. Where would you look first?"
- **Verified resources only** — every YouTube video verified via oEmbed. No hallucinated references.
- **Fresh metaphors** — each concept gets a unique metaphor. Never the same one twice.

## Interactive elements

Courses include 17 interactive element types:

| Element | Description |
|---------|-------------|
| Multiple-choice quiz | Scenario-based questions with per-option feedback |
| Code ↔ English translation | Side-by-side code with plain-language explanations |
| Glossary tooltips | Hover/tap definitions for technical terms |
| Chat animations | iMessage-style component conversations |
| Data flow animations | Step-by-step packet movement visualization |
| Flashcards | 3D flip cards with progress tracking |
| Drag-and-drop matching | Touch-friendly concept matching |
| Spot-the-bug | Click the buggy line in a code snippet |
| Callout boxes | Highlight "aha moments" and key insights |
| Step cards | Visual sequential process breakdowns |
| Visual file trees | Directory structures with descriptions |
| Layer toggle | Progressive HTML → CSS → JS reveals |
| Architecture diagrams | Interactive system overviews |
| Pattern cards | Grid of engineering patterns/concepts |
| Reflection questions | Saved to localStorage for review |
| Progress tracking | Streaks, quiz scores, section completion |
| Confetti celebration | Reward on quiz success |

---

Built with Claude Code.
