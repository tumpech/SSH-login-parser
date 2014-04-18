#!/bin/bash
function c {
declare -a cn=("${!1}")
read ch
case $ch in
''|*[!0-9]*) echo "Your choice is not a number." && c $1;;
*)if [ $ch -lt ${#cn[*]} ]
then
        echo ${cn[$ch]}
        eval ${cn[$ch]}
else
        echo "Well, I wrote everything down from 0 to $[${#cn[*]} - 1] please write between those."
        c $1
fi;;
esac
}

c_file=connections.txt
echo "Searching for $1"
IFS=$'\n'
conn=($(egrep -i ssh.*$1 $c_file))
unset IFS
case ${#conn[*]} in
        0) echo "No luck my master, try again." && exit;;
        1) echo "Connecting" &&  eval $conn;;
        *)
                "Found these:"
                for i in ${!conn[*]}; do
                        echo $i")" ${conn[$i]}; done
                echo "Please make your choice: "
                c conn[@];
esac
