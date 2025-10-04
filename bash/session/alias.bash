_sd="$(dirname "${BASH_SOURCE[0]}")"

# shellcheck source=bash/lib/os.bash
. "${_sd}/../lib/os.bash"

# shellcheck source=bash/lib/io.bash
. "${_sd}/../lib/io.bash"

declare -A _variant_by_cmd

#
# On a mac, install the gnu versions of the
# bsd command below.  We will use GNU everywhere
# and not bother learning BSD.
#
for c in "date" "grep" "xargs"; do
    if os_is_darwin; then
	if ! os_have_cmd "g${c}"; then
	    io_warn "missing g${c}: brew install g${c}"
	fi
	_variant_by_cmd["${c}"]="g${c}"

	# default alias
	eval "alias ${c}=g${c}"
    else
	_variant_by_cmd["${c}"]="${c}"
    fi
done

function _get_cmd() {
    local cmd="${1}"
    if [[ -v _variant_by_cmd["${cmd}"] ]]; then
	echo "${_variant_by_cmd[${cmd}]}"
    else
	echo "${cmd}"
    fi
}

# shellcheck disable=SC2139,SC2312
alias ls="$(_get_cmd ls) --color=auto "

# shellcheck disable=SC2139,SC2312
alias grep="$(_get_cmd grep) --color=auto "

if os_is_darwin; then
    if ! os_have_cmd pbcopy; then
	io_warn "missing pbcopy/paste"
    fi
else
    if ! os_have_cmd xclip; then
	io_warn "need xclip for pbcopy/paste"
    fi
    alias pbcopy='xclip -selection clipboard '
    alias pbpaste='xclip -selection clipboard -o '
fi

