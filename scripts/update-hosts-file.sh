#!/usr/bin/env bash
#!/data/data/com.termux/files/usr/bin/env bash
# Enable bash's unofficial strict mode
GITROOT=$(git rev-parse --show-toplevel)
# shellcheck disable=SC1091
. "${GITROOT}"/lib/strict-mode
strictMode
# Enabling utils
# shellcheck disable=SC1091
. "${GITROOT}"/lib/utils

declare -a HOSTS_URLS=(
  'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
  'https://adaway.org/hosts.txt'
  'https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt'
  'https://zerodot1.gitlab.io/CoinBlockerLists/hosts'
  'https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt'
  'https://hblock.molinero.dev/hosts'
  'https://www.netguard.me/hosts'
)

curl -sL "${HOSTS_URLS[@]}" | \
  sed '/\(local\|^#\|^$\|^\s*$\|^\s*#\|^255\.255\.255\.255\|^0\.0\.0\.0 0\.0\.0\.0\|^::1\|^ff0[02]:\)/d' | \
  sed 's!^\(127\|0\)\.0\.0\.\(1\|0\) !!g' | \
  sort -u | \
  sed 's!^!0\.0\.0\.0 !g'
