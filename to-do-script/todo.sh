#!/usr/bin/bash

# This is a test script. 

usage() { # prints this text till EOF
  cat <<EOF
Usage: $0 [OPTION]

Options:
  -h, --help, help        Show this help text and exit.
  -a, --add               Add a new chore to your list.
  -d, --done              Mark a chore as done (delete by number).
  -l, --list              Show the current list.

When you run the script with no options it will prompt you for the to-do file.
Each task is stored as one line in that file.

Examples:
  $0 -a                   (add a chore interactively)
  $0 -l                   (list chores)
  $0 -d                   (delete a chore interactively)
EOF
}

case "$1" in
  -h|--h|--help|help)
    usage
    exit 0
    ;;
esac


# Obtaining filezzz to store the list.
echo -n "Would you like to create a new to-do file ? [y/n]: "
read -r ans
echo "$ans"
case "$ans" in
y|Y|yes|YES|Yes)
# enter name touch $name.txt
echo -n "Please enter name or path to the new to-do file: "
read -r file
filepath=$(realpath "$file.txt")
touch "$filepath"
echo "The new to-do file $filepath has been created."
;;
n|N|no|NO|No)
# please type the path to the file
echo -n "Please enter name or path to the file: "
read -r file
filepath=$(realpath "$file.txt")
if [ ! -f "$filepath" ]; then
    echo "File not found, will be created."
    touch "$filepath"
    sleep 1
fi
echo "The file $filepath has been chosen."
;;
*)
echo "Please answer y or n."
exit 1
;;
esac

sleep 1

# this file will be the storage for the the list because arrays reset at run-time as far as ik
IFS=$'\n' read -r -d '' -a list < <(cat "$filepath"; printf '\0') # separate tasks in the file by newline, stop when '' is reached, put in array
# also ignore escape sequences in the tasks

case "$1" in
-a|--add)
echo -n "Enter the new chore : "
read newchore
list+=("$newchore") 
echo -e "\n$newchore" >> "$filepath"
echo "Added $newchore"
;;

-d|--done)
echo -n "Type the serial number of the chore to be deleted : "
read deln
delindex=$(($deln - 1))
echo "Deleting the chore: [$deln] ${list[delindex]}"
unset 'list[delindex]'
list=("${list[@]}")
printf "%s\n" "${list[@]}" > "$filepath"
;;

-l|--list) 
echo "LIST"
echo -e "Your list is :- \n "

for ((i=0; i<${#list[@]}; i++)); 
do 
    echo "[$((i+1))] ${list[i]}"
done
echo "Number of items : ${#list[@]}"
;;
*)
echo "Wrong usage."
usage
;;
esac



