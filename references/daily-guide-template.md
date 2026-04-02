# Daily Study Guide Template

Use this template for every day in a generated course. Each daily guide should be **800-1500 words** with all 8 sections. No section should be a placeholder or stub.

---

## Template

```markdown
# Day X: [Topic Title]

[← Previous: Day X-1 Topic](./day-XX-slug.md) | [Course Home](../README.md) | [Next: Day X+1 Topic →](./day-XX-slug.md)

---

## 🎯 Learning Objectives

By the end of today, you will be able to:

1. [Specific, measurable goal — e.g., "Explain the Perceive-Decide-Act loop and its three phases"]
2. [Practical skill — e.g., "Implement a basic tool-calling agent using LangChain"]
3. [Conceptual understanding — e.g., "Differentiate between ReAct, Plan-and-Execute, and Reflexion patterns"]
4. [Application — e.g., "Design an agent architecture for a given use case"]
5. [Optional 5th goal for advanced days]

**Difficulty:** 🟢 Beginner | 🟡 Intermediate | 🔴 Advanced
**Estimated Time:** X hours (Y reading + Z hands-on)

---

## 📚 Core Concepts

[800-1200 words of clear, well-structured explanations. Use subheadings to organize.]

### [Subtopic 1]

[2-3 paragraphs explaining the concept clearly. Use analogies to make abstract ideas concrete.]

[Example: "Think of an AI Agent like a new employee on their first day. They observe their surroundings (Perceive), decide what to do based on their training and instructions (Decide), then take action — sending an email, updating a spreadsheet, searching for information (Act). The key difference from a chatbot? The employee doesn't wait for instructions after every single step. They keep working until the task is done."]

### [Subtopic 2]

[2-3 paragraphs. Include comparisons to related concepts where helpful.]

### [Subtopic 3]

[2-3 paragraphs. Build on previous subtopics — progressive complexity within the day.]

> **Key Insight:** [One-sentence takeaway that captures the most important idea from today's concepts.]

---

## 🔑 Key Terminology

| Term | Definition | Example |
|------|-----------|---------|
| **[Term 1]** | [Clear, concise definition] | [Concrete example of this term in use] |
| **[Term 2]** | [Clear, concise definition] | [Concrete example] |
| **[Term 3]** | [Clear, concise definition] | [Concrete example] |
| **[Term 4]** | [Clear, concise definition] | [Concrete example] |
| **[Term 5]** | [Clear, concise definition] | [Concrete example] |

[5-10 terms per day. Prioritize terms the learner will encounter in code/docs, not just academic vocabulary.]

---

## 💻 Code Examples

### Example 1: [What This Demonstrates]

```python
# [Descriptive filename: e.g., basic_agent.py]
# Purpose: [One line explaining what this code does]

from langchain.agents import AgentExecutor, create_react_agent
from langchain_anthropic import ChatAnthropic
from langchain.tools import Tool

# Initialize the LLM
# Using Claude as the reasoning engine — any LLM works here
llm = ChatAnthropic(model="claude-sonnet-4-20250514", temperature=0)

# Define tools the agent can use
# Each tool needs: name, description (for the LLM), and a function
tools = [
    Tool(
        name="search",
        description="Search the web for current information",
        func=lambda q: f"Search results for: {q}"  # Replace with real search
    ),
    Tool(
        name="calculator",
        description="Perform mathematical calculations",
        func=lambda expr: str(eval(expr))  # Simple eval — use a proper parser in production
    ),
]

# Create and run the agent
# The agent will: perceive the task → decide which tool to use → act → repeat
agent = create_react_agent(llm, tools, prompt_template)
executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

result = executor.invoke({"input": "What's the population of Sydney divided by 2?"})
print(result["output"])

