export EDITOR=vim

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Hook direnv into your shell.
eval "$(asdf exec direnv hook bash)"

# A shortcut for asdf managed direnv.
direnv() { asdf exec direnv "$@"; }

# below is not needed after patchelf
#export LD_PRELOAD="${RUBY_BREW}/lib/ruby/gems/2.6.0/gems/bigdecimal-3.0.2/ext/bigdecimal/bigdecimal.so"
#patchelf --add-needed /data/data/com.termux/files/usr/lib/ruby/2.6.0/aarch64-linux-android/bigdecimal.so /data/data/com.termux/files/usr/lib/ruby/2.6.0/aarch64-linux-android/bigdecimal/util.so
export PATH="${PATH}:${HOME}/bin"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# https://ohmyposh.dev/
# load oh-my-posh prompt
eval "$(oh-my-posh --init --shell bash --config ${HOME}/.ohmyposh.json)"