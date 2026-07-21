---
name: html
description: Generate polished, self-contained HTML report documents for research, reviews, summaries, investigations, roadmaps, architecture, debug reports, documentation, planning, and decision records. Always produces a single HTML file with dashboard-style layout using Tailwind CSS (CDN), then serves it via `html-serve` for immediate preview.
---

# HTML Report Generator

## Purpose

Your task is to produce a **single self-contained HTML document** that serves as a polished artifact for:

- Research
- Reviews
- Summaries
- Technical investigations
- Roadmaps
- Architecture reports
- Debug reports
- Documentation
- Planning
- Decision records

The document should resemble a professionally designed dashboard, not a rendered Markdown page.

---

## HTML Requirements

Always output a single HTML file.

Include:

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.tailwindcss.com"></script>
<title>...</title>
</head>
<body>
...
</body>
</html>
```

Never output markdown.

Never output plaintext.

Never wrap HTML inside markdown fences.

---

## Design Language

The page should resemble:

- Linear
- Vercel
- Stripe Docs
- GitHub
- Notion
- Claude Artifacts

The overall feeling should be:

- spacious
- modern
- technical
- information-dense
- visually organized

Avoid blog styling.

Avoid article styling.

Avoid markdown styling.

Think "dashboard".

---

## Layout

Always use

```html
<body class="bg-slate-950 text-slate-100">
```

Main wrapper

```html
<div class="mx-auto max-w-7xl px-8 py-10">
```

Never allow content to span the entire viewport.

---

## Page Sections

The page should be composed of reusable containers.

Example structure:

```
Header
↓
Metadata Grid
↓
Executive Summary
↓
Metrics
↓
Main Content
↓
Roadmap
↓
Recommendations
↓
Appendix
↓
Footer
```

Every section should live inside its own card.

Example:

```html
<div class="rounded-2xl border border-slate-800 bg-slate-900 p-8 shadow-lg">
```

Never dump content directly into the page.

---

## Components

Prefer components over paragraphs.

The `components/` directory in this skill contains reusable component templates (callouts, metric cards, tables, etc.) — reference or inline them as needed.

Available components include:

### Hero Header

- Large title
- Subtitle
- Description
- Status pill
- Tags
- Metadata

### Metric Cards

Grid layout. Examples: Files, Issues, Risk, Time, Confidence, Coverage.
Each metric should have: small label, large value, optional trend.

### Callouts

Information, Warning, Success, Danger. Each should have: left colored border, icon, title, description.

### Section Cards

Every major topic belongs inside an independent card.

### Tables

Responsive, rounded, overflow scrolling, alternating rows, sticky header.

### Code Blocks

Rounded, overflow-x-auto, dark background, language badge, monospace.

### Timeline

Vertical roadmap. Each milestone contains: title, description, status, owner, ETA.

### Roadmap

Display phases as connected cards:

```
Phase 1 → Phase 2 → Phase 3 → Phase 4
```

Each phase should contain: objective, deliverables, dependencies, completion.

### Decision Cards

Decision, Reason, Alternatives, Tradeoffs, Outcome.

### Risk Cards

Severity badge, Likelihood badge, Mitigation, Owner.

### Recommendation Cards

Priority badge, Description, Expected impact, Difficulty.

### Architecture

Represent architecture using HTML. Examples:
- Frontend → API → Database
- Grid layouts
- Connection arrows
- Nested containers

No SVG libraries. No Mermaid. No Canvas.

### Progress

Progress bars, percentage, completion labels.

### Checklist

Interactive appearance: Completed, Pending, Blocked.

### Badges

Success, Warning, Error, Neutral. Use Tailwind pills.

### TOC Sidebar

Desktop, sticky, anchor links, current section highlight. Hidden on mobile.

---

## Tailwind Usage

Prefer utility classes exclusively.

Examples:

```
grid
grid-cols-4
gap-6
flex
items-center
justify-between
rounded-xl
rounded-2xl
border
shadow
space-y-8
space-x-4
text-sm
text-lg
text-3xl
font-semibold
tracking-tight
uppercase
hover:bg-slate-800
transition
duration-200
```

Never invent CSS for spacing that Tailwind already provides.

---

## Responsiveness

Use responsive utilities everywhere.

Examples:

```
md:grid-cols-2
xl:grid-cols-4
hidden lg:block
flex-col md:flex-row
```

---

## Icons

Use inline SVG only.

Never use Heroicons CDN.

Never use FontAwesome.

Never use icon libraries.

---

## Colors

- Primary: Slate
- Secondary: Zinc
- Semantic: green, yellow, red, blue

Avoid saturated accent colors.

---

## Typography

Hierarchy is critical:

- Title: `text-5xl`
- Section: `text-2xl`
- Cards: `text-lg`
- Metadata: `text-sm`
- Supporting text: `text-slate-400`

---

## Content Rules

Convert walls of text into: cards, grids, tables, callouts, timelines, roadmaps, lists, metrics.

Only use paragraphs when necessary.

---

## HTML Quality

The resulting document should look like it could have been built manually by a frontend engineer.

It should never resemble a Markdown renderer.

Every major concept should have its own visual component.

Whitespace, hierarchy and layout are more important than decorative styling.

The report should be presentation-ready immediately after opening in a browser.

---

## Preview & Serving

After generating the HTML file, always make it immediately viewable by the user.

If the environment provides the `html-serve` utility, invoke it.

Command:

```
html-serve path/to/generated/file.html
```

The command starts (or reuses) a background HTTP server and returns a URL.

Example:

```
$ html-serve test-tw.html
http://localhost:3333/test-tw.html
```

The returned URL should be included in the final response.

Example response:

```
Generated:
/tmp/test-tw.html

Preview:
http://localhost:3333/test-tw.html
```

Do not attempt to manually construct the URL.

Always use the exact URL returned by the tool.

Do not start your own HTTP server.

Do not use Python's http.server.

Do not use npx serve.

Do not use live-server.

Do not use any alternative serving mechanism.

The `html-serve` tool is the canonical way to expose HTML artifacts.

If `html-serve` fails, still return the generated HTML file path along with the error produced by the tool.

Never omit the preview step when `html-serve` is available.

---

## Standard Workflow

For every HTML artifact:

1. Determine the document type.
2. Generate the complete standalone HTML document.
3. Save it to an appropriate filename.
4. Invoke `html-serve /absolute/path/to/file.html`
5. Wait for the tool to return a URL.
6. Return:
   - the generated file path
   - the preview URL
   - a short description of what was generated

A task is not considered complete until the preview URL has been returned (when `html-serve` is available).
