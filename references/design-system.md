# Design System

Visual language for learning-to-course websites. Warm, inviting, not the typical purple-gradient AI look.

## Color Palette

```css
:root {
  /* Primary - Warm terracotta (focus, CTAs) */
  --primary: #c4825a;
  --primary-hover: #b07149;
  
  /* Background - Warm cream */
  --bg-base: #f5f0eb;
  --bg-card: #ffffff;
  --bg-hover: #fef9f5;
  
  /* Text */
  --text-primary: #2d2d2d;
  --text-secondary: #6b6b6b;
  --text-muted: #999999;
  
  /* Accents */
  --accent-green: #4a7c59; /* completed */
  --accent-yellow: #f4d35e; /* in progress */
  --accent-blue: #5b8fa3; /* resources */
  --accent-red: #c86b5a; /* challenges */
  
  /* Borders */
  --border: #e5ddd5;
  --border-light: #f0ebe6;
}
```

## Typography

```css
/* Headings - Serif for warmth */
--font-heading: 'Noto Serif SC', 'Crimson Pro', Georgia, serif;

/* Body - Clean sans-serif */
--font-body: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;

/* Code - Monospace */
--font-code: 'JetBrains Mono', 'Fira Code', monospace;

/* Sizes */
--text-xs: 0.75rem;   /* 12px */
--text-sm: 0.875rem;  /* 14px */
--text-base: 1rem;    /* 16px */
--text-lg: 1.125rem;  /* 18px */
--text-xl: 1.25rem;   /* 20px */
--text-2xl: 1.5rem;   /* 24px */
--text-3xl: 2rem;     /* 32px */
--text-4xl: 2.5rem;   /* 40px */
```

## Spacing

```css
--space-1: 0.25rem;  /* 4px */
--space-2: 0.5rem;   /* 8px */
--space-3: 0.75rem;  /* 12px */
--space-4: 1rem;     /* 16px */
--space-6: 1.5rem;   /* 24px */
--space-8: 2rem;     /* 32px */
--space-12: 3rem;    /* 48px */
--space-16: 4rem;    /* 64px */
```

## Components

### Resource Card
```css
.resource-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 12px;
  padding: var(--space-6);
  transition: all 0.2s;
}

.resource-card:hover {
  background: var(--bg-hover);
  border-color: var(--primary);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(196, 130, 90, 0.1);
}
```

### Progress Bar
```css
.progress-bar {
  height: 8px;
  background: var(--border-light);
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--accent-green), var(--primary));
  transition: width 0.3s ease;
}
```

### Quiz Card
```css
.quiz-card {
  background: var(--bg-card);
  border-left: 4px solid var(--accent-blue);
  padding: var(--space-6);
  border-radius: 8px;
  margin: var(--space-4) 0;
}

.quiz-option {
  padding: var(--space-3) var(--space-4);
  border: 2px solid var(--border);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.quiz-option:hover {
  border-color: var(--primary);
  background: var(--bg-hover);
}

.quiz-option.correct {
  border-color: var(--accent-green);
  background: rgba(74, 124, 89, 0.1);
}

.quiz-option.incorrect {
  border-color: var(--accent-red);
  background: rgba(200, 107, 90, 0.1);
}
```

### Flashcard
```css
.flashcard {
  perspective: 1000px;
  min-height: 200px;
}

.flashcard-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transition: transform 0.6s;
  transform-style: preserve-3d;
}

.flashcard.flipped .flashcard-inner {
  transform: rotateY(180deg);
}

.flashcard-front,
.flashcard-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  border-radius: 12px;
  padding: var(--space-8);
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.flashcard-front {
  background: var(--bg-card);
  border: 2px solid var(--primary);
}

.flashcard-back {
  background: var(--primary);
  color: white;
  transform: rotateY(180deg);
}
```

## Layout

### Mobile-first Grid
```css
.content-grid {
  display: grid;
  gap: var(--space-6);
  max-width: 1200px;
  margin: 0 auto;
  padding: var(--space-6);
}

/* Mobile: single column */
@media (min-width: 768px) {
  .content-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .content-grid {
    grid-template-columns: repeat(3, 1fr);
    padding: var(--space-8);
  }
}
```

### Sidebar Layout
```css
.layout-sidebar {
  display: grid;
  gap: var(--space-6);
}

@media (min-width: 1024px) {
  .layout-sidebar {
    grid-template-columns: 280px 1fr;
  }
}
```

## Animations

### Fade In
```css
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in {
  animation: fadeIn 0.5s ease-out;
}
```

### Pulse (for current section)
```css
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.6;
  }
}

.pulse {
  animation: pulse 2s ease-in-out infinite;
}
```

## Icons

Use emoji for quick visual cues:
- ✅ Completed
- 📚 Resource
- 🎯 Quiz
- 💡 Key concept
- ⏱️ Time estimate
- 🎓 Certificate
- 🔥 Streak
- ⭐ Favorite

## Accessibility

```css
/* Focus states */
:focus-visible {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
}

/* Skip to content */
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: var(--primary);
  color: white;
  padding: var(--space-2) var(--space-4);
  text-decoration: none;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}

/* Reduced motion */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## Print Styles

```css
@media print {
  .no-print {
    display: none !important;
  }
  
  body {
    background: white;
    color: black;
  }
  
  .resource-card,
  .quiz-card {
    border: 1px solid #000;
    page-break-inside: avoid;
  }
}
```
