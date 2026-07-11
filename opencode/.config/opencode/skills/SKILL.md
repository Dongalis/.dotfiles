---
name: accessibility-audit
description: Checklist for reviewing accessibility (WCAG-aligned) of any web page or component. Use when adding new UI or asked to check accessibility.
---

## Check for
- Color contrast: text vs background meets WCAG AA (4.5:1 normal text, 3:1 large text)
- Keyboard operability: every interactive element reachable and usable via Tab/Enter/Space
- Visible focus indicators (never remove `outline` without a replacement focus style)
- Images have meaningful `alt`; decorative images have `alt=""`
- Form inputs have associated labels; errors are announced (not color-only)
- Heading structure is logical (one h1, no skipped levels)
- Interactive elements have accessible names (not just icons with no label)

## Reporting
Group findings by severity — "blocks a user" vs "minor improvement" — rather than a flat list.
