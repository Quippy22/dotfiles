# Purpose

The roadmap component presents high-level project phases, goals, or milestones in a clear, linear format.

# Visual Goals

An ordered series of distinct stages, using accent colors to denote progress or status.

# HTML

<div class="space-y-4">
  <div class="flex items-center gap-4 bg-slate-900 border border-slate-800 rounded-2xl p-6">
    <div class="h-10 w-10 flex items-center justify-center rounded-full bg-cyan-500/10 text-cyan-400 font-bold">1</div>
    <div>
      <h4 class="font-semibold text-slate-100">{{TITLE}}</h4>
      <p class="text-sm text-slate-400">{{DESCRIPTION}}</p>
    </div>
  </div>
</div>

# Tailwind Notes

* `h-10 w-10 flex items-center justify-center rounded-full bg-cyan-500/10` creates a stylized step-number indicator.
* `flex items-center gap-4` aligns step icon with text.

# Composition

Often the centerpiece of a `section-card.md`.

# Responsive Behavior

* **Mobile/Tablet/Desktop:** Linear list that adjusts to parent container width.
