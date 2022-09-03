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

if [ -d tmp/_NodesMap ]
then
rm -R tmp/_NodesMap
fi
mkdir -p tmp/_NodesMap
echo "${bg_blue}${white}---> Hello I'm WFS_Layers_fromCsv.sh${reset}"
echo "${white}---> I'm Doing WFS Nodes from IDCPARIS Maptype ${orange}: IDCPARIS __ALL_CSV_Image_HEADER.csv"




#reed -p "${white}--->  Execute ${green} on distant server
#SCP auth + Links"

echo "${white}---> Run this command on distant machine in        ${green}: cd /private_file/Raw_map_EPSG_3857/Geotiff/"
echo "${red}sudo${orange} ./List_IDC_csv_tif.sh"
read -p "Once the process has finished on the distant server, ${orange}press Enter !"
echo "${orange}---> DONE !"


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
echo "${white}---> The command shoult be : ${green}scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/private_file/Raw_map_EPSG_3857/Geotiff/_ALL_CSV_Image_HEADER.csv ../_Output_CSVs/_ALL_CSV_Image_HEADER.csv"
echo "                                   : ${green}scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/private_file/Raw_map_EPSG_3857/Geotiff/_ALL_CSV_Image_No_HEADER.csv ../_Output_CSVs/_ALL_CSV_Image_No_HEADER.csv"
scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/private_file/Raw_map_EPSG_3857/Geotiff/_ALL_CSV_Image_HEADER.csv ../_Output_CSVs/_ALL_CSV_Image_HEADER.csv
scp -P "$Port_SCP" "$User_scp"@"$Server_SCP":/private_file/Raw_map_EPSG_3857/Geotiff/_ALL_CSV_Image_No_HEADER.csv ../_Output_CSVs/_ALL_CSV_Image_No_HEADER.csv


if [ -f tmp/WFSTEMP ]
then
rm tmp/WFSTEMP
fi


HeaderFromCSV=$(cat ../_Output_CSVs/_ALL_CSV_Image_HEADER.csv|awk 'NR == 1' |sed 's/\: OutputFilenameSeul/OutputFilenameSeul/g')


#find /private_file/Raw_map_EPSG_3857/Geotiff/ -name "*.tif" | sed 's/\/\//\//g'> tmp/FoundTiFTagged

IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing

for LineGotif in $(cat ../_Output_CSVs/_ALL_CSV_Image_No_HEADER.csv)
do
echo "${red}---> Removing old tmp_bash"
echo "$white $HeaderFromCSV"
if [ -f tmp/tmp_bash ]
then
rm tmp/tmp_bash
fi

echo "$HeaderFromCSV
$LineGotif" > tmp/exiftool
#exiftool $LineGotif |awk '/Keywords/'|sed 's/Keywords                        \: //g'|sed 's/||/|THIS_IS_AN_EMPTY_CELL|/g'|sed 's/||/|THIS_IS_AN_EMPTY_CELL|/g'|sed 's/THIS_IS_A_LINEBREAK./\
#/g' |sed 's/Keywords                        \: //g' |sed 's/THIS_IS_A_LINEBREAK./\
#/g' > tmp/exiftool


