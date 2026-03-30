# Interactive Elements

Patterns for quizzes, animations, visualizations, and daily guide structures in learning-to-course websites.

---

## Daily Study Guide Patterns

### Section Structure (All 8 Required)

Every daily guide must include these sections in this order:

```html
<!-- Day page structure in the PWA website -->
<section class="day-content" data-day="X">
  <h2>Day X: [Topic]</h2>
  
  <!-- Navigation -->
  <nav class="day-nav">
    <a href="#day-X-1">← Previous</a>
    <a href="#home">Course Home</a>
    <a href="#day-X+1">Next →</a>
  </nav>
  
  <!-- 1. Learning Objectives -->
  <div class="section objectives">
    <h3>🎯 Learning Objectives</h3>
    <ul class="objective-list">
      <li data-objective="1">Explain [concept] and its key components</li>
      <li data-objective="2">Implement [skill] using [tool/framework]</li>
      <li data-objective="3">Compare and contrast [A] vs [B]</li>
    </ul>
    <div class="difficulty-badge">🟡 Intermediate</div>
  </div>
  
  <!-- 2. Core Concepts (800-1200 words) -->
  <div class="section concepts">
    <h3>📚 Core Concepts</h3>
    <!-- This is the meat — substantial explanations, not stubs -->
  </div>
  
  <!-- 3. Key Terminology -->
  <div class="section terminology">
    <h3>🔑 Key Terminology</h3>
    <div class="term-grid">
      <div class="term-card">
        <dt>Term Name</dt>
        <dd>Definition with concrete example</dd>
      </div>
    </div>
  </div>
  
  <!-- 4. Code Examples -->
  <div class="section code-examples">
    <h3>💻 Code Examples</h3>
    <div class="code-block" data-lang="python">
      <div class="code-header">
        <span class="filename">basic_agent.py</span>
        <button class="copy-btn">📋 Copy</button>
      </div>
      <pre><code>...</code></pre>
      <p class="code-explanation">What's happening: ...</p>
    </div>
  </div>
  
  <!-- 5. Hands-On Exercises -->
  <div class="section exercises">
    <h3>✏️ Hands-On Exercises</h3>
    <div class="exercise-card">
      <h4>Exercise 1: [Title] (⏱️ ~15 min)</h4>
      <p class="exercise-goal">Goal: ...</p>
      <ol class="exercise-steps">...</ol>
      <details class="exercise-hints">
        <summary>Need a hint?</summary>
        <p>...</p>
      </details>
    </div>
  </div>
  
  <!-- 6. Curated Resources -->
  <div class="section resources">
    <h3>📖 Curated Resources</h3>
    <div class="resource-cards">
      <a class="resource-card" href="..." target="_blank">
        <span class="resource-type">📄 Article</span>
        <span class="resource-title">Title</span>
        <span class="resource-meta">Author — Section "X", ~Y min</span>
      </a>
    </div>
  </div>
  
  <!-- 7. Reflection Questions -->
  <div class="section reflection">
    <h3>🤔 Reflection Questions</h3>
    <div class="reflection-card">
      <p class="reflection-prompt">Question here?</p>
      <textarea placeholder="Your thoughts..."></textarea>
      <button class="save-reflection">Save</button>
    </div>
  </div>
  
  <!-- 8. Next Steps -->
  <div class="section next-steps">
    <h3>➡️ Next Steps</h3>
    <p>Tomorrow: [Topic preview]</p>
    <div class="checklist">
      <label><input type="checkbox"> I can explain [objective 1]</label>
      <label><input type="checkbox"> I completed [exercise]</label>
      <label><input type="checkbox"> I understand [key concept]</label>
    </div>
  </div>
  
  <!-- Bottom navigation -->
  <nav class="day-nav bottom">
    <a href="#day-X-1">← Previous</a>
    <a href="#home">Course Home</a>
    <a href="#day-X+1">Next →</a>
  </nav>
</section>
```

### Code Example Format (Detailed)

Code examples in daily guides must be working, commented, and explained:

