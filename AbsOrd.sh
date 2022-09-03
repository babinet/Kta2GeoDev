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
echo "${bg_green}${white}---> Hello I'm AbsOrd.sh${reset}"
echo "${white}---> I'm dealing with A - O"

source tmp/tmp_bash
source tmp/variable_invariable




#Began Rules AbsOrd
if [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27A_"* ]]
then
Ordinate=11
Abscissa=31
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27B_"* ]]
then
Ordinate=12
Abscissa=31
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27F_"* ]]
then
Ordinate=11
Abscissa=32
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27K_"* ]]
then
Ordinate=11
Abscissa=33
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27L_"* ]]
then
Ordinate=12
Abscissa=33
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27P_"* ]]
then
Ordinate=11
Abscissa=34
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27Q_"* ]]
then
Ordinate=12
Abscissa=34
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27X_"* ]]
then
Ordinate=14
Abscissa=35
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35D_"* ]]
then
Ordinate=9
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35O_"* ]]
then
Ordinate=10
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35Y_"* ]]
then
Ordinate=11
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/36U_"* ]]
then
Ordinate=11
Abscissa=40
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/44E_"* ]]
then
Ordinate=10
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/45A_"* ]]
then
Ordinate=11
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/61Y_"* ]]
then
Ordinate=15
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62J_"* ]]
then
Ordinate=20
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62P_"* ]]
then
Ordinate=16
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62R_"* ]]
then
Ordinate=18
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62T_"* ]]
then
Ordinate=20
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62U_"* ]]
then
Ordinate=16
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62V_"* ]]
then
Ordinate=17
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62Y_"* ]]
then
Ordinate=20
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63K_"* ]]
then
Ordinate=21
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63P_"* ]]
then
Ordinate=21
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63Q_"* ]]
then
Ordinate=22
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63R_"* ]]
then
Ordinate=23
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63U_"* ]]
then
Ordinate=21
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63V_"* ]]
then
Ordinate=22
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63W_"* ]]
then
Ordinate=23
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63X_"* ]]
then
Ordinate=24
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/66K_"* ]]
then
Ordinate=36
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/70E_"* ]]
then
Ordinate=15
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/70J_"* ]]
then
Ordinate=15
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/70O_"* ]]
then
Ordinate=15
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71A_"* ]]
then
Ordinate=16
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71B_"* ]]
then
Ordinate=17
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71C_"* ]]
then
Ordinate=18
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71D_"* ]]
then
Ordinate=19
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71E_"* ]]
then
Ordinate=20
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71F_"* ]]
then
Ordinate=16
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71G_"* ]]
then
Ordinate=17
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71H_"* ]]
then
Ordinate=18
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71I_"* ]]
then
Ordinate=19
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71J_"* ]]
then
Ordinate=20
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71K_"* ]]
then
Ordinate=16
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71L_"* ]]
then
Ordinate=17
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71M_"* ]]
then
Ordinate=18
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71N_"* ]]
then
Ordinate=19
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71O_"* ]]
then
Ordinate=20
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71R_"* ]]
then
Ordinate=18
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71S_"* ]]
then
Ordinate=19
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71T_"* ]]
then
Ordinate=20
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71W_"* ]]
then
Ordinate=18
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71V_"* ]]
then
Ordinate=17
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"



elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71X_"* ]]
then
Ordinate=19
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71Y_"* ]]
then
Ordinate=20
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72A_"* ]]
then
Ordinate=21
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72B_"* ]]
then
Ordinate=22
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72C_"* ]]
then
Ordinate=23
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72D_"* ]]
then
Ordinate=24
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72F_"* ]]
then
Ordinate=21
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72G_"* ]]
then
Ordinate=22
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72H_"* ]]
then
Ordinate=23
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72I_"* ]]
then
Ordinate=24
Abscissa=57
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72K_"* ]]
then
Ordinate=21
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72L_"* ]]
then
Ordinate=22
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72M_"* ]]
then
Ordinate=23
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72N_"* ]]
then
Ordinate=24
Abscissa=58
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72P_"* ]]
then
Ordinate=21
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72Q_"* ]]
then
Ordinate=22
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72R_"* ]]
then
Ordinate=23
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72S_"* ]]
then
Ordinate=24
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72U_"* ]]
then
Ordinate=21
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72V_"* ]]
then
Ordinate=22
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72W_"* ]]
then
Ordinate=23
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/72X_"* ]]
then
Ordinate=24
Abscissa=60
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/73D_"* ]]
then
Ordinate=29
Abscissa=56
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/73R_"* ]]
then
Ordinate=28
Abscissa=59
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/80C_"* ]]
then
Ordinate=18
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/80D_"* ]]
then
Ordinate=19
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/80E_"* ]]
then
Ordinate=20
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/82J_"* ]]
then
Ordinate=20
Abscissa=62
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81A_"* ]]
then
Ordinate=21
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81B_"* ]]
then
Ordinate=22
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81C_"* ]]
then
Ordinate=23
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81F_"* ]]
then
Ordinate=21
Abscissa=62
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81G_"* ]]
then
Ordinate=22
Abscissa=62
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81H_"* ]]
then
Ordinate=23
Abscissa=62
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81L_"* ]]
then
Ordinate=22
Abscissa=63
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81D_"* ]]
then
Ordinate=24
Abscissa=61
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147_"* ]]
then
Ordinate=19
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/95D_"* ]]
then
Ordinate=19
Abscissa=71
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/95E_"* ]]
then
Ordinate=20
Abscissa=71
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/95I_"* ]]
then
Ordinate=19
Abscissa=72
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/95J_"* ]]
then
Ordinate=20
Abscissa=72
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/96A_"* ]]
then
Ordinate=21
Abscissa=71
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/96F_"* ]]
then
Ordinate=21
Abscissa=72
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

#
## Ancienne Numérotation / EXEMPLE: Feuille 25-50 = Feuille 281
#

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-14_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/29T_"* ]]
then
Ordinate=25
Abscissa=34
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-59_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40G_"* ]]
then
Ordinate=32
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-15_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/30P_"* ]]
then
Ordinate=26
Abscissa=34
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-26_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/29Y_"* ]]
then
Ordinate=25
Abscissa=35
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-27_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/30U_"* ]]
then
Ordinate=26
Abscissa=35
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-28_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/30V_"* ]]
then
Ordinate=27
Abscissa=35
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"


elif [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/36K_"* ]]
then
Ordinate=11
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/36P_"* ]]
then
Ordinate=11
Abscissa=39
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/18Q_"* ]]
then
Ordinate=12
Abscissa=29
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-39_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/38E_"* ]]
then
Ordinate=25
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-40_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39A_"* ]]
then
Ordinate=26
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-41_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39B_"* ]]
then
Ordinate=27
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-42_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39C_"* ]]
then
Ordinate=28
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-45_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40A_"* ]]
then
Ordinate=31
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-46_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40B_"* ]]
then
Ordinate=32
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-253_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57L_"* ]]
then
Ordinate=32
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-47_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40C_"* ]]
then
Ordinate=33
Abscissa=36
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-53_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39F_"* ]]
then
Ordinate=26
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-54_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39G_"* ]]
then
Ordinate=27
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-55_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39H_"* ]]
then
Ordinate=28
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-57_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39J_"* ]]
then
Ordinate=30
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-58_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40F_"* ]]
then
Ordinate=31
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-60_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40H_"* ]]
then
Ordinate=33
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/43G_"* ]]
then
Ordinate=47
Abscissa=37
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-72_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39O_"* ]]
then
Ordinate=30
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-73_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40K_"* ]]
then
Ordinate=31
Abscissa=38
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-77_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/37S_"* ]]
then
Ordinate=19
Abscissa=39
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-88_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39T_"* ]]
then
Ordinate=30
Abscissa=39
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-89_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40P_"* ]]
then
Ordinate=31
Abscissa=39
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-106_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40U_"* ]]
then
Ordinate=31
Abscissa=40
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-107_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40V_"* ]]
then
Ordinate=32
Abscissa=40
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-110_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46C_"* ]]
then
Ordinate=18
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-111_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46D_"* ]]
then
Ordinate=19
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-112_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46E_"* ]]
then
Ordinate=20
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-113_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/47A_"* ]]
then
Ordinate=33-37
Abscissa=41
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-128_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46H_"* ]]
then
Ordinate=18
Abscissa=42
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-129_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46I_"* ]]
then
Ordinate=19
Abscissa=42
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-130_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46J_"* ]]
then
Ordinate=20
Abscissa=42
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-142_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49G_"* ]]
then
Ordinate=32
Abscissa=42
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-143_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49H_"* ]]
then
Ordinate=33
Abscissa=42
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-146_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46M_"* ]]
then
Ordinate=18
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-160_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49L_"* ]]
then
Ordinate=32
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-161_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49M_"* ]]
then
Ordinate=33
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-162_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49N_"* ]]
then
Ordinate=34
Abscissa=43
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-164_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46R_"* ]]
then
Ordinate=18
Abscissa=44
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-165_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46S_"* ]]
then
Ordinate=19
Abscissa=44
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-207_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55D_"* ]]
then
Ordinate=24
Abscissa=46
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-208_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55E_"* ]]
then
Ordinate=25
Abscissa=46
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-209_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56A_"* ]]
then
Ordinate=26
Abscissa=46
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-225_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55H_"* ]]
then
Ordinate=23
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-226_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55I_"* ]]
then
Ordinate=24
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-227_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55J_"* ]]
then
Ordinate=25
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-228_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56F_"* ]]
then
Ordinate=26
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-229_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56G_"* ]]
then
Ordinate=27
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-230_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56H_"* ]]
then
Ordinate=28
Abscissa=47
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-244_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55M_"* ]]
then
Ordinate=23
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-245_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55N_"* ]]
then
Ordinate=24
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-246_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55O_"* ]]
then
Ordinate=25
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-247_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56K_"* ]]
then
Ordinate=26
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-248_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56L_"* ]]
then
Ordinate=27
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-249_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56M_"* ]]
then
Ordinate=28
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-261_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55P_"* ]]
then
Ordinate=21
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-262_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55Q_"* ]]
then
Ordinate=22
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-263_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55R_"* ]]
then
Ordinate=23
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-264_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55S_"* ]]
then
Ordinate=24
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-265_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55T_"* ]]
then
Ordinate=25
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-266_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56P_"* ]]
then
Ordinate=26
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-267_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56Q_"* ]]
then
Ordinate=27
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-268_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56R_"* ]]
then
Ordinate=28
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-269_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56S_"* ]]
then
Ordinate=29
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-272_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57Q_"* ]]
then
Ordinate=32
Abscissa=49
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-276_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/54Y_"* ]]
then
Ordinate=20
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-277_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55U_"* ]]
then
Ordinate=21
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-278_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55V_"* ]]
then
Ordinate=22
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-279_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55W_"* ]]
then
Ordinate=23
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-280_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55X_"* ]]
then
Ordinate=24
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-281_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55Y_"* ]]
then
Ordinate=25
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-282_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56U_"* ]]
then
Ordinate=26
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-283_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56V_"* ]]
then
Ordinate=27
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-284_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56W_"* ]]
then
Ordinate=28
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-285_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56X_"* ]]
then
Ordinate=29
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-288_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57V_"* ]]
then
Ordinate=32
Abscissa=50
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-291_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/62E_"* ]]
then
Ordinate=20
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-292_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63A_"* ]]
then
Ordinate=21
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-243_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55L_"* ]]
then
Ordinate=22
Abscissa=48
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-293_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63B_"* ]]
then
Ordinate=22
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-294_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63C_"* ]]
then
Ordinate=23
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-295_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63D_"* ]]
then
Ordinate=24
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"



elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-296_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63E_"* ]]
then
Ordinate=25
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-297_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64A_"* ]]
then
Ordinate=26
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-298_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64B_"* ]]
then
Ordinate=27
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-299_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64C_"* ]]
then
Ordinate=28
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-300_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64D_"* ]]
then
Ordinate=29
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-301_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64E_"* ]]
then
Ordinate=30
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-304-bis_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/66A_"* ]]
then
Ordinate=36
Abscissa=51
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-305_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63F_"* ]]
then
Ordinate=21
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-306"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63G_"* ]]
then
Ordinate=22
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-307_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63H_"* ]]
then
Ordinate=23
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-308_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63I_"* ]]
then
Ordinate=24
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-309_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63J_"* ]]
then
Ordinate=25
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-310_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64F_"* ]]
then
Ordinate=26
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-311_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64G_"* ]]
then
Ordinate=27
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-312_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64H_"* ]]
then
Ordinate=28
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-313_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64I_"* ]]
then
Ordinate=29
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-314_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64J_"* ]]
then
Ordinate=30
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-314-bis_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/66F_"* ]]
then
Ordinate=36
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-315_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63L_"* ]]
then
Ordinate=22
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-316_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63M_"* ]]
then
Ordinate=23
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-317_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63N_"* ]]
then
Ordinate=24
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-318_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63O_"* ]]
then
Ordinate=25
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-319_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64K_"* ]]
then
Ordinate=26
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-320_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64L_"* ]]
then
Ordinate=27
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-321_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64M_"* ]]
then
Ordinate=28
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-322_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64N_"* ]]
then
Ordinate=29
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-323_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64O_"* ]]
then
Ordinate=30
Abscissa=53
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-324_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63S_"* ]]
then
Ordinate=24
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-325_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63T_"* ]]
then
Ordinate=25
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-326_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64P_"* ]]
then
Ordinate=26
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-327_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64Q_"* ]]
then
Ordinate=27
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-328_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64R_"* ]]
then
Ordinate=28
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-329_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64S_"* ]]
then
Ordinate=29
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-330_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64T_"* ]]
then
Ordinate=30
Abscissa=54
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-331_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/63Y_"* ]]
then
Ordinate=25
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-332_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64U_"* ]]
then
Ordinate=26
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-334_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64W_"* ]]
then
Ordinate=28
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-335_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/64X_"* ]]
then
Ordinate=29
Abscissa=55
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/65I_"* ]]
then
Ordinate=34
Abscissa=52
echo "${white}---> Ordinate substitut : ${green}$Ordinate"
echo "${white}---> Abscissa substitut : ${green}$Abscissa"

