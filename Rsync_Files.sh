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


echo "${white}---> Now fetching the files on the server where apache user can read"


echo "${white}'
                     ########:::'######::'##:::'##:'##::: ##::'######::
                     ##.... ##:'##... ##:. ##:'##:: ###:: ##:'##... ##:
                     ##:::: ##: ##:::..:::. ####::: ####: ##: ##:::..::
                     ########::. ######::::. ##:::: ## ## ##: ##:::::::
                     ##.. ##::::..... ##:::: ##:::: ##. ####: ##:::::::
                     ##::. ##::'##::: ##:::: ##:::: ##:. ###: ##::: ##:
                     ##:::. ##:. ######::::: ##:::: ##::. ##:. ######::
                    ..:::::..:::......::::::..:::::..::::..:::......:::
"


read -p "what is the StorageLocation ? : " StorageLocation
echo StorageLocation=\"$StorageLocation\" > tmp/tmp_bash
echo "${white}---> Now copy the files on the server in $StorageLocation
${white}---> Where folder _Outpout has to be renamed to _Output_3857
${white}---> Path must look like bellow ${orange}:
    "$StorageLocation"_Output_3857
    "$StorageLocation"_Output_PNG_Preview
    "$StorageLocation"_Output_wld_zip
    "$StorageLocation"_Output_CSVs
"

echo "${white}---> Checking server information"

if [ -f Server_Port.cfg ]
then
echo "${green}---> Server.cfg found"
else
read -p "What is the server name .eg : sous-paris.com ? : " Server_SCP
echo "$Server_SCP" > Server_SCP.cfg

read -p "What is the server port .eg :  1777 ? : " Server_port
echo "$Server_port" > Server_Port.cfg

read -p "What is the server user .eg :  philibert ? : " Server_User
echo "$Server_User" > User_SCP.cfg
fi


echo "${red}---> Make sure ${orange}"$StorageLocation"${red} on the distant server is writable with rsync from this local machine"
read -p "Hit enter when checked" Checked


echo "${white}---> Server name is : "${orange}$Server_SCP"${white} - Server port is : "${orange}$Port_SCP"${white} - Server user is : "${orange}$User_scp"${white}"
Port_SCP=$(cat Server_Port.cfg)
Server_SCP=$(cat Server_SCP.cfg)
User_scp=$(cat User_SCP.cfg)
echo "${white}---> Syncing the GeoTiff folder               :${orange}_Output_3857 in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_3857/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Output_3857
echo "${white}---> Syncing the Zips folder                  :${orange}_Output_wld_zip in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_wld_zip/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Output_wld_zip
echo "${white}---> Syncing the PNG preview folder           :${orange}_Output_PNG_Preview in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_PNG_Preview/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Output_PNG_Preview

    
if [ -f Server_Port.cfg ]
then
echo "${green}---> Server.cfg found"
else
read -p "What is the server name .eg : sous-paris.com ? : " Server_SCP
echo "$Server_SCP" > Server_SCP.cfg

read -p "What is the server port .eg :  1777 ? : " Server_port
echo "$Server_port" > Server_Port.cfg

read -p "What is the server user .eg :  philibert ? : " Server_User
echo "$Server_User" > User_SCP.cfg

fi
Port_SCP=$(cat Server_Port.cfg)
Server_SCP=$(cat Server_SCP.cfg)
User_scp=$(cat User_SCP.cfg)

echo "${white}---> From the ${orange}Server_SCP.cfg Server_Port.cfg${white} the server name is${orange} $Server_SCP${white} port ${orange}$Port_SCP"
echo "${white}---> The command shoult be : ${green}scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/tmp/WFS_Assemblage.txt "$dir"/tmp/WFS_Assemblage.txt"
echo "                                   : ${green}scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/tmp/WFS_Assemblage.json "$dir"/tmp/WFS_Assemblage.json"
scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/tmp/WFS_Assemblage.txt "$dir"/tmp/WFS_Assemblage.txt
scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/tmp/WFS_Assemblage.json "$dir"/tmp/WFS_Assemblage.json

rm temp.tif

echo "${white}---> Syncing the CSVs folder                  :${orange}_Output_CSVs in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_CSVs/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Output_CSVs

echo "${white}---> Syncing the GeoTiff folder               :${orange}_Source_Standard_Croped_TIFF in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Source_Standard_Croped_TIFF/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Source_Standard_Croped_TIFF

echo "${white}---> Syncing the source folder Not Cropped    :${orange}_Source_NOT_Croped in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Source_NOT_Croped/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Source_NOT_Croped
echo "${white}---> Syncing the source folder (croped)       :${orange}_Output_wld_zip in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_wld_zip/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Output_wld_zip
echo "${white}---> Syncing the Zips folder                  :${orange}_Output_CSVs in "$Server_SCP" path ${white}"$StorageLocation""
rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Source_Standard_Croped_TIFF/ "$User_scp"@"$Server_SCP":"$StorageLocation"_Source_Standard_Croped_TIFF
echo "$orange##############################################################################"
echo "$white
##      ##  ######  ########    ##    ##  #######  ########  ########  ######
##  ##  ## ##    ## ##          ###   ## ##     ## ##     ## ##       ##    ##
##  ##  ## ##       ##          ####  ## ##     ## ##     ## ##       ##
##  ##  ##  ######  ######      ## ## ## ##     ## ##     ## ######    ######
##  ##  ##       ## ##          ##  #### ##     ## ##     ## ##             ##
##  ##  ## ##    ## ##          ##   ### ##     ## ##     ## ##       ##    ##
 ###  ###   ######  ##          ##    ##  #######  ########  ########  ######
"
echo "$orange##############################################################################"

