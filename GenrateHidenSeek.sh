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
echo "${bg_green}${white}---> Hello I'm GenrateHidenSeek.sh${reset}"
echo "${white}---> I'm Generating the JQuery part of the Hide end Seek Layers Based on Bound"

source tmp/tmp_bash
source tmp/variable_invariable
echo NomMachine $NomMachine

echo "${white}---> Etx                      ${orange}: $Etx"
echo "${white}---> OutputFilenameSeul       ${orange}: $OutputFilenameSeul"
echo "${white}---> WorkspaceName            ${orange}: $WorkspaceName"

echo "var bound_"$NomMachineLowCap"_bound = new OpenLayers.Bounds($LayerBound); if (mapbounds.intersectsBounds(bound_"$NomMachineLowCap"_bound))    { \$('#add_planche_$NomMachine').show();  } else {  \$('#add_planche_$NomMachine').hide();}" >>tmp/tmp_HideNSeek

source tmp/tmp_bash

echo "${bg_white}${black}---> Good Bye ! from GenrateHidenSeek.sh${reset}"
