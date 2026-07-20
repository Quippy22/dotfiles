# Purpose

The metric-card component displays a single, high-priority numerical or status value, often accompanied by a small descriptive label.

# Visual Goals

A compact, self-contained card with a subtle border and surface color, emphasizing the data value as the primary focus.

# HTML

<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 transition-all hover:border-slate-700">
  <p class="text-slate-400 text-sm font-medium mb-2">{{LABEL}}</p>
  <p class="text-4xl font-bold text-slate-100 tracking-tight">{{VALUE}}</p>
</div>

# Tailwind Notes

* `bg-slate-900 border border-slate-800 rounded-2xl` establishes the consistent surface style.
* `text-4xl font-bold` highlights the metric value.
* `transition-all hover:border-slate-700` adds an interactive feel.

# Composition

Often grouped inside the `stat-grid.md` component.

# Responsive Behavior

* **Mobile/Tablet/Desktop:** Resizes naturally within grid containers.
