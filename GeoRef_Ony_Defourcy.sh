#!/bin/bash
#awk 'FNR==NR{a[$0];next}!($0 in a)' A.txt B.txt | awk '!seen[$0]++'


# exiftool JPG + info detail in wldzip.sh tmp/csv + filesize du zip + . txt info

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
./Generate_Special_Planches_CSV.sh
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

# Map Type
Choose_me ()
{

select select_item; do
# Check menu item number
if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $# ];

then
echo "Running $select_item..."
break;
else
echo "Erreur - Choisir parmis 1-$#"
fi
done
}

# Declare the array
Menu=( 'IDCPARIS' 'OtherMaps' )

# Call the subroutine to create the menu
Choose_me "${Menu[@]}"

if [ "$select_item" = IDCPARIS ]
then
MapType="IDCPARIS"
echo "${white}---> \$MapType                                                        ${orange}: $MapType"
fi
if [ "$select_item" = OtherMaps ]
then
MapType="OtherMaps"
echo "${white}---> \$MapType                                                        ${orange}: $MapType"
fi
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

targetid=$(echo planche"$NomMachine")
echo targetid=\"$targetid\" >> tmp/tmp_bash
idsource=$(echo add_planche"$NomMachine")
echo idsource=\"$idsource\" >> tmp/tmp_bash


# Files Source, Soft and Hard path
#
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
echo "${white}---> Processing \$TiffSource                                          ${orange}: $TiffSource"
echo PNGHTTP=\"$PNGHTTP\" >> tmp/tmp_bash
Cleaned_Name=$(echo "$NameNoExt"|sed 's/-Special-union//g' |sed 's/-B-union//g' |sed 's/-union_//g'| sed 's/-union_//g')


#
##
#



# Begin Rules



# De Fourcy 1858 ../P05_Planche_1_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P05_Planche_1_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601000 127424 -gcp 0 "$HeightImage" 601000 126824 -gcp "$WidthImage" 0 602000 127424 -gcp "$WidthImage" "$HeightImage" 602000 126824 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P05_Planche_1_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P05_Planche_1_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P05_Planche_1_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P05_Planche_1_DeFourcy_1858.tif

# De Fourcy 1858 ../P06_Planche_2_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P06_Planche_2_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601000 126824 -gcp 0 "$HeightImage" 601000 126224 -gcp "$WidthImage" 0 602000 126824 -gcp "$WidthImage" "$HeightImage" 602000 126224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P06_Planche_2_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P06_Planche_2_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P06_Planche_2_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P06_Planche_2_DeFourcy_1858.tif

# De Fourcy 1858 ../P06_Planche_2_Encart_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P06_Planche_2_Encart_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 604200 126682 -gcp 0 "$HeightImage" 604200 126524 -gcp "$WidthImage" 0 604460 126682 -gcp "$WidthImage" "$HeightImage" 604460 126524 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P06_Planche_2_Encart_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P06_Planche_2_Encart_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P06_Planche_2_Encart_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P06_Planche_2_Encart_DeFourcy_1858.tif

# De Fourcy 1858 ../P07_Planche_3_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P07_Planche_3_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601000 126224 -gcp 0 "$HeightImage" 601000 125624 -gcp "$WidthImage" 0 602000 126224 -gcp "$WidthImage" "$HeightImage" 602000 125624 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P07_Planche_3_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P07_Planche_3_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P07_Planche_3_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P07_Planche_3_DeFourcy_1858.tif

# De Fourcy 1858 ../P08_Planche_4_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P08_Planche_4_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 601000 125624 -gcp 0 "$HeightImage" 601000 125024 -gcp "$WidthImage" 0 602000 125624 -gcp "$WidthImage" "$HeightImage" 602000 125024 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P08_Planche_4_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P08_Planche_4_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P08_Planche_4_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear  -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P08_Planche_4_DeFourcy_1858.tif

# De Fourcy 1858 ../P09_Planche_5_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P09_Planche_5_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 128024 -gcp 0 "$HeightImage" 600000 127424 -gcp "$WidthImage" 0 601000 128024 -gcp "$WidthImage" "$HeightImage" 601000 127424 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P09_Planche_5_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P09_Planche_5_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P09_Planche_5_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P09_Planche_5_DeFourcy_1858.tif

