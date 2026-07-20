# Purpose

To display the progress of a multi-stage process or project milestone.

# Visual Goals

A clean, single-line progress bar or circular progress indicator using the project accent colors.

# HTML

<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6">
  <div class="flex justify-between items-end mb-2">
    <h3 class="text-slate-100 font-medium">{{PROGRESS_TITLE}}</h3>
    <span class="text-cyan-400 font-semibold">{{PERCENTAGE}}%</span>
  </div>
  <div class="w-full bg-slate-950 rounded-full h-3 border border-slate-800 overflow-hidden">
    <div class="bg-cyan-400 h-full rounded-full" style="width: {{PERCENTAGE}}%"></div>
  </div>
</div>

# Tailwind Notes

Uses a simple flex container to align text, and a `rounded-full` height-controlled container for the progress bar. The bar itself uses the ice (cyan-400) accent.

# Composition

Best placed in dashboards, summaries, or section headers.

# Responsive Behavior

- Mobile: Responsive width.
- Tablet/Desktop: Maintains standard width containers.
