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
echo "${bg_blue}${white}---> Hello I'm SubRoutine_forNode.sh${reset}"
echo "${white}---> I'm gathering information to generate a CSV, listing different rasters files version, tagging them with key value using exif \"Keywords\" tag in the Geotiff and generating a csv list of all processed maps"
echo "${white}---> Also, I make jpegs files with .wld ans .prj encapsulated in a .zip for Avenza Maps."

source tmp/tmp_bash
source tmp/variable_invariable

PoidsGeoTif=$(ls -lh ../_Output_3857/$Lastrender|awk '{print $5}'|sed 's/K/ Kb/g'|sed 's/M/ Mo/g'|sed 's/G/ Go/g')
echo PoidsGeoTif=\"$PoidsGeoTif\" >> tmp/tmp_bash
LayerHumanTitle=$(echo "$NameNoExt" - "$WorkspaceName" - "$Year" - Size : "$WidthImage" x "$HeightImage" pixels - Reso : $DPI - "$PoidsGeoTif")
echo LayerHumanTitle=\"$LayerHumanTitle\" >> tmp/tmp_bash
LayerHumanShortName=$(echo "$NameNoExt" "$WorkspaceName" "$Year")
echo LayerHumanShortName=\"$LayerHumanShortName\" >> tmp/tmp_bash
echo LayerHumanTitle $LayerHumanTitle
echo PoidsGeoTif $PoidsGeoTif
echo "${white}---> \$LayerHumanShortName                                            ${orange}: $LayerHumanShortName"
echo "${white}---> \$LayerHumanTitle                                                ${orange}: $LayerHumanTitle"
#
#
if [[ $Char3 == [A-Z] ]]
then
echo "${white}---> \$Char3 discovered                                               ${orange}: $Char3"
echo "${white}---> \$This map number is Dpt Seine                                   ${orange}: $Lastrender"

planchesNames=$(awk -F'|' -v "le_nom_completa"="$planchesNamesTMP" '$3=='le_nom_completa'' CODEX_PLANCHES.csv | awk -F'|' '{print $2, $3, $4}' OFS='|' | awk '{print $0"|"}' )
OriginalPost1980Name=$(echo "$planchesNames" |awk -F'|' '{print $1}'|awk -F'_' '{print $1}')
Seine=$(echo "$planchesNames" |awk -F'|' '{print $2}'|awk -F'_' '{print $1}')
OldNum=$(echo "$planchesNames" |awk -F'|' '{print $3}'|awk -F'_' '{print $1}')
NodeID=$(awk -F'|' -v "lenomcompletc"="$planchesNamesTMP" '$3=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $1}'| awk 'NR == 1')

echo OldNum=\"$OldNum\" >> tmp/tmp_bash
echo Seine=\"$Seine\" >> tmp/tmp_bash
echo OriginalPost1980Name=\"$OriginalPost1980Name\" >> tmp/tmp_bash



echo NodeID=\"$NodeID\" >> tmp/tmp_bash
elif [[ $PlancheName_Simple == Feuille-* ]]
then

PlancheFeuille=$( echo "$PlancheName_Simple"| sed 's/Feuille-//g' |awk -F'_' '{print $1}'|sed 's/-B//g'| sed 's/-Special//g')
planchesNames=$(awk -F'|' -v "le_nom_completb"="$PlancheFeuille" '$4=='le_nom_completb'' CODEX_PLANCHES.csv | awk -F'|' '{print $2, $3, $4}' OFS='|'| awk '{print $0"|"}')
OriginalPost1980Name=$(echo "$planchesNames" |awk -F'|' '{print $1}'|awk -F'_' '{print $1}')
Seine=$(echo "$planchesNames" |awk -F'|' '{print $2}'|awk -F'_' '{print $1}')
OldNum=$(echo "$planchesNames" |awk -F'|' '{print $3}'|awk -F'_' '{print $1}'| sed 's/Feuille-//g'| sed 's/-Special//g')
NodeID=$(awk -F'|' -v "lenomcompletc"="$PlancheFeuille" '$4=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $1}'| awk 'NR == 1')
echo NodeID=\"$NodeID\" >> tmp/tmp_bash