# De Fourcy 1858 ../P09_Planche_5_DeFourcy-Encart-A_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P09_Planche_5_DeFourcy-Encart-A_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599960 131465 -gcp 0 "$HeightImage" 599960 131230 -gcp "$WidthImage" 0 600555 131455 -gcp "$WidthImage" "$HeightImage" 600555 131230 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P09_Planche_5_DeFourcy-Encart-A_1858.tif ]
then
mv ../_Output_3857/P09_Planche_5_DeFourcy-Encart-A_1858.tif ../_TRASH_TEMP/"$FileDate"_P09_Planche_5_DeFourcy-Encart-A_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P09_Planche_5_DeFourcy-Encart-A_1858.tif

# De Fourcy 1858 ../P09_Planche_5_DeFourcy-Encart-B_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P09_Planche_5_DeFourcy-Encart-B_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 602405 130937 -gcp 0 "$HeightImage" 602405 130337 -gcp "$WidthImage" 0 602915 130937 -gcp "$WidthImage" "$HeightImage" 602915 130337 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P09_Planche_5_DeFourcy-Encart-B_1858.tif ]
then
mv ../_Output_3857/P09_Planche_5_DeFourcy-Encart-B_1858.tif ../_TRASH_TEMP/"$FileDate"_P09_Planche_5_DeFourcy-Encart-B_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P09_Planche_5_DeFourcy-Encart-B_1858.tif

# De Fourcy 1858 ../P09_Planche_5_DeFourcy-Encart-C_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P09_Planche_5_DeFourcy-Encart-C_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 602250 131560 -gcp 0 "$HeightImage" 602250 131220 -gcp "$WidthImage" 0 602510 131560 -gcp "$WidthImage" "$HeightImage" 602510 131220 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P09_Planche_5_DeFourcy-Encart-C_1858.tif ]
then
mv ../_Output_3857/P09_Planche_5_DeFourcy-Encart-C_1858.tif ../_TRASH_TEMP/"$FileDate"_P09_Planche_5_DeFourcy-Encart-C_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P09_Planche_5_DeFourcy-Encart-C_1858.tif

# De Fourcy 1858 ../P10_Planche_6_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P10_Planche_6_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 127424 -gcp 0 "$HeightImage" 600000 126824 -gcp "$WidthImage" 0 601000 127424 -gcp "$WidthImage" "$HeightImage" 601000 126824 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P10_Planche_6_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P10_Planche_6_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P10_Planche_6_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P10_Planche_6_DeFourcy_1858.tif

# De Fourcy 1858 ../P11_Planche_7_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P11_Planche_7_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 126824 -gcp 0 "$HeightImage" 600000 126224  -gcp "$WidthImage" 0 601000 126824 -gcp "$WidthImage" "$HeightImage" 601000 126224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P11_Planche_7_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P11_Planche_7_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P11_Planche_7_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P11_Planche_7_DeFourcy_1858.tif

# De Fourcy 1858 ../P12_Planche_8_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P12_Planche_8_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 600000 126224 -gcp 0 "$HeightImage" 600000 125624  -gcp "$WidthImage" 0 601000 126224 -gcp "$WidthImage" "$HeightImage" 601000 125624 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P12_Planche_8_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P12_Planche_8_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P12_Planche_8_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -dstalpha -s_srs "EPSG:27561" -t_srs "EPSG:3857" temp.tif ../_Output_3857/P12_Planche_8_DeFourcy_1858.tif

# De Fourcy 1858 ../P13_Planche_9_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P13_Planche_9_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599000 128024 -gcp 0 "$HeightImage" 599000 127424  -gcp "$WidthImage" 0 600000 128024 -gcp "$WidthImage" "$HeightImage" 600000 127424 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P13_Planche_9_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P13_Planche_9_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P13_Planche_9_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P13_Planche_9_DeFourcy_1858.tif

# De Fourcy 1858 ../P14_Planche_10_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P14_Planche_10_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599000 127424 -gcp 0 "$HeightImage" 599000 126824  -gcp "$WidthImage" 0 600000 127424 -gcp "$WidthImage" "$HeightImage" 600000 126824 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P14_Planche_10_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P14_Planche_10_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P14_Planche_10_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P14_Planche_10_DeFourcy_1858.tif

# De Fourcy 1858 ../P15_Planche_11_DeFourcy_1858*
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P15_Planche_11_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599000 126824 -gcp 0 "$HeightImage" 599000 126224  -gcp "$WidthImage" 0 600000 126824 -gcp "$WidthImage" "$HeightImage" 600000 126224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P15_Planche_11_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P15_Planche_11_DeFourcy_1858.tif ../_TRASH_TEMP/P15_Planche_11_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -overwrite temp.tif ../_Output_3857/P15_Planche_11_DeFourcy_1858.tif

