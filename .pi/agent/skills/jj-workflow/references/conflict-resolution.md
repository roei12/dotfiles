# Conflict Resolution in Jujutsu

Conflicts in Jujutsu are recorded as part of the change state and can be resolved at any time. Unlike Git, conflicts don't block operations—you can continue working while conflicts exist.

## Detecting Conflicts

```bash
jj status    # Shows if current change has conflicts
jj show @    # Displays conflict markers in file content
```

## Resolving Conflicts

### Manual Resolution

Conflicts are represented with conflict markers in files:

```
%%%%%%%
Left side of conflict
+++++++
Right side of conflict
>>>>>>>
```

Edit the file to resolve, then:

```bash
jj resolve    # Mark conflict as resolved
```

### Automated Resolution

```bash
jj resolve --tool <tool>    # Use specific merge tool
```

Common tools: `meld`, `vimdiff`, `kdiff3`, `opendiff`

## Abandoning Conflicted Changes

If you want to discard the conflicted change:

```bash
jj abandon    # Abandon current change
```

## Conflict Scenarios

### After `jj tug` (Rebase Conflicts)

When rebasing creates conflicts:

```bash
jj tug                    # May create conflicts
# Resolve conflicts in affected files
jj resolve                # Mark as resolved
jj continue               # Complete the rebase
```

### After Merging

When merging divergent changes creates conflicts:

```bash
jj new -m "merge feature"
# Resolve conflicts
jj resolve
```

## Viewing Conflict State

```bash
jj diff            # Shows unresolved conflicts
jj show            # Shows current state including conflicts
jj status          # Summary of conflict status
```

## Best Practices

1. **Resolve conflicts before pushing** - Conflicted changes cannot be pushed
2. **Use `jj resolve` explicitly** - Don't forget to mark conflicts as resolved
3. **Test after resolution** - Verify the resolved code works correctly
4. **Describe your resolution** - Update commit message if resolution is non-trivial

## Related Commands

- `jj diff` - Show changes including conflict markers
- `jj show` - Detailed view of current state
- `jj abandon` - Discard current change
- `jj squash` - Merge resolved conflict into parent
