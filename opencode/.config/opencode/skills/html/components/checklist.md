# Purpose

To present a set of actionable items or tasks with completion status markers.

# Visual Goals

Clean list view with custom interactive-looking checkboxes that align with the dark-mode aesthetic.

# HTML

<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6">
  <h3 class="text-slate-100 font-semibold mb-4">{{CHECKLIST_TITLE}}</h3>
  <ul class="space-y-3">
    <li class="flex items-center gap-3">
      <div class="w-5 h-5 rounded border border-slate-700 bg-slate-950"></div>
      <span class="text-slate-300 text-sm">{{ITEM_NAME_1}}</span>
    </li>
    <li class="flex items-center gap-3">
      <div class="w-5 h-5 rounded bg-cyan-400 border border-cyan-400 flex items-center justify-center">
        <svg class="w-3 h-3 text-slate-950" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path></svg>
      </div>
      <span class="text-slate-400 text-sm line-through">{{ITEM_NAME_2}}</span>
    </li>
  </ul>
</div>

# Tailwind Notes

Uses `space-y-3` for vertical list spacing. The checked state uses the ice (cyan-400) accent.

# Composition

Typically part of section-based content.

# Responsive Behavior

- Mobile/Desktop: List structure is consistent.