echo OldNum=\"$OldNum\" >> tmp/tmp_bash
echo Seine=\"$Seine\" >> tmp/tmp_bash
echo OriginalPost1980Name=\"$OriginalPost1980Name\" >> tmp/tmp_bash
echo "$purple Feuille- planchesNames $planchesNames"
else

echo "$purple ELSE planchesNames $planchesNames"

planchesNames=$(awk -F'|' -v "lenomcompletc"="$PlancheName_Simple" '$2=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $2, $3, $4}' OFS='|' | awk '{print $0"|"}'| awk 'NR == 1')






NodeID=$(awk -F'|' -v "lenomcompletc"="$PlancheName_Simple" '$2=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $1}'| awk 'NR == 1')
OriginalPost1980Name=$(echo "$planchesNames" |awk -F'|' '{print $1}'|awk -F'_' '{print $1}')
Seine=$(echo "$planchesNames" |awk -F'|' '{print $2}'|awk -F'_' '{print $1}')
OldNum=$(echo "$planchesNames" |awk -F'|' '{print $3}'|awk -F'_' '{print $1}')
echo NodeID=\"$NodeID\" >> tmp/tmp_bash
echo OldNum=\"$OldNum\" >> tmp/tmp_bash
echo Seine=\"$Seine\" >> tmp/tmp_bash
echo OriginalPost1980Name=\"$OriginalPost1980Name\" >> tmp/tmp_bash
fi


echo "${white}---> Variables in ${orange}./SubRoutine_forNode.sh                    ${white}<---"
echo "${white}---> \$Lastrender                                                     ${orange}: $Lastrender"
echo "${white}---> \$NodeID                                                         ${orange}: $NodeID"
echo "${white}---> \$OriginalPost1980Name                                           ${orange}: $OriginalPost1980Name"
echo "${white}---> \$Seine                                                          ${orange}: $Seine"
echo "${white}---> \$OldNum                                                         ${orange}: $OldNum"
echo "${white}---> \$PlancheName_Simple                                             ${orange}: $PlancheName_Simple"
echo "${white}---> \$planchesNames                                                  ${orange}: $planchesNames"
echo "${white}---> \$TiffSource                                                     ${orange}: $TiffSource"






#Layer Text Pattern
#NomMachine    NomHuman    targetid    idsource    WKT_Map_Extent    WorkspaceName    WorkspaceNameLowCap    CloudTIFSource    CloudZIPSource    CloudPNGSource    HttpTIFF    PrivateTIFF    Year    layer_attribut    HttpZip    HttpPNG




NameOf_LastProcessed=$(ls -t ../_Output_3857/ | head -n1| sed 's/........$//'| awk -F'_' '{print $1"_"}')


