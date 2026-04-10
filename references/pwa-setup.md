# PWA Setup Guide

Complete implementation guide for making every learning-to-course website a Progressive Web App.

**This is a CORE feature.** Every generated course website MUST be a PWA. No exceptions.

---

## Quick Checklist

Before shipping, verify ALL of these:

- [ ] `manifest.json` linked in `<head>`
- [ ] `sw.js` registered on page load
- [ ] `offline.html` fallback page created
- [ ] Icons: 192×192, 512×512, maskable versions, apple-touch-icon
- [ ] `<meta name="theme-color">` set
- [ ] Apple-specific meta tags for iOS
- [ ] Install prompt banner with dismiss logic
- [ ] Service worker pre-caches core assets
- [ ] Tested in Chrome DevTools → Application → Manifest
- [ ] Tested in Lighthouse (PWA audit score 100)
- [ ] Tested on actual mobile device

---

## File Structure

```
website/
├── index.html          # Main course page (includes SW registration + install prompt)
├── manifest.json       # PWA manifest
├── sw.js               # Service worker
├── offline.html        # Offline fallback page
└── icons/
    ├── icon-192.png           # Home screen (Android/desktop)
    ├── icon-512.png           # Splash screen (Android)
    ├── icon-192-maskable.png  # Android adaptive icon
    ├── icon-512-maskable.png  # Android adaptive icon
    └── apple-touch-icon-180.png  # iOS home screen
```

---

## 1. manifest.json — Full Structure

```json
{
  "name": "[Full Course Name — e.g. AI Agent Learning Path]",
  "short_name": "[Max 12 chars — e.g. AI Agents]",
  "description": "[One-line course description]",
  "start_url": "./index.html",
  "scope": "./",
  "id": "./",
  "display": "standalone",
  "orientation": "portrait-primary",
  "theme_color": "#c4825a",
  "background_color": "#f5f0eb",
  "categories": ["education"],
  "lang": "en",
  "dir": "ltr",
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
  ]
}
```

### Field Reference

| Field | Required | Notes |
|-------|----------|-------|
| `name` | Yes | Full app name shown in install dialog and app drawer |
| `short_name` | Yes | Shown below icon on home screen. Max ~12 chars. |
| `description` | Yes | Used by app stores and install UI |
| `start_url` | Yes | Use `./index.html` for relative paths (works on any host) |
| `scope` | Yes | `./` keeps navigation within the course folder |
| `id` | Recommended | Stable identity for the app. Use `./` |
| `display` | Yes | Always `standalone` (no browser chrome) |
| `orientation` | Optional | `portrait-primary` for course reading; omit for flexible |
| `theme_color` | Yes | Browser UI color. Use `#c4825a` (terracotta) |
| `background_color` | Yes | Splash screen BG. Use `#f5f0eb` (warm cream) |
| `categories` | Optional | `["education"]` for app store hints |
| `icons` | Yes | Minimum: 192 + 512 (both any + maskable) |

### Adapting for Chinese-language courses

```json
{
  "name": "AI Agent 学习路径",
  "short_name": "AI Agent",
  "lang": "zh-CN",
  "dir": "ltr"
}
```

---

## 2. HTML `<head>` Tags

Add ALL of these to `index.html`:

```html
<!-- PWA Manifest -->
<link rel="manifest" href="manifest.json">

<!-- Theme color -->
<meta name="theme-color" content="#c4825a">

<!-- iOS PWA support (Safari doesn't read manifest for these) -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="{{short_name}}">
<link rel="apple-touch-icon" href="icons/apple-touch-icon-180.png">

<!-- Favicon fallback -->
<link rel="icon" type="image/png" sizes="192x192" href="icons/icon-192.png">
```

### Why each tag matters

- **`manifest`** — Required for Chrome/Edge/Samsung to recognize as PWA
- **`theme-color`** — Colors the browser toolbar and task switcher
- **`apple-mobile-web-app-capable`** — Enables standalone mode on iOS
- **`apple-mobile-web-app-status-bar-style`** — `black-translucent` lets content flow under status bar
- **`apple-mobile-web-app-title`** — iOS ignores `short_name` in manifest; needs this
- **`apple-touch-icon`** — iOS ignores manifest icons; needs this specific link

