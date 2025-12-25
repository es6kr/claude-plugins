---
allowed-tools: Read, Edit, Bash(ghq:*), Bash(git:*), Bash(cat:*), Bash(ls:*)
argument-hint: <command> [args]
description: Manage SourceGit repositories and workspaces
---

# SourceGit Management Command

Manage SourceGit's preference.json from command line.

## Arguments

Parse `$ARGUMENTS` to determine the subcommand:

| Command | Description |
|---------|-------------|
| `add <path>` | Add repository at path |
| `add-ghq <url>` | Clone with ghq and add to SourceGit |
| `remove <path>` | Remove repository |
| `workspace <name>` | Create or switch workspace |
| `sync-ghq` | Sync all ghq repositories |
| `list` | List all repositories |
| (no args) | Show help |

## Configuration Path

| OS | Path |
|----|------|
| macOS | `~/Library/Application Support/SourceGit/preference.json` |
| Linux | `~/.config/SourceGit/preference.json` |
| Windows | `%LOCALAPPDATA%/SourceGit/preference.json` |

Detect platform and use appropriate path.

## Instructions

1. Read current preference.json
2. Parse the subcommand from `$ARGUMENTS`
3. **Warn user before editing** (except for `list` command):
   > ⚠️ SourceGit가 실행 중이면 변경사항이 덮어씌워집니다. 편집 전에 SourceGit를 종료해 주세요.
4. Execute the appropriate operation
5. Save changes to preference.json
6. Inform user to restart SourceGit

### add <path>

Add a repository to RepositoryNodes at root level:

```json
{
  "Id": "<absolute-path>",
  "Name": "<directory-name>",
  "Bookmark": 0,
  "IsRepository": true,
  "IsExpanded": false,
  "Status": null,
  "SubNodes": []
}
```

If path is relative, resolve to absolute path first.

### add-ghq <url>

1. Run: `ghq get <url>`
2. Get cloned path: `ghq list -p | grep <repo-name>`
3. Parse path to extract host/org/repo
4. Find or create group hierarchy in RepositoryNodes
5. Add repository under appropriate group

Group structure example for `github.com/es6kr/blog`:
- Find/create "github.com" group
- Find/create "es6kr" group under "github.com"
- Add "blog.git" repository under "es6kr"

### remove <path>

1. Find repository by Id matching the path
2. Remove from RepositoryNodes (handle nested groups)
3. Also remove from any Workspace.Repositories arrays

### workspace <name>

If workspace exists: set IsActive=true for this, IsActive=false for others
If workspace doesn't exist: create new workspace

```json
{
  "Name": "<name>",
  "Color": 4278221015,
  "Repositories": [],
  "ActiveIdx": 0,
  "IsActive": true,
  "RestoreOnStartup": true,
  "DefaultCloneDir": "~/works/<name>/"
}
```

### sync-ghq

1. Get all ghq repos: `ghq list -p`
2. For each repo path:
   - Parse host/org/repo from path
   - Check if already in RepositoryNodes
   - If not, add with proper group hierarchy
3. Report added repositories

### list

Output all repositories in tree format:

```
RepositoryNodes:
- github.com/
  - es6kr/
    - blog.git (main, 0 changes)
    - TextOverlay.git (main, 2 changes)
  - hyperledger/
    - indy-node-monitor.git (main)
- disp/
  - disp-flutter (temp, 6 changes)
  ...

Workspaces:
- Default (active)
- willkomo
- disp
- ghq
```

## Output

After each operation, confirm what was done and remind:

```
[Operation completed]

Restart SourceGit to see changes.
```
