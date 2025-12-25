---
name: repo-migrator
description: Migrate standard Git repositories to ghq bare + worktree structure. "repo migrate", "convert to ghq", "ghq migrate" 시 사용
allowed-tools:
  - Read
  - Bash(git:*)
  - Bash(ghq:*)
---

# Repo Migrator

Migrate standard Git repositories to ghq bare + worktree structure.

## Script Location

`./scripts/repo-to-ghq.sh` - Converts current directory's Git repo to ghq structure.

## When to Use

- User wants to migrate a regular Git repository to ghq bare + worktree
- User mentions "convert to ghq", "repo migrate", "ghq migrate"

## How It Works

1. Moves `.git` directory to ghq path (e.g., `~/ghq/github.com/user/repo.git`)
2. Creates `.git` file pointing to the bare repo
3. Configures the bare repo with `core.worktree` pointing to original directory

## Instructions

### Step 1: Identify Target Repository

Check if the current directory or specified path is a regular Git repository (not a worktree):

```bash
# Check if it's a regular .git directory (not a file)
if [[ -d .git ]]; then
  echo "Regular Git repository - can migrate"
elif [[ -f .git ]]; then
  echo "Already a worktree - skip"
fi
```

### Step 2: Run Migration Script

```bash
# From the repository root
~/.claude/plugins/marketplaces/es6kr-plugins/plugins/sourcegit/skills/repo-migrator/scripts/repo-to-ghq.sh
```

Or with explicit target path:

```bash
~/.claude/plugins/marketplaces/es6kr-plugins/plugins/sourcegit/skills/repo-migrator/scripts/repo-to-ghq.sh ~/ghq/github.com/user/repo.git
```

### Step 3: Verify Migration

```bash
# Check .git is now a file
cat .git
# Should show: gitdir: /path/to/ghq/repo.git

# Verify git commands work
git status
```

### Step 4: Update SourceGit

After migration, add the new ghq repository path to SourceGit using the sourcegit-manager skill.

## Batch Migration

For migrating multiple repositories:

1. List candidates: `find ~/works -maxdepth 2 -type d -name ".git"`
2. For each, check if migration is needed
3. Run script in each directory

## Output

```
Repository moved to '/Users/david/ghq/github.com/es6kr/repo.git'.
Current directory is now set as the worktree.
```
