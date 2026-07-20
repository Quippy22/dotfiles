# Purpose

The timeline component visualizes events, project milestones, or historical data chronologically.

# Visual Goals

A vertical line with markers for each event, connecting structured content blocks for clear sequential flow.

# HTML

<div class="space-y-8 border-l-2 border-slate-800 ml-3">
  <div class="relative pl-8">
    <div class="absolute -left-2 top-0 h-4 w-4 rounded-full bg-slate-800 border-2 border-slate-500"></div>
    <h3 class="text-lg font-semibold text-slate-100">{{DATE}}</h3>
    <p class="text-slate-400 mt-1">{{CONTENT}}</p>
  </div>
</div>

# Tailwind Notes

* `border-l-2 border-slate-800` creates the visual connection line.
* `absolute -left-2` positions the marker correctly on the vertical timeline.

# Composition

Typically resides within a `section-card.md`.

# Responsive Behavior

* **Mobile/Tablet/Desktop:** Adapts to parent width; vertical structure persists.
