
#
# Stuff that's worth re-running per-session
#
if [[ -f /etc/bashrc ]]; then
    # shellcheck disable=SC1091
    . /etc/bash.bashrc
fi

if [[ ${BASH_VERSINFO[0]} -lt 5 ]]; then
    # shellcheck disable=SC2312
    echo "Bash is too old; bad path: $(command -v bash) ${BASH_VERSINFO[*]}" >&2
    exit 1
fi

PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
PATH="${PATH}:/usr/local/lib/rstudio/bin"
PATH="${PATH}:${HOME}/.local/kitty.app/bin"
export PATH

function ld(){
    local _sd
    local f
    f="${1}"
    _sd="$(dirname "${BASH_SOURCE[0]}")"
    echo "source ${_sd}/${f}.bash"

    # shellcheck source=bash/session/alias.bash
    # shellcheck source=bash/history.bash
    . "${_sd}/${f}.bash"
}

for f in "alias" "history"; do
    _sd="$(dirname "${BASH_SOURCE[0]}")"
    ld "${f}"
    #. "${_sd}/${f}.bash"
done


#
# NVM
#
export NVM_DIR="${HOME}/.nvm"

# shellcheck source=/dev/null
[[ -s "${NVM_DIR}/nvm.sh" ]] && \. "${NVM_DIR}/nvm.sh"  # This loads nvm

# shellcheck source=/dev/null
[[ -s "${NVM_DIR}/bash_completion" ]] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion


if [[ -z ${BASH_COMPLETION_INFO-} ]]; then
    if [[ -f "/etc/bash_completion" ]]; then
	. /etc/bash_completion
    else
	io_warn "Missing /etc/bash_completion"
    fi
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!


