#!/bin/bash
#awk 'FNR==NR{a[$0];next}!($0 in a)' A.txt B.txt | awk '!seen[$0]++'
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

mkdir -p tmp/NewLayers ../_Output_3857 ../_Output_CSVs ../_Output_PNG_Preview ../_Output_wld_zip/ ../_TRASH_TEMP ../_Source_Standard_Croped_TIFF ../_Source_Standard_Croped_TIFF ../_Source_NOT_Croped

if [ -f finder_colors.py ]
then
echo "$white----> finder_colors.py$green Found"
else
wget https://raw.githubusercontent.com/danthedeckie/finder_colors/master/finder_colors.py
chmod +x finder_colors.py
fi
if [ -f setup.py ]
then
echo "$white----> finder_colors setup.py$green Found"
else
wget https://raw.githubusercontent.com/danthedeckie/finder_colors/master/setup.py
chmod +x setup.py
fi

echo "${bg_blue}${white}---> Hello I'm GeoRef_Ony_IDC_600_400.sh${reset}
${white}---> ${orange}1 ${white}Georeference IDC maps and output geotiff in _Output_3857 folder
${white}---> ${orange}2 ${white}Print exif tags of the computed result on the geotiff grouping by layer bound for one node
${white}---> ${orange}3 ${white}Generate ${orange}CSVs for Node ${orange}\"Planche WFS\"${white} with the body and the files
${white}---> ${orange}4 ${white}Generate ${orange}CSVs for Node ${orange}\"Text Layer\"${white} including the right ID and attribut for javascipt and fedds import
${white}---> ${orange}5 ${white}Define ${orange}Layer Bound${white} and generate javascript rules"

if [ -f tmp/NewLayers/TheCureentNodeBody.csv ]
then
rm tmp/NewLayers/TheCureentNodeBody.csv
fi
if [ -f tmp/GeoTiffList ]
then
rm tmp/GeoTiffList
fi

if [ -f tmp/tmp_HideNSeek ]
then
rm tmp/tmp_HideNSeek
fi
if [ -f tmp/Layerstmp ]
then
rm tmp/Layerstmp
fi

read -p "${white}What is the name of the workspace in geoserver ${orange}                      : " geoserverworkspace
read -p "${white}What is the row weight order of the layer, eg. ${green}5${orange}                     : " Row_layer_order

if [ -f tmp/StorageLocation ]
then
StorageLocation=$(cat tmp/StorageLocation)
read -p "${white}---> The Source Original Location is of the file to import in DB     : ${orange}$StorageLocation (y/n) ? :" RESP
if [ "$RESP" = "y" ]; then
echo "${white}---> Using $StorageLocation as default Storage Location"
else
echo "${white}---> The source files path must be as fellow
eg. /my_folder/3857 /my_folder/pngpreview"
read -p "${white}What is the Storage Location of the maps eg. ${orange}/my_folder/${white} Do not forget the tailing / ${green} : " StorageLocation
echo "$StorageLocation" > tmp/StorageLocation
fi
else
read -p "${orange}What is the Storage Location of the maps eg. /my_folder/
Do not forget the tailing / ${green} :  " StorageLocation
echo "$StorageLocation" > tmp/StorageLocation
fi
StorageLocation=$(cat tmp/StorageLocation)

echo geoserverworkspace=\"$geoserverworkspace\" > tmp/variable_invariable
echo StorageLocation=\"$StorageLocation\" >> tmp/variable_invariable
echo dir=\"$dir\" >> tmp/variable_invariable

echo "${white}---> Generating special Maps information"
#./Generate_Special_Planches_CSV.sh
source tmp/variable_invariable

# Zero de l'Observatoire 3857
Observatoire=$(echo "260098.642816645 6247162.50356738")
echo "${white}---> Position Origin (meters) 600000 126224 (Zéro de l'observatoire de Paris)"
ObservatoireLong=600000
ObservatoireLat=126224
# Metres
Hauteur=400
Largeur=600
echo "Hauteur=\"400\"" >> tmp/variable_invariable
echo "Largeur=\"600\"" >> tmp/variable_invariable
echo "dir=\"$dir\"" >> tmp/variable_invariable

echo "Observatoire=\"$Observatoire\"" >> tmp/variable_invariable
echo "ObservatoireLong=\"$ObservatoireLong\"" >> tmp/variable_invariable
echo "ObservatoireLat=\"$ObservatoireLat\"" >> tmp/variable_invariable

python finder_colors.py red ../_Source_Standard_Croped_TIFF 2>&1 &>/dev/null
read -p "Drop your file in  ${orange}_Source_Standard_Croped_TIFF folder ${green}- When ready hit Enter ! " voila

parendir=$(dirname "$dir")


echo "${white}---> Cleanup Finder color tag to unprocessed file \$TiffSource        ${orange}: $TiffSource${white}"

echo "${white}---> Select Map Type                                                 ${orange}: $MapType${white}"


MapType="IDCPARIS"
echo MapType=\"$MapType\" >> tmp/variable_invariable

python finder_colors.py none $AllTifOnOneLine 2>&1 &>/dev/null

find ../_Source_Standard_Croped_TIFF/ -name "*.tif" -o -name "*.geotiff" |sed 's/\/\//\//g' > tmp/FoundFiles
cat tmp/FoundFiles|tr '\n' ' ' > tmp/AllSourcesOneLine
AllTifOnOneLine=$(cat tmp/AllSourcesOneLine)

IFS=$'\n'       # Processing full line (ignoring spaces)
set -f          # disable globbing

for TiffSource in $(cat tmp/FoundFiles)
do
source tmp/variable_invariable
echo "${white}---> Processing \$TiffSource                                          ${orange}: $TiffSource"





echo 'FileDate=$(echo $(date +%Y_%m_%d_%Hh%Mm%Ss) | tr "/" "_")' > tmp/tmp_bash
echo "MapType=\"$MapType\"" >> tmp/tmp_bash
Row_layer_order=$Row_layer_order >> tmp/bash_tmp
source tmp/tmp_bash

Year=$(echo "$TiffSource"| tail -c -9 | awk -F'.tif' '{print $1}')

Filename=$(basename "$TiffSource")
NameNoExt=$(echo "$Filename"|sed 's/.geotiff//g' |sed 's/.tif//g'| rev | cut -c6- | rev)
echo NameNoExt=\"$NameNoExt\" >> tmp/tmp_bash
echo Filename=\"$Filename\" >> tmp/tmp_bash


WorkspaceName="$geoserverworkspace"
echo "WorkspaceName=\"$geoserverworkspace\"" >> tmp/tmp_bash
WorkspaceNameLowCap=$(echo "$geoserverworkspace"|awk '{print tolower}')
echo "WorkspaceNameLowCap=\"$WorkspaceNameLowCap\"" >> tmp/tmp_bash