```html
<div class="code-block" data-lang="python">
  <div class="code-header">
    <span class="filename">agent_with_tools.py</span>
    <span class="badge">Working Example</span>
    <button class="copy-btn" onclick="copyCode(this)">📋 Copy</button>
  </div>
  <pre><code class="language-python">
# agent_with_tools.py
# Purpose: Demonstrate tool-calling agent pattern
# Dependencies: pip install langchain langchain-anthropic

from langchain.agents import AgentExecutor, create_react_agent
from langchain_anthropic import ChatAnthropic

# Initialize - any LLM works here
llm = ChatAnthropic(model="claude-sonnet-4-20250514")

# Define tools with clear descriptions
# The LLM reads these descriptions to decide which tool to use
tools = [
    Tool(name="search", description="Search the web", func=search_fn),
    Tool(name="calc", description="Do math", func=calc_fn),
]

# Run the agent
result = executor.invoke({"input": "What's 2+2?"})
  </code></pre>
  <div class="code-explanation">
    <strong>What's happening:</strong> The agent receives the input, reads the tool
    descriptions, decides "calc" is the right tool for math, calls it, and returns
    the result. The ReAct pattern means it reasons about which tool to use before acting.
  </div>
  <div class="try-it">
    💡 <strong>Try it:</strong> Add a third tool that reads files. Does the agent
    correctly choose between search, calc, and file-read based on the question?
  </div>
</div>
```

### Exercise Format (Detailed)

```html
<div class="exercise-card" data-exercise="1">
  <div class="exercise-header">
    <h4>Exercise 1: Build a Simple Search Agent</h4>
    <span class="time-estimate">⏱️ ~20 min</span>
    <span class="difficulty">🟡 Intermediate</span>
  </div>
  
  <p class="exercise-goal">
    <strong>Goal:</strong> Create an agent that searches the web and summarizes results.
  </p>
  
  <div class="exercise-instructions">
    <ol>
      <li>Install dependencies: <code>pip install langchain langchain-anthropic</code></li>
      <li>Create a new file <code>search_agent.py</code></li>
      <li>Define a search tool using the Brave Search API</li>
      <li>Create a ReAct agent with the search tool</li>
      <li>Test with: "What happened in AI news today?"</li>
    </ol>
  </div>
  
  <div class="expected-output">
    <strong>Expected Output:</strong>
    <pre>Agent: I'll search for today's AI news...
> Using tool: search("AI news today")
> Found 5 results...
Agent: Here's a summary of today's AI news:
1. [Result summary]
2. [Result summary]</pre>
  </div>
  
  <details class="exercise-hints">
    <summary>Hint 1 (if stuck on setup)</summary>
    <p>Make sure you've set your ANTHROPIC_API_KEY environment variable...</p>
  </details>
  
  <details class="exercise-hints">
    <summary>Hint 2 (if stuck on tool definition)</summary>
    <p>The Tool class needs three things: name, description, and func...</p>
  </details>
  
  <div class="stretch-goal">
    <strong>🚀 Stretch Goal:</strong> Add a second tool that saves results to a file.
    Can your agent search AND save in one run?
  </div>
</div>
```

### Daily Guide CSS

```css
/* Day navigation */
.day-nav {
  display: flex;
  justify-content: space-between;
  padding: var(--space-4) 0;
  border-bottom: 1px solid var(--border);
  margin-bottom: var(--space-6);
}

.day-nav.bottom {
  border-bottom: none;
  border-top: 1px solid var(--border);
  margin-top: var(--space-8);
  padding-top: var(--space-4);
}

.day-nav a {
  color: var(--primary);
  text-decoration: none;
  font-weight: 500;
}

/* Difficulty badge */
.difficulty-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: var(--text-sm);
  background: var(--surface);
  margin-top: var(--space-2);
}

/* Term grid */
.term-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: var(--space-4);
}

.term-card {
  background: var(--surface);
  padding: var(--space-4);
  border-radius: 8px;
  border-left: 3px solid var(--primary);
}

.term-card dt {
  font-weight: 700;
  color: var(--primary);
  margin-bottom: var(--space-1);
}

/* Code blocks */
.code-block {
  margin: var(--space-6) 0;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid var(--border);
}

.code-header {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-2) var(--space-4);
  background: #2c2c2c;
  color: #ccc;
  font-size: var(--text-sm);
}

.code-header .filename { flex: 1; font-family: var(--font-mono); }
.code-header .badge { color: #96f2d7; }
.copy-btn { background: none; border: none; cursor: pointer; font-size: 14px; }

.code-explanation {
  padding: var(--space-3) var(--space-4);
  background: var(--surface);
  font-size: var(--text-sm);
  border-top: 1px solid var(--border);
}

.try-it {
  padding: var(--space-3) var(--space-4);
  background: #fef9c3;
  font-size: var(--text-sm);
}

/* Exercise cards */
.exercise-card {
  background: var(--surface);
  border-radius: 12px;
  padding: var(--space-6);
  margin: var(--space-6) 0;
  border: 1px solid var(--border);
}

.exercise-header {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  flex-wrap: wrap;
}

.time-estimate, .difficulty {
  font-size: var(--text-sm);
  color: var(--text-secondary);
}

.stretch-goal {
  margin-top: var(--space-4);
  padding: var(--space-3);
  background: #f0fdf4;
  border-radius: 8px;
  font-size: var(--text-sm);
}

/* Checklist */
.checklist label {
  display: block;
  padding: var(--space-2) 0;
  cursor: pointer;
}

.checklist input[type="checkbox"] {
  margin-right: var(--space-2);
}

/* Resource cards */
.resource-cards {
  display: grid;
  gap: var(--space-3);
}

.resource-card {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: var(--space-3) var(--space-4);
  background: var(--surface);
  border-radius: 8px;
  text-decoration: none;
  color: inherit;
  border: 1px solid var(--border);
  transition: border-color 0.2s;
}

.resource-card:hover { border-color: var(--primary); }
.resource-type { font-size: var(--text-xs); color: var(--text-muted); }
.resource-title { font-weight: 600; }
.resource-meta { font-size: var(--text-sm); color: var(--text-secondary); }
```

