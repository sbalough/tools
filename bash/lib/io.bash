_sd="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=bash/lib/colors.bash
. "${_sd}/colors.bash"


io_textbar(){
    perl -e "print('='x'$1')"
}

io_width(){
    echo -e "$*" | xargs -IHERE perl -e 'print length(qq(HERE))."\n"' | sort -nr | head -n1
}



#
# @param msg
#
io_warn() {
    local msg
    msg="$*"

    local lineMax
    lineMax=$(io_width "$*")
    if [[ ${lineMax} -lt 60 ]]; then
	lineMax=60
    fi
    
    local con
    con="${cl_On_IYellow}${cl_BIBlack}"
    
    local coff
    coff="${cl_Color_Off}"
    
    local bar
    bar="$(io_textbar "${lineMax}")"
    echo -e "${con}${bar}${coff}"
    echo -e "${con}$(printf "%-${lineMax}s" "${msg}")${coff}"
    echo -e "${con}${bar}${coff}"
}


#
# @param msg
# @param rc
#
io_fail() {
    local msg
    msg="${1-}"
    
    local rc
    rc=
    if [[ -z "${2-}" ]]; then
	rc=1
    else
	rc="${2}"
    fi
    
    if [[ -n "${3-}" ]]; then
	echo "too many args" >&1
	exit 1
    fi
    local lineMax
    lineMax=$(io_width "$*")
    if [[ ${lineMax} -lt 60 ]]; then
	lineMax=60
    fi
    
    local con
    con="${cl_On_IYellow}${cl_BIRed}"
    
    local coff
    coff="${cl_Color_Off}"
    
    local bar
    bar="$(io_textbar "${lineMax}")"
    
    echo -e "${con}${bar}${coff}"
    echo -e "${con}$(printf "%-${lineMax}s" "${msg}")${coff}"
    echo -e "${con}${bar}${coff}"
    exit "${rc}"
}

#
# @param ...whatever
#
io_ok(){
    local msg
    msg=$(printf "    %s    " "$*")
    echo -e "${cl_On_IGreen}${cl_BIBlack}${msg}${cl_Color_Off}"
}

