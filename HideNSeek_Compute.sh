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

echo "${white} ---> Fitering maps thas have the same extent"

if [ -f tmp/HnS/RAW_OUTPUT ]
then
rm tmp/HnS/RAW_OUTPUT
fi

mkdir -p tmp/HnS

cat /Users/zeus/cdm/js/openlayers/HidendSeek.js |tr -d '\n'| awk -F "jQuery" '{print $2}'|awk -F"\/\/ BEGIN ALL LAYERS" '{print $2}'|awk -F'\/\/ END ALL LAYERS' '{print $1}'|awk NF > tmp/HnS/HidenseekList

cat tmp/HnS/HidenseekList|tr -d '\n' |sed 's/\/\//\
\/\//g'|awk -F'\t' '{print $1}' |awk NF > tmp/HnS/LayerFamily

IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing
for LayerFamilyline in $(cat tmp/HnS/LayerFamily)
do
#BEGINLayer=$(echo "$LayerFamilyline" | awk -F' BEGIN  ' '{print $1}' |sed 's~// ~~g')


if [ -f tmp/HnS/hidewetmp ]
then
rm tmp/HnS/hidewetmp
fi

LayerFamilyList=$(echo "$LayerFamilyline" | sed 's/var /\
var /g')
echo "$LayerFamilyList" |awk NF > tmp/HnS/LayerFamilyList
IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing
for layer in $(cat tmp/HnS/LayerFamilyList)
do
#cat tmp/BEGIN

#echo "$LayerFamilyList${purple}"
echo "$layer" |awk -F'Bounds\\(' '{print $2}'|awk -F'\\)' '{print $1}' |awk NF>> tmp/HnS/LayersBounds.tmp

#echo "$layer" |awk -F'Bounds\\(' '{print $2}'|awk -F'\\)' '{print $1}' |tr -d ' ' >> tmp/HnS/LayersBounds.tmp

echo "$layer"|awk NF |awk -F'var ' '{print "var "$2}' |awk NF>> tmp/HnS/ALL_mixedLayers
BBBOX=$(echo "$layer"|awk NF |awk -F'var ' '{print "var "$2}')
echo $green"$BBBOX"
done

#read -p 'wait'



if [[ "$LayerFamilyline" == *" BEGIN "* ]]
then
BEGINLayer=$(echo $LayerFamilyline|tr -d '\n' |sed 's/\/\//\
\/\//g'|awk -F'\t' '{print $1}')
echo "$BEGINLayer" #> tmp/HnS/BEGIN
echo "$BEGINLayer" > tmp/HnS/BEGIN

BEGINLayer=$(cat tmp/HnS/BEGIN)
echo $red BEGINLayer  $BEGINLayer
echo $red ################################
else
echo $green ################################
BEGINLayer=$(cat tmp/HnS/BEGIN)
fi
#read -p 'wait'


BEGINLayer=$(cat tmp/HnS/BEGIN)
echo "$orange$BEGINLayer" #>> tmp/HnS/ALL_mixedLayers

echo "ALLAH OUAKBAR" >> tmp/HnS/ALL_mixedLayers
#echo "$green End
done

cat tmp/HnS/ALL_mixedLayers |awk '!/\/\//' > tmp/HnS/ALL_mixedLayers.txt
cat ../HideNSeek.js |awk '!/\/\//' >> tmp/HnS/ALL_mixedLayers.txt
cat tmp/HnS/ALL_mixedLayers.txt |awk '!seen[$0]++' |sed 's/'\)'        if/'\)'\;        if/g'>> tmp/HnS/ALL_mixedLayers.txtA
mv tmp/HnS/ALL_mixedLayers.txtA tmp/HnS/ALL_mixedLayers.txt


cat tmp/HnS/LayersBounds.tmp|awk '!seen[$0]++'|awk NF > tmp/HnS/LayersBounds.txt

#tmp/HnS/ALL_mixedLayers.txt
rm tmp/HnS/LayersBounds.tmp
#read -p "wait here"
rm tmp/HnS/ALL_mixedLayers

IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing
for BoundingBoxLines in $(cat tmp/HnS/LayersBounds.txt)
do
echo $white $BoundingBoxLines$purple
cat tmp/HnS/ALL_mixedLayers.txt |awk "/$BoundingBoxLines/"|sed 's/#/\
#/g' |awk '/#/'|awk '/.show()/'|awk -F"'" '{print $1}' > tmp/HnS/IDStoHide
cat tmp/HnS/IDStoHide |awk '!seen[$0]++' > tmp/HnS/IDStoHideB
mv tmp/HnS/IDStoHideB tmp/HnS/IDStoHide
cat tmp/HnS/ALL_mixedLayers.txt |awk "/$BoundingBoxLines/" |awk -F"\{" '{print $1}' > tmp/HnS/StringBegin

if [ -f tmp/HnS/showetmp ]
then
rm tmp/HnS/showetmp
fi

if [ -f tmp/HnS/hidewetmp ]
then
rm tmp/HnS/hidewetmp
fi

echo "$purple tmp/HnS/IDStoHide"
cat tmp/HnS/IDStoHide
for hideme in $(cat tmp/HnS/IDStoHide)
do

Show=$(printf "\$('"$hideme"').show();")
Hide=$(printf "\$('"$hideme"').hide();")
printf "$Show" >> tmp/HnS/showetmp
printf "$Hide" >> tmp/HnS/hidewetmp

done
StringBegin=$(cat tmp/HnS/StringBegin |awk 'NR==1')
Mystatic_var=$(echo " } else { ")
hideinIDvariable=$(cat tmp/HnS/hidewetmp)
showinIDvariable=$(cat tmp/HnS/showetmp)



printf "$StringBegin { $showinIDvariable $Mystatic_var $hideinIDvariable}" |awk NF >> tmp/HnS/RAW_OUTPUT
#cat tmp/HnS/hidewetmp |tr '\n' '@' >

#cat tmp/HnS/hidewetmp
#cat tmp/HnS/showetmp|tr -d '\n'
#cat tmp/HnS/hidewetmp|tr -d '\n'
#> tmp/HnS/
#awk -v 'basicname'="$BoundingBoxLines" "/$BoundingBoxLines/" tmp/HnS/ALL_mixedLayers.txt
#echo "$BoundingBoxLines" |sed 's///g'
#awk -v 'basicname'="$BoundingBoxLines" "/$BoundingBoxLines/" tmp/HnS/ALL_mixedLayers.txt #| awk -F'|' '{print $26}'|  awk -F '/' '{print $NF}'
echo "$white cat"
done
FileDate=$(echo $(date +%Y_%m_%d_%Hh%Mm%Ss) | tr "/" "_")

if [ -f ../HideNSeek.js ]
then
mv ../HideNSeek.js ../_TRASH_TEMP/"$FileDateEND"_HideNSeek.js
fi
cat tmp/HnS/RAW_OUTPUT |sed 's/        / /g'|awk '!seen[$0]++'> ../HideNSeek.js

#read -p "wait"

