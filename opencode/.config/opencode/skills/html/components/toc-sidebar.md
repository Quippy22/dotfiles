# Purpose

Provides a navigation sidebar for long-form reports, allowing users to jump to specific sections.

# Visual Goals

A sticky vertical list on the side of the content, with active state highlighting. Minimalist design.

# HTML

<aside class="hidden lg:block w-64 fixed right-0 top-0 h-screen p-8 border-l border-slate-800 z-50 bg-slate-950/80 backdrop-blur-sm">
  <h4 class="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-4">Table of Contents</h4>
  <nav class="space-y-2">
    <a href="#overview" class="block text-sm text-slate-300 hover:text-cyan-400 transition-colors">Overview</a>
    <a href="#architecture" class="block text-sm text-slate-300 hover:text-cyan-400 transition-colors">Architecture</a>
    <a href="#risk-assessment" class="block text-sm text-slate-300 hover:text-cyan-400 transition-colors">Risk Assessment</a>
    <a href="#recommendations" class="block text-sm font-medium text-cyan-400">Recommendations</a>
  </nav>
</aside>

# Tailwind Notes

* `w-64 fixed right-0` positions the sidebar on the right edge.
* `hidden lg:block` hides on mobile; visible on large screens.
* `z-50` keeps it above page content.
* Muted text with cyan accent for active state.

# Composition

Placed before the main content container. The main content wrapper must add `lg:mr-64` to prevent the fixed sidebar from overlapping content:

```html
<div class="mx-auto max-w-7xl px-8 py-10 lg:mr-64">
```

# Responsive Behavior

* **Mobile/Tablet:** Hidden (`hidden lg:block`).
* **Desktop:** Fixed on the right; main container compensates with `lg:mr-64`.
