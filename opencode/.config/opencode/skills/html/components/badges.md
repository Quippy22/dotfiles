# Purpose

Badges are used to tag items or indicate status with a compact, visual label.

# Visual Goals

Small, pill-shaped labels with subtle backgrounds and high-contrast text.

# HTML

<div class="flex gap-2">
  <span class="px-3 py-1 rounded-full text-xs font-medium bg-cyan-400/20 text-cyan-300 border border-cyan-400/30">
    {{LABEL_ONE}}
  </span>
  <span class="px-3 py-1 rounded-full text-xs font-medium bg-rose-400/20 text-rose-300 border border-rose-400/30">
    {{LABEL_TWO}}
  </span>
</div>

# Tailwind Notes

* `px-3 py-1 rounded-full` creates the pill shape.
* `bg-accent/20 text-accent` uses subtle background tints for readability.

# Composition

Often found in headers, tables, or alongside project descriptions.

# Responsive Behavior

* **All screens:** Maintains compact size.