# De Fourcy 1858 ../P16_Planche_12_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P16_Planche_12_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599000 126224 -gcp 0 "$HeightImage" 599000 125624  -gcp "$WidthImage" 0 600000 126224 -gcp "$WidthImage" "$HeightImage" 600000 125624 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P16_Planche_12_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P16_Planche_12_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P16_Planche_12_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P16_Planche_12_DeFourcy_1858.tif

# De Fourcy 1858 ../P16_Planche_12_Encart_DeFourcy_1860.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P16_Planche_12_Encart_DeFourcy_1860.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599559 125654 -gcp 0 "$HeightImage" 599559 125452.5  -gcp "$WidthImage" 0 599844.5 125654 -gcp "$WidthImage" "$HeightImage" 599844.5 125452.5 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P16_Planche_12_Encart_DeFourcy_1860.tif ]
then
mv ../_Output_3857/P16_Planche_12_Encart_DeFourcy_1860.tif ../_TRASH_TEMP/"$FileDate"_P16_Planche_12_Encart_DeFourcy_1860.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha -overwrite temp.tif ../_Output_3857/P16_Planche_12_Encart_DeFourcy_1860.tif

# De Fourcy 1858 (Planche Seule) ../Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 599500 125663 -gcp 0 "$HeightImage" 599500 125420  -gcp "$WidthImage" 0 599912 125663 -gcp "$WidthImage" "$HeightImage" 599912 125420 "$TiffSource" temp.tif
if [ -f ../_Output_3857/Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif ]
then
mv ../_Output_3857/Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif ../_TRASH_TEMP/"$FileDate"_Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha -overwrite temp.tif ../_Output_3857/Plan_des_Catacombes_de_Paris_DeFourcy_1857.tif


# De Fourcy 1858 ../P17_Planche_13_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P17_Planche_13_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 598000 127424 -gcp 0 "$HeightImage" 598000 126824  -gcp "$WidthImage" 0 599000 127424 -gcp "$WidthImage" "$HeightImage" 599000 126824 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P17_Planche_13_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P17_Planche_13_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P17_Planche_13_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P17_Planche_13_DeFourcy_1858.tif

# De Fourcy 1858 ../P18_Planche_14_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P18_Planche_14_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 598000 126824 -gcp 0 "$HeightImage" 598000 126224  -gcp "$WidthImage" 0 599000 126824 -gcp "$WidthImage" "$HeightImage" 599000 126224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P18_Planche_14_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P18_Planche_14_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P18_Planche_14_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P18_Planche_14_DeFourcy_1858.tif

# De Fourcy 1858 ../P19_Planche_15_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P19_Planche_15_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 597000 129824 -gcp 0 "$HeightImage" 597000 129224  -gcp "$WidthImage" 0 598000 129824 -gcp "$WidthImage" "$HeightImage" 598000 129224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P19_Planche_15_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P19_Planche_15_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P19_Planche_15_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P19_Planche_15_DeFourcy_1858.tif

# De Fourcy 1858 ../P20_Planche_16_DeFourcy_1858.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P20_Planche_16_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596000 129824 -gcp 0 "$HeightImage" 596000 129224  -gcp "$WidthImage" 0 597000 129824 -gcp "$WidthImage" "$HeightImage" 597000 129224 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P20_Planche_16_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P20_Planche_16_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P20_Planche_16_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P20_Planche_16_DeFourcy_1858.tif

# De Fourcy 1858 ../P21_Planche_17_DeFourcy_1858
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P21_Planche_17_DeFourcy_1858.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596000 129224 -gcp 0 "$HeightImage" 596000 128624  -gcp "$WidthImage" 0 597000 129224 -gcp "$WidthImage" "$HeightImage" 597000 128624 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P21_Planche_17_DeFourcy_1858.tif ]
then
mv ../_Output_3857/P21_Planche_17_DeFourcy_1858.tif ../_TRASH_TEMP/"$FileDate"_P21_Planche_17_DeFourcy_1858.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P21_Planche_17_DeFourcy_1858.tif