#
##
### Missing Special rules
##
#

#elif [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/3-4-41_"* ]]||[[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/03-04-41_"* ]]
#then
#Ordinate=3.5
#Abscissa=41
#echo "${white}---> Ordinate substitut : ${green}$Ordinate"
#echo "${white}---> Abscissa substitut : ${green}$Abscissa"


# END Abscissa definition
else

Echo "${white}---> Default information was not found yet"

IDCFirst2Nbr=$(echo "$NameNoExt" |awk '{print substr($0,0,2)}')
IDCThirdLetter=$(echo "$NameNoExt" | head -c 3 | tail -c 1 )
if [[ "$TiffSource" == *"Feuille-"* ]]
then
echo "${green}---> Feuille detected !"
#echo "${lightblue}Abscissa $Abscissa Ordinate $Ordinate"
#wk -F'|' -v "le_nom_complet"="$Title_Name" '$3=='le_nom_complet'' Cleaned_db/title.basics_movie.csv | awk -F'|' -v "year"="$Year" '$6=='year'' > ../.Temp.film
echo "$purple NameNoExt $NameNoExt"
awk -F'|' -v "Cleaned_Name"="$NameNoExt" '$1=='Cleaned_Name'' Abs-Ord.txt
Ordinate_Basic=$(awk -F'|' -v "Cleaned_Name"="$NameNoExt" '$1=='Cleaned_Name'' Abs-Ord.txt|awk -F'|' '{print $2}')
Abscissa_Basic=$(awk -F'|' -v "Cleaned_Name"="$NameNoExt" '$1=='Cleaned_Name'' Abs-Ord.txt|awk -F'|' '{print $3}')
echo "$green Ordinate_Basic $Ordinate_Basic Abscissa_Basic $Abscissa_Basic"

