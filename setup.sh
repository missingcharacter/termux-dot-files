#!/data/data/com.termux/files/usr/bin/env bash
# Enable bash's unofficial strict mode
GITROOT=$(git rev-parse --show-toplevel)
# shellcheck disable=SC1091
. "${GITROOT}"/lib/strict-mode
strictMode
# shellcheck disable=SC1091
. "${GITROOT}"/lib/utils

THIS_SCRIPT=$(basename "${0}")
#PADDING=$(printf %-${#THIS_SCRIPT}s " ")

function usage() {
    msg_info "Usage:"
    msg_info "${THIS_SCRIPT} -i <Optional, 'y' or 'n'>"
    echo
    msg_error "Sets up base termux system"
    msg_fatal "-i avoids asking you every time if you want to install something or not"
}

# Ensure dependencies are present
if ! command -v git &>/dev/null; then
    msg_fatal "[-] Dependencies unmet. Please verify that the following are installed and in the PATH: git"
fi

MACHINE_OS="$(get_operatingsystem)"
export DEBIAN_FRONTEND='noninteractive'

INSTALL_EVERYTHING='n'
ASK='y'
while [[ $# -gt 0 ]]; do
  case "${1}" in
    -i|--install-everything)
      INSTALL_EVERYTHING='y'
      shift # past argument
      ;;
    -y|--yes)
      ASK='n'
      shift # past argument
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Unknown option ${1}"
      usage
      ;;
  esac
done

# Installing basics
# shellcheck disable=SC1090,SC1091
. "${GITROOT}/${MACHINE_OS}/base"
is_asdf_installed "${ASK:-''}"

# Actual dot-files
declare -a LINKS=('bashrc'
'bash_aliases'
'envrc'
'gitconfig'
'ohmyposh.json'
'tool-versions'
'vimrc')

for LINK in "${LINKS[@]}"; do
  link_if_not_exists "${GITROOT}/${LINK}" "${HOME}/.${LINK}"
done

if [[ "${INSTALL_EVERYTHING}" == 'y' ]]; then
  install_everything_else
fi

msg_info "I'm done!"
