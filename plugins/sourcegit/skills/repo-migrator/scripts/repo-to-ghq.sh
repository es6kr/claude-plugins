#!/bin/bash
# repo-to-ghq.sh - Convert standard Git repo to ghq bare + worktree structure
# Based on gitmv shell function

set -e

# Get ghq path from git origin
# Supports: SSH (git@host:user/repo), HTTPS (https://host/user/repo), HTTP (http://host/user/repo)
ghq_path() {
  local origin_url=$(git remote get-url origin 2>/dev/null)
  [[ -z "$origin_url" ]] && return 1

  local host user repo_name

  # HTTPS/HTTP: https://host/user/repo.git or http://host/user/repo
  if [[ $origin_url =~ ^https?://([^/]+)/(.+)/([^/]+)$ ]]; then
    host=${BASH_REMATCH[1]}
    user=${BASH_REMATCH[2]}
    repo_name=${BASH_REMATCH[3]%.git}
  # SSH: git@host:user/repo.git
  elif [[ $origin_url =~ ^git@([^:]+):(.+)/([^/]+)$ ]]; then
    host=${BASH_REMATCH[1]}
    user=${BASH_REMATCH[2]}
    repo_name=${BASH_REMATCH[3]%.git}
  # SSH with ssh:// prefix: ssh://git@host/user/repo.git
  elif [[ $origin_url =~ ^ssh://[^@]+@([^/]+)/(.+)/([^/]+)$ ]]; then
    host=${BASH_REMATCH[1]}
    user=${BASH_REMATCH[2]}
    repo_name=${BASH_REMATCH[3]%.git}
  else
    return 1
  fi

  echo "$HOME/ghq/$host/$user/$repo_name.git"
}

# Main function
main() {
  # Check if current directory is a Git repository
  if [[ ! -d .git ]]; then
    echo "Error: This is not a Git repository."
    exit 1
  fi

  local new_ghq_path
  if [[ -z "$1" ]]; then
    new_ghq_path=$(ghq_path)
  else
    new_ghq_path=$(realpath "$1")
  fi

  if [[ -z "$new_ghq_path" ]]; then
    echo "Usage: repo-to-ghq.sh [target_path]"
    echo "If target_path is not specified, it will be derived from git origin URL."
    exit 1
  fi

  # Check if target path already exists
  if [[ -e "$new_ghq_path" ]]; then
    echo "Error: Target path '$new_ghq_path' already exists."
    exit 1
  fi

  # Create parent directory and move .git
  mkdir -p "$(dirname "$new_ghq_path")"
  mv .git "$new_ghq_path"

  # Create gitdir file pointing to bare repo
  echo "gitdir: $new_ghq_path" > .git

  # Configure as non-bare with worktree
  git --git-dir="$new_ghq_path" config --bool core.bare false
  git --git-dir="$new_ghq_path" config core.worktree "$PWD"

  echo "Repository moved to '$new_ghq_path'."
  echo "Current directory is now set as the worktree."
}

main "$@"
