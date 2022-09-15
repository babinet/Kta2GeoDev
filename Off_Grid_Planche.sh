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
echo "${bg_green}${white}---> Hello I'm Off_Grid_Planche.sh${reset}"
echo "${white}---> I'm dealing with A - O"

source tmp/tmp_bash
source tmp/variable_invariable

#Began Rules AbsOrd

# Off grid names rules
# Special Names Abs Ord
if [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-48-49"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57N-S"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-255"* ]]
then
Ordinate=34
Abscissa=48.25
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35-49-50"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57T-Y"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-275"* ]]
then
Ordinate=35
Abscissa=49.25
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"


elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-48-49"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57M-R"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-254-273"* ]]
then
echo $purple Found
Ordinate=33
Abscissa=48.75
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-161-162_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49M"* ]]
then
Ordinate=33
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147-148-union"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147-148_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46N"* ]]
then
Ordinate=19
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49B-C_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/FEUILLE-124-125"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32-33-41"* ]]
then
echo $purple Found
Ordinate=32.166666666666666666666
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40U_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/FEUILLE-106"* ]]
then
echo $purple Found
Ordinate=31
Abscissa=40
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/18-40-19"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-93"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/37W-X"* ]]
then
echo $purple Found
Ordinate=18.5
Abscissa=40
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-35-38"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-76"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40M-O"* ]]
then
echo $purple Found
Ordinate=34.5
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/15-16-59"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71P"* ]]
then
echo $purple Found
Ordinate=15.66666666666666666664
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

fi





#
#IGCPatternOrdinate="$Ordinate"
#IGCPatternAbscissa="$Abscissa"



echo Ordinate=\"$Ordinate\" >> tmp/tmp_bash
echo Abscissa=\"$Abscissa\" >> tmp/tmp_bash

#source tmp/tmp_bash
#
#echo Ordinate $Ordinate
#echo Abscissa $Abscissa
#echo IGCPatternOrdinate $IGCPatternOrdinate
#echo IGCPatternAbscissa $IGCPatternAbscissa


echo "${bg_white}${black}---> Good Bye ! from Off_Grid_Planche.sh${reset}"

