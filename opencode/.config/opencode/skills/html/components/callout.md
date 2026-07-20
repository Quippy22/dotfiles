# Purpose

The callout component draws attention to important information, notes, or warnings using an accent-colored border.

# Visual Goals

A visually distinct box that uses one of the defined accent palettes to signal importance without being overwhelming.

# HTML

<div class="border-l-4 border-cyan-400 bg-cyan-400/10 p-6 rounded-r-2xl mb-6">
  <h4 class="text-cyan-300 font-semibold mb-2">Important Note</h4>
  <p class="text-cyan-100 leading-relaxed">
    {{CONTENT}}
  </p>
</div>

# Tailwind Notes

* `border-l-4 border-cyan-400` creates a clear accent marker.
* `bg-cyan-400/10` adds a very subtle tint to the background, linking it to the border color.
* `rounded-r-2xl` maintains the rounded design theme on the right side.

# Composition

Inserted within text content or `section-card.md` to highlight key findings.

# Responsive Behavior

* **All screen sizes:** Adapts to content width.
