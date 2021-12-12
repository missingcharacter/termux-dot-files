#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

patchelf --add-needed /data/data/com.termux/files/home/.asdf/installs/ruby/2.6.8/lib/ruby/2.6.0/aarch64-linux/bigdecimal.so /data/data/com.termux/files/home/.asdf/installs/ruby/2.6.8/lib/ruby/2.6.0/aarch64-linux/bigdecimal/util.so
