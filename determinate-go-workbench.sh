#!/usr/bin/env bash

# use ./determiante-go-workbench.sh <folder-name> where <folder-name> is a string you write down in the terminal.
# This script has by objective to create a folder you name, then invokes a golang development flake created by Determinate Systems but the copy I backed up in github/alabamasystem and then you have a working environment for golang applications
# hope this is actually useful

set -euo pipefail

LOG_FILE="determinate_trace.log"

# Pre-Flight Control
# File Existence
: > "$LOG_FILE"

footprint() {
    local stage=$1
    {
        echo "[i] Stage $stage"
        echo "[t]   : $(date '+%Y-%m-%d %H:%M:%S')"
        echo "[p]   : $$"
        echo "[pp]  : $PPID"
        echo "[cwd] : $(pwd)"
        echo ""
    } >> "$LOG_FILE"
}

footprint "Script Initialized"


if [ $# -eq 0 ]; then
  echo "no arguments provided" >&2
  exit 1
fi

TARGET_DIRECTORY="$1"

if [ ! -d "${TARGET_DIRECTORY}" ]; then
    echo "Creating directory: ${TARGET_DIRECTORY}"
    mkdir -p "${TARGET_DIRECTORY}"
fi

footprint "Pre-Migration"

cd "${TARGET_DIRECTORY}"

footprint "Post-Migration"

echo "[i] Initiating Go Development Environment in target folder ${TARGET_DIRECTORY}"
nix develop github:alabamasystem/determinate-go -c "${SHELL}"