Etx=$(echo "$Filename"|awk -F'.' '{print "."$2}')
echo Etx=\"$Etx\" >> tmp/tmp_bash
source tmp/tmp_bash tmp/variable_invariable

OutputFilenametmp=$(echo "$NameNoExt$Etx"|awk -F'_' '{print $1}'| rev | cut -c5- | rev)

OutputFilenameSeul=$(echo "$OutputFilenametmp"_"$WorkspaceName"_"$Year"$Etx"")
echo OutputFilenameSeul=\"$OutputFilenameSeul\" >> tmp/tmp_bash
OutputFileNoExt=$(echo $OutputFilenameSeul|sed 's/.geotiff//g' |sed 's/.tif//g')
echo OutputFileNoExt=\"$OutputFileNoExt\" >> tmp/tmp_bash

NomMachine="$OutputFileNoExt"
echo NomMachine=\"$NomMachine\" >> tmp/tmp_bash
NomMachineLowCap=$(echo "$NomMachine"|awk '{print tolower}'|tr '-' '_')
echo NomMachineLowCap=\"$NomMachineLowCap\" >> tmp/tmp_bash

echo "# Layer's Attribut" >> tmp/tmp_bash
layer_attribut="$NomMachine"
echo layer_attribut=\"$NomMachine\" >> tmp/tmp_bash

targetid=$(echo planche_"$NomMachine")
echo targetid=\"$targetid\" >> tmp/tmp_bash
idsource=$(echo add_planche_"$NomMachine")
echo idsource=\"$idsource\" >> tmp/tmp_bash
echo TiffSource=\"$TiffSource\" >> tmp/tmp_bash

# Files Source, Soft and Hard path
echo "### Files" >> tmp/tmp_bash
#Tiff :
#TiffCloudpath
TiffCloudpath=$(echo "$StorageLocation"_Output_3857/"$OutputFilenameSeul")
echo "${white}---> \$TiffCloudpath                                                  ${orange}: $TiffCloudpath"
echo TiffCloudpath=\"$TiffCloudpath\" >> tmp/tmp_bash
#TiffPrivatePath
TiffPrivatePath=$(echo /private_file/Raw_map_EPSG_3857/Geotiff/"$OutputFilenameSeul")
echo "${white}---> \$TiffPrivatePath                                                ${orange}: $TiffPrivatePath"
echo TiffPrivatePath=\"$TiffPrivatePath\" >> tmp/tmp_bash
#TiffHTTP
TiffHTTP=$(echo /system/files/Raw_map_EPSG_3857/Geotiff/"$OutputFilenameSeul")
echo "${white}---> \$TiffHTTP                                                       ${orange}: $TiffHTTP"
echo TiffHTTP=\"$TiffHTTP\" >> tmp/tmp_bash
##
#Zip  :
#ZipCloudpath
ZipCloudpath=$(echo "$StorageLocation"_Output_wld_zip/"$OutputFileNoExt".zip)
echo "${white}---> \$ZipCloudpath                                                   ${orange}: $ZipCloudpath"
echo ZipCloudpath=\"$ZipCloudpath\" >> tmp/tmp_bash

#ZipHTTP
ZipHTTP=$(echo /system/files/Raw_map_EPSG_3857/Zips/"$OutputFileNoExt".zip)
echo "${white}---> \$ZipHTTP                                                        ${orange}: $ZipHTTP"
echo ZipHTTP=\"$ZipHTTP\" >> tmp/tmp_bash

# PNG
#PNGCloudpath
PNGCloudpath=$(echo "$StorageLocation"_Output_PNG_Preview/"$OutputFileNoExt".png)
echo "${white}---> \$PNGCloudpath                                                   ${orange}: $PNGCloudpath"
echo PNGCloudpath=\"$PNGCloudpath\" >> tmp/tmp_bash

#PNGHTTP
PNGHTTP=$(echo /system/files/Raw_map_EPSG_3857/PNG/"$OutputFileNoExt".png)
echo "${white}---> \$PNGHTTP                                                        ${orange}: $PNGHTTP"
echo "${white}###########################################################################################################################################################
---> Processing \$TiffSource                                          ${orange}: $TiffSource
${white}###########################################################################################################################################################"
echo PNGHTTP=\"$PNGHTTP\" >> tmp/tmp_bash
Cleaned_Name=$(echo "$NameNoExt"|sed 's/-Special-union//g' |sed 's/-B-union//g' |sed 's/-union_//g'| sed 's/-union_//g')

echo Cleaned_Name=\"$Cleaned_Name\" >> tmp/tmp_bash
./AbsOrd.sh


source tmp/tmp_bash








#echo Abscissa=\"$Abscissa\" >> tmp/tmp_bash
#echo Ordinate=\"$Ordinate\" >> tmp/tmp_bash

AbscissaMultiple=$(echo "$Abscissa"-50 |bc -l)
OrdinateMultiple=$(echo "$Ordinate"-25 | bc -l)
echo AbscissaMultiple=\"$AbscissaMultiple\" >> tmp/tmp_bash
echo OrdinateMultiple=\"$OrdinateMultiple\" >> tmp/tmp_bash

# Image Info
ExifInfo=$(exiftool $TiffSource)

#echo $SerialPoster
WidthImage=$(echo "$ExifInfo"| awk '/Image Width/'|awk 'NR == 1' |awk -F': ' '{print $2}' | awk '{print $1}')
HeightImage=$(echo "$ExifInfo"| awk '/Image Height/'|awk 'NR == 1' | awk -F': ' '{print $2}' | awk '{print $1}')
echo "${white}---> Processing \$ExifInfo"
# Position Origin (Mètres) 600000 126224 Zéro de l'observatoire de Paris


Nord=$(echo 126224-$Hauteur*$AbscissaMultiple |bc -l)
Sud=$(echo 125824-$Hauteur*$AbscissaMultiple|bc -l )
Est=$(echo 600000+\($OrdinateMultiple*$Largeur\) |bc -l )
Ouest=$(echo 599400+\($OrdinateMultiple*$Largeur\) |bc -l )

