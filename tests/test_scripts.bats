#!/usr/bin/env bats
# Unit tests for PR #1 review feedback — shell script fixes

SCRIPTS_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/../plugins/code-quality/skills/claude-session/scripts" && pwd)"
SKILL_KIT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/../plugins/code-quality/skills/skill-kit/scripts" && pwd)"

# --- A-1: trigger-compile.sh CRLF removal ---

@test "A-1: trigger-compile.sh has no CRLF line endings" {
  result=$(file "$SKILL_KIT_DIR/trigger-compile.sh")
  [[ "$result" != *"CRLF"* ]]
}

# --- A-3: purge-dead-sessions.sh path traversal prevention ---

@test "A-3: purge-dead-sessions rejects project name with .." {
  run bash "$SCRIPTS_DIR/purge-dead-sessions.sh" "../../etc"
  [ "$status" -ne 0 ]
  [[ "$output" == *"invalid project name"* ]]
}

@test "A-3: purge-dead-sessions rejects project name with /" {
  run bash "$SCRIPTS_DIR/purge-dead-sessions.sh" "foo/bar"
  [ "$status" -ne 0 ]
  [[ "$output" == *"invalid project name"* ]]
}

# --- A-4: purge-dead-sessions.sh assistant detection with spacing ---

@test "A-4: assistant detection matches without spaces" {
  echo '"type":"assistant"' | grep -cE '"type"\s*:\s*"assistant"' >/dev/null
}

@test "A-4: assistant detection matches with spaces" {
  echo '"type": "assistant"' | grep -cE '"type"\s*:\s*"assistant"' >/dev/null
}

@test "A-4: assistant detection matches with extra spaces" {
  echo '"type" : "assistant"' | grep -cE '"type"\s*:\s*"assistant"' >/dev/null
}

# --- A-5: restart-extension-host.sh no --command flag ---

@test "A-5: restart-extension-host.sh does not use --command flag" {
  ! grep -q '\-\-command' "$SCRIPTS_DIR/restart-extension-host.sh"
}

# --- C-1: destroy-session.sh project folder normalization ---

@test "C-1: destroy-session uses same normalization as find-session-id" {
  # Both should replace all non-alphanumeric with -
  destroy_pattern=$(grep 'sed' "$SCRIPTS_DIR/destroy-session.sh" | grep -o "s/\[^a-zA-Z0-9\]/-/g" || true)
  find_pattern=$(grep 'sed' "$SCRIPTS_DIR/find-session-id.sh" | grep -o "s/\[^a-zA-Z0-9\]/-/g" || true)
  [ -n "$destroy_pattern" ]
  [ "$destroy_pattern" = "$find_pattern" ]
}

# --- C-2: destroy-session.sh restart failure tolerance ---

@test "C-2: destroy-session tolerates restart-extension-host failure" {
  grep -q 'restart-extension-host.sh.*|| true' "$SCRIPTS_DIR/destroy-session.sh"
}

# --- C-3: rename-session.sh uses jq for JSON ---

@test "C-3: rename-session uses jq for JSON generation" {
  grep -q 'jq -nc' "$SCRIPTS_DIR/rename-session.sh"
}

@test "C-3: rename-session does not use printf for JSON" {
  ! grep -q "printf.*custom-title" "$SCRIPTS_DIR/rename-session.sh"
}
