---
name: sourcegit-manager
description: Manage SourceGit repositories, workspaces, and settings. "sourcegit", "SourceGit", "add repository to sourcegit", "workspace management", "sync ghq" 시 사용
allowed-tools:
  - Read
  - Edit
  - Bash(ghq:*)
  - Bash(git:*)
---

# SourceGit Manager

Manage SourceGit GUI client's preference.json from Claude Code.

## Configuration File Location

| OS | Path |
|----|------|
| macOS | `~/Library/Application Support/SourceGit/preference.json` |
| Linux | `~/.config/SourceGit/preference.json` |
| Windows | `%LOCALAPPDATA%/SourceGit/preference.json` |

Detect OS and use the appropriate path.

## When to Use

- User wants to add/remove a repository to SourceGit
- User wants to create/manage workspaces
- User wants to sync ghq repositories with SourceGit
- User mentions "sourcegit" or "SourceGit"

## Instructions

### Step 1: Read Current Configuration

Always read the current preference.json first:

```bash
cat ~/Library/Application\ Support/SourceGit/preference.json
```

### Step 2: Determine Operation

| User Request | Operation |
|--------------|-----------|
| "Add this repo to SourceGit" | Add to RepositoryNodes |
| "Create workspace X" | Add to Workspaces |
| "Sync ghq repos" | Scan ghq and update RepositoryNodes |
| "Remove repo X" | Remove from RepositoryNodes |

### Step 3: Execute Operation

#### Adding a Repository

1. Check if repository already exists in RepositoryNodes
2. Determine group structure (by host/org or custom)
3. Create node with proper structure:

```json
{
  "Id": "/path/to/repo",
  "Name": "repo-name",
  "Bookmark": 0,
  "IsRepository": true,
  "IsExpanded": false,
  "Status": null,
  "SubNodes": []
}
```

#### Creating Group Hierarchy (for ghq repositories)

For path like `/Users/david/ghq/github.com/es6kr/blog.git`:

1. Find or create host group: `github.com`
2. Find or create org group: `es6kr` (under github.com)
3. Add repository: `blog.git` (under es6kr)

Group node structure:
```json
{
  "Id": "uuid-v4",
  "Name": "group-name",
  "Bookmark": 0,
  "IsRepository": false,
  "IsExpanded": true,
  "Status": null,
  "SubNodes": [...]
}
```

#### Creating a Workspace

```json
{
  "Name": "workspace-name",
  "Color": 4278221015,
  "Repositories": [],
  "ActiveIdx": 0,
  "IsActive": false,
  "RestoreOnStartup": true,
  "DefaultCloneDir": "/path/to/default/clone/dir/"
}
```

### Step 4: Warn About Running SourceGit

**CRITICAL**: Before editing preference.json, always warn the user:

> ⚠️ SourceGit가 실행 중이면 변경사항이 덮어씌워집니다.
> 편집 전에 SourceGit를 종료해 주세요.

**Why**: SourceGit keeps preference.json in memory while running. Any external edits will be overwritten when SourceGit saves on exit.

### Step 5: Apply Changes

Use Edit tool to modify preference.json with the updated structure.

**Important**: Restart SourceGit to see the changes.

## ghq Integration

When user says "sync ghq" or "add-ghq":

1. Get ghq root: `ghq root`
2. List all ghq repos: `ghq list -p`
3. Parse each path to extract host/org/repo
4. Create hierarchical group structure
5. Add repositories under appropriate groups

### Clone and Add Workflow

For `/sourcegit add-ghq <url>`:

```bash
ghq get <url>
# Parse the result to get local path
# Add to RepositoryNodes with proper grouping
```

## Output Guidelines

- Confirm what was added/modified
- Show the group hierarchy if applicable
- Remind user to restart SourceGit if it's running

## Example Outputs

### Repository Added
```
Added repository to SourceGit:
- Path: /Users/david/works/my-project
- Group: (root level)

Restart SourceGit to see changes.
```

### ghq Repository Added
```
Cloned and added to SourceGit:
- Path: /Users/david/ghq/github.com/es6kr/blog.git
- Group: github.com > es6kr

Restart SourceGit to see changes.
```

### Workspace Created
```
Created workspace 'disp':
- DefaultCloneDir: /Users/david/disp/
- Color: Default blue

Switch to this workspace in SourceGit's workspace selector.
```