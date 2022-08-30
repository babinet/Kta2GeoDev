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
cd "$dir" 2>&1 &>/dev/null
echo "${bg_blue}${white}---> Hello I'm WFS_LayersBody.sh${reset}"
echo "${white}---> I'm I'm Dealing with multi lines fields and body including layer button"


source tmp/tmp_bash




IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing



echo "hello
There $NomMachine"
#Header=$(echo "OutputFilenameSeul|NodeID|NomMachine|NomMachineLowCap|LayerHumanTitle|LayerHumanShortName|MapType|WorkspaceName|WorkspaceNameLowCap|Year|body|TiffPrivatePath|TiffCloudpath|ZipCloudpath|PNGCloudpath|TiffHTTP|ZipHTTP|PNGHTTP|layer_attribut|targetid|idsource|LayerBound|WKT_Map_Extent|Sort_Layer|")
#echo $Header > ../_Output_CSVs/_List_from_geotif.txt
#cat tmp/exiftool |awk NF >> ../_Output_CSVs/_List_from_geotif.txt
#echo "${white}---> Output                                                           ${orange}: ../_Output_CSVs/_List_from_geotif.txt"
#
#
#cat ../_Output_CSVs/_List_from_geotif.txt |awk -F'|' '{print $2}'|awk '!/./ || !seen[$0]++' > ../_Output_CSVs/_NodeIDsInUse.txt

echo "${bg_white}${black}---> Good Bye ! form WFS_LayersBody.sh${reset}"
