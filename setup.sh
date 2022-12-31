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

UNAME_OUTPUT=$(uname -s)
case "${UNAME_OUTPUT}" in
    Linux*)
      msg_info "I will continue"
      ;;
    *)
      msg_fatal "UNKNOWN OS: ${UNAME_OUTPUT}"
esac

while getopts ":i:" opt; do
  case ${opt} in
    i)
      if [[ "$OPTARG" == "y" || "$OPTARG" == "n" ]]; then
        INSTALL_EVERYTHING="${OPTARG}"
      else
        usage
      fi ;;
    \?)
      usage ;;
    :)
      usage ;;
  esac
done

# Installing basics
# shellcheck disable=SC1091
. "${GITROOT}"/scripts/base
is_asdf_installed "${INSTALL_EVERYTHING:-''}"

# Actual dot-files
LINKS=('bashrc' 'bash_aliases' 'envrc' 'gitconfig' 'ohmyposh.json' 'tool-versions' 'vimrc')

function link_if_not_exists() {
  local FILE=${1}
  local DOT_FILE=${2:-"${FILE}"}
  local SOURCE_FILE="${GITROOT}/${FILE}"
  local TARGET_FILE="${HOME}/.${DOT_FILE}"
  if [[ -L "${TARGET_FILE}" || -e "${TARGET_FILE}" ]]; then
    local USER_REPLY
    msg_warn "${TARGET_FILE} exists" >&2
    read -p "Want me to overwrite it? " -n 1 -r USER_REPLY
    echo
    if [[ ${USER_REPLY} =~ ^[Yy]$ ]]; then
      ln -sf "${SOURCE_FILE}" "${TARGET_FILE}"
    fi
  else
    msg_info "Creating ${TARGET_FILE} symlink"
    ln -s "${SOURCE_FILE}" "${TARGET_FILE}"
  fi
}

for LINK in "${LINKS[@]}"; do
  link_if_not_exists "${LINK}"
done

# Install everything else
function install_everything_else() {
  # Install asdf plugins and tools' versions
  install_asdf_tool_versions
  configure_direnv

  msg_info "Sourcing ${HOME}/.bashrc"
  disableStrictMode
  # shellcheck disable=SC1091
  . "${HOME}"/.bashrc
  strictMode

  # Running post-install steps
  # shellcheck disable=SC1091
  . "${GITROOT}"/scripts/post-install
}

if [[ "${INSTALL_EVERYTHING:-''}" == 'y' ]]; then
  install_everything_else
  msg_info "I'm done!"
elif [[ "${INSTALL_EVERYTHING:-''}" == 'n' ]]; then
  msg_info "I'm done!"
else
  read -p "Want me to install everything else? " -n 1 -r USER_REPLY
  echo
  if [[ ${USER_REPLY} =~ ^[Yy]$ ]]; then
    install_everything_else
  else
    msg_info "I'm done!"
  fi
fi
