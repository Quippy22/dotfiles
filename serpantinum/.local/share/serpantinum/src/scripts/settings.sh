#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == */* ]]; then
    SCRIPT_DIR="$(cd -- "${BASH_SOURCE[0]%/*}" 2>/dev/null && pwd -P)"
else
    SCRIPT_DIR="$(pwd -P)"
fi

source "$SCRIPT_DIR/caching.sh" 2>/dev/null || true

if [ -z "$MAIN_QML" ]; then
    export MAIN_QML="$(find "$SCRIPT_DIR/../quickshell" -type f \( -name "Shell.qml" -o -name "Bar.qml" \) 2>/dev/null | head -n 1)"
fi

ACTION="open"
case "$1" in
    open|toggle|close) ACTION="$1"; shift ;;
esac
TAB="$1"
SUBTAB="$2"

if [[ -n "$MAIN_QML" ]]; then
    quickshell -p "$MAIN_QML" ipc call main embeddedSettings "$ACTION" "${TAB}${SUBTAB:+:$SUBTAB}" >/dev/null 2>&1
else
    quickshell ipc call main embeddedSettings "$ACTION" "${TAB}${SUBTAB:+:$SUBTAB}" >/dev/null 2>&1
fi
