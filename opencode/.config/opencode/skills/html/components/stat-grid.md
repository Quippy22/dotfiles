# Purpose

The stat-grid component acts as a container for multiple `metric-card.md` instances, providing a structured overview of key performance indicators.

# Visual Goals

A responsive grid layout that adapts to the number of metrics, ensuring consistent alignment and spacing across the report.

# HTML

<div class="max-w-7xl mx-auto px-8 py-10">
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
    <!-- Place metric-card.md content here -->
    {{METRIC_CARDS}}
  </div>
</div>

# Tailwind Notes

* `grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6` ensures the grid flows gracefully from mobile to large screens.

# Composition

Wraps multiple `metric-card.md` instances.

# Responsive Behavior

* **Mobile:** Single column.
* **Tablet:** Two-column grid.
* **Desktop:** Up to four columns.