# De Fourcy 1858 ../P00_Planche_0_Assemblage_DeFourcy_1958.tif
elif [ "$TiffSource" == ../_Source_Standard_Croped_TIFF/P00_Planche_0_Assemblage_DeFourcy_1958.tif ]
then
gdal_translate -co ALPHA=YES -co COMPRESS=NONE -a_srs EPSG:27561 -of GTiff -r bilinear -gcp 0 0 596000 129824 -gcp 0 "$HeightImage" 596000 125024  -gcp "$WidthImage" 0 602000 129824 -gcp "$WidthImage" "$HeightImage" 602000 125024 "$TiffSource" temp.tif
if [ -f ../_Output_3857/P00_Planche_0_Assemblage_DeFourcy_1958.tif ]
then
mv ../_Output_3857/P00_Planche_0_Assemblage_DeFourcy_1958.tif ../_TRASH_TEMP/"$FileDate"_P00_Planche_0_Assemblage_DeFourcy_1958.tif
fi
gdalwarp -co COMPRESS=NONE -r bilinear -s_srs "EPSG:27561" -t_srs "EPSG:3857" -dstalpha temp.tif ../_Output_3857/P00_Planche_0_Assemblage_DeFourcy_1958.tif

# End Rules









#
##
#

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

echo "$purple DEBUG 5500"

./SubRoutine_forNode.sh
echo "$purple DEBUG 5600"
echo "${white}---> Back from ${orange}CsvNWfs.sh${orange}"
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


echo "$white Variables"
echo "$OutputFilenameSeul|$NodeID|$NomMachine|$NomMachineLowCap|$LayerHumanTitle|$LayerHumanShortName|$MapType|$WorkspaceName|$WorkspaceNameLowCap|$Year|$body|$TiffPrivatePath|$TiffCloudpath|$ZipCloudpath|$PNGCloudpath|$TiffHTTP|$ZipHTTP|$PNGHTTP|$layer_attribut|$targetid|$idsource|$LayerBound|$WKT_Map_Extent|$Row_layer_order|$Nord|$Sud|$Est|$Ouest|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$NordBasic|$SudBasic|$EstBasic|$OuestBasic|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$Default_IDC_GEOMETRY|$OriginalPost1980Name|$OldNum|$Seine|$Author|$Comentaire|$LienSource|$LieuxDitTID|"
echo "$red Done !"


#THIS_IS_A_LINEBREAK
echo "$OutputFilenameSeul|$NodeID|$NomMachine|$NomMachineLowCap|$LayerHumanTitle|$LayerHumanShortName|$MapType|$WorkspaceName|$WorkspaceNameLowCap|$Year|$body|$TiffPrivatePath|$TiffCloudpath|$ZipCloudpath|$PNGCloudpath|$TiffHTTP|$ZipHTTP|$PNGHTTP|$layer_attribut|$targetid|$idsource|$LayerBound|$WKT_Map_Extent|$Row_layer_order|$Nord|$Sud|$Est|$Ouest|$NordOuest3857|$SudOuest3857|$SudEst3857|$NordEst3857|$NordOuest4326|$SudOuest4326|$SudEst4326|$NordEst4326|$NordBasic|$SudBasic|$EstBasic|$OuestBasic|$BasicNordOuest|$BasicSudOuest|$BasicSudEst|$BasicNordEst|$BasicNordOuest3857|$BasicSudOuest3857|$BasicSudEst3857|$BasicNordEst3857|$BasicNordOuest4326|$BasicSudOuest4326|$BasicSudEst4326|$BasicNordEst4326|$Default_IDC_GEOMETRY|$OriginalPost1980Name|$OldNum|$Seine|$Author|$Comentaire|$LienSource|$LieuxDitTID|" >> tmp/Layerstmp



exiftool -r -overwrite_original -keywords= -m -keywords="OutputFilenameSeul|NodeID|NomMachine|NomMachineLowCap|LayerHumanTitle|LayerHumanShortName|MapType|WorkspaceName|WorkspaceNameLowCap|Year|body|TiffPrivatePath|TiffCloudpath|ZipCloudpath|PNGCloudpath|TiffHTTP|ZipHTTP|PNGHTTP|layer_attribut|targetid|idsource|LayerBound|WKT_Map_Extent|Row_layer_order|Nord|Sud|Est|Ouest|NordOuest3857|SudOuest3857|SudEst3857|NordEst3857|NordOuest4326|SudOuest4326|SudEst4326|NordEst4326|NordBasic|SudBasic|EstBasic|OuestBasic|BasicNordOuest|BasicSudOuest|BasicSudEst|BasicNordEst|BasicNordOuest3857|BasicSudOuest3857|BasicSudEst3857|BasicNordEst3857|BasicNordOuest4326|BasicSudOuest4326|BasicSudEst4326|BasicNordEst4326|Default_IDC_GEOMETRY|OriginalPost1980Name|OldNum|Seine|Author|Comentaire|LienSource|LieuxDitTID|THIS_IS_A_LINEBREAK
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
