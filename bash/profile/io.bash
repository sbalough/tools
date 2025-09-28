_sd="$(dirname "${BASH_SOURCE[0]}")"
. "$_sd/colors.bash"


io_textbar(){
    echo $(perl -e "print('='x'$1')")
}
io_width(){
    echo -e "$*" | xargs -iHERE perl -e 'print length(qq(HERE))."\n"' | sort -nr | head -n1
}



#
# @param msg
#
io_warn() {
    local msg="$*"

    local lineMax=$(io_width "$*")
    if [[ $lineMax -lt 60 ]]; then
	lineMax=60
    fi
    
    local con="${On_IYellow}${BIBlack}"
    local coff="${Color_Off}"
    local bar=$(io_textbar $lineMax)
    echo -e "$con${bar}$coff"
    echo -e "$con$(printf "%-${lineMax}s" "$msg")$coff"
    echo -e "$con${bar}$coff"
}


#
# @param msg
# @param rc
#
io_fail() {
    local msg="${1-}"
    
    local rc=
    if [ -z "${2-}" ]; then
	rc=1
    else
	rc="$2"
    fi
    
    if [ -n "${3-}" ]; then
	echo "too many args" >&1
	exit 1
    fi
    local lineMax=$(io_width "$*")
    if [[ $lineMax -lt 60 ]]; then
	lineMax=60
    fi
    
    local con="${On_IYellow}${BIRed}"
    local coff="${Color_Off}"
    local bar=$(io_textbar $lineMax)
    echo -e "$con${bar}$coff"
    echo -e "$con$(printf "%-${lineMax}s" "$msg")$coff"
    echo -e "$con${bar}$coff"
    exit $rc
}

#
# @param ...whatever
#
io_ok(){
    local msg=$(printf "    %s    " "$*")
    echo -e "${On_IGreen}${BIBlack}$msg${Color_Off}"
}