# Expected flow:
# 1. Agent perceives: "I need to find Sydney's population, then divide by 2"
# 2. Agent decides: "I'll search for the population first"
# 3. Agent acts: calls search("population of Sydney")
# 4. Agent perceives: "Got 5.3 million, now I need to divide"
# 5. Agent decides: "I'll use the calculator"
# 6. Agent acts: calls calculator("5300000 / 2")
# 7. Agent perceives: "Got 2,650,000 — task complete"
```

**What's happening:** [2-3 sentences explaining the key pattern this demonstrates]

### Example 2: [What This Demonstrates]

```python
# [Another working example building on Example 1]
# ...
```

**What's happening:** [Explanation]

> **💡 Try it:** [Specific modification the learner should make to understand the concept better — e.g., "Add a third tool that reads files. How does the agent decide which tool to use?"]

---

## ✏️ Hands-On Exercises

### Exercise 1: [Title] (⏱️ ~15 min)

**Goal:** [What the learner will build/do]

**Instructions:**
1. [Step-by-step instructions]
2. [Clear enough that the learner can complete without guessing]
3. [Include any setup steps needed]

**Expected Output:**
```
[What the learner should see when they succeed]
```

**Stretch Goal:** [Optional harder version for fast learners]

---

### Exercise 2: [Title] (⏱️ ~20 min)

**Goal:** [What the learner will build/do]

**Instructions:**
1. [Steps]
2. [Steps]

**Hints (if stuck):**
<details>
<summary>Hint 1</summary>
[Gentle nudge in the right direction]
</details>

<details>
<summary>Hint 2</summary>
[More specific guidance]
</details>

---

### Exercise 3: [Title] (⏱️ ~30 min)

**Goal:** [Larger exercise that combines today's concepts]

**Instructions:**
1. [Steps]
2. [Steps]
3. [Steps]

---

## 📖 Curated Resources

### Must-Read (pick at least 2)

1. **[Resource Title]** — [Author/Source]
   - 🔗 [URL] (Section: "[specific section name]", ~X min read)
   - Why: [One sentence on what this adds beyond the guide]

2. **[Resource Title]** — [Author/Source]
   - 🔗 [URL] (Pages X-Y or Section "[name]")
   - Why: [One sentence]

3. **[Resource Title]** — [Author/Source]
   - 🔗 [URL]
   - Why: [One sentence]

### Video Resources

4. **[Video Title]** — [Creator Name]
   - 🎥 [YouTube URL] (⚠️ VERIFIED — timestamp: X:XX-Y:YY for relevant section)
   - Why: [One sentence]

### Deep Dives (optional, for the curious)

5. **[Paper/Article Title]** — [Author]
   - 🔗 [URL]
   - Why: [One sentence on what advanced insight this provides]

> **⚠️ Resource Verification:** Every URL must be verified as accessible and matching the described content. Video links must be checked — LLM-generated YouTube IDs are almost always wrong. See `references/quality-checklist.md`.

---

## 🤔 Reflection Questions

1. **Comprehension:** [Question testing understanding of today's core concept]
   - *Think about: [brief framing to help the learner approach the question]*

2. **Application:** [Question asking the learner to apply what they learned to a real scenario]
   - *Think about: [brief framing]*

3. **Connection:** [Question linking today's learning to previous days or broader context]
   - *Think about: [brief framing]*

4. **Critical Thinking:** [Question that challenges assumptions or explores edge cases]

5. **Personal:** [Question connecting the material to the learner's own work/goals]

---

## ➡️ Next Steps

**Tomorrow:** [Day X+1 Title] — [One sentence preview of what's coming]

[Brief explanation of how tomorrow builds on today: "Now that you understand [today's concept], tomorrow we'll explore [next concept] which lets you [capability]."]

**Before moving on, make sure you can:**
- [ ] [Checkpoint 1 — tied to Learning Objective 1]
- [ ] [Checkpoint 2 — tied to Learning Objective 2]
- [ ] [Checkpoint 3 — tied to Learning Objective 3]

[← Previous: Day X-1 Topic](./day-XX-slug.md) | [Course Home](../README.md) | [Next: Day X+1 Topic →](./day-XX-slug.md)
```

---

## Formatting Standards

### Word Count
- **Minimum:** 800 words per daily guide
- **Target:** 1000-1200 words (Core Concepts carries the weight)
- **Maximum:** 1500 words (don't pad — if a day is simpler, that's fine)

### Section Weights
- Learning Objectives: ~50 words
- **Core Concepts: 800-1200 words** (this is the meat)
- Key Terminology: ~100-200 words
- Code Examples: 200-400 words (including comments)
- Exercises: ~200-300 words
- Resources: ~100 words
- Reflection: ~100 words
- Next Steps: ~50-100 words

### Progressive Difficulty Pattern

```
Week 1: 🟢 Foundations
  Day 1: What is [topic]? History and motivation
  Day 2: Core concepts and terminology
  Day 3: Your first [basic implementation]
  Day 4: Understanding the building blocks
  Day 5: Week 1 review + mini-project

Week 2: 🟡 Intermediate
  Day 6: Deeper patterns and techniques
  Day 7: Real-world tools and frameworks
  Day 8: Integration and composition
  Day 9: Debugging and optimization
  Day 10: Week 2 review + project

Week 3: 🔴 Advanced
  Day 11: Advanced patterns
  Day 12: Production considerations
  Day 13: Cutting-edge research
  Day 14: Capstone project
  Day 15: Review, reflection, what's next
```

### Code Example Requirements
- **Language:** Match the topic (Python for AI/ML, JavaScript for web, etc.)
- **Working:** Must run as-is (with noted dependencies)
- **Commented:** Every significant line has a comment
- **Explained:** "What's happening" block after each example
- **Progressive:** Example 2 builds on Example 1
- **"Try it" prompts:** Encourage experimentation

