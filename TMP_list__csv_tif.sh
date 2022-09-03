#!/bin/bash
orange=`tput setaf 11`
bg_orange=`tput setab 178`
purple=`tput setaf 13`
Line=`tput smul`
bold=`tput bold`
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 15`
reset=`tput sgr0`
bg_red=`tput setab 1`
bg_green=`tput setab 2`
bg_white=`tput setab 7`
bg_blue=`tput setab 4`
lightblue=`tput setaf 45`
lightgreen=`tput setaf 46`
bleuetern=`tput setaf 45`
ilghtpurple=`tput setaf 33`
lightred=`tput setaf 161`
darkblue=`tput setaf 19`
dir=$(
cd -P -- "$(dirname -- "$0")" && pwd -P
)
cd "$dir" 2>&1 &>/dev/null
if [ -f ALL_CSVS.csv ]
then
rm ALL_CSVS.csv
fi
for LineGotif in *.tif
do
exiftool $LineGotif |awk '/Keywords/'|sed 's/Keywords                        \: //g'|sed 's/||/|THIS_IS_AN_EMPTY_CELL|/g'|sed 's/||/|THIS_IS_AN_EMPTY_CELL|/g'|sed 's/THIS_IS_A_LINEBREAK./\
/g' |sed 's/Keywords                        \: //g' |sed 's/THIS_IS_A_LINEBREAK./\
/g'|awk 'NR == 2' >> ALL_CSVS.csv





done