Maptype=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["MapType"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')

echo $purple $Maptype Maptype

read

if [ $Maptype == IDCPARIS ]
then
echo "${white}---> Maptype                                                         ${green}: IDCPARIS"
echo "${white}---> Looking for variables                                           ${orange}: tmp/exitooltmp.csv"


NomMachine=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["NomMachine"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$NomMachine                                                     ${orange}: $NomMachine"
echo NomMachine=\"$NomMachine\" >> tmp/tmp_bash

NomMachineLowCap=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["NomMachineLowCap"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$NomMachineLowCap                                               ${orange}: $NomMachineLowCap"
echo NomMachineLowCap=\"$NomMachineLowCap\" >> tmp/tmp_bash

OutputFilenameSeul=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["OutputFilenameSeul"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$OutputFilenameSeul                                             ${orange}: $OutputFilenameSeul"
echo OutputFilenameSeul=\"$OutputFilenameSeul\" >> tmp/tmp_bash

LayerHumanTitle=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["LayerHumanTitle"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$LayerHumanTitle                                                ${orange}: $LayerHumanTitle"
echo LayerHumanTitle=\"$LayerHumanTitle\" >> tmp/tmp_bash

WorkspaceName=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["WorkspaceName"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$WorkspaceName                                                  ${orange}: $WorkspaceName"
echo WorkspaceName=\"$WorkspaceName\" >> tmp/tmp_bash

WorkspaceNameLowCap=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["WorkspaceNameLowCap"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$WorkspaceNameLowCap                                            ${orange}: $WorkspaceNameLowCap"
echo WorkspaceNameLowCap=\"$WorkspaceNameLowCap\" >> tmp/tmp_bash

Year=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["Year"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$Year                                                           ${orange}: $Year"
echo Year=\"$Year\" >> tmp/tmp_bash

TiffPrivatePath=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["TiffPrivatePath"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$TiffPrivatePath                                                ${orange}: $TiffPrivatePath"
echo TiffPrivatePath=\"$TiffPrivatePath\" >> tmp/tmp_bash


ZipCloudpath=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["ZipCloudpath"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$ZipCloudpath                                                   ${orange}: $ZipCloudpath"
echo ZipCloudpath=\"$ZipCloudpath\" >> tmp/tmp_bash

TiffCloudpath=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["TiffCloudpath"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$TiffCloudpath                                                  ${orange}: $TiffCloudpath"
echo TiffCloudpath=\"$TiffCloudpath\" >> tmp/tmp_bash

PNGCloudpath=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["PNGCloudpath"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$PNGCloudpath                                                   ${orange}: $PNGCloudpath"
echo PNGCloudpath=\"$PNGCloudpath\" >> tmp/tmp_bash

TiffHTTP=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["TiffHTTP"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$TiffHTTP                                                       ${orange}: $TiffHTTP"
echo TiffHTTP=\"$TiffHTTP\" >> tmp/tmp_bash

ZipHTTP=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["ZipHTTP"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$ZipHTTP                                                        ${orange}: $ZipHTTP"
echo ZipHTTP=\"$ZipHTTP\" >> tmp/tmp_bash

PNGHTTP=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["PNGHTTP"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$PNGHTTP                                                        ${orange}: $PNGHTTP"
echo PNGHTTP=\"$PNGHTTP\" >> tmp/tmp_bash

layer_attribut=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["layer_attribut"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$layer_attribut                                                 ${orange}: $layer_attribut"
echo layer_attribut=\"$layer_attribut\" >> tmp/tmp_bash

targetid=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["targetid"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$targetid                                                       ${orange}: $targetid"
echo targetid=\"$targetid\" >> tmp/tmp_bash

idsource=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["idsource"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$idsource                                                       ${orange}: $idsource"
echo idsource=\"$idsource\" >> tmp/tmp_bash

NodeID=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["NodeID"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$NodeID                                                         ${orange}: $NodeID"
echo NodeID=\"$NodeID\" >> tmp/tmp_bash

WKT_Map_Extent=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["WKT_Map_Extent"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$WKT_Map_Extent                                                 ${orange}: $WKT_Map_Extent"
echo WKT_Map_Extent=\"$WKT_Map_Extent\" >> tmp/tmp_bash

OriginalPost1980Name=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["OriginalPost1980Name"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$OriginalPost1980Name                                           ${orange}: $OriginalPost1980Name"
echo OriginalPost1980Name=\"$OriginalPost1980Name\" >> tmp/tmp_bash

OldNum=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["OldNum"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$OldNum                                                         ${orange}: $OldNum"
echo OldNum=\"$OldNum\" >> tmp/tmp_bash

Seine=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["Seine"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$Seine                                                          ${orange}: $Seine"
echo Seine=\"$Seine\" >> tmp/tmp_bash

body=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["body"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$body                                                           ${orange}: $body"
echo body=\"$body\" >> tmp/tmp_bash


Default_IDC_GEOMETRY=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["Default_IDC_GEOMETRY"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$Default_IDC_GEOMETRY                                           ${orange}: $Default_IDC_GEOMETRY"
echo Default_IDC_GEOMETRY=\"$Default_IDC_GEOMETRY\" >> tmp/tmp_bash




echo "
$white---> Export default idc coordinate                                   ${orange}: EPSG:27561 - Lambert Nord
"
BasicNordOuest=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordOuest"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordOuest                                                 ${lightblue}: $BasicNordOuest"
echo BasicNordOuest=\"$BasicNordOuest\" >> tmp/tmp_bash

BasicSudOuest=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudOuest"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudOuest                                                  ${lightblue}: $BasicSudOuest"
echo BasicSudOuest=\"$BasicSudOuest\" >> tmp/tmp_bash

BasicSudEst=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudEst"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudEst                                                    ${lightblue}: $BasicSudEst"
echo BasicSudEst=\"$BasicSudEst\" >> tmp/tmp_bash

BasicNordEst=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordEst"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordEst                                                   ${lightblue}: $BasicNordEst"
echo BasicNordEst=\"$BasicNordEst\" >> tmp/tmp_bash

echo "
$white---> Export default idc coordinate                                   ${orange}: EPSG:3857 - WGS84
"
BasicNordOuest3857=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordOuest3857"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordOuest3857                                             ${green}: $BasicNordOuest3857"
echo BasicNordOuest3857=\"$BasicNordOuest3857\" >> tmp/tmp_bash

BasicSudOuest3857=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudOuest3857"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudOuest3857                                              ${green}: $BasicSudOuest3857"
echo BasicSudOuest3857=\"$BasicSudOuest3857\" >> tmp/tmp_bash

BasicSudEst3857=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudEst3857"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudEst3857                                                ${green}: $BasicSudEst3857"
echo BasicSudEst3857=\"$BasicSudEst3857\" >> tmp/tmp_bash

BasicNordEst3857=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordEst3857"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordEst3857                                               ${green}: $BasicNordEst3857"
echo BasicNordEst3857=\"$BasicNordEst3857\" >> tmp/tmp_bash

echo "
$white---> Export default idc coordinate                                   ${orange}: 4326 - WGS84
"

BasicNordOuest4326=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordOuest4326"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordOuest4326                                             ${purple}: $BasicNordOuest4326"
echo BasicNordOuest4326=\"$BasicNordOuest4326\" >> tmp/tmp_bash

BasicSudOuest4326=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudOuest4326"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudOuest4326                                              ${purple}: $BasicSudOuest4326"
echo BasicSudOuest4326=\"$BasicSudOuest4326\" >> tmp/tmp_bash

BasicSudEst4326=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicSudEst4326"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicSudEst4326                                                ${purple}: $BasicSudEst4326"
echo BasicNordEst=\"$BasicSudEst4326\" >> tmp/tmp_bash

BasicNordEst4326=$(cat tmp/exiftool|awk -F'|' 'NR==1 {for (i=1; i<=NF; i++) {f[$i] = i}}; { print $(f["BasicNordEst4326"]) }' OFS='|' |sed 's/THIS_IS_AN_EMPTY_CELL//g'|awk 'NR == 2')
echo "${white}---> \$BasicNordEst4326                                               ${purple}: $BasicNordEst4326"
echo BasicNordEst4326=\"$BasicNordEst4326\" >> tmp/tmp_bash


echo "$purple CloudPNGSource $CloudPNGSource CloudZIPSource $CloudZIPSource $CloudTIFSource $CloudTIFSource"
touch tmp/_NodesMap/WFS_Node_$NodeID
printf "$Year|$NodeID|$OriginalPost1980Name|$OldNum|$Seine|$NomMachine|$NomMachineLowCap|$OutputFilenameSeul|$LayerHumanTitle|$WorkspaceName|$WorkspaceNameLowCap|$body|$WKT_Map_Extent|$idsource|$targetid|$layer_attribut|$Default_IDC_GEOMETRY|$PNGHTTP|$ZipHTTP$TiffHTTP|$ZipCloudpath|$TiffPrivatePath|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$ZipCloudpath|$PNGCloudpath|$TiffCloudpath|" >> tmp/_NodesMap/WFS_Node_$NodeID
echo "$red tmp/_NodesMap/WFS_Node_"$NodeID""
echo  "$Year|$NodeID|$OriginalPost1980Name|$OldNum|$Seine|$NomMachine|$NomMachineLowCap|$OutputFilenameSeul|$LayerHumanTitle|$WorkspaceName|$WorkspaceNameLowCap|$body|$WKT_Map_Extent|$idsource|$targetid|$layer_attribut|$Default_IDC_GEOMETRY|$PNGHTTP|$ZipHTTP$TiffHTTP|$ZipCloudpath|$TiffPrivatePath|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$ZipCloudpath|$PNGCloudpath|$TiffCloudpath|"
read
else
echo "${white}---> Maptype                                                          ${orange}: $Maptype"
fi
done

read

#Finising WFS NODE
IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing

find tmp/_NodesMap/ -name WFS_Node_* |sed 's/\/\//\//g'> tmp/_NodesMap/Nodelist
for NodesubMap in $(cat tmp/_NodesMap/Nodelist)
do
cat "$NodesubMap" |sort -n -t '|' -k1 > tmp/TheNodeOrdered
mv tmp/TheNodeOrdered $NodesubMap
done

for NodesubMapB in $(cat tmp/_NodesMap/Nodelist)
do
Year=$(cat $NodesubMapB |awk -F'|' '{print $1}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output Year                                      ${orange}: $Year"
NodeID=$(cat $NodesubMapB |awk -F'|' '{print $2}'|awk 'NR == 1')
echo "${white}---> Output NodeID                                    ${orange}: $NodeID"
OriginalPost1980Name=$(cat $NodesubMapB |awk -F'|' '{print $3}'|awk 'NR == 1')
echo "${white}---> Output OriginalPost1980Name                      ${orange}: $OriginalPost1980Name"

OldNum=$(cat $NodesubMapB |awk -F'|' '{print $4}'|awk 'NR == 1')
echo "${white}---> Output OldNum                                    ${orange}: $OldNum"

Seine=$(cat $NodesubMapB |awk -F'|' '{print $5}'|awk 'NR == 1')
echo "${white}---> Output Seine                                     ${orange}: $Seine"

NomMachine=$(cat $NodesubMapB |awk -F'|' '{print $6}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output NomMachine                                ${orange}: $NomMachine"

NomMachineLowCap=$(cat $NodesubMapB |awk -F'|' '{print $7}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output NomMachineLowCap                          ${orange}: $NomMachineLowCap"

OutputFilenameSeul=$(cat $NodesubMapB |awk -F'|' '{print $8}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output OutputFilenameSeul                        ${orange}: $OutputFilenameSeul"

LayerHumanTitle=$(cat $NodesubMapB |awk -F'|' '{print $9}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output LayerHumanTitle                           ${orange}: $LayerHumanTitle"

WorkspaceName=$(cat $NodesubMapB |awk -F'|' '{print $10}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output WorkspaceName                             ${orange}: $WorkspaceName"

WorkspaceNameLowCap=$(cat $NodesubMapB |awk -F'|' '{print $11}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output WorkspaceNameLowCap                       ${orange}: $WorkspaceNameLowCap"

body=$(cat $NodesubMapB |awk -F'|' '{print $12}'|tr -d '\n')
echo "${white}---> Output body                                      ${orange}: $body"

WKT_Map_Extent=$(cat $NodesubMapB |awk -F'|' '{print $13}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output WKT_Map_Extent                            ${orange}: $WKT_Map_Extent"

idsource=$(cat $NodesubMapB |awk -F'|' '{print $14}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output idsource                                  ${orange}: $idsource"

targetid=$(cat $NodesubMapB |awk -F'|' '{print $15}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output targetid                                  ${orange}: $targetid"

layer_attribut=$(cat $NodesubMapB |awk -F'|' '{print $16}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output layer_attribut                            ${orange}: $layer_attribut"

Default_IDC_GEOMETRY=$(cat $NodesubMapB |awk -F'|' '{print $17}'|awk 'NR == 1')
echo "${white}---> Output Default_IDC_GEOMETRY                      ${orange}: $Default_IDC_GEOMETRY"

PNGHTTP=$(cat $NodesubMapB |awk -F'|' '{print $18}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output PNGHTTP                                   ${orange}: $PNGHTTP"

ZipHTTPTiffHTTP=$(cat $NodesubMapB |awk -F'|' '{print $19}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output ZipHTTPTiffHTTP                           ${orange}: $ZipHTTPTiffHTTP"

ZipCloudpath=$(cat $NodesubMapB |awk -F'|' '{print $20}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output ZipCloudpath                              ${orange}: $ZipCloudpath"

TiffPrivatePath=$(cat $NodesubMapB |awk -F'|' '{print $21}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output TiffPrivatePath                           ${orange}: $TiffPrivatePath"


BasicNordOuest=$(cat $NodesubMapB |awk -F'|' '{print $22}'|awk 'NR == 1')
echo "${white}---> Output BasicNordOuest                            ${orange}: $BasicNordOuest"
BasicSudOuest=$(cat $NodesubMapB |awk -F'|' '{print $23}'|awk 'NR == 1')
echo "${white}---> Output BasicSudOuest                             ${orange}: $BasicSudOuest"
BasicSudEst=$(cat $NodesubMapB |awk -F'|' '{print $24}'|awk 'NR == 1')
echo "${white}---> Output BasicSudEst                               ${orange}: $BasicSudEst"
BasicNordEst=$(cat $NodesubMapB |awk -F'|' '{print $25}'|awk 'NR == 1')
echo "${white}---> Output BasicNordEst                              ${orange}: $BasicNordEst"

echo "${orange}---> Output EPSG:3857                                ${lightblue}: EPSG:3857"

BasicNordOuest3857=$(cat $NodesubMapB |awk -F'|' '{print $26}'|awk 'NR == 1')
echo "${white}---> Output BasicNordOuest3857                        ${orange}: $BasicNordOuest3857"

BasicSudOuest3857=$(cat $NodesubMapB |awk -F'|' '{print $27}'|awk 'NR == 1')
echo "${white}---> Output BasicSudOuest3857                         ${orange}: $BasicSudOuest3857"

BasicSudEst3857=$(cat $NodesubMapB |awk -F'|' '{print $28}'|awk 'NR == 1')
echo "${white}---> Output BasicSudEst3857                           ${orange}: $BasicSudEst3857"

BasicNordEst3857=$(cat $NodesubMapB |awk -F'|' '{print $29}'|awk 'NR == 1')
echo "${white}---> Output BasicNordEst3857                          ${orange}: $BasicNordEst3857"

echo "${orange}---> Output EPSG:4326                                ${lightblue}: EPSG:4326"

BasicNordOuest4326=$(cat $NodesubMapB |awk -F'|' '{print $30}'|awk 'NR == 1')
echo "${white}---> Output BasicNordOuest4326                        ${orange}: $BasicNordOuest4326"

BasicSudOuest4326=$(cat $NodesubMapB |awk -F'|' '{print $31}'|awk 'NR == 1')
echo "${white}---> Output BasicSudOuest4326                         ${orange}: $BasicSudOuest4326"

BasicSudEst4326=$(cat $NodesubMapB |awk -F'|' '{print $32}'|awk 'NR == 1')
echo "${white}---> Output BasicSudEst4326                           ${orange}: $BasicSudEst4326"

BasicNordEst4326=$(cat $NodesubMapB |awk -F'|' '{print $33}'|awk 'NR == 1')
echo "${white}---> Output BasicNordEst4326                          ${orange}: $BasicNordEst4326"

ZipCloudpath=$(cat $NodesubMapB |awk -F'|' '{print $34}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output ZipCloudpath                              ${orange}: $ZipCloudpath"
PNGCloudpath=$(cat $NodesubMapB |awk -F'|' '{print $35}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output PNGCloudpath                              ${orange}: $PNGCloudpath"
TiffCloudpath=$(cat $NodesubMapB |awk -F'|' '{print $36}'|tr '\n' '@' | sed 's/@$//g')
echo "${white}---> Output TiffCloudpath                             ${orange}: $TiffCloudpath"

echo "$NodeID|$OriginalPost1980Name|$OldNum|$Seine|$Year|$WorkspaceNameLowCap|$WorkspaceName|$body|$WKT_Map_Extent|$idsource|$targetid|$layer_attribut|$Default_IDC_GEOMETRY|$PNGHTTP|$ZipHTTP|$TiffHTTP|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$ZipCloudpath|$PNGCloudpath|$TiffCloudpath" >> tmp/WFSTEMP
done
echo "NodeID|OriginalPost1980Name|OldNum|Seine|Year|WorkspaceNameLowCap|WorkspaceName|body|WKT_Map_Extent|idsource|targetid|layer_attribut|Default_IDC_GEOMETRY|PNGHTTP|ZipHTTP|TiffHTTP|BasicNordOuest|BasicSudOuest|BasicSudEst|BasicNordEst|BasicNordOuest3857|BasicSudOuest3857|BasicSudEst3857|BasicNordEst3857|BasicNordOuest4326|BasicSudOuest4326|BasicSudEst4326|BasicNordEst4326|ZipCloudpath|PNGCloudpath|TiffCloudpath" > ../_Output_CSVs/_IMPORT_WFS_LAYERS.csv
cat tmp/WFSTEMP >> ../_Output_CSVs/_IMPORT_WFS_LAYERS.csv

echo "${bg_white}${black}---> Good Bye ! form WFS_Layers_fromCsv.sh${reset}"


#add_planche24-50_ScanHD_1988
#add_25-50_ScanHD_1985
