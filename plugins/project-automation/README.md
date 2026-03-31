# Project Automation Plugin

Claude Code automation toolkit for creating and managing agents, skills, and workflows.

## Features

### Skills

#### agentify

Convert functionality into the appropriate Claude Code automation type. Helps decide between Agent, Skill, Slash Command, or Hook based on requirements.

**Trigger**: "agentify", "automate this", "create an agent", "make a skill"

**Features**:
- Decision guide for automation type selection
- Distribution level recommendation (open source, team, personal)
- Marketplace search integration
- Combination pattern suggestions

#### next-action

Suggest logical follow-up actions after task completion.

**Trigger**: Automatically activates after completing tasks

**Features**:
- Context-aware suggestions
- 2-4 actionable options
- Immediate execution on selection

## Installation

```bash
make install PLUGIN=project-automation
```

## Reference Files

The agentify skill includes detailed reference documentation:

- `resources/hook-examples.md` - Hook patterns and examples
- `resources/agent-templates.md` - Agent creation templates

## License

MIT
