#!/bin/bash
function c {
declare -a cn=("${!1}");
PS3="Please make your choice:"

echo "Found these:"
select ch in "${cn[@]}" "quit" ;
do case $ch in
                '')echo "No choice!"; continue;;
                'quit') echo "Bye :)" && exit;;
                *)local  resultvar=$2; eval $resultvar="'$ch'"; break;;
esac;done
}

function apc {
#read-file
bs=($(egrep -i "#.*$1" $c_file)) #name of matches
case ${#bs[*]} in #check match number
        0) echo "No luck my lord, try again." && exit;; #0=exit
        1) bn=$(egrep -in "$bs" $c_file | awk -F":" '{print $1}');; #1=connect
        *) c bs[@] ch; bn=$(egrep -in "^$ch$" $c_file | awk -F":" '{print $1}');; #more=choose/connect
esac
en=$(cat $c_file | awk "NR > $bn" | egrep -inm 1 "#" | awk -F":" '{print $1}') #sorting out specific connections
let en+=$bn
if [ "$en" -eq "$bn" ]; then
conn=($(cat $c_file | awk "NR > $bn"))
else
conn=($(cat $c_file | awk "NR > $bn && NR < $en"))
fi
}

. ssh-agent.sh #for automatic ssh-agent
clear
c_file=connections.txt #source file

if [ ! -f $c_file ]; then #source file check
 echo "$c_file not founs"; exit
fi

IFS=$'\n' #read-file
case $1 in
        "")echo "Searching for $1"; conn=($(grep -v "#" $c_file));; #incase there is no parameter
        -a)apc $2;; #read applications
        *)echo "Searching for $1"; conn=($(grep -v "#" $c_file | grep -i $1));; #read connections
esac
unset IFS

case ${#conn[*]} in #check match number
        0) echo "No luck my lord, try again." && exit;; #0=exit
        1) echo -e "Connecting to $conn \n" &&  eval "ssh -X $conn" && clear;; #1=connect
        *) c conn[@] ch; echo -e "Connecting to $ch\n"; eval "ssh -X $ch";; #more=choose/connect
esac