InfoSpecialMap=$(awk -F'|' -v 'NameOf_LastProcessed'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' OFS='|')
echo InfoSpecialMap $InfoSpecialMap

if [ "$InfoSpecialMap" == "" ]
then
echo "${white}---> This map has ${green}No${white} special info !"
echo "$green Nord $Nord"
echo "$green Sud $Sud"
echo "$green Est $Est"
echo "$green Ouest $Ouest"
NordOuest=$(echo "$Ouest $Nord")
SudOuest=$(echo "$Ouest $Sud")
SudEst=$(echo "$Est $Sud")
NordEst=$(echo "$Est $Nord")

else
echo "${white}---> This map has ${red}special info !${reset}"

# 27561
NordOuest=$(echo "$InfoSpecialMap"|awk -F'|' '{print $1}')
SudOuest=$(echo "$InfoSpecialMap"|awk -F'|' '{print $2}')
SudEst=$(echo "$InfoSpecialMap"|awk -F'|' '{print $4}')
NordEst=$(echo "$InfoSpecialMap"|awk -F'|' '{print $3}')
#
NordOuest27561="$NordOuest"
SudOuest27561="$SudOuest"
SudEst27561="$SudEst"
NordEst27561="$NordEst"
echo NordOuest27561=\"$NordOuest27561\" >> tmp/tmp_bash
echo SudOuest27561=\"$SudOuest27561\" >> tmp/tmp_bash
echo SudEst27561=\"$SudEst27561\" >> tmp/tmp_bash
echo NordEst27561=\"$NordEst27561\" >> tmp/tmp_bash


Nord=$(echo "$NordOuest"|awk '{print $2}')
Sud=$(echo "$SudOuest"|awk '{print $2}')
Est=$(echo "$NordEst"|awk '{print $1}')
Ouest=$(echo "$InfoSpecialMap"|awk '{print $1}')





echo "$lightblue Debug Nord 27561   : \$Nord $Nord"
echo "$lightblue Debug Sud 27561    : \$Sud $Sud"
echo "$lightblue Debug Est 27561    : \$Est $Est"
echo "$lightblue Debug Ouest 27561  : \$Ouest $Ouest"
# 3857
NordOuest3857=$(echo "$InfoSpecialMap"|awk -F'|' '{print $5}')
SudOuest3857=$(echo "$InfoSpecialMap"|awk -F'|' '{print $6}')
SudEst3857=$(echo "$InfoSpecialMap"|awk -F'|' '{print $7}')
NordEst3857=$(echo "$InfoSpecialMap"|awk -F'|' '{print $8}')

# 4326
NordOuest4326=$(echo "$InfoSpecialMap"|awk -F'|' '{print $9}')
SudOuest4326=$(echo "$InfoSpecialMap"|awk -F'|' '{print $10}')
SudEst4326=$(echo "$InfoSpecialMap"|awk -F'|' '{print $11}')
NordEst4326=$(echo "$InfoSpecialMap"|awk -F'|' '{print $12}')

fi
    
# 27561
echo "${white}---> \$NordOuest                                                      ${green}: $NordOuest"
echo "${white}---> \$SudOuest                                                       ${green}: $SudOuest"
echo "${white}---> \$SudEst                                                         ${green}: $SudEst"
echo "${white}---> \$NordEst                                                        ${green}: $NordEst"
# 4326
echo "${white}---> \$NordOuest4326                                                  ${green}: $NordOuest4326"
echo "${white}---> \$SudOuest4326                                                   ${green}: $SudOuest4326"
echo "${white}---> \$SudEst4326                                                     ${green}: $SudEst4326"
echo "${white}---> \$NordEst4326                                                    ${green}: $NordEst4326"
# 3857
echo "${white}---> \$NordOuest3857                                                  ${green}: $NordOuest3857"
echo "${white}---> \$SudOuest3857                                                   ${green}: $SudOuest3857"
echo "${white}---> \$SudEst3857                                                     ${green}: $SudEst3857"
echo "${white}---> \$NordEst3857                                                    ${green}: $NordEst3857"
#
# Other Variable
echo "${white}---> \$WidthImage                                                     ${green}: $WidthImage"
echo "${white}---> \$HeightImage                                                    ${green}: $HeightImage"
echo "${white}---> \$Lastrender                                                     ${green}: $Lastrender"
echo "${white}---> \$PlancheName_Simple                                             ${green}: $PlancheName_Simple"
echo "${white}---> \$planchesNamesTMP                                               ${green}: $planchesNamesTMP"
echo "${white}---> \$Char3                                                          ${green}: $Char3"
echo "${white}---> \$NodeID                                                         ${green}: $NodeID"
echo "${white}---> \$Year                                                           ${green}: $Year"
WKT_Map_Extent=$(echo "GEOMETRYCOLLECTION(POLYGON(($NordOuest3857, $SudOuest3857, $SudEst3857, $NordEst3857, $NordOuest3857)))")

echo "${white}---> \$AbscissaMultiple     ${green}: $AbscissaMultiple"
echo "${white}---> \$OrdinateMultiple     ${green}: $OrdinateMultiple"

echo WKT_Map_Extent=\"$WKT_Map_Extent\" >> tmp/tmp_bash
echo NordOuest=\"$NordOuest\" >> tmp/tmp_bash
echo SudOuest=\"$SudOuest\" >> tmp/tmp_bash
echo SudEst=\"$SudEst\" >> tmp/tmp_bash
echo NordEst=\"$NordEst\" >> tmp/tmp_bash
echo Nord=\"$Nord\" >> tmp/tmp_bash
echo Sud=\"$Sud\" >> tmp/tmp_bash
echo Est=\"$Est\" >> tmp/tmp_bash
echo Ouest=\"$Ouest\" >> tmp/tmp_bash
echo NordOuest3857=\"$NordOuest3857\" >> tmp/tmp_bash
echo SudOuest3857=\"$SudOuest3857\" >> tmp/tmp_bash
echo SudEst3857=\"$SudEst3857\" >> tmp/tmp_bash
echo NordEst3857=\"$NordEst3857\" >> tmp/tmp_bash
echo NordOuest4326=\"$NordOuest4326\" >> tmp/tmp_bash
echo SudOuest4326=\"$SudOuest4326\" >> tmp/tmp_bash
echo SudEst4326=\"$SudEst4326\" >> tmp/tmp_bash
echo NordEst4326=\"$NordEst4326\" >> tmp/tmp_bash

LayerBound=$(echo $SudOuest3857 $NordEst3857|sed 's/  / /g'|sed 's/ /, /g'|sed 's/, $//g')
NordBasic=$(echo 126224-$Hauteur*$AbscissaMultiple |bc -l)
SudBasic=$(echo 125824-$Hauteur*$AbscissaMultiple|bc -l )
EstBasic=$(echo 600000+\($OrdinateMultiple*$Largeur\) |bc -l )
OuestBasic=$(echo 599400+\($OrdinateMultiple*$Largeur\) |bc -l )


BasicNordOuest=$(echo $OuestBasic $NordBasic)
BasicSudOuest=$(echo $OuestBasic $SudBasic)
BasicSudEst=$(echo $EstBasic $SudBasic)
BasicNordEst=$(echo $EstBasic $NordBasic)
echo BasicNordOuest=\"$BasicNordOuest\" >> tmp/tmp_bash
echo BasicSudOuest=\"$BasicSudOuest\" >> tmp/tmp_bash
echo BasicSudEst=\"$BasicSudEst\" >> tmp/tmp_bash
echo BasicNordEst=\"$BasicNordEst\" >> tmp/tmp_bash

echo "${white}---> Point cardinaux ${orange}EPSG:27561"
echo "${white}---> Default map IDC NordBasic                                        27561  ${orange}: $NordBasic "
echo "${white}---> Default map IDC SudBasic                                         27561  ${orange}: $SudBasic "
echo "${white}---> Default map IDC OuestBasic                                       27561  ${orange}: $OuestBasic "
echo "${white}---> Default map IDC EstBasic                                         27561  ${orange}: $EstBasic "
echo "${white}---> Basic Extent EPSG:27561"
echo "${white}---> Default map IDC BasicNordOuest                                   27561  ${orange}: $BasicNordOuest "
echo "${white}---> Default map IDC BasicSudOuest                                    27561  ${orange}: $BasicSudOuest "
echo "${white}---> Default map IDC BasicSudEst                                      27561  ${orange}: $BasicSudEst "
echo "${white}---> Default map IDC BasicNordEst                                     27561  ${orange}: $BasicNordEst "

BasicNordOuest3857=$(echo "$BasicNordOuest"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
BasicSudOuest3857=$(echo "$BasicSudOuest"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
BasicSudEst3857=$(echo "$BasicSudEst"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
BasicNordEst3857=$(echo "$BasicNordEst"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
echo BasicNordOuest3857=\"$BasicNordOuest3857\" >> tmp/tmp_bash
echo BasicSudOuest3857=\"$BasicSudOuest3857\" >> tmp/tmp_bash
echo BasicSudEst3857=\"$BasicSudEst3857\" >> tmp/tmp_bash
echo BasicNordEst3857=\"$BasicNordEst3857\" >> tmp/tmp_bash

#
BasicNordOuest4326=$(echo "$BasicNordOuest"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326| awk '{print $2, $1}')
echo BasicNordOuest4326=\"$BasicNordOuest4326\" >> tmp/tmp_bash
BasicSudOuest4326=$(echo "$BasicSudOuest"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326| awk '{print $2, $1}')
echo BasicSudOuest4326=\"$BasicSudOuest4326\" >> tmp/tmp_bash
BasicSudEst4326=$(echo "$BasicSudEst"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326| awk '{print $2, $1}')
echo BasicSudEst4326=\"$BasicSudEst4326\" >> tmp/tmp_bash
BasicNordEst4326=$(echo "$BasicNordEst"| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326| awk '{print $2, $1}')
echo BasicNordEst4326=\"$BasicNordEst4326\" >> tmp/tmp_bash

echo "${white}---> Basic Extent ${orange}EPSG:3857"
echo "${white}---> Default map IDC BasicNordOuest3857                               3857  ${orange}: $BasicNordOuest3857 "
echo "${white}---> Default map IDC BasicSudOuest3857                                3857  ${orange}: $BasicSudOuest3857 "
echo "${white}---> Default map IDC BasicSudEst3857                                  3857  ${orange}: $BasicSudEst3857 "
echo "${white}---> Default map IDC BasicNordEst3857                                 3857  ${orange}: $BasicNordEst3857 "
echo "${white}---> Geometry WKT Map Extent                                                ${orange}: EPSG:3857"

Default_IDC_GEOMETRY=$(echo "GEOMETRYCOLLECTION(POLYGON(("$BasicNordOuest3857, $BasicSudOuest3857, $BasicSudEst3857, $BasicNordEst3857, $BasicNordOuest3857")))")
echo "${white}---> Default_IDC_GEOMETRY                        ${green} : $Default_IDC_GEOMETRY"
echo Default_IDC_GEOMETRY=\"$Default_IDC_GEOMETRY\" >> tmp/tmp_bash
echo "${white}---> Basic Extent                                                           ${orange}: EPSG:4326"
echo "${white}---> Default map IDC BasicNordOuest4326                               4326  ${orange}: $BasicNordOuest4326"
echo "${white}---> Default map IDC BasicSudOuest4326                                4326  ${orange}: $BasicSudOuest4326"
echo "${white}---> Default map IDC BasicSudEst4326                                  4326  ${orange}: $BasicSudEst4326"
echo "${white}---> Default map IDC BasicNordEst4326                                 4326  ${orange}: $BasicNordEst4326"
#
echo "${white}---> Default map IDC AbscissaMultiple                                       ${orange}: $AbscissaMultiple"
echo "${white}---> Default map IDC OrdinateMultiple                                       ${orange}: $OrdinateMultiple"
echo "${white}---> Default map IDC Abscissa                                               ${orange}: $Abscissa"
echo "${white}---> Default map IDC Ordinate                                               ${orange}: $Ordinate"
#
echo LayerBound=\"$LayerBound\" >> tmp/tmp_bash
echo NordBasic=\"$NordBasic\" >> tmp/tmp_bash
echo SudBasic=\"$SudBasic\" >> tmp/tmp_bash
echo EstBasic=\"$EstBasic\" >> tmp/tmp_bash
echo OuestBasic=\"$OuestBasic\" >> tmp/tmp_bash
#
echo NodeID=\"$NodeID\" >> tmp/tmp_bash

source tmp/tmp_bash
./GenrateBody.sh
source tmp/tmp_bash

./GenrateHidenSeek.sh
source tmp/tmp_bash
./GenerateWLD.sh
source tmp/tmp_bash


base_name=$(echo "$PlancheName_Simple" | awk -F'_' '{print $1}')


echo "${white}---> \$base_name                                                          ${orange} :$base_name"

echo "${bg_white}${black}---> GoodBye ! from SubRoutine_forNode.sh${reset}"



