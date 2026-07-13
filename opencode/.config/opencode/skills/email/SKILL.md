---
name: email-update
description: Send the user a specific update, summary, or piece of content directly to their inbox via the `oximail` command. Use this any time the user asks to "email me", "send me an update", "mail me the summary", "send this to my inbox", or similar — whenever they want output delivered as an email rather than just shown in chat. Always use this skill instead of just printing the requested content in the terminal when an email is what they asked for.
---

# Email Update

Sends the user exactly what they asked for as an email, using the `oximail` CLI.

## Command reference

```
oximail --subject "<subject line>" --text "<plain text or markdown content>"
oximail --subject "<subject line>" --file <path-to-markdown-or-text-file>
```

- `--subject` is always required — a short, specific subject line describing the update.
- `--text` takes an inline string. It accepts plain text, and it also accepts markdown (markdown will render correctly), so light formatting like `**bold**`, `#` headers, or `-` bullet lists is fine directly in `--text`.
- `--file` takes a path to a `.txt` or `.md` file on disk. Use this instead of `--text` when the content is long, has multiple sections, or is easier to draft and review as a file first.
- Exactly one of `--text` or `--file` should be used per call, not both.

## Workflow

1. **Figure out what the user actually wants sent.** If they've already described it clearly in their message (e.g. "email me a summary of what we just discussed" or "send me today's build status"), just use that — don't ask a clarifying question for something already implied by the conversation.
2. **Compose the content** in the user's voice/intent — concise, scannable, no filler. Use markdown formatting (headers, bullets, bold) when it improves readability; both delivery methods support it.
3. **Choose delivery method:**
   - Short update (roughly under ~15 lines): write it straight into `--text`.
   - Longer or multi-section update: write the content to a markdown file (e.g. `/tmp/update.md`) first, review it, then send with `--file`.
4. **Write a real subject line** — specific to the content (e.g. "Deploy status: staging build passed", not "Update").
5. **Run the command** via the shell.
6. **Confirm to the user** what was sent (subject + one-line description of the content), don't just say "done."

## Examples

Quick inline update:
```
oximail --subject "Tests passing on main" --text "All 214 tests pass on main after the refactor. No regressions found."
```

Longer update via file:
```bash
cat > /tmp/update.md << 'EOF'
# Sprint Summary

## Completed
- Auth refactor merged
- Fixed flaky CI job

## In progress
- Rate limiting for the API

## Blockers
- None
EOF
oximail --subject "Weekly sprint summary" --file /tmp/update.md
```

## Notes

- Don't invent content the user didn't ask for — send what they requested, not a padded-out version.
- If the user asks for an update on something you don't have information about (e.g. a codebase you haven't looked at), gather that information first (read files, check logs, etc.) before composing the email.
- Clean up any temp files created for `--file` delivery after sending, unless the user wants to keep them.
