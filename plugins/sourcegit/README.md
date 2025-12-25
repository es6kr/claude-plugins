# SourceGit Plugin

Manage SourceGit GUI client and ghq repository structure from Claude Code.

## Features

### Skills

#### sourcegit-manager

Automatically manages SourceGit's `preference.json`.

**Trigger**: "sourcegit", "add repository", "workspace"

**Features**:
- Add/remove repositories (`RepositoryNodes`)
- Manage workspaces (`Workspaces`)
- Auto-group ghq repositories (host/org/repo hierarchy)
- Manage custom actions (`CustomActions`)

#### repo-migrator

Migrate standard Git repositories to ghq bare + worktree structure.

**Trigger**: "gitmv", "ghq migrate", "repo migrate", "convert to ghq"

**Features**:
- Identify migration candidates (distinguish worktrees from regular repos)
- Execute migration using `gitmv` shell function
- Batch migration support
- Post-migration verification

### Slash Commands

#### /sourcegit

Repository and workspace management commands

```bash
/sourcegit add <path>              # Add repository
/sourcegit add-ghq <remote-url>    # Clone with ghq and add to SourceGit
/sourcegit list                    # List current repositories
/sourcegit remove <path>           # Remove repository
/sourcegit sync-ghq                # Sync all ghq repositories
/sourcegit workspace <name>        # Create/switch workspace
```

## Configuration

Settings file location:
- macOS: `~/Library/Application Support/SourceGit/preference.json`
- Linux: `~/.config/SourceGit/preference.json`
- Windows: `%APPDATA%/SourceGit/preference.json`

## Installation

```bash
claude /install-plugin github.com/es6kr/claude-plugins/plugins/sourcegit
```

## Usage

### Add Repository

```
User: Add current directory to SourceGit
Claude: [sourcegit-manager skill activated]
        Added repository to preference.json.
```

### Clone and Add via ghq

```
User: /sourcegit add-ghq github.com/es6kr/claude-code-session
Claude: Cloning with ghq and adding to SourceGit.
        Repository: /Users/david/ghq/github.com/es6kr/claude-code-session.git
        Group: github.com > es6kr
```

### Workspace Management

```
User: Create a disp workspace
Claude: Created workspace 'disp'.
        DefaultCloneDir: /Users/david/disp/
```

## JSON Structure

### RepositoryNodes

```json
{
  "Id": "uuid or path",
  "Name": "display name",
  "Bookmark": 0,
  "IsRepository": true/false,
  "IsExpanded": false,
  "Status": {
    "CurrentBranch": "main",
    "Ahead": 0,
    "Behind": 0,
    "LocalChanges": 0
  },
  "SubNodes": []
}
```

### Workspaces

```json
{
  "Name": "workspace name",
  "Color": 4278221015,
  "Repositories": ["path array"],
  "ActiveIdx": 0,
  "IsActive": true/false,
  "RestoreOnStartup": true,
  "DefaultCloneDir": "/path/to/dir/"
}
```

## License

MIT