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

# Hosts URLs source https://git.frostnerd.com/PublicAndroidApps/smokescreen/-/blob/master/app/src/main/java/com/frostnerd/smokescreen/fragment/DnsRuleFragment.kt#L691-719
declare -a HOSTS_URLS=(
  'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
  'https://adaway.org/hosts.txt'
  'https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt'
  'https://github.com/Ultimate-Hosts-Blacklist/ZeroDot1_CoinBlockerLists/raw/refs/heads/master/domains.list'
  'https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt'
  'https://hblock.molinero.dev/hosts'
  'https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt'
  'https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt'
)

for url in "${HOSTS_URLS[@]}"; do
  echo "URL is ${url}"
  head -n3 <(curl -sSL "${url}" 2> /dev/null)
done
