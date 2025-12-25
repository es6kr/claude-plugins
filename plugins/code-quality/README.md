# Code Quality Plugin

Code review and commit management tools for Claude Code.

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

#### commit-splitter

Analyzes staged changes and recommends whether commits should be split.

**Trigger**: Activated when user mentions "commit split", "should I split this commit"

**Decision Criteria**:
- Unrelated functionality changes
- Mixed change types (feat + fix + refactor)
- Wide file spread across directories
- Large diff size

## Installation

```bash
claude /install-plugin github.com/es6kr/claude-plugins/plugins/code-quality
```

## Usage

### Code Review

After committing, the commit-reviewer agent activates automatically:

```
User: Commit the changes
Claude: Changes committed. Launching commit-reviewer agent...

## Code Review Results
**Commit:** abc1234
**Changed Files:** 3

| File | Status | Issues |
|------|--------|--------|
| src/api.ts | ✅ | - |
| src/utils.ts | ⚠️ | Missing JSDoc |
```

### Commit Splitting

Before committing large changes:

```
User: Should I split this commit?
Claude: [Analyzes staged changes]

## Analysis Results
### Recommendation: Split into 2 commits

**Commit 1**: feat: add user API
- src/api/user.ts
- tests/api/user.test.ts

**Commit 2**: fix: correct validation logic
- src/utils/validate.ts
```

## Configuration

No additional configuration required. The plugin uses project conventions from:
- `CONTRIBUTING.md`
- `.eslintrc` / `.prettierrc`
- `pyproject.toml` / `ruff.toml`

## License

MIT