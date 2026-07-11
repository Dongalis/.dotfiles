---
name: html-conventions
description: General best practices for semantic, well-structured HTML on any vanilla (no-framework) site. Use when creating or editing HTML pages.
---

## Semantics
- One `<h1>` per page; headings follow hierarchy without skipping levels (h2 → h3, not h2 → h4)
- Use semantic elements (`<nav>`, `<main>`, `<header>`, `<footer>`, `<article>`, `<section>`) instead of unlabeled `<div>`s wherever the meaning fits
- Every `<img>` needs `alt` text; use `alt=""` only for purely decorative images
- Every form `<input>` needs an associated `<label>` (via `for`/`id` or wrapping)

## Organization
- Prefer shared CSS/JS files over inline `style=""` / `<script>` blocks, unless the project has no separate asset files at all
- Before adding new markup patterns, check the existing codebase for similar components and match that pattern instead of introducing a new one

## Before finishing
- Check the project's own conventions file (AGENTS.md, README, or similar) if one exists — it overrides these defaults
