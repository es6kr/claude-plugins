# Claude Plugins by es6.kr

A collection of Claude Code plugins for code quality and project automation.

## Plugins

### [code-quality](./plugins/code-quality)

Code review and commit management tools.

- **commit-reviewer** (Agent): Review individual commits for convention compliance
- **commit-splitter** (Skill): Analyze and recommend commit splitting strategies

### [project-automation](./plugins/project-automation)

Automation toolkit for creating agents, skills, and workflows.

- **agentify** (Skill): Convert functionality into appropriate automation type
- **skill-writer** (Skill): Guide for creating Agent Skills
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
make install PLUGIN=project-automation
make install PLUGIN=code-quality
```

### Verify Installation

```bash
ls ~/.claude/plugins/marketplaces/es6kr-plugins/plugins/
# Should show: code-quality  project-automation
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
