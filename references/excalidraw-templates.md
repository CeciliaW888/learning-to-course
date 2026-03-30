# Excalidraw Diagram Templates

Ready-to-use templates for course diagrams. Each template includes the Excalidraw JSON structure and MCP commands to generate it.

## Color Palette (Consistent Across All Diagrams)

```
Primary Blue:    #a5d8ff  (frameworks, process steps)
Primary Purple:  #b197fc  (core concepts, agents)
Green:           #96f2d7  (solutions, outputs, success)
Yellow:          #ffd43b  (attention, titles, highlights)
Red/Pink:        #ffa8a8  (problems, risks, inputs)
Orange:          #ffc078  (tools, actions)
Gray:            #dee2e6  (background elements, connectors)
White:           #ffffff  (text backgrounds)
Dark text:       #1e1e1e  (labels)
```

---

## 1. Perceive-Decide-Act Loop

**Use for:** Week 1 foundations, explaining the core agent cycle

**Layout:** Circular flowchart with 3 main nodes + center hub

### MCP Commands

```bash
# Center hub
mcporter call excalidraw.create_element \
  type=ellipse x:350 y:180 width:120 height:120 \
  backgroundColor="#b197fc" text="AI Agent" fontSize:18

# Perceive node (top-left)
mcporter call excalidraw.create_element \
  type=rectangle x:100 y:50 width:180 height:80 \
  backgroundColor="#a5d8ff" text="👁 Perceive\nObserve environment" \
  fontSize:14 roundness:12

# Decide node (top-right)
mcporter call excalidraw.create_element \
  type=rectangle x:540 y:50 width:180 height:80 \
  backgroundColor="#ffd43b" text="🧠 Decide\nPlan next action" \
  fontSize:14 roundness:12

# Act node (bottom)
mcporter call excalidraw.create_element \
  type=rectangle x:320 y:380 width:180 height:80 \
  backgroundColor="#96f2d7" text="⚡ Act\nExecute tools" \
  fontSize:14 roundness:12

# Check node (right)
mcporter call excalidraw.create_element \
  type=diamond x:580 y:280 width:140 height:100 \
  backgroundColor="#ffa8a8" text="Goal\nachieved?" fontSize:13

# Done node
mcporter call excalidraw.create_element \
  type=rectangle x:620 y:420 width:120 height:50 \
  backgroundColor="#96f2d7" text="✅ Done" fontSize:14 roundness:8

# Arrows: Perceive → Decide → Act → Check → loop back or Done
mcporter call excalidraw.create_element type=arrow startX:280 startY:90 endX:540 endY:90
mcporter call excalidraw.create_element type=arrow startX:630 startY:130 endX:500 endY:380
mcporter call excalidraw.create_element type=arrow startX:320 startY:420 endX:200 endY:130
mcporter call excalidraw.create_element type=arrow startX:500 startY:420 endX:580 endY:330
mcporter call excalidraw.create_element type=arrow startX:680 startY:380 endX:680 endY:420
```

### Excalidraw JSON Template

```json
{
  "type": "excalidraw",
  "version": 2,
  "appState": { "viewBackgroundColor": "#ffffff" },
  "elements": [
    {
      "type": "ellipse",
      "x": 350, "y": 180,
      "width": 120, "height": 120,
      "backgroundColor": "#b197fc",
      "strokeColor": "#1e1e1e",
      "strokeWidth": 2,
      "label": { "text": "AI Agent", "fontSize": 18, "fontFamily": 1 }
    },
    {
      "type": "rectangle",
      "x": 100, "y": 50,
      "width": 180, "height": 80,
      "backgroundColor": "#a5d8ff",
      "roundness": { "type": 3, "value": 12 },
      "label": { "text": "👁 Perceive\nObserve environment", "fontSize": 14 }
    },
    {
      "type": "rectangle",
      "x": 540, "y": 50,
      "width": 180, "height": 80,
      "backgroundColor": "#ffd43b",
      "roundness": { "type": 3, "value": 12 },
      "label": { "text": "🧠 Decide\nPlan next action", "fontSize": 14 }
    },
    {
      "type": "rectangle",
      "x": 320, "y": 380,
      "width": 180, "height": 80,
      "backgroundColor": "#96f2d7",
      "roundness": { "type": 3, "value": 12 },
      "label": { "text": "⚡ Act\nExecute tools", "fontSize": 14 }
    },
    {
      "type": "diamond",
      "x": 580, "y": 280,
      "width": 140, "height": 100,
      "backgroundColor": "#ffa8a8",
      "label": { "text": "Goal\nachieved?", "fontSize": 13 }
    }
  ]
}
```

