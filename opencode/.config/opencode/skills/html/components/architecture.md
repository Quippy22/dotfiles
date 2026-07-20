# Purpose

The architecture component provides a clean layout for describing system components, their relationships, and data flow.

# Visual Goals

A diagram-like or list-based layout using visual groupings to distinguish between system parts.

# HTML

<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
  <div class="border border-slate-800 rounded-2xl p-6 bg-slate-900">
    <h3 class="font-bold text-slate-100 mb-4">{{COMPONENT_NAME}}</h3>
    <p class="text-sm text-slate-400">{{DESCRIPTION}}</p>
  </div>
</div>

# Tailwind Notes

* `grid grid-cols-1 md:grid-cols-2 gap-8` handles component grouping.
* `p-6 bg-slate-900 border border-slate-800` maintains component card consistency.

# Composition

Used within a `section-card.md` to explain technical underpinnings.

# Responsive Behavior

* **Mobile:** Stacked list.
* **Tablet/Desktop:** Two-column grid.