---

## 3. Service Worker (sw.js)

### Caching Strategies

Use different strategies based on resource type:

| Resource Type | Strategy | Why |
|---------------|----------|-----|
| index.html, module HTML files | **Network-first** | Users always see latest content; module updates visible immediately |
| CSS, JS (local) | **Stale-while-revalidate** | Instant load from cache + background refresh |
| Fonts, icons, images | **Cache-first** | Immutable resources, cache forever |
| External CDN resources | **Network-first** | Want freshest version, fall back to cache |
| Navigation (HTML pages) | **Network-first** | Fall back to offline.html |

### Complete Service Worker

```javascript
// ============================================
// Service Worker for {{Course Name}}
// Strategy: Offline-first with smart caching
// ============================================

const CACHE_VERSION = 1;
const CACHE_NAME = `{{course-slug}}-v${CACHE_VERSION}`;
const OFFLINE_URL = './offline.html';

// Pre-cache on install (critical path resources)
// IMPORTANT: Include ALL module HTML files, data JSONs, and diagram SVGs.
// Missing assets = broken offline mode. Generate this list from the course
// structure — one entry per module, quiz file, flashcard file, and SVG.
const PRECACHE_URLS = [
  './',
  './index.html',
  './offline.html',
  './manifest.json',
  './styles.css',
  './main.js',
  './icons/icon-192.png',
  './icons/icon-512.png',
  './icons/icon-192-maskable.png',
  './icons/icon-512-maskable.png',
  './icons/apple-touch-icon.png',
  // Module HTML fragments (one per day — lazy-loaded by accordion)
  './modules/01-topic.html',
  // ... add all ./modules/XX-*.html
  // Quiz and flashcard data
  './data/flashcards.json',
  './data/quiz-01.json',
  // ... add all ./data/quiz-XX.json
  // Diagram SVG exports
  './diagrams/example.svg',
  // ... add all ./diagrams/*.svg
];

// ---- INSTALL ----
// Pre-cache critical resources
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(PRECACHE_URLS))
      .then(() => self.skipWaiting())
  );
});

// ---- ACTIVATE ----
// Clean up old cache versions
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames =>
      Promise.all(
        cacheNames
          .filter(name => name.startsWith('{{course-slug}}-') && name !== CACHE_NAME)
          .map(name => caches.delete(name))
      )
    ).then(() => self.clients.claim())
  );
});

// ---- FETCH ----
self.addEventListener('fetch', event => {
  const { request } = event;

  // Only handle GET requests
  if (request.method !== 'GET') return;

  const url = new URL(request.url);

  // Navigation requests: network-first with offline fallback
  if (request.mode === 'navigate') {
    event.respondWith(
      fetch(request)
        .then(response => {
          // Cache successful navigation responses
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(request, clone));
          return response;
        })
        .catch(() => caches.match(request).then(cached => cached || caches.match(OFFLINE_URL)))
    );
    return;
  }

  // Same-origin assets: stale-while-revalidate
  if (url.origin === self.location.origin) {
    event.respondWith(staleWhileRevalidate(request));
    return;
  }

  // External resources (fonts, CDNs): cache-first with network fallback
  event.respondWith(cacheFirst(request));
});

// ---- STRATEGIES ----

// Stale-while-revalidate: return cached immediately, update in background
async function staleWhileRevalidate(request) {
  const cache = await caches.open(CACHE_NAME);
  const cached = await cache.match(request);

  const fetchPromise = fetch(request).then(response => {
    if (response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  }).catch(() => null);

  // Return cached version instantly if available, otherwise wait for network
  return cached || fetchPromise || caches.match(OFFLINE_URL);
}

// Cache-first: check cache, only fetch if not cached
async function cacheFirst(request) {
  const cached = await caches.match(request);
  if (cached) return cached;

  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    return response;
  } catch {
    return new Response('', { status: 408, statusText: 'Offline' });
  }
}
```