### Resource Citation Format
```markdown
**[Title]** — [Author/Organization]
- 🔗 [Full URL] (Section: "[specific section]", ~X min)
- Why: [What this adds that the guide doesn't cover]
```

- Always cite the specific section, not just the homepage
- For videos: include timestamp range for the relevant portion
- For papers: cite specific sections or page numbers
- **ALL video links must be verified** (see quality-checklist.md)

### Navigation Links
Every daily guide MUST have navigation at top and bottom:
```markdown
[← Previous: Day X Topic](./day-XX-slug.md) | [Course Home](../README.md) | [Next: Day Y Topic →](./day-YY-slug.md)
```
- Day 1: no "Previous" link
- Last day: no "Next" link
- Always include "Course Home" link

---

## Day Brief Template (Parallel Generation)

Use this template when generating courses with 10+ days. Write one brief per day, then dispatch to subagents for parallel generation.

### Purpose

Each brief provides a subagent everything needed to write ONE daily guide + its website module HTML, without access to source research or other days' content.

### Template

---

#### Day [N]: [Topic Title]

**Week:** [Week number]
**Difficulty:** Beginner / Intermediate / Advanced
**Estimated study time:** [30 min / 1 hour / 2 hours]

##### Teaching Arc

- **Metaphor:** [Everyday metaphor that grounds this concept — must be unique, never reused]
- **Opening hook:** [1-2 sentences connecting to learner's experience or previous day]
- **Key insight:** [The single most important takeaway]
- **Practical relevance:** [Why this matters — how it helps the learner's stated goal]

##### Learning Objectives (3-5)

1. [Measurable objective using action verbs: explain, implement, compare, analyze]
2. ...
3. ...

##### Core Concepts Outline

- **Concept 1:** [Topic] — [2-3 sentence summary of what to cover, key points]
- **Concept 2:** [Topic] — [2-3 sentence summary]
- **Concept 3:** [Topic] — [2-3 sentence summary]
- Target: 800-1200 words total for Core Concepts section

##### Pre-Researched Resources

Include verified resources so the subagent doesn't need to search:

- **Video:** [Title] by [Author] — https://youtube.com/watch?v=ID (oEmbed verified)
- **Article:** [Title] — [URL] (web_fetch verified)
- **Docs:** [Section name] — [URL] (web_fetch verified)

##### Key Terminology (5-10 terms)

| Term | Definition | Example |
|------|-----------|---------|
| [Term] | [Plain-language definition] | [Concrete example] |

##### Code Examples to Include

```[language]
# Pre-selected code example (working, tested)
# Include file context: filename, what it demonstrates
```

- **What it demonstrates:** [explanation]
- **"Try it" prompt:** [what the learner should modify/experiment with]

##### Exercise Ideas (3-5)

1. **[Title]** (~X min, difficulty) — [Brief description of what the learner builds/does]
2. ...

##### Reflection Questions (3-5)

1. [Open-ended question connecting today's content to learner's goals]
2. ...

##### Interactive Elements for Website Module

Specify which interactive elements the website module should include:

- [ ] Quiz (multiple-choice) — [topic/question idea]
- [ ] Code / English translation block — [which code example]
- [ ] Flashcards — [which terms]
- [ ] Diagram — [which concept, SVG filename in website/diagrams/]
- [ ] Chat animation — [which components/actors talk]
- [ ] Data flow animation — [what flow to animate]
- [ ] Callout box — [insight to highlight]

##### Context from Adjacent Days

- **Previous day covered:** [brief summary so transitions are smooth]
- **Next day will cover:** [brief summary so "Next Steps" section is accurate]

##### Reference Files Needed

The subagent should read these sections:
- `references/daily-guide-template.md` — full 8-section template (this file)
- `references/interactive-elements.md` — [specific sections needed]
- `references/quality-checklist.md` — gotchas and failure points to avoid

---

### Usage Guidelines

#### When to use briefs
- Courses with **10+ days** — parallel generation saves significant time
- Complex topics where research is expensive — pre-research once, distribute

#### When to skip briefs
- Short courses (5-7 days) — sequential generation is fine
- Simple topics — overhead of brief-writing exceeds time saved

#### Dispatch strategy
- Send 2-3 briefs per batch to subagents
- Each subagent receives: its brief + referenced sections from references/
- Each subagent produces: one day-XX-topic.md + one modules/XX-topic.html
- Main agent does consistency check after all days are generated

#### Brief quality checklist
- [ ] All resources verified (oEmbed for videos, web_fetch for links)
- [ ] Code examples tested and working
- [ ] Metaphor is unique (not used in any other day's brief)
- [ ] Objectives are measurable (action verbs, not "understand" or "learn about")
- [ ] Adjacent day context filled in (for smooth transitions)
