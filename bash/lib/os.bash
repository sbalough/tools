function os_is_darwin {
    [[ "$(uname)" =~ "Darwin" ]] && return 0 || return 1
}

#
# @param cmd
#
function os_have_cmd(){
    if command -v "$1"; then
	return 0
    else
	return 1
    fi
}