Ordinate="$Ordinate_Basic"
Abscissa="$Abscissa_Basic"
echo Ordinate=\"$Ordinate_Basic\" >> tmp/tmp_bash
echo Ordinate=\"$Ordinate_Basic\" >> tmp/tmp_bash
source tmp/tmp_bash
echo $lightblue$Ordinate $Abscissa

echo $red IDCThirdLetter $white $IDCThirdLetter
elif [[ $IDCThirdLetter =~ [A-Z] ]]
then
echo "${white}---> Third letter detected ###############################"
echo "$purple NameNoExt $NameNoExt"
Ordinate_Basic=$(awk -F'|' -v "Cleaned_Name"="$NameNoExt" '$1=='Cleaned_Name'' Abs-Ord.txt|awk -F'|' '{print $2}')
Abscissa_Basic=$(awk -F'|' -v "Cleaned_Name"="$NameNoExt" '$1=='Cleaned_Name'' Abs-Ord.txt|awk -F'|' '{print $3}')
echo "$green Ordinate_Basic $Ordinate_Basic Abscissa_Basic $Abscissa_Basic"

else

echo "${white}---> Regular Adscissa Ordinate detected"

Ordinate=$(echo $NameNoExt | awk -F'-' '{print $1}'| tr -d ' ' | sed 's/..\///g')
Abscissa=$(echo $NameNoExt | awk -F'-' '{print $2}' | tr -d ' '  | awk -F'_' '{print $1}'| sed 's/..\///g')
IGCPatternOrdinate=$(echo $NameNoExt | awk -F'-' '{print $1}' )
IGCPatternAbscissa=$(echo $NameNoExt | awk -F'-' '{print $2}' )
#End Rules AbsOrd

fi
echo $Cleaned_Name Cleaned_Name
source tmp/tmp_bash


# END Abscissa
fi
echo Ordinate=\"$Ordinate\" >> tmp/tmp_bash
echo Abscissa=\"$Abscissa\" >> tmp/tmp_bash
echo IGCPatternOrdinate=\"$IGCPatternOrdinate\" >> tmp/tmp_bash
echo IGCPatternAbscissa=\"$IGCPatternAbscissa\" >> tmp/tmp_bash

#source tmp/tmp_bash
#
#echo Ordinate $Ordinate
#echo Abscissa $Abscissa
#echo IGCPatternOrdinate $IGCPatternOrdinate
#echo IGCPatternAbscissa $IGCPatternAbscissa


echo "${bg_white}${black}---> Good Bye ! from AbsOrd.sh${reset}"