---

## Quiz Types

### 1. Multiple Choice

**Purpose:** Test concept understanding

**JSON Structure:**
```json
{
  "id": "quiz-01",
  "type": "multiple-choice",
  "question": "What's the main difference between a Chatbot and an Agent?",
  "options": [
    {
      "id": "a",
      "text": "Chatbot is smarter",
      "correct": false,
      "feedback": "Not quite. Intelligence isn't the key difference."
    },
    {
      "id": "b",
      "text": "Agent can take autonomous actions in a loop",
      "correct": true,
      "feedback": "Correct! Agents perceive → decide → act in a continuous loop until the task is done."
    },
    {
      "id": "c",
      "text": "Agent is cheaper",
      "correct": false,
      "feedback": "Cost isn't the defining characteristic."
    }
  ],
  "explanation": "Agents differ from chatbots in their ability to autonomously take actions and iterate until a goal is achieved."
}
```

**HTML Template:**
```html
<div class="quiz-card" data-quiz-id="quiz-01">
  <h3 class="quiz-question">{{question}}</h3>
  <div class="quiz-options">
    {{#each options}}
    <button class="quiz-option" data-option-id="{{id}}">
      <span class="option-letter">{{id}})</span>
      <span class="option-text">{{text}}</span>
    </button>
    {{/each}}
  </div>
  <div class="quiz-feedback" style="display: none;"></div>
  <div class="quiz-explanation" style="display: none;">{{explanation}}</div>
</div>
```

### 2. Code Challenge

**Purpose:** Test practical application

**JSON Structure:**
```json
{
  "id": "challenge-01",
  "type": "code-challenge",
  "scenario": "You want to add a 'favorites' feature to your app. Users should be able to star items and see them in a separate list.",
  "question": "Which files would you need to modify?",
  "options": [
    {
      "file": "components/ItemCard.js",
      "needed": true,
      "reason": "Need to add star button UI"
    },
    {
      "file": "utils/api.js",
      "needed": true,
      "reason": "Need to call favorite/unfavorite endpoints"
    },
    {
      "file": "pages/login.js",
      "needed": false,
      "reason": "Login logic is unrelated to favorites"
    }
  ]
}
```

### 3. Reflection Question

**Purpose:** Personal application and deeper thinking

**JSON Structure:**
```json
{
  "id": "reflect-01",
  "type": "reflection",
  "prompt": "Think of a repetitive task you do every week. Could an Agent automate it? What tools would it need?",
  "hints": [
    "Consider: email management, data collection, report generation",
    "What information does the task require?",
    "What actions need to be taken?"
  ]
}
```

**HTML Template:**
```html
<div class="reflection-card">
  <h3>💭 Reflection</h3>
  <p class="reflection-prompt">{{prompt}}</p>
  <textarea class="reflection-input" placeholder="Your thoughts..."></textarea>
  <details class="reflection-hints">
    <summary>Need hints?</summary>
    <ul>
      {{#each hints}}
      <li>{{this}}</li>
      {{/each}}
    </ul>
  </details>
  <button class="save-reflection">Save</button>
</div>
```

