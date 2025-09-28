#
# Stuff that's worth re-running per-session
#
set -euo pipefail
IFS=$'\n\t'

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [[ ${BASH_VERSINFO[0]} -lt 5 ]]; then
    echo "Bash is too old; bad path: $(which bash) ${BASH_VERSINFO[*]}" >&2
    exit 1
fi

_sd="$(dirname "${BASH_SOURCE[0]}")"
for f in "alias"; do
    . "$_sd/$f.bash"
done


#
# NVM
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [[ -z $BASH_COMPLETION_INFO ]]; then
    if [[ -f "/etc/bash_completion" ]]; then
	. /etc/bash_completion
    else
	io_warn "Missing /etc/bash_completion"
    fi
fi