#mkdir -p tmp/csv_from_geotif ../_Output_wld_zip ../_Output_PNG_Preview ../_Output_Tagged_Geotif_3857 ../_Output_CSVs ../_NoGeoInfo ../_Source_GEOTIFF tmp/NewLayers/ ../_TRASH_TEMP/ ../_TOO_BIG_DONSIZED ../_Large_Images_2_rsync/ ../_Done_No_GeoRef_Normal_TIFF
#
#
#echo "${white} ---> Asking the workspace name in GeoServer."
#read -p "${white} --->  What is the name of the workspace in geoserver e.g ${orange}ED_Verniquet                               :" WorkspaceName
#TheWorkspaceClassJsCss=$(echo "$WorkspaceName"|awk '{print tolower}')
#echo "${white} ---> \TheWorkspaceClassJsCss                                                                                     :$TheWorkspaceClassJsCss"
#
#
#
#echo "${white} ---> Checking if using the right path for ${orange}$WorkspaceName."
#if [ -f tmp/StoragePath ]
#then
#StoragePath=$(cat tmp/StoragePath)
#read -p "${white} ---> The current Storage Location is${orange}             : $StoragePath (y/n) ?          :" RESP
#if [ "$RESP" = "y" ]; then
#echo "${white}  ---> Using default Storage Location${orange}                : $StoragePath ${reset}"
#else
#echo "${white}---> The source files path must be as followed
#eg. /my_folder/3857 /my_folder/pngpreview"
#read -p "${white}What is the Storage Location of the maps eg. /my_folder/
#Do not forget the tailing / ${green} : " StoragePath
#echo "$StoragePath" > tmp/StoragePath
#fi
#else
#read -p "${orange}What is the Storage Location of the maps eg. /my_folder/
#Do not forget the tailing / ${green} :  " StoragePath
#echo "$StoragePath" > tmp/StoragePath
#fi
#StoragePath=$(cat tmp/StoragePath)
#echo "${white} ---> the storage path is ${orange}$StoragePath."
#
#
#read -p "${white} ---> Drop you GeoTiff files in the Folder : ${orange}../_Source_GEOTIFF${green} " whatever
#find ../_Source_GEOTIFF/ -name "*.tif" -o -name "*.geotiff"| sed 's/\/\//\//g' > tmp/csv_from_geotif/listtmp.txt
#if [ -f tmp/_IMPORT_OTHER_MAPStmp ]
#then
#rm tmp/_IMPORT_OTHER_MAPStmp
#fi
#if [ -f tmp/OutputTemp ]
#then
#rm tmp/OutputTemp
#fi
#
#if [ -f tmp/NewLayers/TheCureentNodeBody.csv ]
#then
#rm tmp/NewLayers/TheCureentNodeBody.csv
#fi
#
#echo "// $WorkspaceName BEGIN" > tmp/HideNSeektmp
#if [ -f tmp/OtherLayersTMP ]
#then
#rm tmp/OtherLayersTMP
#fi
#
#
#IFS=$'\n'       # Processing full line (ignoring spaces)
#set -f          # disable globbing
#
#for imagegeotif in $(cat tmp/csv_from_geotif/listtmp.txt)
#do
##
##
#echo "${white} ---> Dealing with imagegeotif                             ${orange}:$imagegeotif"
#SingleName=$(echo $imagegeotif|sed 's/\.\.\///g'|tr ' ' '_'| sed 's/_Source_GEOTIFF\///g')
#SingleNameNoExt=$(echo $imagegeotif|sed 's/\.\.\///g'|tr ' ' '_' |awk -F'.' '{print $1}'| sed 's/_Source_GEOTIFF\///g')
#echo "${green} ---> Getting file info with gdalinfo :                    ${orange}: tmp/csv_from_geotif/"$SingleName".txt"
#gdalinfo "$imagegeotif" > tmp/csv_from_geotif/"$SingleName".txt
#
#InfoText=$(echo "$imagegeotif"|sed 's/.geotiff/.txt/g'|sed 's/.tif/.txt/g')
#echo "${white} ---> \$InfoText                                            ${orange}: $InfoText"
#size=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Size is / {print $0}'| sed 's/Size is //g' | tr -d ' ')
#echo "${white} ---> \$size                                                ${orange}: $size"
#
#Xsize=$(echo "$size"| awk -F',' '{print $1}')
#Ysize=$(echo "$size"| awk -F',' '{print $2}')
#echo "${white} ---> Image size is                                         ${white}: \$Xsize ${orange}$Xsize ${white}\$Ysize ${orange}$Ysize"
#
#UL=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Upper Left/'| awk -F'(' '{print $2}'| awk -F')' '{print $1}' | sed 's/ //g'|tr ',' ' ')
#LL=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Lower Left/'| awk -F'(' '{print $2}'| awk -F')' '{print $1}' | sed 's/ //g'|tr ',' ' ')
#LR=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Lower Right/'| awk -F'(' '{print $2}'| awk -F')' '{print $1}' | sed 's/ //g'|tr ',' ' ')
#UR=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Upper Right/'| awk -F'(' '{print $2}'| awk -F')' '{print $1}' | sed 's/ //g'|tr ',' ' ')
#Center=$(cat tmp/csv_from_geotif/"$SingleName".txt |awk '/Center/' | awk -F'(' '{print $2}'| awk -F')' '{print $1}' | sed 's/ //g'|tr ',' ' ')
#echo "${white} ---> EPSG:3857=\$UL${orange} $UL ${white}- \$LL${orange} $LL ${white}- \$UL${orange} $LR ${white}- \$UR${orange} $UR ${white}- \$UL${orange} $UL"
#
#echo "${red} ---> CENTER= \$Center                                      ${orange}: $Center ${white}"
#
#
#Projection=$(cat tmp/csv_from_geotif/"$SingleName".txt| tr -d '\n'| awk -F'PROJCRS' '{print "PROJCR"$2}'| awk -F']]],' '{print $1"\]\]\]"}')
#echo "${white} ---> \$Projection                                          ${orange}: $Projection"
#Other_layer_GUID=$( echo "$SingleNameNoExt"|awk '{print "otherLayer_"tolower}')
#echo "${white} ---> \$Other_layer_GUID                                    ${orange}: $Other_layer_GUID"
#
#if [ -f "$InfoText" ]
#then
#echo "${white} ---> Info text $InfoText ${green}found !"
#Base_text=$(cat "$InfoText" | awk 'NR == 2')
#NomHuman=$(echo "$Base_text" |awk -F'|' '{print $1}'| tr '/' '•')
#NomMachine=$(echo "$Base_text" |awk -F'|' '{print $2}')
#LienSouces=$(echo "$Base_text" |awk -F'|' '{print $3}')
#Commentaire=$(echo "$Base_text" |awk -F'|' '{print $4}')
#author=$(echo "$Base_text" |awk -F'|' '{print $5}')
#TheYear=$(echo "$Base_text" |awk -F'|' '{print $6}')
#TitreHTML=$(echo "$Base_text" |awk -F'|' '{print $7}')
#else
#read -p "NomHuman : ?" NomHuman
#read -p "NomMachine : ?" NomMachine
#read -p "LienSouces : ?" LienSouces
#read -p "Commentaire : ?" Commentaire
#read -p "author : ?" author
#read -p "TheYear : ?" TheYear
#read -p "TitreHTML : ?" TitreHTML
#fi
#
#LayerNameComplete=$(echo "$NomHuman" - $TheYear $Xsize x $Ysize - $author)
#
#
#DoubleQuote=$(echo \")
#QUOTE="'"
#
#png_final_location=$(echo /private_file/Raw_Other_Maps/png/"$SingleNameNoExt".png)
#PrivatePath=$(echo /private_file/Raw_Other_Maps/Geotiffs/"$SingleName")
#
#HttpDownloadTiff=$(echo /system/files/Raw_Other_Maps/Geotiffs/"$SingleName")
#HttpDownloadWLD=$(echo /system/files/Raw_Other_Maps/zips/"$SingleNameNoExt".zip)
#HttpPng=$(echo /system/files/Raw_Other_Maps/png/"$SingleNameNoExt".png)
#echo "/system/files/Raw_Other_Maps/png/"$SingleNameNoExt".png"
#TheZipNameShort=$(echo "$NomHuman .zip .wld .prj - $TheYear")
#
#TheEmprise="$WKT_Emprise"
#TheAddLayerMachineName=$(echo add_planche"$NomMachine")
#TheLayerMachineName_rm=$(echo planche"$NomMachine"_rm)
##
#echo "${orange}#######                      ${white}Variables                             ${orange}#######${white}"
#echo "${white} ---> \$LayerNameComplete                                   ${orange}: $LayerNameComplete"
#echo "${white} ---> \$Base_text                                           ${orange}: $Base_text"
#echo "${white} ---> \$NomHuman                                            ${orange}: $NomHuman"
#echo "${white} ---> \$NomMachine                                          ${orange}: $NomMachine"
#echo "${white} ---> \$author                                              ${orange}: $author"
#echo "${white} ---> \$TheYear                                             ${orange}: $TheYear"
#echo "${white} ---> \$LienSouces                                          ${orange}: $LienSouces"
#echo "${white} ---> \$TitreHTML                                           ${orange}: $TitreHTML"
#echo "${white} ---> \$SingleNameNoExt                                     ${orange}: $SingleNameNoExt"
#echo "${white} ---> \$SingleName                                          ${orange}: $SingleName"
#
#echo "${white} ---> \$Commentaire                                                  #
#${lightblue}: $Commentaire"
#
#echo "${orange}#######                      ${red}Action                             ${orange}#######${white}"
#
#
#
#
#
#
#if [ "$Projection" == "PROJCR]]]" ]
#then
#echo "${red}---> there is no geo information"
#else
#echo "${white} ---> Doing PNGs poxis ${orange}                  "$SingleNameNoExt".png"
#if [ -f ../_Output_PNG_Preview/"$SingleNameNoExt".png ]
#then
#mv ../_Output_PNG_Preview/"$SingleNameNoExt".png  ../_TRASH_TEMP/"$FileDate"_"$SingleNameNoExt".png
#fi
#
#if [ -f ../_Output_Tagged_Geotif_3857/"$SingleName" ]
#then
#mv ../_Output_Tagged_Geotif_3857/"$SingleName" ../_TRASH_TEMP/"$FileDate"_"$SingleName"
#fi
#
#cp "$imagegeotif" ../_Output_Tagged_Geotif_3857/"$SingleName"
#
#
#
#
#
#poidsbeforgdalaaddo=$(ls -lah ../_Output_Tagged_Geotif_3857/"$SingleName"  |awk '{print $5}')
#echo "${white} ---> \$poidsbeforgdalaaddo                                  ${orange}: $poidsbeforgdalaaddo"
#
#gdaladdo -r average ../_Output_Tagged_Geotif_3857/"$SingleName"  2 4 8 16
#poids=$(ls -lah ../_Output_Tagged_Geotif_3857/"$SingleName"  |awk '{print $5}')
#echo "${white} ---> \$poids           after gdaladdo                       ${orange}: $poidsbeforgdalaaddo"
#
#LastLetterPoids=$(echo $poids | tail -c 2)
#TiffRenderHeight=$(echo "$Xsize"/10|bc -l)
#TiffRenderwidth=$(echo "$Ysize"/10|bc -l)
#echo "$white DEBUG $red 4$white"
#if [ "$LastLetterPoids" = "G" ]
#then
#
#mkdir -p ../_Large_Images_2_rsync/"$WorkspaceName"/"$SingleNameNoExt"/ ../_TOO_BIG_DONSIZED
#gdalwarp -overwrite -of GTiff -co COMPRESS=LZW -ts $TiffRenderHeight $TiffRenderwidth -r cubic "$imagegeotif" ../_TOO_BIG_DONSIZED/"$SingleNameNoExt".tif
#convert ../_TOO_BIG_DONSIZED/"$SingleNameNoExt".tif[0] -resize x300 ../_Output_PNG_Preview/"$SingleNameNoExt".png
#cp ../_Output_Tagged_Geotif_3857/"$SingleName" ../_Large_Images_2_rsync/"$WorkspaceName"/"$SingleNameNoExt"/"$SingleName"
#echo "${white}---> This file is bigger than ${red}One Gigabytes${white}"
#else
#echo "${white}---> This file does not exceed ${green}1000 Megabytes${white}"
#convert "$imagegeotif"[0] -resize x300 ../_Output_PNG_Preview/"$SingleNameNoExt".png
#
#fi
#
#WKT_Emprise=$(echo "GEOMETRYCOLLECTION(POLYGON("$UL", "$LL", "$LR", "$UR", "$UL"))")
#echo "${white} ---> \$WKT_Emprise                                          ${orange}: $WKT_Emprise"
#fi
#echo "#                  #####    Variables     #####                  #"
#RawMapUri=$(echo "$StoragePath"_Output_Tagged_Geotif_3857/"$SingleName")
#PreviewPNGLocation=$(echo "$StoragePath"_Output_PNG_Preview/"$SingleNameNoExt".png)
#ZipWLDLocation=$(echo "$StoragePath"_Output_wld_zip/"$SingleNameNoExt".zip)
#echo "${white} ---> \$RawMapUri                                            ${orange}: $RawMapUri"
#echo "${white} ---> \$PreviewPNGLocation                                   ${orange}: $PreviewPNGLocation"
#echo "${white} ---> \$ZipWLDLocation                                       ${orange}: $ZipWLDLocation"
#LayerBound=$(echo "$LL $UR"|sed 's/ /, /g')
#echo "${white} ---> \$LayerBound                                           ${orange}: $LayerBound"
#echo "var "$NomMachine"_boundary = new OpenLayers.Bounds($LayerBound)
#    if (mapbounds.intersectsBounds("$NomMachine"_boundary)) { \$('#plan_planche"$NomMachine"').show(); \$('#add_planche"$NomMachine"').show(); } else { \$('#add_planche"$NomMachine"').hide(); \$('#plan_planche"$NomMachine"').hide(); } " >> tmp/HideNSeektmp
## export bash variables
#echo "SingleName=\"$SingleName\"" > tmp/tmp_bash
#echo "SingleName=\"$SingleName\"" > tmp/tmp_bash
#echo "GEOMETRYCOLLECTION=\"$WKT_Emprise\"" >> tmp/tmp_bash
#echo "SingleNameNoExt=\"$SingleNameNoExt\"" >> tmp/tmp_bash
#echo "imagegeotif=\"$imagegeotif\"" >> tmp/tmp_bash
#echo "WorkspaceName=\"$WorkspaceName\"" >> tmp/tmp_bash
#echo 'FileDate=$(echo $(date +%Y_%m_%d_%Hh%Mm%Ss) | tr "/" "_")' >> tmp/tmp_bash
#echo "TheYear=\"$TheYear\"" >> tmp/tmp_bash
#echo 'Lastrender=$(ls -t ../_Output_Tagged_Geotif_3857/ | head -n1)' >> tmp/tmp_bash
#echo "Ysize=\"$Ysize\"" >> tmp/tmp_bash
#echo "Xsize=\"$Xsize\"" >> tmp/tmp_bash
#echo "NomHuman=\"$NomHuman\"" >> tmp/tmp_bash
##png_final_location=$(echo "/system/files/styles/x70/private/MyMap/55677_test3000_preview.png "
##echo "NomHuman=\"$NomHuman\"" >> tmp/tmp_bash
#
#
#./MakeWldPrjWld.sh
#
#
##25-50_ScanHD_1985
#source tmp/tmp_bash
#LayerAttributName=$(echo $SingleName|awk -F'.' '{print $1}')
#
#targetid=$(echo planche"$NomMachine" )
#idsource=$(echo add_planche"$NomMachine" )
#LayerNamepopover=$(echo "$NomHuman $TheYear $author")
#LayerNametooltipzip=$(echo "$NomHuman $TheYear <br> $Xsize x $Ysize <br> $author <br><b> .zip .wld .prj  $poidszip")
#echo "<div class="$QUOTE"btn-group $TheWorkspaceClassJsCss btn-group-xs"$QUOTE" year="$QUOTE"$TheYear"$QUOTE">
#<div class="$QUOTE"btn btn-dark btn-xs geometry layer-selected"$QUOTE" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"WKT EPSG:3857"$QUOTE" data-placement="$QUOTE"left"$QUOTE" data-content="$QUOTE"$TheEmprise"$QUOTE"><div class="$QUOTE"position"$QUOTE">$TheEmprise</div>Emprise</div>
#
#
#<div class="$QUOTE"btn btn-dark btn-xs showlayer"$QUOTE" data-img="$QUOTE"$HttpPng"$QUOTE" data-original-title="$QUOTE""$LayerNamepopover""$QUOTE" data-toggle="$QUOTE"popover"$QUOTE" layer="$QUOTE"$TheAddLayerMachineName"$QUOTE" addlayertolist="$QUOTE"$PrivatePath"$QUOTE">Voir</div>
#<div class="$QUOTE"btn btn-dark btn-xs hidelayer"$QUOTE" layer="$QUOTE"$TheLayerMachineName_rm"$QUOTE" removelayerfromlist="$DoubleQuote"$PrivatePath"$DoubleQuote">Cacher</div>
#<a class="$QUOTE"btn btn-dark btn-xs download-tif"$QUOTE" href="$QUOTE"$HttpDownloadTiff"$QUOTE" data-toggle="$QUOTE"tooltip"$QUOTE" data-original-title="$QUOTE"$LayerNametooltiptiff"$QUOTE">$NomHuman<span class="$QUOTE"glyphicon glyphicon-download-alt"$QUOTE"></span></a>
#<a class="$QUOTE"btn btn-dark btn-xs download-zip"$QUOTE" href="$QUOTE"$HttpDownloadWLD"$QUOTE" data-toggle="$QUOTE"tooltip"$QUOTE" data-original-title="$QUOTE"$LayerNametooltipzip"$QUOTE">$TheZipNameShort<span class="$QUOTE"glyphicon glyphicon-download-alt"$QUOTE"></span></a>" > tmp/NewLayers/TheCureentNodeBodyTMP.csv
#
#FileDate=$(echo $(date +%Y_%m_%d_%Hh%Mm%Ss) | tr "/" "_")
#echo "$white DEBUG $green 3$white $FileDate FileDate"
#LayerAttributName=$(echo $SingleName|awk -F'.' '{print $1}')
#
#exiftool -r -overwrite_original -keywords= -m -keywords="$SingleName|$NomHuman|$png_final_location|$TheBody|$NomMachine|$LienSouces||$author|$TitreHTML|$LayerAttributName|$targetid|$idsource|$TheWorkspaceClassJsCss|||$GEOMETRYCOLLECTION|$WKT_3857|$RawMapUri|RawMapName|$PrivatePath|$PreviewPNGLocation|$TheYear|$Other_layer_GUID|WKT_Map_Extent|$WorkspaceName|$ZipWLDLocation||SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable" -artist="sous-paris.com" -Software="Kta2geo 1.1" ../_Output_Tagged_Geotif_3857/"$SingleNameNoExt".tif
#echo "SingleName|NomHuman|png_final_location|TheBody|NomMachine|LienSouces||author|TitreHTML|LayerAttributName|targetid|idsource|TheWorkspaceClassJsCss|||GEOMETRYCOLLECTION|WKT_3857|RawMapUri|RawMapName|PrivatePath|PreviewPNGLocation|TheYear|Other_layer_GUID|WKT_Map_Extent|WorkspaceName|ZipWLDLocation|LienSouces|SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable
#$SingleName|$NomHuman|$png_final_location|$TheBody|$NomMachine|$LienSouces||$author|$TitreHTML|$LayerAttributName|$targetid|$idsource|$TheWorkspaceClassJsCss|||$GEOMETRYCOLLECTION|$WKT_3857|$RawMapUri|RawMapName|$PrivatePath|$PreviewPNGLocation|$TheYear|$Other_layer_GUID|WKT_Map_Extent|$WorkspaceName|$ZipWLDLocation||SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable" >  ../_Output_Tagged_Geotif_3857/"$SingleNameNoExt".txt
#
#
#echo $purple "$SingleName|$NomHuman|$png_final_location|$TheBody|$NomMachine|$LienSouces||$author|$TitreHTML|$LayerAttributName|$targetid|$idsource|$TheWorkspaceClassJsCss|||$GEOMETRYCOLLECTION|$WKT_3857|$RawMapUri|RawMapName|$PrivatePath|$PreviewPNGLocation|$TheYear|$Other_layer_GUID|WKT_Map_Extent|$WorkspaceName|$ZipWLDLocation||SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable"
#
#echo "$SingleName|$NomHuman|$png_final_location|$TheBody|$NomMachine|$LienSouces||$author|$TitreHTML|$LayerAttributName|$targetid|$idsource|$TheWorkspaceClassJsCss|||$GEOMETRYCOLLECTION|$WKT_3857|$RawMapUri|RawMapName|$PrivatePath|$PreviewPNGLocation|$TheYear|$Other_layer_GUID|WKT_Map_Extent|$WorkspaceName|$ZipWLDLocation||SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable" >> tmp/OutputTemp
#done
#
#echo "SingleName|NomHuman|png_final_location|TheBody|NomMachine|LienSouces||author|TitreHTML|LayerAttributName|targetid|idsource|TheWorkspaceClassJsCss|||GEOMETRYCOLLECTION|WKT_3857|RawMapUri|RawMapName|PrivatePath|PreviewPNGLocation|TheYear|Other_layer_GUID|WKT_Map_Extent|WorkspaceName|ZipWLDLocation|LienSouces|SudOuestBasic2571|SudEstBasic2571|NordEstBasic2571|NordOuestBasic4326|SudOuestBasic4326|SudEstBasic4326|NordEstBasic4326|NordOuestBasic|SudOuestBasic|SudEstBasic|NordEstBasic|LastModified_GeoTiff|MapCentroid|MapTitleHumanReadable" > ../_Output_CSVs/_OtherMaps_import.csv
#cat tmp/OutputTemp >> ../_Output_CSVs/_OtherMaps_import.csv
#
#echo "
#});
#});
#// $WorkspaceName END" >> tmp/HideNSeektmp
#
#FileDateEND=$(echo $(date +%Y_%m_%d_%Hh%Mm%Ss) | tr "/" "_")
#
##cat
#
#
#echo "$red DEBUG 99 percent"
#
#
#echo "${white}---> Checking server information"
#
#if [ -f Server_Port.cfg ]
#then
#echo "${green}---> Server.cfg found"
#Port_SCP=$(cat Server_Port.cfg)
#Server_SCP=$(cat Server_SCP.cfg)
#User_scp=$(cat User_SCP.cfg)
#
#else
#read -p "What is the server name .eg : sous-paris.com ? : " Server_SCP
#echo "$Server_SCP" > Server_SCP.cfg
#
#read -p "What is the server port .eg :  1777 ? : " Server_port
#echo "$Server_port" > Server_Port.cfg
#
#read -p "What is the server user .eg :  philibert ? : " Server_User
#echo "$Server_User" > User_SCP.cfg
#fi
#
#echo "${bg_red}${white} ---> Make sure ${orange}"$StoragePath"${white} on the distant server is writable with rsync from this local machine${reset}"
#
#read -p "Hit enter when checked" Checked
#
#echo "${white} ---> Server name is : "${orange}$Server_SCP"${white} - Server port is : "${orange}$Port_SCP"${white} - Server user is : "${orange}$User_scp"${white}"
#
#echo "${white} ---> Syncing the GeoTiff folder               :${orange}_Output_Tagged_Geotif_3857 in "$Server_SCP" path ${white}"$StoragePath""
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_Tagged_Geotif_3857/ "$User_scp"@"$Server_SCP":"$StoragePath"_Output_Tagged_Geotif_3857
#
#echo ":${orange}_Output_Tagged_CSV in "$Server_SCP" path ${white}"$StoragePath""
#
#
#echo "${white} ---> Syncing the CSV folder               :${orange}_Output_CSVs in "$Server_SCP" path ${white}"$StoragePath""
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_CSVs/ "$User_scp"@"$Server_SCP":"$StoragePath"_Output_CSVs
#
#echo "${white} ---> Syncing the Zips folder                  :${orange}_Output_wld_zip in "$Server_SCP" path ${white}"$StoragePath""
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_wld_zip/ "$User_scp"@"$Server_SCP":"$StoragePath"_Output_wld_zip
#echo "${white} ---> Syncing the PNG preview folder           :${orange}_Output_PNG_Preview in "$Server_SCP" path ${white}"$StoragePath""
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Output_PNG_Preview/ "$User_scp"@"$Server_SCP":"$StoragePath"_Output_PNG_Preview
#echo "${white} ---> Syncing the main TIFFs folder            :${orange}_Output_PNG_Preview in "$Server_SCP" path ${white}"$StoragePath""
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Done_No_GeoRef_Normal_TIFF/ "$User_scp"@"$Server_SCP":"$StoragePath"_Done_No_GeoRef_Normal_TIFF/
#
#
#echo "${white} ---> Syncing the files folder           :${orange}_Large_Images_2_rsync in "$Server_SCP" path ${white}"$StoragePath"_Large_Images_2_rsync"
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_Large_Images_2_rsync/ "$User_scp"@"$Server_SCP":"$StoragePath"_Large_Images_2_rsync
#echo "${white} ---> Syncing the files folder           :${orange}_TOO_BIG_DONSIZED in "$Server_SCP" path ${white}"$StoragePath"_TOO_BIG_DONSIZED"
#rsync -vrapth --update --progress -e "ssh -p $Port_SCP" ../_TOO_BIG_DONSIZED/ "$User_scp"@"$Server_SCP":"$StoragePath"_TOO_BIG_DONSIZED
#
#
##echo "nodetitle|NomMachine|GEOMETRYCOLLECTION|LayerAttributName|TheWorkspaceClassJsCss|targetid|idsource|geoserverworkspace|Year|PrivatePath" > ../_Output_CSVs/_OtherMaps_TEXT_import.csv
##
##cat tmp/OutputTemp| awk -F'|' '{print $2, $5, $8, $10, $11, $12, $13, $16, $20, $22, $25}' OFS='|'>>  ../_Output_CSVs/_OtherMaps_TEXT_import.csv
#rm temp.tif
#
#
#
#
##https://sous-paris.com/geoserver/wms?service=wms&version=1.1.1&request=GetCapabilities