### 4. Sorting Challenge

**Purpose:** Test understanding of sequences and relationships

**JSON Structure:**
```json
{
  "id": "sort-01",
  "type": "sorting",
  "question": "Put these steps in the correct order for the Perceive-Decide-Act loop:",
  "items": [
    {"id": 1, "text": "LLM analyzes task and plans actions", "order": 2},
    {"id": 2, "text": "Agent receives task and gathers context", "order": 1},
    {"id": 3, "text": "Execute tools and APIs", "order": 3},
    {"id": 4, "text": "Check if goal is achieved", "order": 4}
  ]
}
```

## Flashcard Types

### 1. Term → Definition

```json
{
  "id": "card-01",
  "type": "term-definition",
  "front": "Perceive-Decide-Act Loop",
  "back": "The core cycle of an AI Agent: observe environment → make decisions → take actions → repeat until goal is achieved",
  "category": "AI Agents",
  "difficulty": "beginner"
}
```

### 2. Scenario → Solution

```json
{
  "id": "card-02",
  "type": "scenario-solution",
  "front": "When should you use RAG instead of an Agent?",
  "back": "When you have a fixed document and need to find a specific answer (e.g., 'What is the return policy?'). No dynamic decision-making needed.",
  "category": "AI Agents",
  "difficulty": "intermediate"
}
```

### 3. Code → Explanation

```json
{
  "id": "card-03",
  "type": "code-explain",
  "front": "const agent = new Agent({ tools: [search, calculator] });",
  "back": "Creates an AI agent with access to search and calculator tools, allowing it to look up information and perform calculations during task execution.",
  "category": "Implementation",
  "difficulty": "intermediate"
}
```

## Progress Tracking

### Local Storage Schema

```json
{
  "userId": "local-user",
  "courseId": "ai-agents-2026",
  "progress": {
    "completedSections": ["week-01-day-01", "week-01-day-02"],
    "quizScores": {
      "quiz-01": {"score": 3, "total": 4, "attempts": 2},
      "quiz-02": {"score": 5, "total": 5, "attempts": 1}
    },
    "flashcardProgress": {
      "card-01": {"correct": 3, "incorrect": 1, "lastReviewed": "2026-03-25"},
      "card-02": {"correct": 1, "incorrect": 0, "lastReviewed": "2026-03-26"}
    },
    "reflections": {
      "reflect-01": "I could use an Agent to automatically collect analytics data and generate weekly reports..."
    },
    "currentSection": "week-01-day-03",
    "streak": 5,
    "lastVisit": "2026-03-26T08:30:00Z"
  }
}
```

### Progress Dashboard

```html
<div class="progress-dashboard">
  <div class="stat-card">
    <span class="stat-icon">🔥</span>
    <div class="stat-content">
      <div class="stat-value">{{streak}}</div>
      <div class="stat-label">Day Streak</div>
    </div>
  </div>
  
  <div class="stat-card">
    <span class="stat-icon">✅</span>
    <div class="stat-content">
      <div class="stat-value">{{completedSections.length}}/{{totalSections}}</div>
      <div class="stat-label">Lessons</div>
    </div>
  </div>
  
  <div class="stat-card">
    <span class="stat-icon">🎯</span>
    <div class="stat-content">
      <div class="stat-value">{{quizAccuracy}}%</div>
      <div class="stat-label">Quiz Accuracy</div>
    </div>
  </div>
  
  <div class="stat-card">
    <span class="stat-icon">📚</span>
    <div class="stat-content">
      <div class="stat-value">{{flashcardsReviewed}}</div>
      <div class="stat-label">Cards Reviewed</div>
    </div>
  </div>
</div>
```

## Animations

### 1. Progress Bar Fill

```javascript
function animateProgress(element, targetPercent) {
  let currentPercent = 0;
  const interval = setInterval(() => {
    if (currentPercent >= targetPercent) {
      clearInterval(interval);
      return;
    }
    currentPercent += 1;
    element.style.width = `${currentPercent}%`;
  }, 10);
}
```

### 2. Confetti on Quiz Success

```javascript
function celebrateSuccess() {
  const confetti = document.createElement('div');
  confetti.className = 'confetti-container';
  document.body.appendChild(confetti);
  
  for (let i = 0; i < 50; i++) {
    const piece = document.createElement('div');
    piece.className = 'confetti-piece';
    piece.style.left = `${Math.random() * 100}%`;
    piece.style.animationDelay = `${Math.random() * 0.5}s`;
    piece.style.backgroundColor = ['#c4825a', '#4a7c59', '#f4d35e', '#5b8fa3'][Math.floor(Math.random() * 4)];
    confetti.appendChild(piece);
  }
  
  setTimeout(() => confetti.remove(), 3000);
}
```

