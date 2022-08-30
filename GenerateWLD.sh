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
echo "${bg_green}${white}---> Hello I'm GenerateWLD.sh${reset}"
echo "${white}---> I'm Generating jpg with .wld + .prj file in a .zip"

source tmp/tmp_bash
source tmp/variable_invariable






ResolutionX=$(exiftool ../_Output_3857/"$Lastrender" | awk '/X Resolution/' |awk -F' : ' '{print $2}')
ResolutionY=$(exiftool ../_Output_3857/"$Lastrender" | awk '/Y Resolution/' |awk -F' : ' '{print $2}')
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


#DPI WidthImage HeightImage


gdal_translate -co "TFW=YES" ../_Output_3857/"$Lastrender" temp.tif
LastrenderNoExt=$(echo "$Lastrender"| sed 's/\.geotiff//g'| sed 's/\.geotif//g'| sed 's/\.tif//g')
convert -quiet temp.tif "$LastrenderNoExt".jpg
JpegPoids=$(ls -lah "$LastrenderNoExt".jpg |awk '{print $5}'|sed 's/M/ Mo/g'|sed 's/G/ Go/g'|sed 's/K/ Ko/g')

convert -quiet ../_Output_3857/"$Lastrender"[1]  -define png:swap-bytes -resize x200 ../_Output_PNG_Preview/"$NameNoExt"_"$WorkspaceName"_"$Year".png
exiftool -all= -m -Keywords="$CSV_INFO" -Software="Kta2geo 1.3" -artist="sous-paris.com" ../_Output_PNG_Preview/"$NameNoExt"_"$WorkspaceName"_"$Year".png
python finder_colors.py blue ../_Output_PNG_Preview/"$NameNoExt"_"$WorkspaceName"_"$Year".png



CSV_INFO=$(echo $NameNoExt - $Year - $WorkspaceName - $JpegPoids - $WidthImage x $HeightImage px - Reso : $DPI - Poids : $JpegPoids)
echo $CSV_INFO




if [ -f ../_Output_PNG_Preview/"$NameNoExt"_"$WorkspaceName"_"$Year".png_original ]
then
rm ../_Output_PNG_Preview/"$NameNoExt"_"$WorkspaceName"_"$Year".png_original
fi
exiftool -m -keywords="$CSV_INFO" -artist="sous-paris.com" -Software="Kta2geo 1.3" "$LastrenderNoExt".jpg

mv temp.tfw "$LastrenderNoExt".wld
#proj
echo 'PROJCS["WGS_1984_Web_Mercator_Auxiliary_Sphere",GEOGCS["GCS_WGS_1984",DATUM["D_WGS_1984",SPHEROID["WGS_1984",6378137.0,298.257223563]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Mercator_Auxiliary_Sphere"],PARAMETER["False_Easting",0.0],PARAMETER["False_Northing",0.0],PARAMETER["Central_Meridian",0.0],PARAMETER["Standard_Parallel_1",0.0],PARAMETER["Auxiliary_Sphere_Type",0.0],UNIT["Meter",1.0]]' > "$LastrenderNoExt".prj

echo "$NameNoExt - $Year - $WorkspaceName - $JpegPoids - $WidthImage x $HeightImage px - Reso : $DPI - $filesizeMO - GeoTiff - Poids : $JpegPoids" >> tmp/GeoTiffList

echo "$NameNoExt - $Year - $WorkspaceName - $JpegPoids - $WidthImage x $HeightImage px - Reso : $DPI - $filesizeMO - GeoTiff - Poids : $JpegPoids" > "$LastrenderNoExt"_info.txt
zip "$LastrenderNoExt".zip "$LastrenderNoExt".jpg "$LastrenderNoExt".wld "$LastrenderNoExt".prj "$LastrenderNoExt"_info.txt
if [ -f ../_Output_wld_zip/"$LastrenderNoExt".zip ]
then
mv ../_Output_wld_zip/"$LastrenderNoExt".zip ../_TRASH_TEMP/"$FileDate"_"$LastrenderNoExt".zip
fi
mv "$LastrenderNoExt".zip ../_Output_wld_zip/
python finder_colors.py blue ../_Output_wld_zip/"$LastrenderNoExt".zip
rm "$LastrenderNoExt".jpg "$LastrenderNoExt".wld "$LastrenderNoExt".prj "$LastrenderNoExt"_info.txt
if [ -f "$LastrenderNoExt".jpg_original ]
then
rm "$LastrenderNoExt".jpg_original
fi

# Generating CSV Computed_Maps.csv
if [ -f tmp/computed_MapsTMP.csv ]
then
rm tmp/computed_MapsTMP.csv
fi

for ListGeoreferenced in ../_Output_3857/*.tif
do
exiftool "$ListGeoreferenced" | awk '/Keywords                        :/'| awk -F': ' '{print $2}' >> tmp/computed_MapsTMP.csv


done
echo "${white}---> Control bash export${orange}"
echo LayerBound=\"$LayerBound\" >> tmp/tmp_bash




source tmp/tmp_bash

echo "${bg_white}${black}---> Good Bye ! from GenerateWLD.sh${reset}"




#
