# Common Jujutsu Patterns

Expanded workflows and patterns for common tasks.

## Essential Patterns

### Starting New Work
```bash
jj tug                              # Sync with remote
jj new -m "feat: new feature"       # Start new change
# ... make changes ...
jj new                              # Finalize and start next
```

### Amending Current Change
Simply make changes—they're automatically included in `@`. Use `jj describe` to update the message if needed.

### Rebasing onto Latest
```bash
jj tug    # Fetches and rebases in one command
```

### Viewing What Will Be Pushed
```bash
jj log -r 'remote_branches()..@'    # Changes not yet on remote
```

### Checkpoints
```bash
# Create checkpoint before risky work
jj new -m "checkpoint: all tests pass"
jj new -m "trying: experimental change"

# If needed, revert
jj op log
jj op restore <id>

# When done, squash onto checkpoint
jj squash -m "feat: final implementation"
```

## Advanced Patterns

### Bisecting to Find Bugs

Find the change that introduced a bug:

```bash
jj bisect init good..bad              # Start bisect
# jj will checkout a change
# Test if bug is present
jj bisect good|bad                   # Mark as good or bad
# Repeat until found
jj bisect reset                      # Exit when done
```

### Undoing Operations

View and reverse operations:

```bash
jj op log                    # View operation history
jj op undo                   # Undo last operation
jj op restore <id>           # Restore to specific state
```

### Abandoning Work

Discard changes you no longer need:

```bash
jj abandon                   # Abandon current change
jj abandon <change-id>       # Abandon specific change
```

Note: Abandoned changes can be recovered with `jj undo` if done recently.

### Splitting Changes

Split a large change into smaller logical units:

```bash
# Start with a large change
jj new -m "feat: big feature"
# Make many changes...

# Split specific files into separate change
jj split file1.py -m "feat: part 1"
jj split file2.py -m "feat: part 2"

# Or split interactively
jj split  # Will prompt for which changes to split
```

### Moving Changes Between Branches

Move a change to be a child of a different parent:

```bash
# View current state
jj log

# Move current change to new parent
jj rebase -d <new-parent-change-id>

# Or rebase a specific change
jj rebase -s <source-change> -d <dest-change>
```

### Comparing Changes

```bash
jj diff @- @          # Compare parent to current
jj diff main @        # Compare main branch to current
jj show <change-id>   # Show specific change details
```

### Searching History

```bash
jj log -r 'author("John")'            # Changes by author
jj log -r 'description("fix")'        # Changes with "fix" in message
jj log -r 'branches()'                # Changes on any branch
jj log -r 'remote_branches()'         # Changes on remote branches
```

### Working with Multiple Remotes

```bash
jj git list-remotes                           # List remotes
jj git fetch --remote origin                  # Fetch specific remote
jj git push --branch main --remote origin     # Push specific branch
```

## Collaboration Patterns

### Reviewing Colleague's Work

```bash
jj git fetch                          # Fetch latest
jj log -r 'remote_branches()'         # See remote changes
jj new -m "review: <name>'s work"     # Create change to review
jj describe --from <their-change-id>  # Inspect their change
```

### Creating Pull Requests

1. Push your branch:
```bash
jj branch create my-feature
jj git push --branch my-feature
```

2. After review and feedback:
```bash
jj new -m "fix: address review comments"
# Make changes...
jj git push --branch my-feature
```

### Merging Feature Branches

```bash
jj tug                                    # Sync
jj new -m "merge: feature-x into main"
jj merge main -m "merge: main into feature"
jj resolve                                # If conflicts
jj git push --branch main
```

## Maintenance Patterns

### Cleaning Up

Remove old or abandoned changes:

```bash
jj log                    # Review changes
jj abandon <change-id>    # Abandon unwanted changes
jj squash                 # Squash small related changes
```

### View Operation History

```bash
jj op log                 # All operations performed
jj op show <id>           # Details of specific operation
```

### Rewriting History Safely

Before bulk rewrites:

```bash
# Create checkpoint
jj new -m "checkpoint: before history rewrite"

# Perform rewrite operations
# ...

# If something goes wrong
jj op undo
# or
jj op restore <checkpoint-id>
```

## Testing Workflows

### Test-Driven Development

```bash
# Start with failing tests
jj new -m "test: feature tests failing"

# Write implementation
jj new -m "feat: implement feature"

# If tests pass, squash
jj squash -m "feat: implement feature with tests"
```

### Experimental Development

```bash
# Create experimental branch
jj new -m "exp: trying approach A"

# If it works, finalize
jj squash -m "feat: implemented approach A"

# If not, abandon and try something else
jj abandon
jj new -m "exp: trying approach B"
```