### 3. Card Flip Animation

```javascript
function flipFlashcard(card) {
  card.classList.toggle('flipped');
}

// Keyboard support
document.addEventListener('keydown', (e) => {
  if (e.code === 'Space' && document.querySelector('.flashcard')) {
    e.preventDefault();
    flipFlashcard(document.querySelector('.flashcard'));
  }
});
```

## Excalidraw Diagram Patterns

### Diagram Container (Standard Embed)

Use this pattern for all Excalidraw diagrams embedded in the course website:

```html
<figure class="diagram-container" data-diagram="{{diagramId}}">
  <img src="assets/diagrams/{{filename}}.png"
       alt="{{descriptive alt text}}"
       loading="lazy"
       class="diagram-img" />
  <figcaption>
    <span class="diagram-caption">{{title}}</span>
    <a href="https://github.com/{{user}}/{{repo}}/blob/main/diagrams/{{filename}}.excalidraw"
       class="edit-diagram-link" target="_blank" rel="noopener">
      ✏️ Edit this diagram
    </a>
  </figcaption>
</figure>
```

### Diagram Gallery (Multiple Diagrams Side-by-Side)

```html
<div class="diagram-gallery">
  <figure class="diagram-container">
    <img src="assets/diagrams/agent-overview.png" alt="..." loading="lazy" class="diagram-img" />
    <figcaption><span class="diagram-caption">Agent Overview</span></figcaption>
  </figure>
  <figure class="diagram-container">
    <img src="assets/diagrams/tool-calling.png" alt="..." loading="lazy" class="diagram-img" />
    <figcaption><span class="diagram-caption">Tool Calling</span></figcaption>
  </figure>
</div>
```

```css
.diagram-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: var(--space-6);
  margin: var(--space-8) 0;
}
```

### Zoomable Diagram (Complex Diagrams)

For diagrams with lots of detail, add zoom on click:

```html
<figure class="diagram-container diagram-zoomable" data-diagram="{{diagramId}}">
  <img src="assets/diagrams/{{filename}}.png"
       alt="{{descriptive alt text}}"
       loading="lazy"
       class="diagram-img"
       onclick="toggleDiagramZoom(this)" />
  <figcaption>
    <span class="diagram-caption">{{title}}</span>
    <span class="zoom-hint">🔍 Click to zoom</span>
  </figcaption>
</figure>
```

```javascript
function toggleDiagramZoom(img) {
  const overlay = document.createElement('div');
  overlay.className = 'diagram-overlay';
  overlay.innerHTML = `<img src="${img.src}" alt="${img.alt}" />`;
  overlay.onclick = () => overlay.remove();
  document.body.appendChild(overlay);
}
```

```css
.diagram-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.85);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  cursor: zoom-out;
  padding: var(--space-4);
}

.diagram-overlay img {
  max-width: 95vw;
  max-height: 95vh;
  object-fit: contain;
  border-radius: 8px;
}

.zoom-hint {
  font-size: var(--text-xs);
  color: var(--text-muted);
  cursor: pointer;
}
```

