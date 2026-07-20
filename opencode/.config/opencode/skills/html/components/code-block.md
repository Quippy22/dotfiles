# Purpose

The code-block component provides a clean, syntax-highlighted container for code samples, command snippets, or configuration files.

# Visual Goals

Monospaced typography inside a high-contrast dark surface, with distinct syntax highlighting colors.

# HTML

<div class="bg-slate-950 border border-slate-800 rounded-2xl p-6 overflow-hidden">
  <div class="flex items-center justify-between mb-4">
    <span class="text-xs font-mono text-slate-500">example.json</span>
  </div>
  <pre class="font-mono text-sm text-slate-300 overflow-x-auto"><code>{{CONTENT}}</code></pre>
</div>

# Tailwind Notes

* `bg-slate-950` distinguishes the code block from the surrounding `bg-slate-900` card surface.
* `font-mono` ensures correct character rendering.

# Composition

Placed inside `section-card.md` or used as a standalone block.

# Responsive Behavior

* **Mobile/Tablet/Desktop:** Horizontal scroll for long lines.
