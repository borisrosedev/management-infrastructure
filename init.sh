#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

WORKING_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

# shellcheck source=./constants.sh
if [[ -f "$WORKING_DIR/constants.sh" ]]; then
  # shellcheck disable=SC1091
  source "$WORKING_DIR/constants.sh"
else
  CYAN_COLOR=""
  RED_COLOR=""
  NO_COLOR=""
fi

search_mtime() {
    printf "🚀%b searching files edited within 24h : %b\n" "${CYAN_COLOR:-}" "${NO_COLOR:-}"
    find . -type f -mtime -1 -print
}

find_suspects() {
    local ext=${1:-}
    if [[ -z "$ext" ]]; then
        printf "Usage: %s <extension>\n" "${FUNCNAME[0]}"
        return 2
    fi
    printf "🚀%b searching suspect files with .%s extension : %b\n" "${RED_COLOR:-}" "$ext" "${NO_COLOR:-}"
    find . -type f -iname "*.${ext}" -print0 \
      | xargs -0 -r grep -HnEI -- 'malware|virus|worm' || true
}

search_for_type() {
    local ext=${1:-}
    if [[ -z "$ext" ]]; then
        printf "Usage: %s <extension>\n" "${FUNCNAME[0]}"
        return 2
    fi
    printf "🚀search for type => %s :\n" "$ext"
    find . -type f -iname "*.${ext}"
}


case "${1:-}" in
  mtime)        search_mtime ;;
  suspects)     shift; find_suspects "${1:-}" ;;
  type)         shift; search_for_type "${1:-}" ;;
  *)            printf "Usage: %s {mtime|suspects <ext>|type <ext>}\n" "$0"; exit 1 ;;
esac
