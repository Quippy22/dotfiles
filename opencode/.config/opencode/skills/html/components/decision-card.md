# Purpose

The decision-card component documents a critical project decision, its context, and the rationale.

# Visual Goals

A clear, well-structured card that sets off a decision from general report text, using semantic colors for importance.

# HTML

<div class="border border-slate-800 rounded-2xl bg-slate-900 p-8 space-y-4">
  <h3 class="text-xl font-bold text-slate-100 border-b border-slate-800 pb-4">{{DECISION_TITLE}}</h3>
  <div class="space-y-2">
    <p class="text-sm font-semibold text-slate-500 uppercase">Context</p>
    <p class="text-slate-300">{{CONTEXT}}</p>
  </div>
  <div class="space-y-2">
    <p class="text-sm font-semibold text-slate-500 uppercase">Rationale</p>
    <p class="text-slate-300">{{RATIONALE}}</p>
  </div>
</div>

# Tailwind Notes

* `space-y-4` and `pb-4` provide a clean internal rhythm.
* `text-sm font-semibold text-slate-500 uppercase` creates a clear, distinct metadata style for decision fields.

# Composition

Placed within a `section-card.md` to highlight architectural choices.

# Responsive Behavior

* **Mobile/Tablet/Desktop:** Adapts to parent container.