---

## 2. Agent vs Chatbot vs RAG Comparison

**Use for:** Week 1, explaining when to use each approach

**Layout:** 3-column comparison with feature rows

### MCP Commands

```bash
# Column headers
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:30 width:220 height:60 \
  backgroundColor="#ffa8a8" text="💬 Chatbot" fontSize:18 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:300 y:30 width:220 height:60 \
  backgroundColor="#a5d8ff" text="📚 RAG" fontSize:18 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:550 y:30 width:220 height:60 \
  backgroundColor="#b197fc" text="🤖 Agent" fontSize:18 roundness:8

# Feature rows (repeat pattern for each feature)
# Row 1: Memory
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:110 width:220 height:50 \
  backgroundColor="#ffffff" text="Session only" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:300 y:110 width:220 height:50 \
  backgroundColor="#ffffff" text="Document context" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:550 y:110 width:220 height:50 \
  backgroundColor="#ffffff" text="Persistent + dynamic" fontSize:13

# Row 2: Actions
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:175 width:220 height:50 \
  backgroundColor="#ffffff" text="Text responses" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:300 y:175 width:220 height:50 \
  backgroundColor="#ffffff" text="Search + respond" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:550 y:175 width:220 height:50 \
  backgroundColor="#ffffff" text="Tools, APIs, code" fontSize:13

# Row 3: Autonomy
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:240 width:220 height:50 \
  backgroundColor="#ffffff" text="❌ None" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:300 y:240 width:220 height:50 \
  backgroundColor="#ffffff" text="⚠️ Limited" fontSize:13

mcporter call excalidraw.create_element \
  type=rectangle x:550 y:240 width:220 height:50 \
  backgroundColor="#ffffff" text="✅ Full loop" fontSize:13

# Row labels (left side)
mcporter call excalidraw.create_element \
  type=text x:-80 y:120 text="Memory" fontSize:13
mcporter call excalidraw.create_element \
  type=text x:-80 y:185 text="Actions" fontSize:13
mcporter call excalidraw.create_element \
  type=text x:-80 y:250 text="Autonomy" fontSize:13
```

---

## 3. Tool Calling Architecture

**Use for:** Week 2, explaining how agents use tools

**Layout:** Vertical flow — LLM at top, tool router in middle, tools at bottom

### MCP Commands

```bash
# User input (top)
mcporter call excalidraw.create_element \
  type=rectangle x:280 y:20 width:200 height:60 \
  backgroundColor="#ffa8a8" text="👤 User Request" fontSize:14 roundness:8

# LLM brain
mcporter call excalidraw.create_element \
  type=rectangle x:250 y:120 width:260 height:80 \
  backgroundColor="#b197fc" text="🧠 LLM\nParse intent → Select tool → Format args" \
  fontSize:13 roundness:12

# Tool router
mcporter call excalidraw.create_element \
  type=diamond x:310 y:240 width:140 height:80 \
  backgroundColor="#ffd43b" text="Router" fontSize:14

# Tools (bottom row)
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:360 width:140 height:60 \
  backgroundColor="#96f2d7" text="🔍 Search API" fontSize:12 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:220 y:360 width:140 height:60 \
  backgroundColor="#96f2d7" text="🧮 Calculator" fontSize:12 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:390 y:360 width:140 height:60 \
  backgroundColor="#96f2d7" text="💾 Database" fontSize:12 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:560 y:360 width:140 height:60 \
  backgroundColor="#96f2d7" text="📧 Email API" fontSize:12 roundness:8

# Response aggregator
mcporter call excalidraw.create_element \
  type=rectangle x:280 y:470 width:200 height:60 \
  backgroundColor="#a5d8ff" text="📤 Response\nFormat + deliver to user" \
  fontSize:13 roundness:8

# Arrows
mcporter call excalidraw.create_element type=arrow startX:380 startY:80 endX:380 endY:120
mcporter call excalidraw.create_element type=arrow startX:380 startY:200 endX:380 endY:240
mcporter call excalidraw.create_element type=arrow startX:310 startY:280 endX:120 endY:360
mcporter call excalidraw.create_element type=arrow startX:350 startY:320 endX:290 endY:360
mcporter call excalidraw.create_element type=arrow startX:410 startY:320 endX:460 endY:360
mcporter call excalidraw.create_element type=arrow startX:450 startY:280 endX:630 endY:360
mcporter call excalidraw.create_element type=arrow startX:380 startY:420 endX:380 endY:470
```

