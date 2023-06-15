#!/bin/bash

# Show usage if no argument is passed
if [ -z "$1" ]
then
    echo "Usage: ./x4rk.sh <host>"
    exit 1
fi

printf "\n------ PORT SCAN ------\n" > recon.txt
echo "Running nmap..."
nmap $1 | tail -n +5 | head -n -3 >> recon.txt

# Searching for some open HTTP port
while read -r line
do
    if [[ $line == *open* ]] && [[ $line == *http* ]]
    then
        # echo "Running dirb..."
        # dirb -S http://$1/ /usr/share/dirb/wordlists/common.txt > tmp1
        echo "Running whatweb..."
        whatweb $1 -v > tmp2
    fi
done < recon.txt

# Showing and storing recon results
if [ -e tmp1 ]
then
    printf "\n\n------ DIRECTORIES ------\n\n" >> recon.txt
    cat tmp1 >> recon.txt
    rm tmp1
if [ -e tmp2 ]
then
    printf "\n\n------ WEB SERVER INFORMATION ------\n\n" >> recon.txt
    cat tmp2 >> recon.txt
    rm tmp2
fi
cat recon.txt