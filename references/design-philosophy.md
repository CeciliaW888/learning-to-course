# Design Philosophy

Read this file when writing daily study guide content and module HTML. Every decision serves one goal: the learner understands faster and retains longer.

## Visual-First Design

The screen is a canvas, not a page. Learners should *see* concepts before they read about them.

- **Max 2-3 sentences per text block.** A fourth sentence means you need a visual break — a diagram, card, code snippet, or interactive element.
- **Every screen must be at least 50% visual content.** If text dominates, convert something.
- **Convert lists to cards.** Bullet points become step cards, icon-label rows, or pattern cards.
- **Convert sequences to flow diagrams.** Any "first... then... finally..." narrative becomes a visual flow.
- **Convert comparisons to visual grids.** Side-by-side tables become styled comparison cards.
- **Replace bullet paragraphs with icon rows.** Each point gets an icon, a label, and one sentence.

When in doubt: if a learner squints at the screen and sees a wall of grey text, redesign it.

## Show, Don't Tell

Explanation is a last resort. Prefer, in order:

1. **Diagrams over descriptions.** A system architecture diagram replaces 500 words of "Component A talks to Component B."
2. **Code examples over theory.** Show what happens, then explain why.
3. **Interactive elements over passive reading.** A clickable flowchart beats a static one. A quiz beats a summary.
4. **Animations over static images where data flows.** If the concept involves movement, animate it.

Every visual must carry information that would otherwise require text.

## Quiz Philosophy

Quizzes test whether learners can *apply* knowledge, not *recall* it.

**Good question patterns:**
- "What would you do?" — Present a scenario and ask for the next step.
- "Where would you look?" — A user reports an error. Which log or component do you investigate first?
- Debugging scenarios, architectural decisions, tradeoff analysis.

**Never ask:** acronym recall, syntax recall, list memorization, context-free true/false.

**Feedback:** Every question includes an explanation for both correct and incorrect answers. Encouraging tone: "Good instinct, but..." not "Wrong."

## Metaphor Strategy

- **Ground in everyday life first.** Introduce the metaphor before revealing technical details.
- **One metaphor per concept.** Never reuse a metaphor across different sections.
- **Avoid recycled clichés.** No "restaurant for APIs." No "library for databases."
- **Pick metaphors that feel inevitable.** The right metaphor makes the learner say "oh, it's *exactly* like that."
- **Introduce, connect, release.** Start with the metaphor, map it to the technical concept, then let the learner work with the real thing.

## Code Examples

- **Pair real code with plain-language line-by-line explanations.** Every code block gets a "what this does in English" companion.
- **Focus on "why" over "what."** Don't say "this line imports requests." Say "we need requests because we're about to make HTTP calls."
- **Use actual working code.** Never pseudo-code. Copy-paste ready.
- **Keep snippets naturally short: 5-15 lines.** Don't truncate — find a naturally short section.
- **Language tags on every code block** for syntax highlighting.

## Code and English Translations

- **Pair real code with plain-language line-by-line explanations.** Every code block gets a "what this does in English" companion.
- **Focus on "why" over "what."** Don't say "this line imports requests." Say "we need requests because we're about to make HTTP calls."
- **Use actual working code.** Never pseudo-code. Copy-paste ready.
- **Keep snippets naturally short: 5-15 lines.** Don't truncate — find a naturally short section.
- **Language tags on every code block** for syntax highlighting.

## Glossary and Terminology

- **Define every technical term on first use per section.** If a term appeared in Day 3 and appears again in Day 7, define it again.
- **Use the dashed-underline tooltip pattern.** Terms get a subtle underline; hovering reveals the definition.
- **When in doubt, add a tooltip.** Over-definition beats under-definition.
- **For bilingual courses:** `ReAct（推理与行动结合）` — English term with Chinese explanation.

## Motivation Before Mechanism

Every section must answer **"why should I care?"** before **"how does it work?"**

- The answer to "why" is always practical — it helps the learner do something specific.
- Connect to the learner's stated goal from the intake questionnaire.
- **Structure every section as:** motivation (1-2 sentences) → concept (visual + explanation) → application (code or exercise).
- Never start a section with a definition. Start with a problem the learner will recognize.

## Progressive Disclosure

Reveal complexity in layers. Never dump everything at once.

- **Start with what learners already know.** Begin from user-facing behavior or everyday concepts.
- **Peel back layers gradually:** experience → mechanism → implementation.
- **One concept per screen or section.** If covering two ideas, split into two sections.
- **Use "you already know this" bridges** to connect new material to previous sections.
- **Hide advanced details behind expandable sections.**

## Resource Integrity

Every external link in the course must be verified. No exceptions.

- **All links verified via `web_fetch` before inclusion.** If a link doesn't load, it doesn't go in.
- **YouTube videos verified via oEmbed API.** Copy exact `title` and `author_name` — never paraphrase.
- **No hallucinated references.** Search for real resources, verify they exist, then include them.
- **Dead links replaced or removed.** Never leave a broken link as a placeholder.
- **Prefer stable, top-level URLs** over deep paths that break when docs restructure.
