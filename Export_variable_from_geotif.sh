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
grey=`tput setaf 248`
lightyellow=`tput setaf 229`
dir=$(
cd -P -- "$(dirname -- "$0")" && pwd -P
)
if [ -f tmp/exitooltmp.csv ]
then rm tmp/exitooltmp.csv
fi
if [ -f tmp/exiftool ]
then rm tmp/exiftool
fi

cd "$dir" 2>&1 &>/dev/null
echo "${bg_blue}${white}---> Hello I'm Export_variable_from_geotif.sh${reset}"
echo "${white}---> I'm Making CSV from exif information stored in Keywords         ${orange}: ../_Output_CSVs/_List_from_geotif.txt"
echo "${white}---> Get Node ID list                                                ${orange}: $TiffPrivatePath"
cat CODEX_PLANCHES.csv |sed '1d'|awk -F'|' '{print $1}' >tmp/AllNodeIDs

find ../_Output_3857/ -name "*.tif" | sed 's/\/\//\//g'> tmp/FoundTiFTagged

IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing

for LineGotif in $(cat tmp/FoundTiFTagged)
do
echo "$white $LineGotif"
exiftool $LineGotif |awk '/Description/'|sed 's/Description                     : //g'|sed 's/THIS_IS_A_LINEBREAK./\
/g' |sed 's/Description                     \: //g' |sed 's/THIS_IS_A_LINEBREAK./\
/g'|awk 'NR == 2'>> tmp/exiftool
done
headerlocation=$(cat tmp/FoundTiFTagged|awk 'NR == 1')
exiftool $headerlocation |awk '/Description/'|sed 's/Description                     \: //g'|sed 's/THIS_IS_A_LINEBREAK./\
/g' |sed 's/Description                     \: //g' |sed 's/THIS_IS_A_LINEBREAK./\
/g'|awk 'NR == 1'> tmp/Header

echo "${white}---> Normalising                                                      ${orange}: tmp/exitooltmp.csv"

Header=$(cat tmp/Header)
echo $Header > ../_Output_CSVs/_List_from_geotif.txt
cat tmp/exiftool |awk NF >> ../_Output_CSVs/_List_from_geotif.txt
echo "${white}---> Output                                                           ${orange}: ../_Output_CSVs/_List_from_geotif.txt"


cat ../_Output_CSVs/_List_from_geotif.txt |awk -F'|' '{print $2}'|awk '!/./ || !seen[$0]++' > ../_Output_CSVs/_NodeIDsInUse.txt

echo "${bg_white}${black}---> Good Bye ! form Export_variable_from_geotif.sh${reset}"

Maptype=$(awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["MapType"]) }' OFS='|' ../_Output_CSVs/_List_from_geotif.txt |sed 's/THIS_IS_AN_EMPTY_CELL//g')

if [[ "$Maptype" == IDCPARIS ]]
then
echo "${white}---> Maptype                                                          ${orange}: IDCPARIS"
else
echo "${white}---> Maptype                                                          ${orange}: $Maptype"
fi


