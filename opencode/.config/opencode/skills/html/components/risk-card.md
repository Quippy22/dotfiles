# Purpose

To display identified project risks, their severity, and mitigation strategies within the report.

# Visual Goals

Use a card-based layout with a distinct visual indicator for severity levels.

# HTML

<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6">
  <div class="flex items-center justify-between mb-4">
    <h3 class="text-slate-100 font-semibold text-lg">{{RISK_TITLE}}</h3>
    <span class="px-3 py-1 rounded-full text-xs font-medium bg-rose-500/10 text-rose-400 border border-rose-500/20">
      {{SEVERITY_LEVEL}}
    </span>
  </div>
  <p class="text-slate-300 text-sm mb-6">{{DESCRIPTION}}</p>
  <div class="bg-slate-950 rounded-xl p-4 border border-slate-800">
    <h4 class="text-slate-100 font-medium text-sm mb-2">Mitigation Strategy</h4>
    <p class="text-slate-400 text-sm">{{MITIGATION}}</p>
  </div>
</div>

# Tailwind Notes

Uses a high-contrast background (bg-slate-900) with a nested inner container (bg-slate-950) for the mitigation section to create visual hierarchy. The severity tag utilizes the rose accent palette.

# Composition

Typically placed inside a `section-card` or as part of a risk assessment grid.

# Responsive Behavior

- Mobile: Full width card with stacked layout.
- Tablet: Maintains card structure.
- Desktop: Stacks well in a grid layout (e.g., 2-3 columns).
