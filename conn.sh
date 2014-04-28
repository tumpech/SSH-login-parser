#!/bin/bash
function c {
declare -a cn=("${!1}")
read ch
case $ch in
q) echo Quitting!! && exit;;
''|*[!0-9]*) echo "Your choice is not a number." && c $1;;
*)if [ $ch -lt ${#cn[*]} ]
then
	clear
	echo ${cn[$ch]}
	eval "ssh -X ${cn[$ch]}"
	clear
else
	echo "Well, I wrote everything down from 0 to $[${#cn[*]} - 1] please write between those."
	c $1
fi;;
esac
}

clear
c_file=connections.txt
echo "Searching for $1"
IFS=$'\n'
conn=($(grep -i $1 $c_file | grep -v "#"))
unset IFS
case ${#conn[*]} in
	0) echo "No luck my lord, try again." && exit;;
	1) echo "Connecting" &&  eval "ssh -X $conn" && clear;;
	*)
		echo "Found these:"
		for i in ${!conn[*]}; do
			echo $i")" ${conn[$i]};	done
		echo "q) quitting from the script"
		echo "Please make your choice: "
		c conn[@];
esac
