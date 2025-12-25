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

#### skill-writer

Guide for creating Agent Skills with proper structure and best practices.

**Trigger**: "create a skill", "write a skill", "SKILL.md help"

**Features**:
- Step-by-step skill creation guidance
- Frontmatter validation
- Description optimization for discovery
- Troubleshooting tips

#### next-action

Suggest logical follow-up actions after task completion.

**Trigger**: Automatically activates after completing tasks

**Features**:
- Context-aware suggestions
- 2-4 actionable options
- Immediate execution on selection

## Installation

```bash
claude /install-plugin github.com/es6kr/claude-plugins/plugins/project-automation
```

## Usage

### Agentificate

```
User: I want to automate my code review process
Claude: [Analyzes requirements]

## Automation Type Recommendation

Based on your requirements:
- **Recommended**: Agent
- **Reason**: Requires autonomous multi-step execution and tool use

Where should this automation be deployed?
- Open Source (publish to marketplace)
- Team/Project (git commit, share with team)
- Personal (save to ~/.claude/)
```

### Skill Writer

```
User: Help me create a skill for PDF processing
Claude: [Uses skill-writer skill]

## Creating PDF Processor Skill

Let me guide you through creating this skill:

1. **Scope**: PDF text extraction, form filling, merging
2. **Location**: ~/.claude/skills/pdf-processor/
3. **Frontmatter**: [generates proper YAML]
4. **Instructions**: [step-by-step guidance]
```

### Next Action

```
User: [After completing a bug fix]
Claude: Bug fix complete.

What would you like to do next?
- Add regression test (prevent bug recurrence)
- Commit (git commit the fix)
- Done (no additional work needed)
```

## Reference Files

The agentify skill includes detailed reference documentation:

- `references/hook-examples.md` - Hook patterns and examples
- `references/agent-templates.md` - Agent creation templates
- `references/plugin-creation.md` - Open-source plugin guide

## License

MIT

Note: `skills/skill-writer/SKILL.md` is derived from [PyTorch](https://github.com/pytorch/pytorch/tree/main/.claude/skills/skill-writer) and is licensed under BSD 3-Clause License.
