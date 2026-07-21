---
name: notify
description: Send desktop notifications to the user via the `notifyme` command. Use when the user asks to be notified, alerted, pinged, announced to, or reminded of something.
---

# Notify

Sends a desktop notification using the `notifyme` tool.

## When to use

Use this skill whenever the user asks to be:
- notified / pinged / alerted
- reminded at a certain point
- announced to (e.g. "let me know", "tell me when", "ping me")

Do NOT use for in-chat informational messages — only for actual desktop notifications.

## Usage

```sh
notifyme <summary> [body...]
```

- First word/phrase = summary (bold in notification)
- Everything after = body (detail text)
- No arguments → no-op, skip it.

## Examples

- User: "notify me when the build finishes" → after build completes, run `notifyme "Build done" "exit code 0"`
- User: "ping me when it's ready" → run `notifyme "Ready" "<what's ready>"`
- User: "announce the result" → run `notifyme "<summary>" "<details>"`
