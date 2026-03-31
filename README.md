# Claude Plugins by es6.kr

A collection of Claude Code plugins for code quality, project automation, git tools, and dotfile management.

## Plugins

### [code-quality](./plugins/code-quality)

Code quality tools for commit management and skill lifecycle.

- **commit-reviewer** (Agent): Review individual commits for convention compliance
- **commit-tidy** (Skill): Analyze and recommend commit splitting/squashing strategies
- **skill-toolkit** (Skill): Skill lifecycle management (create, lint, merge, convert, upgrade)

### [dotfile-tools](./plugins/dotfile-tools)

Dotfile management tools.

- **chezmoi** (Skill): Chezmoi dotfile template management
- **dotfile** (Skill): Dotfile sync with chezmoi, syncthing, and MCP
- **omz** (Skill): Oh My Zsh plugin and custom configuration management

### [git-tools](./plugins/git-tools)

Git repository management tools.

- **git-repo** (Skill): ghq migration, SourceGit integration, worktree fixes, and duplicate repo merging

### [project-automation](./plugins/project-automation)

Automation toolkit for creating agents, skills, and workflows.

- **agentify** (Skill): Convert functionality into appropriate automation type
- **next-action** (Skill): Suggest follow-up actions after task completion

## Installation

### Option 1: Inside Claude Code (Recommended)

Use `/plugin` command to install via UI.

### Option 2: Terminal

```bash
cd ~/.claude/plugins/marketplaces
git clone https://github.com/es6kr/claude-plugins.git es6kr-plugins
cd es6kr-plugins
make add-marketplace
make install PLUGIN=code-quality
make install PLUGIN=project-automation
make install PLUGIN=git-tools
make install PLUGIN=dotfile-tools
```

### Verify Installation

```bash
ls ~/.claude/plugins/marketplaces/es6kr-plugins/plugins/
# Should show: code-quality  dotfile-tools  git-tools  project-automation
```

### Update

```bash
cd ~/.claude/plugins/marketplaces/es6kr-plugins
git pull
make update
```

## Author

- **es6.kr** - drumrobot43@gmail.com

## License

MIT
