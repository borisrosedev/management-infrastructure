#!/bin/bash 

CYAN_COLOR="\033[1;36m"
GREEN_COLOR="\033[1;32m"
RED_COLOR="\033[1;31m"
NO_COLOR="\033[0m"

#shellcheck disable=all


function search_mtime {
    echo -e "🚀$CYAN_COLOR searching files edited within 24h :  $NO_COLOR"
    find . -mtime -1
}

function find_suspects {
    echo -e "🚀$RED_COLOR searching suspect files with $1 extension :  $NO_COLOR"
    find ./ -name "*.$1" -exec grep "malware" {} \;
    find ./ -name "*.$1" -exec grep "virus" {} \;
    find ./ -name "*.$1" -exec grep "worm" {} \;
}


function search_for_type {
    echo "🚀search for type => $1 : "
    find . -type f -name "*.$1"
}

