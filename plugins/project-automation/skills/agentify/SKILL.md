---
name: agentify
description: Convert functionality into Claude Code automation. Use when the user says "agentify", "agentic", "automate this", "create an agent", "make a plugin", "make a skill", or wants to automate a workflow as an agent, skill, or plugin.
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Skill
  - Bash(mkdir:*)
---

# Agentify

Guide users to convert functionality into the appropriate Claude Code automation type.

## When to Use

- User says "agentify [something]" or just "agentify"
- User wants to create an agent, skill, or plugin
- User wants to automate a repetitive workflow

## Quick Reference

| Type | Trigger | Best For |
| ---- | ------- | -------- |
| **Skill** | Auto (context match) | Instructions, domain guidance |
| **Agent** | Task tool delegation | Multi-step execution, tools |
| **Rules** | Auto (session start) | AI behavior constraints, project conventions |
| **Slash Command** | User types `/cmd` | Simple prompt templates |
| **Hook** | Events (tool use, etc) | Automation on actions |

→ Full comparison: [automation-decision-guide.md](./resources/automation-decision-guide.md)

## Workflow

### Step 1: Analyze Target & Check Duplicates

**If no target specified** ("agentify" alone):
- Review conversation for automation candidates
- Look for: verbose outputs, multi-step workflows, repeated patterns
- ⚠️ **MUST use `multiSelect: true`** when presenting candidates (users often want multiple)

**If target specified**:
1. Check local marketplaces first:
   - `~/.claude/plugins/marketplaces/*/plugins/*/`
   - Use `/skill-dedup` command to find overlaps
2. If not found locally, search remote: `WebFetch https://claudemarketplaces.com/?search=[keyword]`
3. If found → recommend existing or extend. If not → proceed to create

### Step 2: Gather Requirements

Use AskUserQuestion to clarify:
- **Trigger**: Automatic / Manual / Event-based
- **Scope**: Global (`~/.claude/`) / Project (`.claude/`)
- **Language**: code comments, variable names, documentation

→ Question patterns: [askuserquestion-patterns.md](./resources/askuserquestion-patterns.md)

### Step 3: Recommend Type

| Requirements | Type |
| ------------ | ---- |
| Auto + instructions | Skill |
| Auto + tool execution | Agent |
| Auto + constraints/conventions | Rules |
| Manual + simple | Slash Command |
| Event reaction | Hook |

### Step 4: Create

⚠️ **CRITICAL**: Follow the creation method for each type

**Skill** → **MUST** use skill-writer (do NOT create directly)
```
Skill tool: skill: "project-automation:skill-writer"
```

**Agent** → Create in `~/.claude/agents/` or `.claude/agents/`
→ [agent-templates.md](./resources/agent-templates.md)

**Rules** → Create in `~/.claude/rules/` or `.claude/rules/`
→ [rules-guide.md](./resources/rules-guide.md)

**Slash Command** → Create in `~/.claude/commands/` or `.claude/commands/`
→ [slash-command-syntax.md](./resources/slash-command-syntax.md)

**Hook** → Add to settings.json
→ [hook-examples.md](./resources/hook-examples.md)

**Plugin** (open source) →
→ [plugin-creation.md](./resources/plugin-creation.md)

### Step 5: Validate

- Verify file location
- Test activation/invocation
- Confirm expected behavior

## Plugin Structure

**Marketplace vs Cache**:
- **Marketplace** (`~/.claude/plugins/marketplaces/<marketplace>/plugins/<plugin>/`): Source of truth, edit here
- **Cache** (`~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/`): Runtime copy, loaded on session start

**Important**: Cache is loaded at session start. Marketplace edits require:
1. Manual sync to cache, OR
2. New session to reload

**Auto-sync hook**: `plugin-cache-sync.sh` syncs marketplace → cache on Edit/Write

## Output Guidelines

Keep responses concise:
- Use tables over verbose lists
- Link to references instead of inline
- Use AskUserQuestion instead of text options

## AskUserQuestion Defaults

| Context | multiSelect |
|---------|-------------|
| Automation candidates | **true** (users often want multiple) |
| Type selection | false (mutually exclusive) |
| Scope selection | false (one location) |
| Feature selection | **true** (additive choices) |
