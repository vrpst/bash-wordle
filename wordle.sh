#!/bin/bash
target="audio"
targeta=("a","u","d","i","o")

read guess
validate_guess() {
    if [ "${#1}" -ne 5 ]; then
        return 1
    else
        check=$(grep -iwx $1 ./targets)
        if [ "$check" = $1 ]; then
            return 0    # success
        else
            return 1    # not found
        fi
    fi
}

create_hints() {
    guessa=(${1:0:1},${1:1:1},${1:2:1},${1:3:1},${1:4:1})
    printf "$guessa\n"
    printf "$targeta\n"
}

if validate_guess $guess 1 ; then
    if [ $guess = $target ]; then
        printf "solved!"
    else
        create_hints $guess
        printf "not solved"
    fi
else
    exit
fi

