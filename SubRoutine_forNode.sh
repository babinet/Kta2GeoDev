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

planchesNames=$(awk -F'|' -v "lenomcompletc"="$planchesNamesTMP" '$2=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $2, $3, $4}' OFS='|' | awk '{print $0"|"}'| awk 'NR == 1')
NodeID=$(awk -F'|' -v "lenomcompletc"="$planchesNamesTMP" '$2=='lenomcompletc'' CODEX_PLANCHES.csv | awk -F'|' '{print $1}'| awk 'NR == 1')
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
echo $purple NordOuest $NordOuest SudOuest $SudOuest SudEst $SudEst NordEst $NordEst

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
echo Default_IDC_GEOMETRY=\"$Default_IDC_GEOMETRY\" >> tmp/tmp_bash
echo "${white}---> Basic Extent                                                     ${orange}: EPSG:4326"
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



#
#if [[ $TiffSource == *-union_* ]]||[[ $TiffSource == *Feuille-300-301_* ]]||[[ $TiffSource == *Feuille-281-Special-union_* ]]||[[ $TiffSource == *Feuille-281-B-union_* ]]||[[ $TiffSource == *Feuille-276-277_* ]]||[[ $TiffSource == *Feuille-59-union* ]]
#then
#
#
##echo "$red Rares and specials names"
##if [[ $TiffSource == *Feuille-281-union_* ]]
##then
##echo "${red} spécial${white} "$TiffSource""
##NodeID="34663"
##OldNum="281"
##Seine="55Y"
##planchesNames="25-50|55Y|281"
##OriginalPost1980Name="25-50"
##fi
#
#if [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-59-union"* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="54891"
#OldNum="59"
#Seine="40G"
#planchesNames="32-37|40G|59"
#OriginalPost1980Name="32-37"
#fi
#
#if [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/Feuille-281-B-union_"* ]]
#then
#NodeID="34663"
#OldNum="281"
#Seine="55Y"
#planchesNames="25-50|55Y|281|"
#OriginalPost1980Name="25-50"
#fi
#
#if [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/Feuille-282-B-union_"* ]]
#then
#NodeID="34664"
#OldNum="282"
#Seine="56U"
#planchesNames="26-50|56U|282|"
#OriginalPost1980Name="26-50"
#fi
#
#
#if [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/Feuille-300-301_"* ]]
#then
#NodeID="34679"
#OldNum="300"
#Seine="64D"
#planchesNames="29-51|64D|300|"
#OriginalPost1980Name="29-51"
#fi
#
#if [[ "$TiffSource" == *Feuille-276-277_* ]]
#then
#OldNum="277"
#Seine="55U"
#OriginalPost1980Name="21-50"
#fi
#
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-147-148-union_* ]]
#then
#BasicWKT=$(echo "Polygon ((253726.239 6251420.329, 53726.239 6250810.978, 254788.639 6250810.978, 253726.239 6251420.329))")
#echo "${red} spécial${white} Feuille-147-148-union_"
#NodeID="34605"
#OldNum="147"
#Seine="46N"
#planchesNames="19-43|46N|147"
#OriginalPost1980Name="19-43"
#fi
#
    #OriginalAbsica=$(echo "$OriginalPost1980Name"| awk -F'-' '{print $2}')
