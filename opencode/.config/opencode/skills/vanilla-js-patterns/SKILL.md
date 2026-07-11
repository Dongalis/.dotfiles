---
name: vanilla-js-patterns
description: Safe, reusable patterns for plain JavaScript (no framework) — scoping, event handling, DOM safety. Use when writing or reviewing vanilla JS.
---

## Patterns to prefer
- Scope page scripts (IIFE, module, or block scope) instead of leaking variables onto `window`
- Use event delegation for dynamic/repeated elements instead of re-binding listeners on each render
- Guard DOM queries (`if (el) {...}`) since markup may differ across pages/environments
- Attach event listeners in JS rather than inline `onclick=""` attributes in HTML

## Safety checks
- Flag direct `innerHTML` assignment with any user-supplied or untrusted content (XSS risk) — prefer `textContent` or sanitize first
- Flag global variable name collisions across multiple script files
- Flag listeners added repeatedly without cleanup (memory leak / duplicate firing)
