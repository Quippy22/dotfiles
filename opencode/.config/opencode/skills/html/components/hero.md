# Purpose

The hero component acts as the visual entry point for a report, establishing the primary context, title, and summary immediately.

# Visual Goals

A large, high-impact header area with spacious typography, centered or left-aligned within the container. It should feel balanced, clean, and professional.

# HTML

<header class="max-w-7xl mx-auto px-8 py-20 border-b border-slate-800">
  <h1 class="text-6xl font-extrabold text-slate-100 tracking-tight mb-6">
    {{TITLE}}
  </h1>
  <p class="text-2xl text-slate-400 max-w-3xl leading-relaxed">
    {{DESCRIPTION}}
  </p>
</header>

# Tailwind Notes

* `max-w-7xl mx-auto px-8` ensures layout consistency.
* `text-6xl font-extrabold tracking-tight` provides strong visual hierarchy.
* `border-b border-slate-800` creates a clear separation from the content body.

# Composition

Typically placed at the very top of the page. Followed by `metadata.md` or the first `section-card.md`.

# Responsive Behavior

* **Mobile:** Reduce padding and title size slightly for readability.
* **Tablet:** Default spacing, centered layout.
* **Desktop:** Full impact, consistent with 7xl container width.