### Diagram Styles

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
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.diagram-img:hover {
  transform: scale(1.01);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.diagram-caption {
  font-family: var(--font-heading);
  font-size: var(--text-base);
  color: var(--text-primary);
}

.edit-diagram-link {
  display: inline-block;
  margin-left: var(--space-3);
  font-size: var(--text-sm);
  color: var(--text-secondary);
  text-decoration: none;
  opacity: 0.7;
  transition: opacity 0.2s, color 0.2s;
}

.edit-diagram-link:hover {
  color: var(--primary);
  opacity: 1;
}

/* Mobile: full-bleed diagrams */
@media (max-width: 768px) {
  .diagram-container {
    margin-left: calc(-1 * var(--space-4));
    margin-right: calc(-1 * var(--space-4));
  }
  .diagram-img {
    border-radius: 0;
    border-left: none;
    border-right: none;
  }
  .edit-diagram-link {
    display: block;
    margin: var(--space-2) 0 0 0;
  }
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  .diagram-img {
    filter: invert(0.88) hue-rotate(180deg);
  }
}
```

---

## Visualizations

### 1. Concept Map (SVG Inline — Legacy)

For simple inline concept maps without Excalidraw:

```html
<svg class="concept-map" viewBox="0 0 800 400">
  <!-- Central concept -->
  <circle cx="400" cy="200" r="60" fill="var(--primary)" />
  <text x="400" y="205" text-anchor="middle" fill="white" font-weight="bold">
    AI Agent
  </text>
  
  <!-- Connected concepts -->
  <g class="concept-node">
    <line x1="400" y1="200" x2="250" y2="100" stroke="var(--border)" stroke-width="2" />
    <circle cx="250" cy="100" r="40" fill="var(--accent-blue)" />
    <text x="250" y="105" text-anchor="middle" fill="white" font-size="14">
      Perceive
    </text>
  </g>
  
  <!-- Add more nodes... -->
</svg>
```

> **Prefer Excalidraw** for new diagrams. SVG inline is kept for backwards compatibility or very simple illustrations.

### 2. Timeline

```html
<div class="timeline">
  {{#each weeks}}
  <div class="timeline-item {{#if completed}}completed{{/if}}">
    <div class="timeline-marker">
      {{#if completed}}✅{{else}}📍{{/if}}
    </div>
    <div class="timeline-content">
      <h4>{{title}}</h4>
      <p>{{description}}</p>
      <div class="timeline-meta">
        <span>⏱️ {{estimatedTime}}</span>
        <span>📚 {{resourceCount}} resources</span>
      </div>
    </div>
  </div>
  {{/each}}
</div>
```

### 3. Knowledge Graph

Interactive D3.js visualization showing relationships between concepts.

```javascript
const data = {
  nodes: [
    { id: 'agent', label: 'AI Agent', category: 'core' },
    { id: 'tools', label: 'Tools', category: 'component' },
    { id: 'llm', label: 'LLM', category: 'component' },
    { id: 'pda', label: 'P-D-A Loop', category: 'concept' }
  ],
  links: [
    { source: 'agent', target: 'tools', type: 'uses' },
    { source: 'agent', target: 'llm', type: 'powered-by' },
    { source: 'agent', target: 'pda', type: 'implements' }
  ]
};

// Render with D3.js force simulation
```

## Keyboard Navigation

```javascript
const keyboardNav = {
  'ArrowRight': () => goToNextSection(),
  'ArrowLeft': () => goToPreviousSection(),
  'Space': () => toggleFlashcard(),
  'Enter': () => submitQuiz(),
  'r': () => retryQuiz(),
  'h': () => showHints()
};

document.addEventListener('keydown', (e) => {
  if (keyboardNav[e.key] && !e.target.matches('input, textarea')) {
    e.preventDefault();
    keyboardNav[e.key]();
  }
});
```

## Mobile Gestures

```javascript
let touchStartX = 0;
let touchEndX = 0;

document.addEventListener('touchstart', (e) => {
  touchStartX = e.changedTouches[0].screenX;
});

document.addEventListener('touchend', (e) => {
  touchEndX = e.changedTouches[0].screenX;
  handleSwipe();
});

function handleSwipe() {
  const swipeThreshold = 50;
  const diff = touchStartX - touchEndX;
  
  if (Math.abs(diff) > swipeThreshold) {
    if (diff > 0) {
      // Swipe left - next
      goToNextSection();
    } else {
      // Swipe right - previous
      goToPreviousSection();
    }
  }
}
```

## Accessibility

### Screen Reader Announcements

```javascript
function announce(message) {
  const liveRegion = document.getElementById('sr-live-region');
  liveRegion.textContent = message;
}

// Usage:
// announce('Quiz completed! You scored 4 out of 5.');
```

### ARIA Labels

```html
<button 
  class="quiz-option" 
  aria-label="Option A: Agent can take autonomous actions in a loop"
  aria-pressed="false"
  role="radio">
  A) Agent can take autonomous actions in a loop
</button>

<div 
  role="progressbar" 
  aria-valuenow="60" 
  aria-valuemin="0" 
  aria-valuemax="100"
  aria-label="Course progress: 60% complete">
  <div class="progress-fill" style="width: 60%;"></div>
</div>
```

## PWA (Progressive Web App)

Every course website is a PWA. Include these elements in every generated site.

### Manifest Link & Meta Tags (in `<head>`)

```html
<!-- PWA Manifest -->
<link rel="manifest" href="manifest.json">

<!-- Theme color (matches design system) -->
<meta name="theme-color" content="#c4825a">

<!-- iOS PWA support -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="{{courseName}}">
<link rel="apple-touch-icon" href="icons/apple-touch-icon-180.png">

<!-- Splash screen (iOS) -->
<link rel="apple-touch-startup-image" href="icons/splash-1170x2532.png"
      media="(device-width: 390px) and (device-height: 844px) and (-webkit-device-pixel-ratio: 3)">
```

### manifest.json Template

```json
{
  "name": "{{Course Full Name}}",
  "short_name": "{{Short Name}}",
  "description": "{{One-line course description}}",
  "start_url": "./index.html",
  "scope": "./",
  "display": "standalone",
  "orientation": "portrait-primary",
  "theme_color": "#c4825a",
  "background_color": "#f5f0eb",
  "icons": [
    {
      "src": "icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "icons/icon-192-maskable.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "maskable"
    },
    {
      "src": "icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "icons/icon-512-maskable.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable"
    }
  ],
  "categories": ["education"],
  "lang": "en"
}
```

### Service Worker Registration

```html
<script>
// Register service worker
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('./sw.js')
      .then(reg => {
        console.log('SW registered:', reg.scope);
        // Check for updates
        reg.addEventListener('updatefound', () => {
          const newWorker = reg.installing;
          newWorker.addEventListener('statechange', () => {
            if (newWorker.state === 'activated' && navigator.serviceWorker.controller) {
              showUpdateBanner();
            }
          });
        });
      })
      .catch(err => console.warn('SW registration failed:', err));
  });
}
</script>
```

### Service Worker (sw.js) Pattern

```javascript
const CACHE_NAME = '{{course-slug}}-v1';
const OFFLINE_URL = './offline.html';

// Assets to pre-cache on install
const PRECACHE_ASSETS = [
  './',
  './index.html',
  './offline.html',
  './manifest.json',
  './icons/icon-192.png',
  './icons/icon-512.png'
];

// Install: pre-cache core assets
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(PRECACHE_ASSETS))
  );
  self.skipWaiting();
});

