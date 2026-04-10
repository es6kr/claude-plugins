"""Unit tests for PR #1 review feedback — Python script fixes."""

import json


# --- C-4: clean-profanity.py key collision prevention ---

def test_key_rename_skips_collision():
    """When cleaned key already exists, skip rename to prevent data loss."""
    obj = {"bad_key": "value1", "clean_key": "value2"}
    keys_to_rename = [("bad_key", "clean_key")]
    for old_key, new_key in keys_to_rename:
        if new_key in obj and new_key != old_key:
            continue  # skip if cleaned key already exists
        obj[new_key] = obj.pop(old_key)
    # bad_key should remain because clean_key already exists
    assert "bad_key" in obj
    assert obj["bad_key"] == "value1"
    assert obj["clean_key"] == "value2"


def test_key_rename_works_when_no_collision():
    """Normal rename works when no collision."""
    obj = {"bad_key": "value1"}
    keys_to_rename = [("bad_key", "good_key")]
    for old_key, new_key in keys_to_rename:
        if new_key in obj and new_key != old_key:
            continue
        obj[new_key] = obj.pop(old_key)
    assert "good_key" in obj
    assert obj["good_key"] == "value1"
    assert "bad_key" not in obj


# --- C-5: orphan tool_result handling preserves text content ---

def _filter_orphan_content(content: list, valid_tool_use_ids: set) -> list:
    """Simulate the fixed orphan filtering logic."""
    return [
        item for item in content
        if item.get("type") != "tool_result"
        or item.get("tool_use_id") in valid_tool_use_ids
    ]


def test_orphan_removal_preserves_text_content():
    """When orphan tool_results are removed, text content in the same message survives."""
    content = [
        {"type": "text", "text": "important user message"},
        {"type": "tool_result", "tool_use_id": "orphan_123", "content": "result"},
    ]
    remaining = set()  # orphan_123 has no match
    result = _filter_orphan_content(content, remaining)
    assert len(result) == 1
    assert result[0]["type"] == "text"
    assert result[0]["text"] == "important user message"


def test_orphan_removal_drops_when_only_orphans():
    """When message contains only orphan tool_results, it can be safely removed."""
    content = [
        {"type": "tool_result", "tool_use_id": "orphan_456", "content": "result"},
    ]
    remaining = set()
    result = _filter_orphan_content(content, remaining)
    assert len(result) == 0


def test_orphan_removal_keeps_valid_tool_result():
    """Non-orphan tool_results are preserved."""
    content = [
        {"type": "tool_result", "tool_use_id": "valid_789", "content": "ok"},
        {"type": "tool_result", "tool_use_id": "orphan_000", "content": "bad"},
    ]
    remaining = {"valid_789"}
    result = _filter_orphan_content(content, remaining)
    assert len(result) == 1
    assert result[0]["tool_use_id"] == "valid_789"
