#
# TODO better no data loss solution without pollution
#
# Ensure that the history is saved in a file that persists between sessions                                              
if [[ -z ${HISTFILE} ]]; then
  export HISTFILE="${HOME}/.bash_history"
fi

# Set a large value for the number of commands to store in the history file                                              
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Append new commands to the history file, don't overwrite it                                                            
shopt -s histappend