---

## 4. Multi-Agent Collaboration Network

**Use for:** Week 3, advanced multi-agent architectures

**Layout:** Hub-and-spoke with orchestrator in center

### MCP Commands

```bash
# Orchestrator (center)
mcporter call excalidraw.create_element \
  type=ellipse x:300 y:200 width:160 height:100 \
  backgroundColor="#b197fc" text="🎯 Orchestrator\nAgent" fontSize:14

# Specialist agents (surrounding)
mcporter call excalidraw.create_element \
  type=rectangle x:100 y:40 width:160 height:70 \
  backgroundColor="#a5d8ff" text="🔍 Research\nAgent" fontSize:13 roundness:10

mcporter call excalidraw.create_element \
  type=rectangle x:500 y:40 width:160 height:70 \
  backgroundColor="#96f2d7" text="✍️ Writing\nAgent" fontSize:13 roundness:10

mcporter call excalidraw.create_element \
  type=rectangle x:550 y:220 width:160 height:70 \
  backgroundColor="#ffc078" text="🔧 Code\nAgent" fontSize:13 roundness:10

mcporter call excalidraw.create_element \
  type=rectangle x:500 y:380 width:160 height:70 \
  backgroundColor="#ffa8a8" text="🔍 QA\nAgent" fontSize:13 roundness:10

mcporter call excalidraw.create_element \
  type=rectangle x:100 y:380 width:160 height:70 \
  backgroundColor="#ffd43b" text="📊 Analysis\nAgent" fontSize:13 roundness:10

mcporter call excalidraw.create_element \
  type=rectangle x:30 y:220 width:160 height:70 \
  backgroundColor="#dee2e6" text="💾 Memory\nAgent" fontSize:13 roundness:10

# Shared context (bottom)
mcporter call excalidraw.create_element \
  type=rectangle x:220 y:490 width:320 height:50 \
  backgroundColor="#dee2e6" text="📋 Shared Context / Message Bus" fontSize:13 roundness:8

# Bidirectional arrows from orchestrator to each agent
# (create arrows connecting center to each specialist)
```

---

## 5. Concept Relationship Map (Weekly)

**Use for:** End of each week, connecting all concepts learned

**Layout:** Mind-map style with central topic and branching concepts

### MCP Commands (Example: Week 1)

