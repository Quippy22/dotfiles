# Purpose

The metadata component provides structured administrative information about the report, such as author, date, and status.

# Visual Goals

A low-profile, clean horizontal bar or grid, clearly separated from the hero but still part of the header context. It uses muted colors to ensure it doesn't distract from the main content.

# HTML

<div class="max-w-7xl mx-auto px-8 py-6 grid grid-cols-1 md:grid-cols-4 gap-6 text-sm border-b border-slate-800">
  <div>
    <p class="text-slate-500 uppercase tracking-wider font-semibold">Author</p>
    <p class="text-slate-200">{{OWNER}}</p>
  </div>
  <div>
    <p class="text-slate-500 uppercase tracking-wider font-semibold">Status</p>
    <p class="text-cyan-400">{{STATUS}}</p>
  </div>
  <div>
    <p class="text-slate-500 uppercase tracking-wider font-semibold">Date</p>
    <p class="text-slate-200">{{DATE}}</p>
  </div>
  <div>
    <p class="text-slate-500 uppercase tracking-wider font-semibold">Version</p>
    <p class="text-slate-200">{{VERSION}}</p>
  </div>
</div>

# Tailwind Notes

* `grid-cols-1 md:grid-cols-4` handles responsive rearrangement.
* `text-slate-500 uppercase tracking-wider font-semibold` defines the label style.
* `text-cyan-400` applies the Ice accent for the status, making it stand out as a key indicator.

# Composition

Typically follows the `hero.md` component.

# Responsive Behavior

* **Mobile:** Stacked vertical list.
* **Tablet/Desktop:** Grid layout.
