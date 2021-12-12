function update_ohmyposh() {
  local OHMYPOSH_URL='https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-arm64'
  local OHMYPOSH_LOCATION="${HOME}/bin/oh-my-posh"
  echo 'Downloading latest oh-my-posh'
  curl -sL "${OHMYPOSH_URL}" -o "${OHMYPOSH_LOCATION}"
  echo 'Making oh-my-posh executable'
  chmod u+x "${OHMYPOSH_LOCATION}"
  ${OHMYPOSH_LOCATION} --version
}
