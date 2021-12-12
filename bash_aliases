alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias showversion="neofetch"
alias gitpushchange='git remote set-url --push origin'
alias gitcdroot='cd $(git rev-parse --show-toplevel)'
alias lowercaseuuid="uuidgen | tr -ds '-' '' | tr '[:upper:]' '[:lower:]'"
alias findterragruntcache='find . -type d -name ".terragrunt-cache"'
alias findterraformcache='find . -type d -name ".terraform"'
alias clearterragruntcache='find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;'
alias clearterraformcache='find . -type d -name ".terraform" -prune -exec rm -rf {} \;'
alias kdump='kubectl get all --all-namespaces'
alias kips='kubectl get nodes -o jsonpath={.items[*].status.addresses[?\(@.type==\"InternalIP\"\)].address}'
# If you want to see where cpu/memory is being used at
alias kpodscpu='kubectl top pods --containers --sort-by=cpu'

export ANSI_NO_COLOR=$'\033[0m'
function msg_info () {
  local GREEN=$'\033[0;32m'
  printf "%s\n" "${GREEN}${*}${ANSI_NO_COLOR}"
}

function msg_warn () {
  local YELLOW=$'\033[0;33m'
  printf "%s\n" "${YELLOW}${*}${ANSI_NO_COLOR}"
}

function msg_error () {
  local LRED=$'\033[01;31m'
  printf "%s\n" "${LRED}${*}${ANSI_NO_COLOR}"
}

function msg_fatal () {
  local RED=$'\033[0;31m'
  printf "%s\n" "${RED}${*}${ANSI_NO_COLOR}"
}

function to_lower() {
  echo "${1}" | tr '[:upper:]' '[:lower:]'
}

function to_upper() {
  echo "${1}" | tr '[:lower:]' '[:upper:]'
}

function update_ohmyposh() {
  local OHMYPOSH_URL='https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-arm64'
  local OHMYPOSH_LOCATION="${HOME}/bin/oh-my-posh"
  echo 'Downloading latest oh-my-posh'
  curl -sL "${OHMYPOSH_URL}" -o "${OHMYPOSH_LOCATION}"
  echo 'Making oh-my-posh executable'
  chmod u+x "${OHMYPOSH_LOCATION}"
  ${OHMYPOSH_LOCATION} --version
}

function asdf-all () {
  awk '{ print $1 }' ~/.tool-versions
}

function asdf-all-versions () {
  for i in $(asdf plugin list); do
    echo "Plugin ${i} and versions are $(asdf list ${i})"
  done
}

function httpval() {
  local URL=${1}
  curl --raw -LsD - -o /dev/null "${URL}" \
  | grep -v -E '(Connection:|Date:|Server:|X-Frame-Options:|Keep-Alive:|Content-Length:|Content-Type:|Via:|Retry-After:|Content-Language:|Vary:|Content-Encoding:|Transfer-Encoding:|Set-Cookie:)'
}

function parentpid() {
  local PROCESS_ID=${1}
  ps -o ppid= -p "${PROCESS_ID}" | xargs
}

function findcommands () {
  compgen -ac | grep "${1}"
}

function showmethecolours() {
  for i in {0..255}; do printf "\x1b[38;5;%smcolour%s\x1b[0m\n" "${i}" "${i}"; done
}

function virtualenv3() {
  python3 -m venv "${1}"
}

function gitgrepdiff() {
  local STRING="${1}"
  local DEFAULT_BRANCH="${2:-$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')}"
  local BRANCH="${3:-$(git branch --show-current)}"
  # see https://git-scm.com/docs/git-diff
  # --diff-filter=[(A|C|D|M|R|T|U|X|B)…[*]]
  local DIFF_FILTERS=${4:-A}
  # shellcheck disable=SC2046
  git grep -l "${STRING}" $(git diff "${DEFAULT_BRANCH}"..."${BRANCH}" --name-status --diff-filter="${DIFF_FILTERS}" | awk '{ print $2 }')
}

function gitgrepreplace () {
  local OLD_TEXT="${1}"
  local NEW_TEXT="${2}"
  local SEPARATOR="${3:-!}"
  local REPLACE="s${SEPARATOR}${OLD_TEXT}${SEPARATOR}${NEW_TEXT}${SEPARATOR}g"
  git grep -l "${OLD_TEXT}" | xargs sed -i "${REPLACE}"
}

function base64encodestring() {
  local TEXT="${1}"
  base64 -w 0 <<<"${TEXT}"
}

function base64decodestring() {
  local TEXT="${1}"
  base64 -d -w 0 <<<"${TEXT}"
}
