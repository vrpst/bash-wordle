#!/bin/bash
target="audio"
validate_guess() {
    read guess
    if [ "${#guess}" -ne 5 ]; then
        return 1
    else
        check=$(grep -iwx $guess ./targets)
        if [ "$check" = $guess ]; then
            return 0
        else
            return 1
        fi
    fi
}

if validate_guess 1 ; then
    printf "true\n"
else
    return 1
fi