# NW
NordOuest4326=$(echo "$Ouest $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
NordOuest3857=$(echo "$Ouest $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
# SW
SudOuest4326=$(echo "$Ouest $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
SudOuest3857=$(echo "$Ouest $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
# NE
NordEst4326=$(echo "$Est $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
NordEst3857=$(echo "$Est $Nord" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')
# SE
SudEst4326=$(echo "$Est $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:4326 | awk '{print $2, $1}')
SudEst3857=$(echo "$Est $Sud" | gdaltransform -s_srs EPSG:27561 -t_srs EPSG:3857 | awk '{print $1, $2}')


XResolution=$(echo "$ExifInfo" |awk '/X Resolution/'|awk -F': ' '{print $2}')
YResolution=$(echo "$ExifInfo" |awk '/Y Resolution/'|awk -F': ' '{print $2}')
DPI=$(echo "$XResolution"x"$YResolution" pixels/pouce)
echo XResolution=\"$XResolution\" >> tmp/tmp_bash
echo YResolution=\"$YResolution\" >> tmp/tmp_bash
echo DPI=\"$DPI\" >> tmp/tmp_bash

#Début
#Cas Particuliers
if [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/3-4-41_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/03-04-41_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 586500 129824 -gcp 0 "$HeightImage" 586500 129424 -gcp "$WidthImage" 0 587100 129824 -gcp "$WidthImage" "$HeightImage" 587100 129424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# 41-54-union_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/41-54-union_"* ]]
then
echo "$purple debug found !"
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 608900 124624 -gcp 0 "$HeightImage" 608900 124224 -gcp "$WidthImage" 0 609300 124624 -gcp "$WidthImage" "$HeightImage" 609300 124224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/8-9-51-52_"* ]]
then
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 589500 125624 -gcp 0 "$HeightImage" 589500 125224 -gcp "$WidthImage" 0 590100 125624 -gcp "$WidthImage" "$HeightImage" 590100 125224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../07-58-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/07-58-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/44S-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 588500 123024 -gcp 0 "$HeightImage" 588500 122524 -gcp "$WidthImage" 0 589200 123024 -gcp "$WidthImage" "$HeightImage" 589200 122524 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-161-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-43-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-161-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604200 129024 -gcp 0 "$HeightImage" 604200 128524 -gcp "$WidthImage" 0 604900 129024 -gcp "$WidthImage" "$HeightImage" 604900 128524 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-106-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-106-107-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 603100 130224 -gcp 0 "$HeightImage" 603100 129824 -gcp "$WidthImage" 0 603800 130224 -gcp "$WidthImage" "$HeightImage" 603800 129824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-106-107_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-106-107_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 603100 130224 -gcp 0 "$HeightImage" 603100 129824 -gcp "$WidthImage" 0 603700 130224 -gcp "$WidthImage" "$HeightImage" 603700 129824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16
# Planche ../08-44-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/08-44-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/44S-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 589200 128624 -gcp 0 "$HeightImage" 589200 128124 -gcp "$WidthImage" 0 589800 128624 -gcp "$WidthImage" "$HeightImage" 589800 128124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../12-30-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/12-30-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 591500 134224 -gcp 0 "$HeightImage" 591500 133824 -gcp "$WidthImage" 0 592200 134224 -gcp "$WidthImage" "$HeightImage" 592200 133824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif -dstalpha "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche 29-37
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/29-37_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-56_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39I_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 601800 131524 -gcp 0 "$HeightImage" 601800 131024 -gcp "$WidthImage" 0 602400 131524 -gcp "$WidthImage" "$HeightImage" 602400 131024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857"  temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche 29-38-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/29-38-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-71-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39N-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601800 131024 -gcp 0 "$HeightImage" 601800 130524 -gcp "$WidthImage" 0 602400 131024 -gcp "$WidthImage" "$HeightImage" 602400 130524 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857"  temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche 28-37_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/28-37_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-55_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39H_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 601200 131424 -gcp 0 "$HeightImage" 601200 130924 -gcp "$WidthImage" 0 601800 131424 -gcp "$WidthImage" "$HeightImage" 601800 130924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857"  temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche 28-56-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/28-56-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/73C-union_"* ]]
then
echo "${orange}---> Cas Particuliers - Transformation fixe $TiffSource ${reset}"
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601100 123824 -gcp 0 "$HeightImage" 601100 123424 -gcp "$WidthImage" 0 601800 123824 -gcp "$WidthImage" "$HeightImage" 601800 123424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857"  temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../71P_* or ../15-16-59_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71P_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/15-16-59_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 593800 122624 -gcp 0 "$HeightImage" 593800 122224 -gcp "$WidthImage" 0 594400 122624 -gcp "$WidthImage" "$HeightImage" 594400 122224 "$TiffSource" temp.tif

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif

fi
gdalwarp -co COMPRESS=NONE -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../17-60-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/71V-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/17-60-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 594600 122324 -gcp 0 "$HeightImage" 594600 121624 -gcp "$WidthImage" 0 595200 122324 -gcp "$WidthImage" "$HeightImage" 595200 121624 "$TiffSource" temp.tif

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../12-54-55_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/12-54-55_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/61Q-V_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 591600 124424 -gcp 0 "$HeightImage" 591600 124024 -gcp "$WidthImage" 0 592200 124424 -gcp "$WidthImage" "$HeightImage" 592200 124024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../07-39-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/07-39-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35Q-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 588600 130724 -gcp 0 "$HeightImage" 588600 130224 -gcp "$WidthImage" 0 589200 130724 -gcp "$WidthImage" "$HeightImage" 589200 130224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

## Planche ../19-43-union_1957_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/19-43-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46N-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-147-148-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 595800 129024 -gcp 0 "$HeightImage" 595800 128624 -gcp "$WidthImage" 0 596500 129024 -gcp "$WidthImage" "$HeightImage" 596500 128624 "$TiffSource" temp.tif

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-93_* 18-40-19
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-93_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/18-40-19_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/37W-X_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 595500 130224 -gcp 0 "$HeightImage" 595500 129824 -gcp "$WidthImage" 0 596100 130224 -gcp "$WidthImage" "$HeightImage" 596100 129824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../10-35-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/10-35-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/26Y-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 590400 132324 -gcp 0 "$HeightImage" 590400 131824 -gcp "$WidthImage" 0 591000 132324 -gcp "$WidthImage" "$HeightImage" 591000 131824 "$TiffSource" temp.tif

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../20-51-union_* Feuille-291-union
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/20-51-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-291-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596400 125824 -gcp 0 "$HeightImage" 596400 125324 -gcp "$WidthImage" 0 597000 125824 -gcp "$WidthImage" "$HeightImage" 597000 125324 "$TiffSource" temp.tif
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-276-277_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-276-277_"* ]]
then
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596800 126224 -gcp 0 "$HeightImage" 596800 125824 -gcp "$WidthImage" 0 597600 126224 -gcp "$WidthImage" "$HeightImage" 597600 125824 "$TiffSource" temp.tif
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../20-71-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/20-71-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/95E-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596400 117924 -gcp 0 "$HeightImage" 596400 117424 -gcp "$WidthImage" 0 597000 117924 -gcp "$WidthImage" "$HeightImage" 597000 117424 "$TiffSource" temp.tif

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../21-41-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/21-41-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-113-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/47A-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 597000 130024 -gcp 0 "$HeightImage" 597000 129424 -gcp "$WidthImage" 0 597600 130024 -gcp "$WidthImage" "$HeightImage" 597600 129424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../22-48-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/22-48-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55L-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-243-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 597600 127124 -gcp 0 "$HeightImage" 597600 126624 -gcp "$WidthImage" 0 598200 127124 -gcp "$WidthImage" "$HeightImage" 598200 126624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../26-46-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/26-46-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-209-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56A-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 127924 -gcp 0 "$HeightImage" 600000 127424 -gcp "$WidthImage" 0 600600 127924 -gcp "$WidthImage" "$HeightImage" 600600 127424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../26-56-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/26-56-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/73A-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 123824 -gcp 0 "$HeightImage" 600000 123424 -gcp "$WidthImage" 0 600700 123824 -gcp "$WidthImage" "$HeightImage" 600700 123424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../26-57-union_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/27-57-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/73G-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600600 123524 -gcp 0 "$HeightImage" 600600 123024 -gcp "$WidthImage" 0 601200 123524 -gcp "$WidthImage" "$HeightImage" 601200 123024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../22-63-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/22-63-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/81L-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 597600 121024 -gcp 0 "$HeightImage" 597600 120624 -gcp "$WidthImage" 0 598400 121024 -gcp "$WidthImage" "$HeightImage" 598400 120624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../25-67-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/25-67-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/89J-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599300 119424 -gcp 0 "$HeightImage" 599300 119024 -gcp "$WidthImage" 0 600000 119424 -gcp "$WidthImage" "$HeightImage" 600000 119024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../28-12-13_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/28-12-13_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/3H-M_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 601200 141224 -gcp 0 "$HeightImage" 601200 140824 -gcp "$WidthImage" 0 601800 141224 -gcp "$WidthImage" "$HeightImage" 601800 140824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../30-55-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/30-55-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 602400 124224 -gcp 0 "$HeightImage" 602400 123824 -gcp "$WidthImage" 0 603100 124224 -gcp "$WidthImage" "$HeightImage" 603100 123824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../32-33-41-union
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32-33-41-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-124-125-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49B-C-union"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 603700 129924 -gcp 0 "$HeightImage" 603700 129424 -gcp "$WidthImage" 0 604400 129924 -gcp "$WidthImage" "$HeightImage" 604400 129424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../32-33-41_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32-33-41_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-124-125_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49B-C_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 603700 129824 -gcp 0 "$HeightImage" 603700 129424 -gcp "$WidthImage" 0 604300 129824 -gcp "$WidthImage" "$HeightImage" 604300 129424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../32-37-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32-37-union"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-59-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40G-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 603600 131424 -gcp 0 "$HeightImage" 603600 130924 -gcp "$WidthImage" 0 604200 131424 -gcp "$WidthImage" "$HeightImage" 604200 130924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33-34-51_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-34-51_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-304_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 604300 125824 -gcp 0 "$HeightImage" 604300 125424 -gcp "$WidthImage" 0 604900 125824 -gcp "$WidthImage" "$HeightImage" 604900 125424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33-37-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-37-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-60-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40H-union_"* ]]
then
gdal_translate  -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 604200 131424 -gcp 0 "$HeightImage" 604200 130924 -gcp "$WidthImage" 0 604800 131424 -gcp "$WidthImage" "$HeightImage" 604800 130924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33_44-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-44-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-179-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49R-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604100 128624 -gcp 0 "$HeightImage" 604100 128224 -gcp "$WidthImage" 0 604900 128624 -gcp "$WidthImage" "$HeightImage" 604900 128224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33-48-49-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-48-49-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-273-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57M-R-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604200 126824 -gcp 0 "$HeightImage" 604200 126224 -gcp "$WidthImage" 0 604800 126824 -gcp "$WidthImage" "$HeightImage" 604800 126224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33-48-49_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-48-49_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-273_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604200 126724 -gcp 0 "$HeightImage" 604200 126324 -gcp "$WidthImage" 0 604800 126724 -gcp "$WidthImage" "$HeightImage" 604800 126324 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../33-48-49_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/33-48-49-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-254-273-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604200 126824 -gcp 0 "$HeightImage" 604200 126224 -gcp "$WidthImage" 0 604800 126824 -gcp "$WidthImage" "$HeightImage" 604800 126224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../36-40-41_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/36-40-41_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/41U-50A_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 606000 130124 -gcp 0 "$HeightImage" 606000 129724 -gcp "$WidthImage" 0 606600 130124 -gcp "$WidthImage" "$HeightImage" 606600 129724 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../36-42-43_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/36-42-43_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/50F-N_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 606000 129324 -gcp 0 "$HeightImage" 606000 128924 -gcp "$WidthImage" 0 606600 129324 -gcp "$WidthImage" "$HeightImage" 606600 128924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../39-43-44_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39-43-44_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/50N-S_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 607800 128824 -gcp 0 "$HeightImage" 607800 128424 -gcp "$WidthImage" 0 608400 128824 -gcp "$WidthImage" "$HeightImage" 608400 128424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../39-44-45_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/39-44-45_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/50S-X_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 607800 128424 -gcp 0 "$HeightImage" 607800 128024 -gcp "$WidthImage" 0 608400 128424 -gcp "$WidthImage" "$HeightImage" 608400 128024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../41-45-42-Encart*
elif [[ "$TiffSource" = "../_Source_Standard_Croped_TIFF/41-45-42-Encart_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 609347 128673 -gcp 0 "$HeightImage" 609347 128570 -gcp "$WidthImage" 0 609500 128673 -gcp "$WidthImage" "$HeightImage" 609500 128570 "$TiffSource" temp.tif
gdalwarp -co COMPRESS=NONE -overwrite -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif
gdaladdo -r average ../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif 2 4 8 16

# Planche ../41-45-42-union_*
# La planche sans l'encart, mais avec l'alpha
elif [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/41-45-42-union_* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/51U-V-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 609300 128224 -gcp 0 "$HeightImage" 609300 127824 -gcp "$WidthImage" 0 609900 128224 -gcp "$WidthImage" "$HeightImage" 609900 127824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../41-45-42_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/41-45-42_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/51U-V_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 609300 128224 -gcp 0 "$HeightImage" 609300 127824 -gcp "$WidthImage" 0 609900 128224 -gcp "$WidthImage" "$HeightImage" 609900 127824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../41-42-46_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/41-42-46_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/59A-B_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 609300 127824 -gcp 0 "$HeightImage" 609300 127424 -gcp "$WidthImage" 0 609900 127824 -gcp "$WidthImage" "$HeightImage" 609900 127424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../42-43-60_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/42-43-60_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/76V-W_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 609900 122224 -gcp 0 "$HeightImage" 609900 121824 -gcp "$WidthImage" 0 610500 122224 -gcp "$WidthImage" "$HeightImage" 610500 121824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../42-67-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/42-67-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/93G-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 609600 119424 -gcp 0 "$HeightImage" 609600 118924 -gcp "$WidthImage" 0 610200 119424 -gcp "$WidthImage" "$HeightImage" 610200 118924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../34-35-38_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-35-38_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-76_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40N-O_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 605100 131024 -gcp 0 "$HeightImage" 605100 130624 -gcp "$WidthImage" 0 605700 131024 -gcp "$WidthImage" "$HeightImage" 605700 130624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../34-41-42_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-41-42_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/49D-I_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-126-144_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 604800 129724 -gcp 0 "$HeightImage" 604800 129324 -gcp "$WidthImage" 0 605400 129724 -gcp "$WidthImage" "$HeightImage" 605400 129324 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../34-48-49-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-48-49-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-255-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57N-S-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604800 126924 -gcp 0 "$HeightImage" 604800 126524 -gcp "$WidthImage" 0 605500  126924 -gcp "$WidthImage" "$HeightImage" 605500 126524 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../34-48-49_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-48-49_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-255_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57N-S_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604800 126924 -gcp 0 "$HeightImage" 604800 126524 -gcp "$WidthImage" 0 605400  126924 -gcp "$WidthImage" "$HeightImage" 605400 126524 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../34-49-50_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-49-50_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-274_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57S-X_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604800 126524 -gcp 0 "$HeightImage" 604800 126124 -gcp "$WidthImage" 0 605400  126524 -gcp "$WidthImage" "$HeightImage" 605400 126124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../35-49-50-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35-49-50-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/57T-Y3-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-275-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 605400 126624 -gcp 0 "$HeightImage" 605400 126024 -gcp "$WidthImage" 0 606000  126624 -gcp "$WidthImage" "$HeightImage" 606000 126024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../35-49-50_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/35-49-50_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-275_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 605400 126524 -gcp 0 "$HeightImage" 605400 126124 -gcp "$WidthImage" 0 606000  126524 -gcp "$WidthImage" "$HeightImage" 606000 126124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../34-53-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/34-53-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604700 125124 -gcp 0 "$HeightImage" 604700 124624 -gcp "$WidthImage" 0 605400  125124 -gcp "$WidthImage" "$HeightImage" 605400 124624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../36-34-union_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/36-34-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32P-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 606000 132624 -gcp 0 "$HeightImage" 606000 132224 -gcp "$WidthImage" 0 606800 132624 -gcp "$WidthImage" "$HeightImage" 606800 132224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../36-41-42_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/36-41-42_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/50A-F_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 606000 129724 -gcp 0 "$HeightImage" 606000 129324 -gcp "$WidthImage" 0 606600 129724 -gcp "$WidthImage" "$HeightImage" 606600 129324 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../37-58-59_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/37-58-59_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/75L-N_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 606600 122724 -gcp 0 "$HeightImage" 606600 122324 -gcp "$WidthImage" 0 607200  122724 -gcp "$WidthImage" "$HeightImage" 607200 122324 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../38-39-58_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/38-39-58_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/75M-N_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 607500 123024 -gcp 0 "$HeightImage" 607500 122624 -gcp "$WidthImage" 0 608100  123024 -gcp "$WidthImage" "$HeightImage" 608100 122624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../40-59-union*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40-59-union"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/75T-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 608400 122724 -gcp 0 "$HeightImage" 608400 122224 -gcp "$WidthImage" 0 609000  122724 -gcp "$WidthImage" "$HeightImage" 609000 122224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../42-43-39_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/42-43-39_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/42Q_R_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 610100 130624 -gcp 0 "$HeightImage" 610100 130224 -gcp "$WidthImage" 0 610700  130624 -gcp "$WidthImage" "$HeightImage" 610700 130224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../45-38-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/45-38-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/42O-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 611400 131080 -gcp 0 "$HeightImage" 611400 130624 -gcp "$WidthImage" 0 612000  131080 -gcp "$WidthImage" "$HeightImage" 612000 130624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../45-58-59_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/45-58-59_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/76O-T_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 611400 122824 -gcp 0 "$HeightImage" 611400 122424 -gcp "$WidthImage" 0 612000  122824 -gcp "$WidthImage" "$HeightImage" 612000 122424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../46-39-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46-39-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/43P-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 612000 130624 -gcp 0 "$HeightImage" 612000 130124 -gcp "$WidthImage" 0 612600  130624 -gcp "$WidthImage" "$HeightImage" 612600 130124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../46-57*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46-57_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/77F_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 612100 123424 -gcp 0 "$HeightImage" 612100 123024 -gcp "$WidthImage" 0 612700 123424 -gcp "$WidthImage" "$HeightImage" 612700 123024 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../46-58*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46-58"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/77K_"* ]]
then
gdal_translate -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -gcp 0 0 612100 123024 -gcp 0 "$HeightImage" 612100 122624 -gcp "$WidthImage" 0 612700  123024 -gcp "$WidthImage" "$HeightImage" 612700 122624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../46-59*_
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46-59_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/77P_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 612100 122624 -gcp 0 "$HeightImage" 612100 122224 -gcp "$WidthImage" 0 612700 122624 -gcp "$WidthImage" "$HeightImage" 612700 122224 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../48-38-39_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/48-38-39_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/43M-R_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 613200 130824 -gcp 0 "$HeightImage" 613200 130424 -gcp "$WidthImage" 0 613800 130824 -gcp "$WidthImage" "$HeightImage" 613800 130424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../48-38-39-union*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/48-38-39-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/43M-R-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 613100 130824 -gcp 0 "$HeightImage" 613100 130424 -gcp "$WidthImage" 0 613800 130824 -gcp "$WidthImage" "$HeightImage" 613800 130424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../56-24-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56-24-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 618000 136624 -gcp 0 "$HeightImage" 618000 136124 -gcp "$WidthImage" 0 618600 136624 -gcp "$WidthImage" "$HeightImage" 618600 136124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../20-42-union*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/20-42-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-130-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/46J-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596400 129424 -gcp 0 "$HeightImage" 596400 128924 -gcp "$WidthImage" 0 597000 129424 -gcp "$WidthImage" "$HeightImage" 597000 128924 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../Feuille-300-301_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-300-301_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601800 125824 -gcp 0 "$HeightImage" 601800 125424 -gcp "$WidthImage" 0 602500 125824 -gcp "$WidthImage" "$HeightImage" 602500 125424 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../25-49-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/25-49-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-265-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55T-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599400 126624 -gcp 0 "$HeightImage" 599400 126124 -gcp "$WidthImage" 0 600100  126624 -gcp "$WidthImage" "$HeightImage" 600100 126124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../26-49-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/26-49-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-266-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/56P-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599900 126624 -gcp 0 "$HeightImage" 599900 126124 -gcp "$WidthImage" 0 600600  126624 -gcp "$WidthImage" "$HeightImage" 600600 126124 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../25-50-Special-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/25-50-Special-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-281-Special-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55Y-Special-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599400 126324 -gcp 0 "$HeightImage" 599400 125724 -gcp "$WidthImage" 0 600100  126324 -gcp "$WidthImage" "$HeightImage" 600100 125724 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../25-50-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/25-50-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55Y-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599400 126324 -gcp 0 "$HeightImage" 599400 125824 -gcp "$WidthImage" 0 600100  126324 -gcp "$WidthImage" "$HeightImage" 600100 125824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16



# Planche ../Feuille-281-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-281-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599400 126324 -gcp 0 "$HeightImage" 599400 125824 -gcp "$WidthImage" 0 600100  126324 -gcp "$WidthImage" "$HeightImage" 600100 125824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../25-50-B-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-281-B-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599400 126324 -gcp 0 "$HeightImage" 599400 125824 -gcp "$WidthImage" 0 600100  126324 -gcp "$WidthImage" "$HeightImage" 600100 125824 "$TiffSource" temp.tif
if [ -f ../_Output_3857/Feuille-281-B-union_"$geoserverworkspace"_1896.tif ]
then
mv ../_Output_3857/Feuille-281-B-union_"$geoserverworkspace"_1896.tif ../_TRASH_TEMP/"$FileDate"Feuille-281-B-union_"$geoserverworkspace"_1896.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/Feuille-281-B-union_"$geoserverworkspace"_1896.tif
gdaladdo -r average ../_Output_3857/Feuille-281-B-union_"$geoserverworkspace"_1896.tif 2 4 8 16

# Planche ../26-50-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/26-50-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/Feuille-282-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/55U-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599900 126324 -gcp 0 "$HeightImage" 599900 125824 -gcp "$WidthImage" 0 600600  126324 -gcp "$WidthImage" "$HeightImage" 600600 125824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../40-35-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40-35-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/32Y-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 608400 132224 -gcp 0 "$HeightImage" 608400 131824 -gcp "$WidthImage" 0 609100  132224 -gcp "$WidthImage" "$HeightImage" 609100 131824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../40-36-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40-36-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/41E-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 608400 131824 -gcp 0 "$HeightImage" 608400 131324 -gcp "$WidthImage" 0 609000  131824 -gcp "$WidthImage" "$HeightImage" 609000 131324 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

# Planche ../40-43-union_*
elif [[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/40-43-union_"* ]]||[[ "$TiffSource" == "../_Source_Standard_Croped_TIFF/50O-union_"* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 608400 129124 -gcp 0 "$HeightImage" 608400 128624 -gcp "$WidthImage" 0 609000  129124 -gcp "$WidthImage" "$HeightImage" 609000 128624 "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16


# Planche ../26-50-union_*
elif [[ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Feuille-282-B-union_* ]]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599900 126324 -gcp 0 "$HeightImage" 599900 125824 -gcp "$WidthImage" 0 600600  126324 -gcp "$WidthImage" "$HeightImage" 600600 125824 "$TiffSource" temp.tif
if [ -f "../_Output_3857/Feuille-282-B-union_"$geoserverworkspace"_1896.tif" ]
then
mv "../_Output_3857/Feuille-282-B-union_"$geoserverworkspace"_1896.tif" ../_TRASH_TEMP/"$FileDate"_Feuille-282-B-union_"$geoserverworkspace"_1896.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/Feuille-282-B-union_"$geoserverworkspace"_1896.tif"
gdaladdo -r average "../_Output_3857/Feuille-282-B-union_"$geoserverworkspace"_1896.tif" 2 4 8 16

#
# Fin des traitements particuliers
#

else
#
# Processing Standard $Abscissa & $Ordinate
#
echo "${white}---> \$Abscissa   -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Abscissa"
echo "${white}---> \$Ordinate   -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Ordinate"
echo "${white}---> \$AbscissaMultiple   -   -   -   -   -   -   -   -   -   -   -   ${orange}$AbscissaMultiple"
echo "${white}---> \$OrdinateMultiple   -   -   -   -   -   -   -   -   -   -   -   ${orange}$OrdinateMultiple"

#
# Condition: if the filename corresponds to the pattern: 25-50
# Si c'est une planche IGC nouveaux numéros post 1968
# Processing Gdal
# -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud"
#
if echo "$IGCPatternOrdinate" | grep '[0-9]"_"' &&  echo "$IGCPatternAbscissa" | grep '[0-9]"_"'
then
echo "${white}---> Nouveaux numéros - Post --> 1968 ${orange}("$Year") ${green}"$IGCPatternOrdinate"-"$IGCPatternAbscissa"${white}"
echo "$red MINUTES Line 1328"
echo "$red MINUTES Line 1338"
echo "$red MINUTES Line 1338"
echo "$red MINUTES Line 1338"
echo "gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud" "$TiffSource" temp.tif"
# Si Minute then alpha
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud" "$TiffSource" temp.tif

gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16
echo "$red MINUTES Line 1338"
else
#
# Condition: if the filename corresponds to the pattern: 25X_
# Si c'est une planche IGC  numéros Depts de la Seine pre 1962
# Processing Gdal
# -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud"
#

#
# Sous condition numéros 26K, 72Y,
#
if [[ $IDCThirdLetter == [A-B] ]]
then

echo "$red THIRD LETTER Line 1353"
echo "${white}---> Numérotation du département de la Seine pre 1962 - ("${orange}""$Year")${green}      $NameNoExt $purple"
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud" "$TiffSource" temp.tif
if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi
gdalwarp -co COMPRESS=NONE -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857"  temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16
else

#
# Condition: if the filename corresponds to else (Anciens numéros)
# Reservé pour le Processing Gdal des planches: Feuille-*
# Processing Gdal
# -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud"
#

if [ -f "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ]
then
mv "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" ../_TRASH_TEMP/"$FileDate"_"$NameNoExt"_"$Year".tif
fi

# Si Minute, then alpha
if [[ "$TiffSource" == "*_minute*" ]]
then
echo "---> Pocessing : Plan Minute"
gdal_translate -co COMPRESS=NONE -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud" "$TiffSource" temp.tif
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16
else
echo "${white}---> Pocessing : Plan IDC O-A"
echo "${white}---> Proccess with no special Ordinate or Abscissa - ${green}$NameNoExt ${orange}("$Year")"
gdal_translate -co COMPRESS=NONE  -co ALPHA=YES -a_srs EPSG:27561 -of GTiff -gcp 0 0 "$Ouest" "$Nord" -gcp 0 "$HeightImage" "$Ouest" "$Sud" -gcp "$WidthImage" 0 "$Est" "$Nord" -gcp "$WidthImage" "$HeightImage" "$Est" "$Sud" "$TiffSource" temp.tif
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif"
gdaladdo -r average "../_Output_3857/"$NameNoExt"_"$geoserverworkspace"_"$Year".tif" 2 4 8 16

fi
#
# Fin planches Numéros: Anciens / Nouveaux / Seine
#
fi



#
# Cas Particuliers:
#

fi

#
##
#### Processing Feuille-*
##
#




fi

#
## # OUTPUT IMAGE INFO + WFS in TMP_BASH
#

# For exiftool
PlancheName_Simple=$(echo $NameNoExt| sed 's/-union//g'| sed 's/-minute//g')
Char3=$(echo "$PlancheName_Simple" | sed 's/..//'|awk -F'_' '{print $1}')
planchesNamesTMP=$(echo "$PlancheName_Simple"|  awk '{sub(/^0*/,"");}1'|awk -F'_' '{print $1}')




echo "${white}---> Export variables in tmp/tmp_bash${orange}"
echo TiffSource=\"$TiffSource\" >> tmp/tmp_bash
echo "NameNoExt=\"$NameNoExt\"" >> tmp/tmp_bash
echo "Year=\"$Year\"" >> tmp/tmp_bash
# EPSG 27561
echo "Nord=\"$Nord\"" >> tmp/tmp_bash
echo "Sud=\"$Sud\"" >> tmp/tmp_bash
echo "Est=\"$Est\"" >> tmp/tmp_bash
echo "Ouest=\"$Ouest\"" >> tmp/tmp_bash
# EPSG 4326
echo "NordOuest4326=\"$NordOuest4326\"" >> tmp/tmp_bash
echo "SudOuest4326=\"$SudOuest4326\"" >> tmp/tmp_bash
echo "SudEst4326=\"$SudEst4326\"" >> tmp/tmp_bash
echo "NordEst4326=\"$NordEst4326\"" >> tmp/tmp_bash
# EPSG 3857
echo "NordOuest3857=\"$NordOuest3857\"" >> tmp/tmp_bash
echo "SudOuest3857=\"$SudOuest3857\"" >> tmp/tmp_bash
echo "SudEst3857=\"$SudEst3857\"" >> tmp/tmp_bash
echo "NordEst3857=\"$NordEst3857\"" >> tmp/tmp_bash
# width / height image
echo "WidthImage=\"$WidthImage\"" >> tmp/tmp_bash
echo "HeightImage=\"$HeightImage\"" >> tmp/tmp_bash

echo 'Lastrender=$(ls -t ../_Output_3857/ | head -n1)' >> tmp/tmp_bash
echo PlancheName_Simple=\"$PlancheName_Simple\" >> tmp/tmp_bash

echo planchesNamesTMP=\"$planchesNamesTMP\" >> tmp/tmp_bash
echo Char3=\"$Char3\" >> tmp/tmp_bash


echo "${white}---> Go to ${orange}SubRoutine_forNode.sh${orange}"
echo "${white}---> Go to ${orange}SubRoutine_forNode.sh${orange}"

./SubRoutine_forNode.sh
echo "${white}---> Back from ${orange}SubRoutine_forNode.sh${orange}"
echo "${white}---> source ${orange}tmp/tmp_bash tmp/variable_invariable"

source tmp/tmp_bash tmp/variable_invariable


python finder_colors.py green "$TiffSource"
echo "${white}---> \$TiffSource -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$TiffSource"
echo "${white}---> \$NameNoExt  -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$NameNoExt"
echo "${white}---> \$Year   -   -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$Year"
echo "
${white}############################### Planche ${green}$Ordinate $Abscissa $Version $Year ${white}###############################
"
echo "${white}---> NTF (Paris) / Lambert Nord France  ${green}27561 ${white}            unit  :       ${green}meter           ${white}<---
${white}---> \"Nouvelle Triangulation Francaise (Paris)\""
echo "                                                                     Nord      Lambert 1"
echo "${white}---> \$Nord   Lambert Nord    -   - EPSG:${green}27561${white}-   -   -   -   -   -   ${orange}$Nord"
echo "                                                                     ${white}Sud      Lambert 1"
echo "${white}---> \$Sud    Lambert Nord    -   - EPSG:${green}27561${white}-   -   -   -   -   -   ${orange}$Sud"
echo "                                                                     ${white}Est      Lambert 1"
echo "${white}---> \$Est    Lambert Nord    -   - EPSG:${green}27561${white}-   -   -   -   -   -   ${orange}$Est"
echo "                                                                     ${white}Ouest    Lambert 1"
echo "${white}---> \$Ouest  Lambert Nord    -   - EPSG:${green}27561${white}-   -   -   -   -   -   ${orange}$Ouest"

echo "
${white}---> WGS 84 (World Geodetic System 1984)EPSG:${green}4326 ${white}Corners unit  :       ${green}degree          ${white}<---
${white}---> \"World Geodetic System 1984 / -85.06,-180,85.06,180\""

echo "${white}---> \$NordOuest4326  -   -   -   - EPSG:${green}4326${white} -   -   -   -   -   -   ${orange}$NordOuest4326"
echo "${white}---> \$SudOuest4326   -   -   -   - EPSG:${green}4326${white} -   -   -   -   -   -   ${orange}$SudOuest4326"
echo "${white}---> \$NordEst4326    -   -   -   - EPSG:${green}4326${white} -   -   -   -   -   -   ${orange}$NordEst4326"
echo "${white}---> \$SudEst4326 -   -   -   -   - EPSG:${green}4326${white} -   -   -   -   -   -   ${orange}$SudEst4326"

echo "
${white}---> WGS 84 / Pseudo-Mercator      EPSG:${green}3857 ${white}Corners      unit  :       ${green}meter           ${white}<---
${white}---> \"World Geodetic System 1984\""
echo "${white}---> \$NordOuest3857  -   -   -   - EPSG:${green}3857${white} -   -   -   -   -   -   ${orange}$NordOuest3857"
echo "${white}---> \$SudOuest3857   -   -   -   - EPSG:${green}3857${white} -   -   -   -   -   -   ${orange}$SudOuest3857"
echo "${white}---> \$SudEst3857 -   -   -   -   - EPSG:${green}3857${white} -   -   -   -   -   -   ${orange}$SudEst3857"
echo "${white}---> \$NordEst3857    -   -   -   - EPSG:${green}3857${white} -   -   -   -   -   -   ${orange}$NordEst3857"
echo "${white}---> \$WidthImage${white} -   -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$WidthImage px"
echo "${white}---> \$HeightImage${white}    -   -   -   -   -   -   -   -   -   -   -   -   ${orange}$HeightImage px"
echo "${white}---> \$LayerBound${white}     -   -   -   -   -   -   -   -   -   -   -   -   ${lightblue}$LayerBound"


#
echo "${white}---> model .txt                                                                       ${orange}: NomHuman|NomMachine|LienSources|Commentaire|author|Year|"
if [ -f ../Author.txt ]
then
Author=$(cat ../Author.txt)
echo "${white}---> \$Author${white}                                                                 ${orange}: $Author"
fi
if [ -f ../LinkSource.txt ]
then
LinkSource=$(cat ../LinkSource.txt)
echo "${white}---> \$LinkSource${white}                                                                 ${orange}: $LinkSource"
LienSource="$LinkSource" >> tmp_bash
LienSource="$LinkSource"
fi

echo "$white Variables"
echo "$OutputFilenameSeul|$NodeID|$NomMachine|$NomMachineLowCap|$LayerHumanTitle|$LayerHumanShortName|$MapType|$WorkspaceName|$WorkspaceNameLowCap|$Year|$body|$TiffPrivatePath|$TiffCloudpath|$ZipCloudpath|$PNGCloudpath|$TiffHTTP|$ZipHTTP|$PNGHTTP|$layer_attribut|$targetid|$idsource|$LayerBound|$WKT_Map_Extent|$Row_layer_order|$Nord|$Sud|$Est|$Ouest|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$NordBasic|$SudBasic|$EstBasic|$OuestBasic|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$Default_IDC_GEOMETRY|$OriginalPost1980Name|$OldNum|$Seine|$Author|$Comentaire|$LienSource|$LieuxDitTID|"
echo "$green--->  Done ! $white"


#THIS_IS_A_LINEBREAK
echo "$OutputFilenameSeul|$NodeID|$NomMachine|$NomMachineLowCap|$LayerHumanTitle|$LayerHumanShortName|$MapType|$WorkspaceName|$WorkspaceNameLowCap|$Year|$body|$TiffPrivatePath|$TiffCloudpath|$ZipCloudpath|$PNGCloudpath|$TiffHTTP|$ZipHTTP|$PNGHTTP|$layer_attribut|$targetid|$idsource|$LayerBound|$WKT_Map_Extent|$Row_layer_order|$Nord|$Sud|$Est|$Ouest|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$NordBasic|$SudBasic|$EstBasic|$OuestBasic|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$Default_IDC_GEOMETRY|$OriginalPost1980Name|$OldNum|$Seine|$Author|$Comentaire|$LienSource|$LieuxDitTID|" >> tmp/Layerstmp



exiftool -r -overwrite_original -description= -m -description="OutputFilenameSeul|NodeID|NomMachine|NomMachineLowCap|LayerHumanTitle|LayerHumanShortName|MapType|WorkspaceName|WorkspaceNameLowCap|Year|body|TiffPrivatePath|TiffCloudpath|ZipCloudpath|PNGCloudpath|TiffHTTP|ZipHTTP|PNGHTTP|layer_attribut|targetid|idsource|LayerBound|WKT_Map_Extent|Row_layer_order|Nord|Sud|Est|Ouest|NordOuest3857|SudOuest3857|SudEst3857|NordEst3857|NordOuest4326|SudOuest4326|SudEst4326|NordEst4326|NordBasic|SudBasic|EstBasic|OuestBasic|BasicNordOuest|BasicSudOuest|BasicSudEst|BasicNordEst|BasicNordOuest3857|BasicSudOuest3857|BasicSudEst3857|BasicNordEst3857|BasicNordOuest4326|BasicSudOuest4326|BasicSudEst4326|BasicNordEst4326|Default_IDC_GEOMETRY|OriginalPost1980Name|OldNum|Seine|Author|Comentaire|LienSource|LieuxDitTID|THIS_IS_A_LINEBREAK
$OutputFilenameSeul|$NodeID|$NomMachine|$NomMachineLowCap|$LayerHumanTitle|$LayerHumanShortName|$MapType|$WorkspaceName|$WorkspaceNameLowCap|$Year|$body|$TiffPrivatePath|$TiffCloudpath|$ZipCloudpath|$PNGCloudpath|$TiffHTTP|$ZipHTTP|$PNGHTTP|$layer_attribut|$targetid|$idsource|$LayerBound|$WKT_Map_Extent|$Row_layer_order|$Nord|$Sud|$Est|$Ouest|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$NordBasic|$SudBasic|$EstBasic|$OuestBasic|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$Default_IDC_GEOMETRY|$OriginalPost1980Name|$OldNum|$Seine|$Author|$Comentaire|$LienSource|$LieuxDitTID|"  -artist="sous-paris.com" -Software="Kta2geo 1.3" ../_Output_3857/"$Lastrender"
if [ -f ../_Output_3857/"$Lastrender"_original ]
then
rm ../_Output_3857/"$Lastrender"_original
fi
python finder_colors.py blue ../_Output_3857/"$Lastrender"
done

if [ -f ../HidendSeek.js ]
then
mv ../HidendSeek.js ../_TRASH_TEMP/"$FileDate"_HidendSeek.js
fi
cp tmp/tmp_HideNSeek ../HidendSeek.js

echo "OutputFilenameSeul|NodeID|NomMachine|NomMachineLowCap|LayerHumanTitle|LayerHumanShortName|MapType|WorkspaceName|WorkspaceNameLowCap|Year|body|TiffPrivatePath|TiffCloudpath|ZipCloudpath|PNGCloudpath|TiffHTTP|ZipHTTP|PNGHTTP|layer_attribut|targetid|idsource|LayerBound|WKT_Map_Extent|Row_layer_order|Nord|Sud|Est|Ouest|NordOuest3857|SudOuest3857|SudEst3857|NordEst3857|NordOuest4326|SudOuest4326|SudEst4326|NordEst4326|NordBasic|SudBasic|EstBasic|OuestBasic|BasicNordOuest|BasicSudOuest|BasicSudEst|BasicNordEst|BasicNordOuest3857|BasicSudOuest3857|BasicSudEst3857|BasicNordEst3857|BasicNordOuest4326|BasicSudOuest4326|BasicSudEst4326|BasicNordEst4326|Default_IDC_GEOMETRY|OriginalPost1980Name|OldNum|Seine|Author|Comentaire|LienSource|LieuxDitTID" > ../_Output_CSVs/_Layer_Text_Export.csv
cat tmp/Layerstmp |awk NF >> ../_Output_CSVs/_Layer_Text_Export.csv
#./SubRoutine_forNodeB.sh


echo "${white}---> Now fetching the files on the server where apache user can read"


echo "${white}
                     ########:::'######::'##:::'##:'##::: ##::'######::
                     ##.... ##:'##... ##:. ##:'##:: ###:: ##:'##... ##:
                     ##:::: ##: ##:::..:::. ####::: ####: ##: ##:::..::
                     ########::. ######::::. ##:::: ## ## ##: ##:::::::
                     ##.. ##::::..... ##:::: ##:::: ##. ####: ##:::::::
                     ##::. ##::'##::: ##:::: ##:::: ##:. ###: ##::: ##:
                     ##:::. ##:. ######::::: ##:::: ##::. ##:. ######::
                    ..:::::..:::......::::::..:::::..::::..:::......:::
"

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

rm tmp/tmp_bash

./Export_variable_from_geotif.sh
