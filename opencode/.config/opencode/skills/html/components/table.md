# Purpose

The table component displays structured data in a clear, readable grid format.

# Visual Goals

Minimalist design with clear headings, alternating row emphasis (subtle), and generous padding.

# HTML

<div class="overflow-x-auto">
  <table class="w-full text-left text-sm text-slate-300">
    <thead class="text-slate-400 border-b border-slate-800">
      <tr>
        <th class="px-6 py-4 font-semibold uppercase tracking-wider">Name</th>
        <th class="px-6 py-4 font-semibold uppercase tracking-wider">Status</th>
        <th class="px-6 py-4 font-semibold uppercase tracking-wider">Value</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-slate-800">
      <tr class="hover:bg-slate-900/50 transition">
        <td class="px-6 py-4 text-slate-100 font-medium">Item Name</td>
        <td class="px-6 py-4 text-cyan-400">Active</td>
        <td class="px-6 py-4 text-slate-300">100</td>
      </tr>
    </tbody>
  </table>
</div>

# Tailwind Notes

* `divide-y divide-slate-800` handles clean row separation.
* `hover:bg-slate-900/50` provides clear interactivity on rows.
* `overflow-x-auto` ensures responsive handling on small screens.

# Composition

Typically resides within a `section-card.md`.

# Responsive Behavior

* **Mobile:** Horizontal overflow allows scrolling.
* **Tablet/Desktop:** Adapts to the width of the parent container.