### Service Worker Strategy

Use **network-first for HTML**, **cache-first for static assets**:

```javascript
self.addEventListener('fetch', (event) => {
  // Network-first for HTML (always get latest content)
  if (event.request.mode === 'navigate' || event.request.url.endsWith('.html')) {
    event.respondWith(
      fetch(event.request)
        .then((response) => {
          const clone = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
          return response;
        })
        .catch(() => caches.match(event.request).then(r => r || caches.match('./offline.html')))
    );
    return;
  }
  // Cache-first for static assets (CSS, JS, images, fonts)
  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        if (response) return response;
        return fetch(event.request).then((response) => {
          if (!response || response.status !== 200 || response.type !== 'basic') return response;
          const clone = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
          return response;
        });
      })
      .catch(() => { /* no fallback for non-navigation requests */ })
  );
});
```

**Why this matters:**
- Cache-first for HTML means users never see updates until the SW itself changes
- Returning `offline.html` for non-navigation requests (like module fetches) causes the offline page content to be injected as lesson content and marked as "loaded"
- Network-first ensures module HTML updates are always visible
- Static assets (CSS/JS/images) rarely change, so cache-first is correct for them

### Versioning Strategy

When course content updates:
1. Increment `CACHE_VERSION` in sw.js
2. The activate event automatically cleans old caches
3. Users see the update banner (see interactive-elements.md)

---

## 4. Icons

### Required Sizes

| File | Size | Purpose | Notes |
|------|------|---------|-------|
| `icon-192.png` | 192×192 | Home screen (Android/desktop) | Standard icon |
| `icon-512.png` | 512×512 | Splash screen (Android) | Also used in install dialog |
| `icon-192-maskable.png` | 192×192 | Android adaptive icon | Content in center 80% |
| `icon-512-maskable.png` | 512×512 | Android adaptive icon | Content in center 80% |
| `apple-touch-icon-180.png` | 180×180 | iOS home screen | Linked via `<link>` tag |

### Maskable Icon Safe Zone

Maskable icons are cropped differently by each Android launcher (circle, rounded square, squircle, etc.). Keep ALL important content within the center **80%** of the canvas.

```
┌─────────────────────┐
│     DANGER ZONE     │ ← 10% padding on each side
│  ┌───────────────┐  │
│  │               │  │
│  │   SAFE ZONE   │  │ ← Center 80% — put icon/text here
│  │    (80%)      │  │
│  │               │  │
│  └───────────────┘  │
│     DANGER ZONE     │
└─────────────────────┘
```

### Generating Icons with SVG (No External Tools)

For simple course icons, generate inline SVG and convert:

```html
<!-- Icon as inline SVG — screenshot or convert to PNG -->
<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg">
  <rect width="512" height="512" rx="0" fill="#c4825a"/>
  <text x="256" y="280" text-anchor="middle" font-size="200"
        font-family="-apple-system, sans-serif" fill="white">🤖</text>
</svg>
```

### Generating Icons with Canvas API

```javascript
function generatePWAIcons(emoji, courseName) {
  const sizes = [
    { size: 192, name: 'icon-192.png', maskable: false },
    { size: 192, name: 'icon-192-maskable.png', maskable: true },
    { size: 512, name: 'icon-512.png', maskable: false },
    { size: 512, name: 'icon-512-maskable.png', maskable: true },
    { size: 180, name: 'apple-touch-icon-180.png', maskable: false }
  ];

  sizes.forEach(({ size, name, maskable }) => {
    const canvas = document.createElement('canvas');
    canvas.width = size;
    canvas.height = size;
    const ctx = canvas.getContext('2d');

    // Background
    ctx.fillStyle = '#c4825a';
    ctx.fillRect(0, 0, size, size);

    // For maskable: scale content to 80% (safe zone)
    if (maskable) {
      ctx.translate(size * 0.1, size * 0.1);
      ctx.scale(0.8, 0.8);
    }

    // Emoji/text
    ctx.fillStyle = 'white';
    ctx.font = `${size * 0.45}px -apple-system, sans-serif`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(emoji, size / 2, size / 2);

    // Download
    const link = document.createElement('a');
    link.download = name;
    link.href = canvas.toDataURL('image/png');
    link.click();
  });
}

// Usage: generatePWAIcons('🤖', 'AI Agents')
```