// Activate: clean old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// Fetch: stale-while-revalidate for local assets
self.addEventListener('fetch', event => {
  const { request } = event;
  
  if (request.method !== 'GET') return;
  
  // Same-origin: stale-while-revalidate
  if (new URL(request.url).origin === location.origin) {
    event.respondWith(
      caches.open(CACHE_NAME).then(async cache => {
        const cached = await cache.match(request);
        const fetched = fetch(request).then(response => {
          if (response.ok) cache.put(request, response.clone());
          return response;
        }).catch(() => cached || caches.match(OFFLINE_URL));
        return cached || fetched;
      })
    );
  }
});
```

### Install Prompt UI

```html
<div id="install-banner" class="install-banner" style="display: none;">
  <div class="install-content">
    <span class="install-icon">📱</span>
    <div class="install-text">
      <strong>Install this course</strong>
      <span>Learn offline, anytime</span>
    </div>
    <button id="install-accept" class="install-btn">Install</button>
    <button id="install-dismiss" class="install-dismiss" aria-label="Dismiss">✕</button>
  </div>
</div>
```

```javascript
let deferredPrompt;

window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
  deferredPrompt = e;
  
  // Don't show if user dismissed before
  if (localStorage.getItem('pwa-install-dismissed')) return;
  
  // Don't show if already installed
  if (window.matchMedia('(display-mode: standalone)').matches) return;
  
  document.getElementById('install-banner').style.display = 'flex';
});

document.getElementById('install-accept')?.addEventListener('click', async () => {
  if (!deferredPrompt) return;
  deferredPrompt.prompt();
  const { outcome } = await deferredPrompt.userChoice;
  console.log('Install:', outcome);
  deferredPrompt = null;
  document.getElementById('install-banner').style.display = 'none';
});

