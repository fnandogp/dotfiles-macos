---
description: Analyse and resolve git merge/rebase/cherry-pick conflicts with full context.
argument-hint: "[--dry-run | --abort | --ours | --theirs | file paths...]"
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git show:*), Bash(git checkout:*), Bash(git rev-parse:*), Bash(git branch:*), Bash(git ls-files:*)
---

# Task: Resolve Git Conflicts

Analyse and resolve all merge/rebase/cherry-pick/revert conflicts using full three-way context.

## 1. Detect Operation State

Run `git status` and check the git dir for:

| Path                  | Operation   |
| --------------------- | ----------- |
| `MERGE_HEAD`          | merge       |
| `rebase-merge/`       | rebase      |
| `rebase-apply/`       | rebase      |
| `CHERRY_PICK_HEAD`    | cherry-pick |
| `REVERT_HEAD`         | revert      |

If none exist and no conflicted files found: **STOP** with "No conflicts detected."

Identify both sides:
- **Ours**: current branch (HEAD)
- **Theirs**: incoming branch from the relevant HEAD file

## 2. Argument Parsing

Parse `$ARGUMENTS` for:

| Pattern       | Action                                                    |
| ------------- | --------------------------------------------------------- |
| `--abort`     | Abort the active operation and exit                       |
| `--dry-run`   | Show proposed resolutions without writing files           |
| `--ours`      | Prefer our side for all conflicts                         |
| `--theirs`    | Prefer their side for all conflicts                       |
| `<file path>` | Only resolve conflicts in specified file(s)               |

## 3. Safety Checks

1. Run `git diff --name-only --diff-filter=U` to list conflicted files. If empty: **STOP**
2. Warn about unstaged non-conflict changes if present

## 4. Gather Context Per File

For each conflicted file:

1. Re-checkout with diff3: `git checkout --conflict=diff3 -- <file>`
2. Read the full file with conflict markers
3. Get commit history: `git log --merge -p -- <file>`
4. If complex, extract three versions via `git show :1:<file>`, `:2:`, `:3:`

## 5. Resolve Each File

Strategy:
- `--ours`/`--theirs`: accept specified side, keep non-conflicted changes from other
- Otherwise intelligent resolution:
  - **Complementary** changes: combine both
  - **Overlapping**: choose version preserving both intents, or synthesise
  - **Contradictory**: prefer more recent intent, explain choice
  - Whitespace: normalise to project style
  - Imports: include all, dedupe
  - Config: merge keys, prefer newer for dupes

Output per file:
```
<file path>
  Strategy: <ours | theirs | combined | synthesised>
  Reason: <brief explanation>
```

If `--dry-run`: show proposed content, do NOT write. **STOP** after all files.

Otherwise: write resolved content and `git add <file>`.

## 6. Completion

Run `git diff --name-only --diff-filter=U` to verify.

Output summary:
```
Resolved X of Y conflicted files.
<file>  <strategy>  <one-line reason>
```

**ASK**: "All conflicts resolved. Continue the <operation>? (yes/no)"

Only continue if user confirms. Otherwise: "Resolved files staged. Run `git <operation> --continue` when ready."
