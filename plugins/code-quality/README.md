# Code Quality Plugin

Code quality tools for commit management and skill lifecycle.

## Features

### Agents

#### commit-reviewer

Review individual commits for convention compliance. Complements the official [code-review](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-review) plugin which handles PR-level reviews.

**Trigger**: Automatically launched after git commits

**Features**:
- Reviews commit changes against CONTRIBUTING.md conventions
- Detects linter configurations and code patterns
- Generates CONTRIBUTING.md if missing
- Interactive issue handling

**Difference from code-review@claude-plugins-official**:

| Aspect | code-review (official) | commit-reviewer (this) |
|--------|----------------------|------------------------|
| Scope | PR-level | Individual commits |
| Trigger | `/code-review` command | After each commit |
| Focus | 4 parallel agents, confidence scoring | CONTRIBUTING.md compliance |
| Creates | Review comments on PR | CONTRIBUTING.md if missing |

### Skills

#### commit-tidy

Analyzes staged/committed changes and recommends splitting or squashing strategies.

**Trigger**: "commit split", "split commits", "should I split this commit", "squash commits", "tidy commits"

**Decision Criteria**:
- Unrelated functionality changes
- Mixed change types (feat + fix + refactor)
- Wide file spread across directories
- Large diff size
- Consecutive WIP or agent-loop commits (squash candidates)

#### skill-toolkit

Skill lifecycle management: create, lint, merge, convert, deduplicate, and upgrade skills.

**Trigger**: "skill-toolkit", "skill lint", "skill merge", "skill dedup", "skill convert", "skill upgrade"

**Features**:
- **writer**: Create new skills with proper structure
- **lint**: Validate and fix SKILL.md frontmatter
- **merge**: Combine related skills into one
- **convert**: Convert agents to skills
- **dedup**: Find duplicate skills
- **upgrade**: Add topics and improve existing skills

## Installation

```bash
make install PLUGIN=code-quality
```

## License

MIT
