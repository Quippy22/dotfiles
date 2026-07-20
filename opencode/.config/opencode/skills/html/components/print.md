# Purpose

Provides print-specific styles to ensure the report is formatted correctly when exported to PDF or printed.

# Visual Goals

Removes unnecessary UI elements (like sidebars/buttons), maximizes readability for paper format.

# HTML

<style media="print">
  @page {
    margin: 20mm;
  }
  .no-print {
    display: none !important;
  }
  body {
    background-color: white !important;
    color: black !important;
  }
  .bg-slate-950, .bg-slate-900 {
    background-color: white !important;
  }
  .text-slate-100, .text-slate-300, .text-slate-400 {
    color: black !important;
  }
  .border-slate-800 {
    border-color: #e2e8f0 !important;
  }
</style>

# Tailwind Notes

Using a standard `<style>` block for print-specific CSS that overrides the dark mode themes.

# Composition

Included in the `<head>` or at the end of the `<body>` of any report page.

# Responsive Behavior

Always applied. `no-print` class is used to hide interactive elements.
