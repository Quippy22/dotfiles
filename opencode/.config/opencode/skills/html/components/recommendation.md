# Purpose

To clearly present strategic recommendations with associated impact and effort levels.

# Visual Goals

Use a clean, list-based structure with accent-colored indicators for high-impact items.

# HTML

<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6">
  <div class="flex items-start gap-4">
    <div class="flex-shrink-0 mt-1">
      <div class="w-8 h-8 rounded-full bg-cyan-400/10 border border-cyan-400/20 flex items-center justify-center text-cyan-400">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
          <path d="M12 2H4a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2zM4 1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H4z"/>
        </svg>
      </div>
    </div>
    <div class="flex-grow">
      <h3 class="text-slate-100 font-semibold mb-2">{{RECOMMENDATION_TITLE}}</h3>
      <p class="text-slate-300 text-sm mb-4">{{JUSTIFICATION}}</p>
      <div class="flex gap-4">
        <span class="text-xs text-slate-400 font-medium">Impact: <span class="text-slate-100">{{IMPACT}}</span></span>
        <span class="text-xs text-slate-400 font-medium">Effort: <span class="text-slate-100">{{EFFORT}}</span></span>
      </div>
    </div>
  </div>
</div>

# Tailwind Notes

Uses the ice (cyan-400) accent for the icon and subtle background to denote positive guidance. The layout relies on flexbox for alignment and spacing.

# Composition

Best used in lists within a section or summary block.

# Responsive Behavior

- Mobile: Stacked icon/text.
- Tablet: Stays compact.
- Desktop: Stacks cleanly.
