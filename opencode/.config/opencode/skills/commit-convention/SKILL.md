---
name: commit-convention
description: Enforces one-line commit convention. Types: feat, fix, refactor, chore, docs, test, merge, revert, reapply. Merges use `merge: <src> into <tgt>`. Reverts/reapplies use capitalization. No body.
---

# Commit Convention

Enforces the project commit style from `git log --oneline`.

## Format

```
<type>: <description>
```

- One line only, no body.
- `<type>:` is lowercase, then a space, then description.
- `<description>` starts with a lowercase letter (except Revert/Reapply).
- Branch name may appear in parens at the end (git adds this automatically in `--oneline` view — you don't type it).

## Allowed types

| Type       | When to use                                        |
|------------|----------------------------------------------------|
| `feat`     | New feature for the user                           |
| `fix`      | Bug fix                                            |
| `refactor` | Code restructuring, no behaviour change            |
| `chore`    | Build, tooling, deps, CI — not user-facing         |
| `docs`     | Documentation only                                 |
| `test`     | Adding or fixing tests                             |
| `revert`   | Undoing a previous commit via `git revert`         |
| `reapply`  | Reapplying a previously-reverted commit            |
| `merge`    | Merge commits (see below)                          |

## Merge commits

```
merge: <source-branch> into <target-branch>
```

Always lowercase `merge:`, no type prefix before it. Example:
```
merge: hotkeys into main
```

## Revert / Reapply

Use a capital letter — these aren't typed as a `<type>:` prefix but as a verb:

```
Revert "refactor: toolbar"
Reapply "refactor: toolbar"
```

These come from `git revert` / `git cherry-pick` — the tooling generates them.## Workflow for opencode

When asked to produce a commit message, generate one matching the format above. Types from the table — pick the single best fit.
