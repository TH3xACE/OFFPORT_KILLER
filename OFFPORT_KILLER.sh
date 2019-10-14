#!/bin/bash
# This script was to developed to check for ports' potential service info offline 
# Version="version 0.1"
# Date Created : 14/10/2019
# Date of last modification : 14/10/2019
# @TH3_ACE - BLAIS David

# Future updates :
# 
#
#

##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[00;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m" 


function fn_main ()
{

#cat infile.txt | while read line

cat $ifile | while read line
do

aline=$line
ip=$( echo "$aline" | cut -d ":" -f 1 )
port=$( echo "$aline" | cut -d ":" -f 2 )

if [ $ip ]
then
if [ "$ip_tmp" != "$ip" ]
then
echo -e "\n"
echo "=============================================================="	
echo -e "${BOLD}${YELLOW} Result for the IP: $ip ${RESET}"
echo "=============================================================="
#echo -e "\n"
ip_tmp="$ip"

fi
echo -e "\n"
echo -e "${BOLD}${GREEN}Potential service detected for port: $port ${RESET}"
echo "--------------------------------------------------------------"
#echo "Service Name  Port No  Protocol  Description  Source"
#echo -e  "\n"
fi

if [ $port ]
then

#cat database.csv | grep -w " $port" | sed 's/ ,/NO NAME/g' | sed 's/,/  /g' | sed "s/Protocol:/`printf "\033[33mProtocol:\033[0m"`/g" | sed "s/Service Name:/`printf "\033[33mService Name:\033[0m"`/g" | sed "s/Port No:/`printf "\033[33mPort No:\033[0m"`/g" | sed "s/Source:/`printf "\033[33mSource:\033[0m"`/g" | sed "s/Description:/`printf "\033[33mDescription:\033[0m"`/g"


cat database.csv | grep -w " $port" | sed 's/,/  /g' | sed "s/Protocol:/`printf "\033[33mProtocol:\033[0m"`/g" | sed "s/Service Name:/`printf "\033[33mService Name:\033[0m"`/g" | sed "s/Port No:/`printf "\033[33mPort No:\033[0m"`/g" | sed "s/Source:/`printf "\033[33mSource:\033[0m"`/g" | sed "s/Description:/`printf "\033[33mDescription:\033[0m"`/g"


#sed "s,.*: ,$(tput setaf 2)&$(tput sgr0)," 
fi
done
}


while getopts "i:r:h" option; do
 case "${option}" in
    i) ifile=${OPTARG};;
    r) report=${OPTARG}"-"`date +"%d-%m-%y"`;;
    h) usage; exit;;
    *) usage; exit;;
 esac
done

call_each()
{
fn_main
}

call_each | tee -a $report 2> /dev/null

