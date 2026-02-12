---
description: Generates a conventional commit message from staged changes and commits.
argument-hint: [optional context or --dry-run]
allowed-tools: Bash(git diff:*, git status, git log, git commit:*, git branch, git rev-parse)
---

# Task: Commit Staged Changes

Generate a conventional commit message from staged changes and execute the commit.

## 1. Initial Checks

### Current Branch

!git branch --show-current

### Repository Status

!git status

### Staged Changes

!git diff --cached

### Recent Commit History (Style Reference)

!git log -n 5 --oneline

## 2. Safety Checks

**Before proceeding, verify:**

1. **Staged Changes Exist**:
   - If `git status` shows "nothing to commit" or only untracked files: **STOP**
   - Output: "No staged changes found. Stage files with `git add` first."
   - Exit immediately.

2. **Branch Protection Warning**:
   - If current branch is `main`, `master`, or `production`:
   - Output warning: "⚠️ Committing directly to `[branch]`. Consider using a feature branch."
   - **ASK**: "Proceed with commit to `[branch]`? (yes/no)"
   - Only continue if user confirms.

## 3. Context Parsing

Parse `$ARGUMENTS` for special directives:

| Pattern                                | Action                                   |
| -------------------------------------- | ---------------------------------------- |
| `--dry-run`                            | Generate message only, do not commit     |
| `!BREAKING` or `breaking:`             | Mark as breaking change (`!` after type) |
| `Co-authored-by:`                      | Append to commit body                    |
| `Body:` or multi-line after blank line | Use as commit body                       |

**Example contexts:**

- `feat: add user authentication`
- `--dry-run feat: update API`
- `fix: resolve null pointer` + newline + `Body: Detailed explanation here`
- `feat!: remove deprecated endpoint` (or use `!BREAKING` flag)

## 4. Commit Message Generation

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Rules

**Subject Line (first line):**

- Format: `<type>(<scope>): <subject>` or `<type>!: <subject>` for breaking
- Max 50 characters (hard limit)
- Use imperative mood ("add" not "added")
- Do not end with period
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

**Breaking Changes:**

- Add `!` after type: `feat!:`, `fix!:` etc.
- Or add `BREAKING CHANGE: description` in footer

**Body (optional):**

- Include when detailed explanation needed
- Wrap at 72 characters
- Explain WHAT and WHY, not HOW

**Footer (optional):**

- Include Co-authored-by, References, Closes, etc.

### Style Guidelines

1. **Type Selection**:
   - `feat`: New features/functionality
   - `fix`: Bug fixes
   - `docs`: Documentation only
   - `style`: Formatting, missing semicolons, etc.
   - `refactor`: Code change neither fixes bug nor adds feature
   - `perf`: Performance improvements
   - `test`: Adding or correcting tests
   - `build`: Build system, dependencies
   - `ci`: CI/CD configuration
   - `chore`: Maintenance tasks
   - `revert`: Reverting previous commits

2. **Scope**:
   - Optional but recommended
   - Use component name: `auth`, `api`, `ui`, `deps`, `config`
   - Omit if change affects multiple areas

3. **Subject Generation**:
   - Analyse staged diff for affected files and patterns
   - Use file paths to infer scope
   - Look for keywords: "add", "fix", "remove", "update", "refactor"
   - Reference recent history for style consistency

## 5. Execution

### If `--dry-run`:

```
Proposed commit message:
─────────────────────────
<type>(<scope>): <subject>

[body if present]

[footer if present]
─────────────────────────
Character count: X (subject: Y)
Branch: <branch>
Run without --dry-run to commit.
```

### If committing:

1. **Single-line commit**:

   ```bash
   git commit -m "<type>(<scope>): <subject>"
   ```

2. **Multi-line commit** (with body/footer):

   ```bash
   git commit -m "<type>(<scope>): <subject>" -m "<body>" -m "<footer>"
   ```

3. **Handle pre-commit hook failures**:
   - If commit fails due to hooks, output: "Commit failed due to pre-commit hooks. Fix issues and retry, or use `git commit --no-verify` to bypass."

## 6. Success Output

On successful commit:

```
Committed to <branch>: <short-hash>
<type>(<scope>): <subject>
```

On failure:

```
Commit failed: <error message>
Staged changes preserved. Review and retry.
```