### Generating Icons with Puppeteer (recommended for production)

```javascript
const puppeteer = require('puppeteer');

async function generateIcon(emoji, size, outputPath, maskable = false) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setViewport({ width: size, height: size });

  const padding = maskable ? size * 0.1 : 0;
  const innerSize = maskable ? size * 0.8 : size;
  const fontSize = innerSize * 0.45;

  await page.setContent(`
    <html><body style="margin:0;display:flex;align-items:center;justify-content:center;
      width:${size}px;height:${size}px;background:#c4825a;">
      <span style="font-size:${fontSize}px;line-height:1;">${emoji}</span>
    </body></html>
  `);

  await page.screenshot({ path: outputPath, type: 'png' });
  await browser.close();
}
```

---

## 5. Install Prompt

### Best Practices

1. **Only show if not already installed** — Check `display-mode: standalone`
2. **Only show if not previously dismissed** — Check localStorage
3. **Delay slightly** — Don't show on first page load; wait 30s or until user scrolls
4. **Clear value proposition** — "Learn offline, anytime" not just "Install app"
5. **Respect user choice** — If dismissed, don't show again (or wait 7 days)

### Complete Install Prompt Implementation

```javascript
// ============================================
// PWA Install Prompt Manager
// ============================================

class InstallPrompt {
  constructor() {
    this.deferredPrompt = null;
    this.banner = document.getElementById('install-banner');
    this.DISMISS_KEY = 'pwa-install-dismissed';
    this.DISMISS_DAYS = 7; // Show again after 7 days

    this.init();
  }

  init() {
    // Already installed?
    if (window.matchMedia('(display-mode: standalone)').matches) return;
    if (navigator.standalone === true) return; // iOS

    // Recently dismissed?
    const dismissed = localStorage.getItem(this.DISMISS_KEY);
    if (dismissed) {
      const dismissedAt = new Date(dismissed);
      const daysSince = (Date.now() - dismissedAt) / (1000 * 60 * 60 * 24);
      if (daysSince < this.DISMISS_DAYS) return;
    }

    // Listen for install prompt
    window.addEventListener('beforeinstallprompt', (e) => {
      e.preventDefault();
      this.deferredPrompt = e;
      // Delay showing banner (let user engage first)
      setTimeout(() => this.show(), 30000);
    });

    // Track successful install
    window.addEventListener('appinstalled', () => {
      this.hide();
      this.deferredPrompt = null;
      console.log('PWA installed successfully');
    });

    // Button handlers
    document.getElementById('install-accept')?.addEventListener('click', () => this.install());
    document.getElementById('install-dismiss')?.addEventListener('click', () => this.dismiss());
  }

  show() {
    if (!this.banner || !this.deferredPrompt) return;
    this.banner.style.display = 'flex';
  }

  hide() {
    if (this.banner) this.banner.style.display = 'none';
  }

  async install() {
    if (!this.deferredPrompt) return;
    this.deferredPrompt.prompt();
    const { outcome } = await this.deferredPrompt.userChoice;
    this.deferredPrompt = null;
    this.hide();
  }

  dismiss() {
    this.hide();
    localStorage.setItem(this.DISMISS_KEY, new Date().toISOString());
  }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => new InstallPrompt());
```

### iOS-specific Install Prompt

iOS Safari doesn't fire `beforeinstallprompt`. Show a manual instruction:

```javascript
// Detect iOS Safari (not in standalone mode)
const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
const isStandalone = window.navigator.standalone === true;

if (isIOS && !isStandalone) {
  // Show iOS-specific install instructions
  const iosBanner = document.createElement('div');
  iosBanner.className = 'ios-install-banner';
  iosBanner.innerHTML = `
    <div class="install-content">
      <span class="install-icon">📱</span>
      <div class="install-text">
        <strong>Install this course</strong>
        <span>Tap <img src="data:image/svg+xml,..." alt="share" style="height:16px;vertical-align:middle"> then "Add to Home Screen"</span>
      </div>
      <button onclick="this.parentElement.parentElement.remove(); localStorage.setItem('ios-install-dismissed','true')" class="install-dismiss">✕</button>
    </div>
  `;

  if (!localStorage.getItem('ios-install-dismissed')) {
    setTimeout(() => document.body.appendChild(iosBanner), 30000);
  }
}
```

---

## 6. Offline Fallback Page

### Design Principles

- **Friendly, not scary** — "You're offline" not "ERROR: No network"
- **Match course design** — Same colors, fonts, warm cream background
- **Actionable** — "Try again" button + suggest visiting main page first
- **Self-contained** — All CSS inline (can't load external resources offline!)

### Template

See `interactive-elements.md` → PWA section → Offline Fallback Page for the complete HTML template.

### Key Rules

1. **Must be pre-cached** — Listed in `PRECACHE_URLS` in sw.js
2. **Must be self-contained** — No external CSS, JS, fonts, or images
3. **Inline all styles** — Can't fetch stylesheets when offline
4. **Use system fonts** — `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
5. **Keep it tiny** — Under 5KB ideally

---

## 7. iOS vs Android Differences

### What iOS Safari Supports

| Feature | Android (Chrome) | iOS (Safari) |
|---------|:-:|:-:|
| manifest.json | ✅ Full | ⚠️ Partial |
| Service worker | ✅ | ✅ |
| Offline mode | ✅ | ✅ |
| `beforeinstallprompt` | ✅ | ❌ |
| Push notifications | ✅ | ✅ (iOS 16.4+) |
| Background sync | ✅ | ❌ |
| `display: standalone` | ✅ | ✅ |
| Splash screen from manifest | ✅ | ❌ (needs apple-touch tags) |
| Maskable icons | ✅ | ❌ (ignored) |
| `theme_color` | ✅ | ⚠️ (meta tag only) |

### iOS Workarounds

1. **Icons:** Must use `<link rel="apple-touch-icon">` — iOS ignores manifest icons
2. **App name:** Must use `<meta name="apple-mobile-web-app-title">` — iOS ignores `short_name`
3. **Standalone:** Must use `<meta name="apple-mobile-web-app-capable" content="yes">`
4. **Status bar:** Use `<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">`
5. **Install prompt:** Must show manual instructions ("Tap Share → Add to Home Screen")
6. **Splash screen:** Use `<link rel="apple-touch-startup-image">` with media queries for each device size

### iOS Cache Limitations

- Safari may evict service worker caches after **7 days of inactivity**
- localStorage and IndexedDB have a ~50MB limit per origin
- No background sync — cache refreshes only when app is open

**Mitigation:** Pre-cache everything on install. For our single-page courses, the full HTML + assets typically fit well within limits.

---

## 8. Testing Checklist

### Chrome DevTools

1. Open DevTools → **Application** tab
2. **Manifest** panel:
   - ✅ Manifest detected
   - ✅ Icons display correctly
   - ✅ No warnings or errors
   - ✅ "Add to homescreen" link works
3. **Service Workers** panel:
   - ✅ Service worker is registered and activated
   - ✅ "Offline" checkbox → page still loads
   - ✅ "Update on reload" for development
4. **Cache Storage** panel:
   - ✅ Cache exists with expected name
   - ✅ Pre-cached URLs are present
5. **Storage** panel:
   - ✅ localStorage has progress data

### Lighthouse PWA Audit

1. Open DevTools → **Lighthouse** tab
2. Check "Progressive Web App" category
3. Run audit
4. Target: **100/100** PWA score

**Common failures and fixes:**

| Issue | Fix |
|-------|-----|
| No manifest | Add `<link rel="manifest" href="manifest.json">` |
| No service worker | Check sw.js registration code |
| No offline fallback | Ensure offline.html is pre-cached |
| No maskable icon | Add icon with `"purpose": "maskable"` |
| No HTTPS | Deploy to GitHub Pages or Vercel (auto-HTTPS) |
| Theme color mismatch | Ensure meta tag matches manifest |
| Start URL not cached | Add `./` and `./index.html` to PRECACHE_URLS |

### Real Device Testing

**Android:**
1. Open course URL in Chrome
2. Wait for install banner (or use address bar's install button)
3. Install → check icon on home screen
4. Open installed app → verify standalone mode (no browser chrome)
5. Turn on airplane mode → verify offline functionality
6. Turn off airplane mode → verify content updates

**iOS:**
1. Open course URL in Safari
2. Tap Share button → "Add to Home Screen"
3. Verify icon and name are correct
4. Open from home screen → verify standalone mode
5. Turn on airplane mode → verify offline functionality

### Automated Testing

```bash
# Using Lighthouse CLI
npx lighthouse https://your-course.github.io \
  --only-categories=pwa \
  --output=json \
  --output-path=./pwa-audit.json

# Quick pass/fail check
cat pwa-audit.json | jq '.categories.pwa.score'
# Should be 1 (100%)
```

---

## 9. Deployment Notes

### GitHub Pages

- ✅ PWA works out of the box
- ✅ HTTPS included (required for service worker)
- ⚠️ Set `start_url` relative: `./index.html` (not `/index.html`)
- ⚠️ If deploying to a subdirectory, scope must match: `"scope": "./"` 

### Vercel

- ✅ PWA works out of the box
- ✅ HTTPS included
- ✅ Automatic CDN for static assets (great for cache performance)

### Netlify

- ✅ PWA works out of the box
- ✅ HTTPS included
- Add `_headers` file for cache control:

```
/sw.js
  Cache-Control: no-cache
/manifest.json
  Cache-Control: public, max-age=86400
/icons/*
  Cache-Control: public, max-age=31536000, immutable
```

---

## 10. Common Patterns

### Progress Persistence (Offline-Safe)

Course progress is stored in localStorage, which persists offline:

```javascript
// Save progress (works offline)
function saveProgress(sectionId) {
  const progress = JSON.parse(localStorage.getItem('courseProgress') || '{}');
  progress.completedSections = progress.completedSections || [];
  if (!progress.completedSections.includes(sectionId)) {
    progress.completedSections.push(sectionId);
  }
  progress.lastVisit = new Date().toISOString();
  localStorage.setItem('courseProgress', JSON.stringify(progress));
}

// Restore progress on load (works offline)
function loadProgress() {
  return JSON.parse(localStorage.getItem('courseProgress') || '{}');
}
```

### Dark Mode with PWA

Ensure `theme-color` changes with dark mode:

```html
<meta name="theme-color" content="#c4825a" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#1a1a1a" media="(prefers-color-scheme: dark)">
```

### Single-Page Course (No Router Needed)

Our courses are single-page HTML. This simplifies PWA setup:
- No need for complex routing in service worker
- One HTML file to cache = instant offline
- Progress tracked via localStorage + section IDs
- Hash-based navigation (`#week-01`) works offline natively

---

## Template Summary

When generating a new course, create these files:

1. **`manifest.json`** — Copy template, replace `name`, `short_name`, `description`
2. **`sw.js`** — Copy template, replace `{{course-slug}}`
3. **`offline.html`** — Copy template, replace `{{Course Name}}`
4. **`icons/`** — Generate with emoji + course color scheme
5. **`index.html`** — Add `<head>` tags + SW registration + install prompt

Total added code: ~3KB (manifest + sw.js + offline.html). Icons add ~50KB.

**The result:** Every course is installable, works offline, and feels like a native app. Zero extra effort for the learner. Maximum accessibility.