#OriginalOrditae=$(echo "$OriginalPost1980Name"| awk -F'-' '{print $1}')
#echo "${green}---> i'm very special (not cropped as the original frame or like Feuille-300-301 with a different size)"
#else
#echo "${white}---> Standard ${preen}Abcissa / Ordinate - OriginalAbsica / OriginalOrdinate"
#OriginalAbsica="$Abscissa"
#OriginalOrditae="$Ordinate"
#echo "${white}---> Standard ${preen}Abcissa / Ordinate - $Abscissa / $Orditae"
#fi
#
#hauteur=400
#Largeur=600
#
## To get parent map
#AbscissaMultiple=$(echo "$OriginalAbsica"-50 |bc -l)
#OrdinateMultiple=$(echo "$OriginalOrditae"-25 | bc -l)
## Position Origin (Mètres) 600000 126224 Zéro de l'observatoire de Paris
#
#NordBasicTMP=$(echo 126224-$Hauteur*$AbscissaMultiple |bc -l )
#SudBasicTMP=$(echo 125824-$Hauteur*$AbscissaMultiple|bc -l )
#EstBasicTMP=$(echo 600000+\($OrdinateMultiple*$Largeur\) |bc -l )
#OuestBasicTMP=$(echo 599400+\($OrdinateMultiple*$Largeur\) |bc -l )
#
#NordOuestBasic2571=$(echo $OuestBasicTMP $NordBasicTMP)
#SudOuestBasic2571=$(echo $OuestBasicTMP $SudBasicTMP)
#SudEstBasic2571=$(echo $EstBasicTMP $SudBasicTMP)
#NordEstBasic2571=$(echo $EstBasicTMP $NordBasicTMP)
#
#NordOuestBasic4326=$(echo $OuestBasicTMP $NordBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudOuestBasic4326=$(echo $OuestBasicTMP $SudBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudEstBasic4326=$(echo $EstBasicTMP $SudBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#NordEstBasic4326=$(echo $EstBasicTMP $NordBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 |awk '{print $2, $1}')
#
#NordOuestBasic=$(echo $OuestBasicTMP $NordBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
#SudOuestBasic=$(echo $OuestBasicTMP $SudBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
#SudEstBasic=$(echo $EstBasicTMP $SudBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
#NordEstBasic=$(echo $EstBasicTMP $NordBasicTMP| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
#
#
#
#
## last modified in
#NameOf_LastProcessed=$(ls -t ../_Output_3857/ | head -n1| sed 's/........$//'| awk -F'_' '{print $1"_"}')
## Special case adjustment
#if [ "$NameOf_LastProcessed" == "Feuille-147-148-union_" ]
#then
#NameOf_LastProcessed="Feuille-147-union_"
#fi
#
#if [ "$NameOf_LastProcessed" == "Feuille-276-277_" ]
#then
#NameOf_LastProcessed="Feuille-276-277_"
#fi
#
#
#
#NameForUnion=$(echo "$NameOf_LastProcessed" |awk '/-union_/'| awk -F'-union_' '{print $1"-union_"}')
#
#if [[ $base_name == 42-43-39 ]]||[[ $base_name == 34-38-35 ]]||[[ $base_name == 48-38-39 ]]||[[ $base_name == 36-40-41 ]]||[[ $base_name == 3-4-41 ]]||[[ $base_name == 32-41-33 ]]||[[ $base_name == 34-41-42 ]]||[[ $base_name == 36-41-42 ]]||[[ $base_name == 36-42-43 ]]||[[ $base_name == 39-43-44 ]]||[[ $base_name == 39-44-45 ]]||[[ $base_name == 41-46-42 ]]||[[ $base_name == 34-48-49 ]]||[[ $base_name == 33-48-49 ]]||[[ $base_name == 34-49-50 ]]||[[ $base_name == 35-49-50 ]]||[[ $base_name == 8-9-51-52 ]]||[[ $base_name == 33-51-34 ]]||[[ $base_name == 12-54-55 ]]||[[ $base_name == 37-58-59 ]]||[[ $base_name == 45-58-59 ]]||[[ $base_name == 38-58-59 ]]||[[ $base_name == 42-60-43 ]]||[[ $base_name == 15-59-16 ]]||[[ $base_name == 18-40-19 ]]||[[ $base_name == 28-12-13 ]]||[[ $base_name == 42Q-R ]]||[[ $base_name == 40M-N ]]||[[ $base_name == 43M-R ]]||[[ $base_name == 41U-50A ]]||[[ $base_name == 49B-C ]]||[[ $base_name == 49D-I ]]||[[ $base_name == 50A-F ]]||[[ $base_name == 50F-N ]]||[[ $base_name == 50N-S ]]||[[ $base_name == 50S-X ]]||[[ $base_name == 59A-B ]]||[[ $base_name == 51U-V ]]||[[ $base_name == 51U ]]||[[ $base_name == 57N-S ]]||[[ $base_name == 57M-R ]]||[[ $base_name == 57S-X ]]||[[ $base_name == 57T-Y ]]||[[ $base_name == 65C-D ]]||[[ $base_name == 61Q-V ]]||[[ $base_name == 76O-T ]]||[[ $base_name == 75M-N ]]||[[ $base_name == 76V-W ]]||[[ $base_name == 71P ]]||[[ $base_name == 37W-X ]]||[[ $base_name == 3H-M ]]||[[ $base_name == Feuille-76 ]]||[[ $base_name == Feuille-126-144 ]]||[[ $base_name == Feuille-273 ]]||[[ $base_name == Feuille-274 ]]||[[ $base_name == Feuille-304 ]]||[[ $base_name == Feuille-93 ]]||[[ $base_name == Feuille-93 ]]||[[ $base_name == 77P ]]||[[ $base_name == Feuille-59 ]]||[[ $base_name == Feuille-124-125 ]]||[[ $base_name == Feuille-255 ]]||[[ $base_name == 32-33-41 ]]||[[ $base_name == Feuille-254-273 ]]
#then
#
#
#
#
#
#top_left27561=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $4}')
#bottom_left27561=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $5}')
#bottom_right27561=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $6}')
#top_right27561=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $7}')
#BasicWKT=$(echo "Polygon (($NordOuest3857, $SudOuest3857, $SudEst3857, $NordEst3857, $NordOuest3857))")
#
#Nord=$(echo $top_left27561|awk '{print $2}')
#Sud=$(echo $bottom_left27561|awk '{print $2}')
#Est=$(echo $bottom_right27561|awk '{print $1}')
#Ouest=$(echo $top_left27561|awk '{print $1}')
#
## NW
#NordOuest4326=$(echo "$Ouest $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#NordOuest3857=$(echo "$Ouest $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
## SW
#SudOuest4326=$(echo "$Ouest $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudOuest3857=$(echo "$Ouest $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
## NE
#NordEst4326=$(echo "$Est $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#NordEst3857=$(echo "$Est $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
## SE
#SudEst4326=$(echo "$Est $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudEst3857=$(echo "$Est $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
#
#echo top_left27561=\"$top_left27561\" >> tmp/tmp_bash
#echo bottom_left27561=\"$bottom_left27561\" >> tmp/tmp_bash
#echo bottom_right27561=\"$bottom_right27561\" >> tmp/tmp_bash
#echo top_right27561=\"$top_right27561\" >> tmp/tmp_bash
#
#
#echo NordOuest4326=\"$NordOuest4326\" >> tmp/tmp_bash
#echo NordOuest3857=\"$NordOuest3857\" >> tmp/tmp_bash
#echo SudOuest4326=\"$SudOuest4326\" >> tmp/tmp_bash
#echo SudOuest3857=\"$SudOuest3857\" >> tmp/tmp_bash
#echo NordEst4326=\"$NordEst4326\" >> tmp/tmp_bash
#echo NordEst3857=\"$NordEst3857\" >> tmp/tmp_bash
#echo SudEst4326=\"$SudEst4326\" >> tmp/tmp_bash
#echo SudEst3857=\"$SudEst3857\" >> tmp/tmp_bash
#
#
#
#
#
#NordOuest3857=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $8}')
#SudOuest3857=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $9}')
#SudEst3857=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $10}')
#NordEst3857=$(awk -F'|' -v 'base_name'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $11}')
#BasicWKT=$(echo "Polygon (($NordOuest3857, $SudOuest3857, $SudEst3857, $NordEst3857, $NordOuest3857))")
#echo "$green Hello there... I'm Special $red(Special Map Extent)"
#echo $purple $BasicWKT BasicWKT
#
#
#
#NordOuestBasic2571=$(echo $Ouest $Nord)
#SudOuestBasic2571=$(echo $Ouest $Sud)
#SudEstBasic2571=$(echo $Est $Sud)
#NordEstBasic2571=$(echo $Est $Nord)
#
#NordOuestBasic4326=$(echo $Ouest $Nord| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudOuestBasic4326=$(echo $Ouest $Sud| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#SudEstBasic4326=$(echo $Est $Sud| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
#NordEstBasic4326=$(echo $Est $Nord| gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 |awk '{print $2, $1}')
#
#NordOuestBasic="$NordOuest3857"
#SudOuestBasic="$SudOuest3857"
#SudEstBasic="$SudEst3857"
#NordEstBasic="$NordEst3857"
#
#
#
#
#else
#BasicWKT=$(echo "Polygon (($NordOuestBasic, $SudOuestBasic, $SudEstBasic, $NordEstBasic, $NordOuestBasic))")
#echo "${grey}---> \$BasicWKT${grey}   Original layer extent   -   -   -   -   -   -   -   -   -   ${orange}$BasicWKT"
#echo "$green Normal.. I'm Normal (Map Extent)"
#fi
#
#
##
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-106_* ]]
#then
#echo "${red} spécial${white} 41-45-42-Encart_"
#NodeID="34575"
#OldNum="106"
#Seine="40U"
#planchesNames="31-40|40U|106"
#OriginalPost1980Name="31-40"
#fi
#
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/41-45-42-Encart_* ]]
#then
#echo "${red} spécial${white} 41-45-42-Encart_"
#NodeID="34619"
#OldNum=""
#Seine="51U-V"
#planchesNames="41-45-42|51U-V|"
#OriginalPost1980Name="41-45-42"
#fi
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-281-B* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34663"
#OldNum="281"
#Seine="51U-V"
#planchesNames="25-50|55Y|"
#OriginalPost1980Name="25-50"
#fi
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-282-B* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34664"
#OldNum="282"
#Seine="56U"
#planchesNames="26-50|56U|"
#OriginalPost1980Name="26-50"
#fi
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-147-148-union_* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34605"
#OldNum="282"
#Seine="46N"
#planchesNames="19-43|46N|147-148"
#OriginalPost1980Name="19-43"
#fi
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-276-277* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34658"
#OldNum="277"
#Seine="55U"
#planchesNames="21-50|54Y|276-277"
#OriginalPost1980Name="21-50"
#fi
#
#
#
#
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-254-273_* ]]||[[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-273* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34655"
#OldNum="273"
#Seine="57M-R"
#planchesNames="33-48-49|57M-R|276-277"
#OriginalPost1980Name="33-48-49"
#fi
#
#if [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-276-277* ]]
#then
#echo "${red} spécial${white} "$TiffSource""
#NodeID="34591"
#OldNum="126-144"
#Seine="49D-I"
#planchesNames="20-50|54Y|276-277"
#OriginalPost1980Name="34-41-42"
#fi
#
## # Rares and specials names
#if [[ "$TiffSource" =~ "../_Source_Standard_Croped_TIFF/76V-W_"* ]]
#then
#NodeID="34875"
#OldNum=""
#Seine="76V-W"
#planchesNames="42-60-43|76V-W||"
#OriginalPost1980Name="42-60-43"
#fi
#
#
#### Echo des variables
#echo "                                                                     ${grey}Nord     Lambert 1"
#echo "${grey}---> \$Nord   Lambert Nord    -   - EPSG:${green}27561${grey}-   -   -   -   -   -   ${orange}$Nord"
#echo "                                                                     ${grey}Sud      Lambert 1"
#echo "${grey}---> \$Sud    Lambert Nord    -   - EPSG:${green}27561${grey}-   -   -   -   -   -   ${orange}$Sud"
#echo "                                                                     ${grey}Est      Lambert 1"
#echo "${grey}---> \$Est    Lambert Nord    -   - EPSG:${green}27561${grey}-   -   -   -   -   -   ${orange}$Est"
#echo "                                                                     ${grey}Ouest    Lambert 1"
#echo "${grey}---> \$Ouest  Lambert Nord    -   - EPSG:${green}27561${grey}-   -   -   -   -   -   ${orange}$Ouest"
#echo "
#${grey}---> WGS 84 (World Geodetic System 1984)EPSG:${green}4326 ${grey}Corners unit  :       ${green}degree          ${grey}<---
#${grey}---> \"World Geodetic System 1984 / -85.06,-180,85.06,180\""
#
#echo "${grey}---> \$NordOuest4326  -   -   -   - EPSG:${green}4326${grey} -   -   -   -   -   -   ${orange}$NordOuest4326"
#echo "${grey}---> \$SudOuest4326   -   -   -   - EPSG:${green}4326${grey} -   -   -   -   -   -   ${orange}$SudOuest4326"
#echo "${grey}---> \$NordEst4326    -   -   -   - EPSG:${green}4326${grey} -   -   -   -   -   -   ${orange}$NordEst4326"
#echo "${grey}---> \$SudEst4326 -   -   -   -   - EPSG:${green}4326${grey} -   -   -   -   -   -   ${orange}$SudEst4326"
#
#echo "
#${grey}---> WGS 84 / Pseudo-Mercator      EPSG:${green}3857 ${grey}Corners      unit  :       ${green}meter           ${grey}<---
#${grey}---> \"World Geodetic System 1984\""
#echo "${grey}---> \$NordOuest3857  -   -   -   - EPSG:${green}3857${grey} -   -   -   -   -   -   ${orange}$NordOuest3857"
#echo "${grey}---> \$SudOuest3857   -   -   -   - EPSG:${green}3857${grey} -   -   -   -   -   -   ${orange}$SudOuest3857"
#echo "${grey}---> \$SudEst3857 -   -   -   -   - EPSG:${green}3857${grey} -   -   -   -   -   -   ${orange}$SudEst3857"
#echo "${grey}---> \$NordEst3857    -   -   -   - EPSG:${green}3857${grey} -   -   -   -   -   -   ${orange}$NordEst3857"
#
#echo "${grey}---> \$WidthImage${grey} -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$WidthImage px"
#echo "${grey}---> \$HeightImage${grey}    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$HeightImage px"
#echo "${grey}---> \$Year${grey}   -   -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Year"
#echo "${grey}---> \$geoserverworkspace${grey} -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$geoserverworkspace"
#echo "${grey}---> \$PlancheName_Simple${grey} -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$PlancheName_Simple"
#echo "${grey}---> \$NameOf_LastProcessed${grey}   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NameOf_LastProcessed"
#
#echo "${grey}---> \$NameForUnion${red}            -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NameForUnion"
#
#echo "${grey}---> \$Ordinate${grey}      -   -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Ordinate"
#echo "${grey}---> \$Abscissa${grey}      -   -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Abscissa"
#
#echo "${grey}---> \$NordOuestBasic${grey}    -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NordOuestBasic"
#echo "${grey}---> \$SudOuestBasic${grey}     -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$SudOuestBasic"
#echo "${grey}---> \$SudEstBasic${grey}       -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$SudEstBasic"
#echo "${grey}---> \$NordEstBasic${grey}      -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NordEstBasic"
#echo "${grey}---> \$StorageLocation${grey}   Root folder where the souces are -   -   -   -   -   ${orange}$StorageLocation"
#echo "${grey}---> \$base_name${grey}     -   -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$base_name"
#echo "${grey}---> \$NodeID${grey}        -   -    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NodeID"
#echo "${grey}---> \$planchesNames${grey} -   -    -   -   -   -   -   -   -   -   -   -   -   -   ${purple}$planchesNames"
#echo "${grey}---> \$OriginalPost1980Name${grey}   -   -   -   -   -   -   -   -   -   -   -   -   ${purple}$OriginalPost1980Name"
#
#
#filesizePX=$(exiftool ../_Output_3857/"$Lastrender" | awk '/Image Size/' |sed 's/x/ X /g' |awk -F' : ' '{print $2" PX "}')
#filesizeMO=$(exiftool ../_Output_3857/"$Lastrender" | awk '/File Size/' |sed 's/x/ X /g' |awk -F' : ' '{print $2}'| sed 's/MB/MO/g' | sed 's/MiB/MO/g'  )
#FileName=$(exiftool ../_Output_3857/"$Lastrender" | awk '/File Name/' |sed 's/x/ X /g' |awk -F' : ' '{print $2}' | awk -F'_' '{print $1, $2}' |awk -F'.' '{print $1}'  )
#ResolutionX=$(exiftool ../_Output_3857/"$Lastrender" | awk '/X Resolution/' |awk -F' : ' '{print $2}')
#ResolutionY=$(exiftool ../_Output_3857/"$Lastrender" | awk '/Y Resolution/' |awk -F' : ' '{print $2}')
#
#MapCentroid=$(gdalinfo ../_Output_3857/"$Lastrender" |awk '/Center   /'|awk -F'\\(  '  '{print $2}'|awk -F'\\)'  '{print $1}')
#MapTitleHumanReadable=$(echo ../_Output_3857/"$Lastrender"|awk -F'_Output_3857/' '{print $2}'|sed 's/.tif//g'|tr '-' ' '|tr '_' ' ')
#
#echo MapTitleHumanReadable=\"$MapTitleHumanReadable\" >> tmp/tmp_bash
#echo MapCentroid=\"$MapCentroid\" >> tmp/tmp_bash
#
#
#ResolutionY_rounded=`printf "%.0f" $ResolutionY`
#ResolutionX_rounded=`printf "%.0f" $ResolutionX`
#echo ""$FileName" - "$geoserverworkspace" - Size: "$filesizePX"- Res : "$ResolutionX_rounded" pixels/pouce - "$filesizeMO" - GeoTiff" >> tmp/GeoTiffList
#
#InfoSpecialMap=$(awk -F'|' -v 'NameOf_LastProcessed'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' OFS='|')
#
#echo "${grey}---> \$InfoSpecialMap${grey}   :  ${orange}$InfoSpecialMap"
#
#
#RawMapName=$(echo "$NameNoExt" - "$Year" - "$geoserverworkspace" - "$filesizePX" - "$ResolutionX_rounded"  pixels/pouce - Mètre - EPSG:3857 - "$filesizeMO" | tr '_' ' ')
#RawMapUri=$(echo "$StorageLocation"_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif)
#ZipRawMapUri=$(echo "$StorageLocation"_Output_wld_zip/"$NameNoExt"_"$geoserverworkspace"_"$Year".zip)
#PreviewPNGLocation=$(echo "$StorageLocation"_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png)
#LastModified_GeoTiff=$(exiftool ../_Output_3857/"$Lastrender" |awk '/Modify Date/' |awk -F': ' '{print $2}')
#
#
#NomMachine="$NameNoExt"
#echo NomMachine=\"$NomMachine\" >> tmp/tmp_bash
#
#NomHuman="$RawMapName"
#echo NomHuman=\"$NomHuman\" >> tmp/tmp_bash
#
#S19_Original_RawMapName="$RawMapName"
#echo S19_Original_RawMapName=\"$S19_Original_RawMapName\" >> tmp/tmp_bash
#
#S35_NordOuestBasic="$NordOuestBasic"
#echo S35_NordOuestBasic=\"$S35_NordOuestBasic\" >> tmp/tmp_bash
#
#S36_SudOuestBasic="$SudOuestBasic"
#echo S36_SudOuestBasic=\"$S36_SudOuestBasic\" >> tmp/tmp_bash
#
#S37_SudEstBasic="$SudEstBasic"
#echo S37_SudEstBasic=\"$S37_SudEstBasic\" >> tmp/tmp_bash
#
#S38_NordEstBasic="$NordEstBasic"
#echo S38_NordEstBasic=\"$S38_NordEstBasic\" >> tmp/tmp_bash
#
#S27_NordOuestBasic2571="$NordOuestBasic2571"
#echo S27_NordOuestBasic2571=\"$S27_NordOuestBasic2571\" >> tmp/tmp_bash
#
#S28_SudOuestBasic2571="$SudOuestBasic2571"
#echo S28_SudOuestBasic2571=\"$S28_SudOuestBasic2571\" >> tmp/tmp_bash
#
#S29_SudEstBasic2571="$SudEstBasic2571"
#echo S29_SudEstBasic2571=\"$S29_SudEstBasic2571\" >> tmp/tmp_bash
#
#S30_NordEstBasic2571="$NordEstBasic2571"
#echo S30_NordEstBasic2571=\"$S30_NordEstBasic2571\" >> tmp/tmp_bash
#
#S31_NordOuestBasic4326="$NordOuestBasic4326"
#echo S31_NordOuestBasic4326=\"$S31_NordOuestBasic4326\" >> tmp/tmp_bash
#
#S32_SudOuestBasic4326="$SudOuestBasic4326"
#echo S32_SudOuestBasic4326=\"$S32_SudOuestBasic4326\" >> tmp/tmp_bash
#
#S33_SudEstBasic4326="$SudEstBasic4326"
#echo S33_SudEstBasic4326=\"$S33_SudEstBasic4326\" >> tmp/tmp_bash
#
#S34_NordEstBasic4326="$NordEstBasic4326"
#echo S34_NordEstBasic4326=\"$S34_NordEstBasic4326\" >> tmp/tmp_bash
#WorkspaceName="$geoserverworkspace"
##
#echo "NomMachine|NomHuman|WorkspaceName|WorkspaceNameLowCap|layer_attribut|idsource|targetid|CloudTIFSource|CloudZIPSource|CloudPNGSource|PrivateTIFF|HttpTIFF|HttpPNG|HttpZip|S23_NodeID|S2_nodetitle|S3_field_deptf_seine|S4_OldNum|S17_WKT|S19_Original_RawMapName|S18_Original_Tiff_Sources|S40_Body|S68_SourcePNG|S65_The_zips_sources|S35_NordOuestBasic|S36_SudOuestBasic|S37_SudEstBasic|S38_NordEstBasic|S27_NordOuestBasic2571|S28_SudOuestBasic2571|S29_SudEstBasic2571|S30_NordEstBasic2571|S31_NordOuestBasic4326|S32_SudOuestBasic4326|S33_SudEstBasic4326|S34_NordEstBasic4326|tifprivatelink|zipprivatelink
#$NomMachine|$NomHuman|$WorkspaceName|WorkspaceNameLowCap|layer_attribut|idsource|targetid|CloudTIFSource|CloudZIPSource|CloudPNGSource|PrivateTIFF|HttpTIFF|HttpPNG|HttpZip|S23_NodeID|S2_nodetitle|S3_field_deptf_seine|S4_OldNum|$S17_WKT|$S19_Original_RawMapName|S18_Original_Tiff_Sources|S40_Body|S68_SourcePNG|S65_The_zips_sources|$S35_NordOuestBasic|$S36_SudOuestBasic|$S37_SudEstBasic|$S38_NordEstBasic|$S27_NordOuestBasic2571|$S28_SudOuestBasic2571|$S29_SudEstBasic2571|$S30_NordEstBasic2571|$S31_NordOuestBasic4326|$S32_SudOuestBasic4326|$S33_SudEstBasic4326|$S34_NordEstBasic4326|tifprivatelink|zipprivatelink"
##Layer Text
##NomMachine|NomHuman|WorkspaceName|WKT_Map_Extent|WorkspaceName|WorkspaceNameLowCap|layer_attribut|idsource|targetid|Year|CloudTIFSource|CloudZIPSource|CloudPNGSource|PrivateTIFF|HttpTIFF|HttpPNG|HttpZip
##LayerBound=$(echo $SudOuest3857 $NordEst3857|sed 's/  / /g'|sed 's/ /, /g'|sed 's/, $//g')
#
#
#
##Filename|nodetitle|field_deptf_seine|OldNum|top_left27561|bottom_left27561|bottom_right27561|top_right27561|top_left|bottom_left|bottom_right|top_right|top_left4326|bottom_left4326|bottom_right4326|top_right4326|WKT|RawMapUri|RawMapName|StorageLocation|PreviewPNGLocation|Year|nodeID|WKT_Map_Extent|geoserverworkspace|ZipRawMapUri|NordOuestBasic2571|SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable|LayerBound
#
#
#
#echo ${white} "$Lastrender|$OriginalPost1980Name|$Seine|$OldNum|$Ouest $Nord|$Ouest $Sud|$Est $Sud|$Est $Nord|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$WKT|$RawMapUri|$RawMapName|$StorageLocation|$PreviewPNGLocation|$Year|$NodeID|$WKT_Map_Extent|$geoserverworkspace|$ZipRawMapUri|$NordOuestBasic2571|$SudOuestBasic2571|$SudEstBasic2571|$NordEstBasic2571|$NordOuestBasic4326|$SudOuestBasic4326|$SudEstBasic4326|$NordEstBasic4326|$NordOuestBasic|$SudOuestBasic|$SudEstBasic|$NordEstBasic|$LastModified_GeoTiff|$MapCentroid|$MapTitleHumanReadable|$LayerBound"
#
#
#
#WKT=$(echo "GEOMETRYCOLLECTION(POLYGON(("$NordOuest3857, $SudOuest3857, $SudEst3857, $NordEst3857, $NordOuest3857"B)))")
#echo "$puple $WKT WKT"
#
#echo "$purple$WKT WKT"
#read
#
#if [[ "$InfoSpecialMap" == "" ]]
#then
#WKT_Map_Extent=$(echo "Polygon (($NordOuest3857, $SudOuest3857, $SudEst3857, $NordEst3857, $NordOuest3857))")
#LayerBound=$(echo $SudOuest3857 $NordEst3857|sed 's/  / /g'|sed 's/ /, /g'|sed 's/, $//g')
#
#
#
#exiftool -r -overwrite_original -keywords= -m -keywords="$Lastrender|$OriginalPost1980Name|$Seine|$OldNum|$Ouest $Nord|$Ouest $Sud|$Est $Sud|$Est $Nord|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$WKT|$RawMapUri|$RawMapName|$StorageLocation|$PreviewPNGLocation|$Year|$NodeID|$WKT_Map_Extent|$geoserverworkspace|$ZipRawMapUri|$NordOuestBasic2571|$SudOuestBasic2571|$SudEstBasic2571|$NordEstBasic2571|$NordOuestBasic4326|$SudOuestBasic4326|$SudEstBasic4326|$NordEstBasic4326|$NordOuestBasic|$SudOuestBasic|$SudEstBasic|$NordEstBasic|$LastModified_GeoTiff|$MapCentroid|$MapTitleHumanReadable|$LayerBound"  -artist="sous-paris.com" -Software="Kta2geo 1.3" ../_Output_3857/"$Lastrender"
#echo "$Lastrender|$OriginalPost1980Name|$Seine|$OldNum|$Ouest $Nord|$Ouest $Sud|$Est $Sud|$Est $Nord|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$WKT|$RawMapUri|$RawMapName|$StorageLocation|$PreviewPNGLocation|$Year|$NodeID|$WKT_Map_Extent|$geoserverworkspace|$ZipRawMapUri|$NordOuestBasic2571|$SudOuestBasic2571|$SudEstBasic2571|$NordEstBasic2571|$NordOuestBasic4326|$SudOuestBasic4326|$SudEstBasic4326|$NordEstBasic4326|$NordOuestBasic|$SudOuestBasic|$SudEstBasic|$NordEstBasic|$LastModified_GeoTiff|$MapCentroid|$MapTitleHumanReadable|$LayerBound"  > tmp/csv_tmp
#else
#echo "$yellow I'm .. SPECIAL !"
#WKT_Map_Extent=$(awk -F'|' -v 'NameOf_LastProcessed'='$NameOf_LastProcessed' "/$NameOf_LastProcessed/"  tmp/List_Special_Planches.csv |awk -F'|' '{print $16}')
#
#
#
#
#
#
#
#echo $purple $BasicWKT
#
#
#
#
#
#
#
#
#
#exiftool -r -overwrite_original -keywords= -m -keywords="$Lastrender|$OriginalPost1980Name|$Seine|$OldNum|$InfoSpecialMap|$BasicWKT|$RawMapUri|$RawMapName|$StorageLocation|$PreviewPNGLocation|$Year|$NodeID|$WKT_Map_Extent|$geoserverworkspace|$ZipRawMapUri|$NordOuestBasic2571|$SudOuestBasic2571|$SudEstBasic2571|$NordEstBasic2571|$NordOuestBasic4326|$SudOuestBasic4326|$SudEstBasic4326|$NordEstBasic4326|$NordOuestBasic|$SudOuestBasic|$SudEstBasic|$NordEstBasic|$LastModified_GeoTiff|$MapCentroid|$MapTitleHumanReadable|$LayerBound" -artist="sous-paris.com" -Software="Kta2geo 1.1" ../_Output_3857/"$Lastrender"
#echo "$Lastrender|$OriginalPost1980Name|$Seine|$OldNum|$InfoSpecialMap|$BasicWKT|$RawMapUri|$RawMapName|$StorageLocation|$PreviewPNGLocation|$Year|$NodeID|$WKT_Map_Extent|$geoserverworkspace|$ZipRawMapUri|$NordOuestBasic2571|$SudOuestBasic2571|$SudEstBasic2571|$NordEstBasic2571|$NordOuestBasic4326|$SudOuestBasic4326|$SudEstBasic4326|$NordEstBasic4326|$NordOuestBasic|$SudOuestBasic|$SudEstBasic|$NordEstBasic|$LastModified_GeoTiff|$MapCentroid|$MapTitleHumanReadable|$LayerBound" > tmp/csv_tmp
#fi
#
#
#CSV_INFO=$(cat tmp/csv_tmp)
#
#gdal_translate -co "TFW=YES" ../_Output_3857/"$Lastrender" temp.tif
#LastrenderNoExt=$(echo "$Lastrender"| sed 's/\.tif//g')
#convert -quiet temp.tif "$LastrenderNoExt".jpg
#convert -quiet ../_Output_3857/"$Lastrender"[1]  -define png:swap-bytes -resize x200 ../_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png
#
#exiftool -all= -m -Keywords="$CSV_INFO" -Software="Kta2geo 1.1" -artist="sous-paris.com" ../_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png
#python finder_colors.py blue ../_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png
#if [ -f ../_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png_original ]
#then
#rm ../_Output_PNG_Preview/"$NameNoExt"_"$geoserverworkspace"_"$Year".png_original
#fi
#exiftool -m -keywords="$CSV_INFO" -artist="sous-paris.com" -Software="Kta2geo 1.1" "$LastrenderNoExt".jpg
#
#mv temp.tfw "$LastrenderNoExt".wld
##proj
#echo 'PROJCS["WGS_1984_Web_Mercator_Auxiliary_Sphere",GEOGCS["GCS_WGS_1984",DATUM["D_WGS_1984",SPHEROID["WGS_1984",6378137.0,298.257223563]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Mercator_Auxiliary_Sphere"],PARAMETER["False_Easting",0.0],PARAMETER["False_Northing",0.0],PARAMETER["Central_Meridian",0.0],PARAMETER["Standard_Parallel_1",0.0],PARAMETER["Auxiliary_Sphere_Type",0.0],UNIT["Meter",1.0]]' > "$LastrenderNoExt".prj
#
#echo ""$FileName" - "$geoserverworkspace" - Size: "$filesizePX"- Res : "$ResolutionX_rounded" pixels/pouce - "$filesizeMO" - GeoTiff" >> tmp/GeoTiffList
#
#echo ""$FileName" - "$geoserverworkspace" - Size: "$filesizePX"- Res : "$ResolutionX_rounded"  pixels/pouce - Mètre - EPSG:3857 .wld + .prj" > "$LastrenderNoExt"_info.txt
#zip "$LastrenderNoExt".zip "$LastrenderNoExt".jpg "$LastrenderNoExt".wld "$LastrenderNoExt".prj "$LastrenderNoExt"_info.txt
#if [ -f ../_Output_wld_zip/"$LastrenderNoExt".zip ]
#then
#mv ../_Output_wld_zip/"$LastrenderNoExt".zip ../_TRASH_TEMP/"$FileDate"_"$LastrenderNoExt".zip
#fi
#mv "$LastrenderNoExt".zip ../_Output_wld_zip/
#python finder_colors.py blue ../_Output_wld_zip/"$LastrenderNoExt".zip
#rm "$LastrenderNoExt".jpg "$LastrenderNoExt".wld "$LastrenderNoExt".prj "$LastrenderNoExt"_info.txt
#if [ -f "$LastrenderNoExt".jpg_original ]
#then
#rm "$LastrenderNoExt".jpg_original
#fi
#
## Generating CSV Computed_Maps.csv
#if [ -f tmp/computed_MapsTMP.csv ]
#then
#rm tmp/computed_MapsTMP.csv
#fi
#
#for ListGeoreferenced in ../_Output_3857/*.tif
#do
#exiftool "$ListGeoreferenced" | awk '/Keywords                        :/'| awk -F': ' '{print $2}' >> tmp/computed_MapsTMP.csv
#
#
#done
#echo "${white}---> Control bash export${orange}"
#echo LayerBound=\"$LayerBound\" >> tmp/tmp_bash




echo "${bg_white}${black}---> Goodbye from SubRoutine_forNode.sh${reset}"