document.getElementById('install-dismiss')?.addEventListener('click', () => {
  document.getElementById('install-banner').style.display = 'none';
  localStorage.setItem('pwa-install-dismissed', 'true');
});
```

```css
.install-banner {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: white;
  border-top: 2px solid var(--primary, #c4825a);
  padding: 12px 16px;
  display: flex;
  align-items: center;
  z-index: 999;
  box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
  animation: slideUp 0.3s ease-out;
}

@keyframes slideUp {
  from { transform: translateY(100%); }
  to { transform: translateY(0); }
}

.install-content {
  display: flex;
  align-items: center;
  gap: 12px;
  max-width: 600px;
  margin: 0 auto;
  width: 100%;
}

.install-icon { font-size: 28px; }

.install-text {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.install-text strong { font-size: 14px; }
.install-text span { font-size: 12px; color: var(--text-secondary, #666); }

.install-btn {
  background: var(--primary, #c4825a);
  color: white;
  border: none;
  padding: 8px 20px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  font-size: 14px;
}

.install-btn:hover { opacity: 0.9; }

.install-dismiss {
  background: none;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: var(--text-secondary, #999);
  padding: 4px 8px;
}
```

### Offline Fallback Page (offline.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Offline — {{Course Name}}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #f5f0eb;
      color: #2c2c2c;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 24px;
      text-align: center;
    }
    .offline-card {
      background: white;
      border-radius: 16px;
      padding: 48px 32px;
      max-width: 400px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    }
    .offline-icon { font-size: 64px; margin-bottom: 16px; }
    h1 { font-size: 24px; margin-bottom: 8px; }
    p { color: #666; margin-bottom: 24px; line-height: 1.5; }
    .retry-btn {
      background: #c4825a;
      color: white;
      border: none;
      padding: 12px 32px;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
    }
    .retry-btn:hover { opacity: 0.9; }
  </style>
</head>
<body>
  <div class="offline-card">
    <div class="offline-icon">📡</div>
    <h1>You're offline</h1>
    <p>This page hasn't been cached yet. Visit it once while online, and it'll be available offline next time.</p>
    <button class="retry-btn" onclick="location.reload()">Try again</button>
  </div>
</body>
</html>
```

### Icon Generation Guidelines

Generate icons using SVG-based approach (works without external tools):

```javascript
// Generate PWA icons using Canvas API
function generateIcon(size, text, bgColor = '#c4825a', textColor = '#fff') {
  const canvas = document.createElement('canvas');
  canvas.width = size;
  canvas.height = size;
  const ctx = canvas.getContext('2d');
  
  // Background
  ctx.fillStyle = bgColor;
  ctx.fillRect(0, 0, size, size);
  
  // Text/emoji centered
  ctx.fillStyle = textColor;
  ctx.font = `bold ${size * 0.4}px -apple-system, sans-serif`;
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(text, size / 2, size / 2);
  
  return canvas.toDataURL('image/png');
}
```

**Required icon sizes:**
- `icon-192.png` (192×192) — Home screen icon
- `icon-512.png` (512×512) — Splash screen
- `icon-192-maskable.png` (192×192) — Android adaptive icon (extra padding)
- `icon-512-maskable.png` (512×512) — Android adaptive icon (extra padding)
- `apple-touch-icon-180.png` (180×180) — iOS home screen

**Maskable icons:** Keep the important content within the center 80% (safe zone). The outer 20% may be cropped by the OS into circles, rounded squares, etc.

### Update Banner (when new content is available)

```javascript
function showUpdateBanner() {
  const banner = document.createElement('div');
  banner.className = 'update-banner';
  banner.innerHTML = `
    <span>🔄 New content available!</span>
    <button onclick="location.reload()">Refresh</button>
    <button onclick="this.parentElement.remove()">Later</button>
  `;
  document.body.appendChild(banner);
}
```

```css
.update-banner {
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
  background: #2c2c2c;
  color: white;
  padding: 12px 20px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  gap: 12px;
  z-index: 1000;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
  font-size: 14px;
}

.update-banner button {
  background: white;
  color: #2c2c2c;
  border: none;
  padding: 6px 14px;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  font-size: 13px;
}
```

> **Full PWA implementation guide:** See `references/pwa-setup.md` for complete details on service worker strategies, iOS/Android differences, testing checklist, and production best practices.

---

## Data Export

### Export Progress as JSON

```javascript
function exportProgress() {
  const data = localStorage.getItem('courseProgress');
  const blob = new Blob([data], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'learning-progress.json';
  a.click();
}
```

### Export Flashcards for Anki

```javascript
function exportToAnki() {
  const cards = getAllFlashcards();
  const ankiFormat = cards.map(card => ({
    front: card.front,
    back: card.back,
    tags: [card.category, card.difficulty]
  }));
  
  const csv = ankiFormat.map(c => 
    `"${c.front}","${c.back}","${c.tags.join(' ')}"`
  ).join('\n');
  
  downloadFile('flashcards.csv', csv);
}
```
