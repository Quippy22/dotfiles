# Purpose

The section-card component provides a clear, bordered container for grouping related report content, such as analysis or documentation.

# Visual Goals

A clean, distinct surface container with a subtle border that stands out from the page background.

# HTML

<section class="bg-slate-900 border border-slate-800 rounded-2xl p-8 mb-10">
  <h2 class="text-2xl font-semibold text-slate-100 mb-6">{{TITLE}}</h2>
  <div class="text-slate-300 leading-relaxed">
    {{CONTENT}}
  </div>
</section>

# Tailwind Notes

* `bg-slate-900` sets it apart from the `bg-slate-950` page background.
* `rounded-2xl` is used consistently across components for smooth corners.
* `mb-10` provides vertical rhythm between sections.

# Composition

Contains text, tables, images, or other inline components. Usually placed after the `hero` or `stat-grid`.

# Responsive Behavior

* **Mobile:** Full-width container, adjusted padding.
* **Tablet/Desktop:** Follows parent container constraints.