```bash
# Central topic
mcporter call excalidraw.create_element \
  type=ellipse x:320 y:200 width:180 height:100 \
  backgroundColor="#b197fc" text="Week 1\nAI Agent\nFoundations" fontSize:15

# Branch 1: What is an Agent?
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:50 width:160 height:50 \
  backgroundColor="#a5d8ff" text="What is an Agent?" fontSize:13 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:10 y:120 width:120 height:40 \
  backgroundColor="#ffffff" text="Autonomy" fontSize:11 roundness:6

mcporter call excalidraw.create_element \
  type=rectangle x:140 y:120 width:120 height:40 \
  backgroundColor="#ffffff" text="Goal-oriented" fontSize:11 roundness:6

# Branch 2: PDA Loop
mcporter call excalidraw.create_element \
  type=rectangle x:580 y:50 width:160 height:50 \
  backgroundColor="#ffd43b" text="PDA Loop" fontSize:13 roundness:8

mcporter call excalidraw.create_element \
  type=rectangle x:560 y:120 width:80 height:35 \
  backgroundColor="#ffffff" text="Perceive" fontSize:10 roundness:6

mcporter call excalidraw.create_element \
  type=rectangle x:650 y:120 width:70 height:35 \
  backgroundColor="#ffffff" text="Decide" fontSize:10 roundness:6

mcporter call excalidraw.create_element \
  type=rectangle x:730 y:120 width:60 height:35 \
  backgroundColor="#ffffff" text="Act" fontSize:10 roundness:6

# Branch 3: vs Chatbot/RAG
mcporter call excalidraw.create_element \
  type=rectangle x:50 y:350 width:160 height:50 \
  backgroundColor="#ffa8a8" text="vs Chatbot vs RAG" fontSize:13 roundness:8

# Branch 4: Key Tools
mcporter call excalidraw.create_element \
  type=rectangle x:580 y:350 width:160 height:50 \
  backgroundColor="#96f2d7" text="Key Tools" fontSize:13 roundness:8

# Connect with arrows from center to each branch
```

---

## General Template Guidelines

### Layout Rules
- **Min spacing:** 20px between elements
- **Max elements:** 8-10 per diagram (split if complex)
- **Alignment:** Use `mcporter call excalidraw.align_elements` after placing
- **Distribution:** Use `mcporter call excalidraw.distribute_elements` for even spacing

### Text Rules
- **Titles:** 18px, bold
- **Labels:** 13-14px, regular
- **Sub-labels:** 11px, regular
- **Max 3 lines** per element text
- **Use emoji** sparingly for quick visual identification

### Arrow Rules
- **Flow direction:** Top-to-bottom or left-to-right
- **Stroke width:** 2px for primary flow, 1px for secondary
- **Labels on arrows:** Only when relationship isn't obvious

### Export Checklist
1. ✅ All elements properly aligned and distributed
2. ✅ No overlapping text
3. ✅ Color palette matches design system
4. ✅ Exported at both `.excalidraw` (source) and `.png` (website)
5. ✅ Alt text written for HTML embed
6. ✅ Mobile preview checked (diagram readable at 375px width)

---

## Generating Diagrams Programmatically

For automated course generation, create diagrams by writing `.excalidraw` JSON directly:

```javascript
function generateConceptMap(weekNumber, concepts) {
  const elements = [];
  const centerX = 400, centerY = 300;
  
  // Central node
  elements.push({
    type: "ellipse",
    x: centerX - 90, y: centerY - 50,
    width: 180, height: 100,
    backgroundColor: "#b197fc",
    label: { text: `Week ${weekNumber}\nConcepts`, fontSize: 16 }
  });
  
  // Surrounding concept nodes
  const angleStep = (2 * Math.PI) / concepts.length;
  const radius = 220;
  
  concepts.forEach((concept, i) => {
    const angle = angleStep * i - Math.PI / 2;
    const x = centerX + radius * Math.cos(angle) - 80;
    const y = centerY + radius * Math.sin(angle) - 30;
    
    elements.push({
      type: "rectangle",
      x, y, width: 160, height: 60,
      backgroundColor: concept.color || "#a5d8ff",
      roundness: { type: 3, value: 10 },
      label: { text: concept.name, fontSize: 13 }
    });
    
    // Arrow from center to concept
    elements.push({
      type: "arrow",
      x: centerX, y: centerY,
      points: [[0, 0], [x + 80 - centerX, y + 30 - centerY]],
      strokeWidth: 2
    });
  });
  
  return {
    type: "excalidraw",
    version: 2,
    appState: { viewBackgroundColor: "#ffffff" },
    elements
  };
}
```

This can be used in the build step to auto-generate concept maps from curriculum data.
