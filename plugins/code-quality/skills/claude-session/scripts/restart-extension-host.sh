#!/bin/bash
# Extension Host restart script

# Method 1: VSCode CLI (recommended)
if command -v code &> /dev/null; then
    echo "Restarting Extension Host via VSCode CLI..."
    code --command "workbench.action.restartExtensionHost" 2>/dev/null && exit 0
fi

# Method 2: Cursor CLI
if command -v cursor &> /dev/null; then
    echo "Restarting Extension Host via Cursor CLI..."
    cursor --command "workbench.action.restartExtensionHost" 2>/dev/null && exit 0
fi

# Method 3: AppleScript (macOS fallback)
if [ "$(uname)" = "Darwin" ]; then
    echo "Attempting Extension Host restart via AppleScript..."
    osascript -e '
    tell application "System Events"
        keystroke "p" using {command down, shift down}
        delay 0.3
        keystroke "Developer: Restart Extension Host"
        delay 0.2
        key code 36
    end tell
    ' 2>/dev/null && exit 0
fi

echo "Please restart Extension Host manually:"
echo "  Cmd+Shift+P > 'Developer: Restart Extension Host'"
exit 1
