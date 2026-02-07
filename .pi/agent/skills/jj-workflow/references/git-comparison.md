# Jujutsu vs Git Comparison

Reference for Git users transitioning to Jujutsu.

## Key Conceptual Differences

| Aspect | Git | Jujutsu |
|--------|-----|---------|
| **Staging area** | Required (`git add`) | None - all changes tracked automatically |
| **Commits** | Immutable | Current change is mutable |
| **Working copy** | Separate from commits | Is a change (`@`) that can be modified |
| **Branches** | Required to organize work | Optional - can work with anonymous changes |
| **Conflict handling** | Blocks operations | Recorded as state, resolved later |

## Command Mapping

| Git Command | Jujutsu Equivalent |
|-------------|-------------------|
| `git status` | `jj status` |
| `git log` | `jj log` |
| `git diff` | `jj diff` |
| `git add` | Not needed - automatic |
| `git commit -m "msg"` | `jj describe -m "msg"` |
| `git commit -am "msg"` | `jj new -m "msg"` |
| `git checkout -b name` | `jj branch create name` |
| `git branch` | `jj branch list` |
| `git checkout name` | `jj branch checkout name` |
| `git pull` | `jj tug` |
| `git push` | `jj git push` |
| `git fetch` | `jj git fetch` |
| `git rebase` | `jj tug` (automatic) |
| `git reset --soft` | Not needed - just modify `@` |
| `git reset --hard` | `jj op restore <id>` |
| `git commit --amend` | Just edit files and use `jj describe` |
| `git squash` | `jj squash` |

## Workflow Differences

### Starting New Work

**Git:**
```bash
git checkout -b feature
git add .
git commit -m "feat: new feature"
```

**Jujutsu:**
```bash
jj new -m "feat: new feature"
# Changes are automatically tracked
```

### Amending Last Commit

**Git:**
```bash
git add file
git commit --amend --no-edit
```

**Jujutsu:**
```bash
# Just edit the file - it's automatically included
jj describe -m "updated message"  # Optional: update message
```

### Rebasing

**Git:**
```bash
git fetch origin
git rebase origin/main
# Resolve conflicts
git add .
git rebase --continue
```

**Jujutsu:**
```bash
jj tug
# Resolve conflicts
jj resolve
jj continue  # Only if interrupted
```

### Undoing Changes

**Git:**
```bash
git reset --hard HEAD^    # Lose changes
git reset --soft HEAD^    # Keep changes staged
```

**Jujutsu:**
```bash
jj new                     # Finalize current change
jj squash                  # Squash into parent (keep changes)
jj abandon                 # Abandon current change (lose changes)
```

## Mental Model Shifts

### No Staging Area
In Git, you explicitly stage files before committing. In Jujutsu, all uncommitted changes are part of the current change (`@`). To commit, you create a new change with `jj new`.

### Mutable Working Copy
In Git, commits are immutable. To modify, you create new commits. In Jujutsu, the current change (`@`) is mutable—you can continue editing it until you finalize it with `jj new`.

### Anonymous Branches
In Git, you need named branches to organize work. In Jujutsu, you can work without named branches using change IDs. Named branches (`jj branch`) are optional convenience.

### Change IDs vs Commit IDs
- **Change ID** (e.g., `kkmpptxz`): Stable identifier that survives rebases
- **Commit ID** (SHA): Immutable snapshot identifier

Use change IDs when referencing your own work—they'll stay the same across rebases.

## Common Pitfalls for Git Users

1. **Forgetting to create new changes** - Remember to run `jj new` to finalize work
2. **Looking for `git add`** - Not needed, all changes are tracked
3. **Expecting operations to block on conflicts** - jj records conflicts, work continues
4. **Using commit IDs instead of change IDs** - Change IDs are more stable for your work
5. **Pushing incomplete work** - Push only finalized changes, use `jj log -r 'remote_branches()..@'` to check
