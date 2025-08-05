#!/bin/bash
target="audio"
targeta=(a u d i o)

read guess
validate_guess() {
    if [ "${#1}" -ne 5 ]; then
        return 1
    else
        check=$(grep -iwx $1 ./guesses)
        if [ "$check" = "$1" ]; then
            return 0    # success
        else
            return 1    # not found
        fi
    fi
}

create_hints() {
    lettersa=(0 0 0 0 0)
    targetchk=(0 0 0 0 0)
    guessa=(${1:0:1} ${1:1:1} ${1:2:1} ${1:3:1} ${1:4:1})
    for i in {0..4}; do
        if  [ ${guessa[$i]} = ${targeta[$i]} ]; then
            lettersa[$i]=1
        fi
    done
    for j in {0..4}; do
        if [ ${lettersa[$j]} -eq 0 ]; then      # if the letter is does not exactly map, check it
            brk=0
            k=0
            while (($k < 5)) && (($brk == 0)); do       # constraints for the word
                if [ ${targetchk[$k]} -eq 0 ]; then     # if this is comparing to an index in the target that has not been satisfied yet
                    if [ ${guessa[$j]} = ${targeta[$k]} ]; then     # and the values are the same
                        lettersa[j]=2       # assign a 2
                        targetchk[k]=3      # mark the target index as satisfied 
                        brk=$((brk+1))      # break
                    fi
                fi
                k=$((k+1))
            done
        fi
    done
    for m in {0..4}; do
        printf "${lettersa[m]}\n"
    done

}

if validate_guess $guess 1 ; then
    if [ $guess = $target ]; then
        printf "solved!\n"
    else
        create_hints $guess
        printf "not solved\n"
    fi
else
    exit
fi

