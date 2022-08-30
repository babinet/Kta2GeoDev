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
echo "${bg_green}${white}---> Hello I'm GenrateBody.sh${reset}"
echo "${white}---> I'm Generating the body for the geotif only"

source tmp/tmp_bash
source tmp/variable_invariable

DoubleQuote=$(echo \")
QUOTE="'"
echo "<div class="$QUOTE"btn-group $WorkspaceNameLowCap btn-group-xs"$QUOTE" year="$QUOTE"$Year"$QUOTE">

<div class="$QUOTE"btn btn-dark btn-xs geometry layer-selected"$QUOTE" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"$LayerHumanShortName"$QUOTE" data-placement="$QUOTE"left"$QUOTE" data-content="$QUOTE"$WKT_Map_Extent"$QUOTE"><div class="$QUOTE"position"$QUOTE">$WKT_Map_Extent</div>Emprise</div>
<div class="$QUOTE"btn btn-dark btn-xs geometry corners"$QUOTE">
<div class="$DoubleQuote"tpl"$DoubleQuote">
<div class="$DoubleQuote"loc-wkt"$DoubleQuote">
<div class="$DoubleQuote"position"$DoubleQuote">GEOMETRYCOLLECTION(POINT("$NordOuest3857"))</div><span class=$DoubleQuote"zoominfo$DoubleQuote">18</span>
<span class="$DoubleQuote"philicon-cible-UlLt"$DoubleQuote" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"Top left EPSG:3857"$QUOTE" data-content="$QUOTE"<div class="$DoubleQuote"epsg-3857"$DoubleQuote">$NordOuest3857</div><div class="$DoubleQuote"epsg-4326"$DoubleQuote">EPSG:4326 $NordOuest4326</div><div class="$DoubleQuote"epsg-27571"$DoubleQuote">EPSG:27561 $NordOuest</div>"$QUOTE"></span>
</div>
</div>
<div class="$DoubleQuote"tprght"$DoubleQuote">
<div class="$DoubleQuote"loc-wkt"$DoubleQuote">
<div class="$DoubleQuote"position"$DoubleQuote">GEOMETRYCOLLECTION(POINT("$NordEst3857"))</div><span class=$DoubleQuote"zoominfo$DoubleQuote">18</span>
<span class="$DoubleQuote"philicon-cible-UlLt"$DoubleQuote" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"Top right EPSG:3857"$QUOTE" data-content="$QUOTE"<div class="$DoubleQuote"epsg-3857"$DoubleQuote">$NordEst3857</div><div class="$DoubleQuote"epsg-4326"$DoubleQuote">EPSG:4326 $NordEst4326</div><div class="$DoubleQuote"epsg-27571"$DoubleQuote">EPSG:27561 $NordEst</div>"$QUOTE"></span>
</div>
</div>
<div class="$DoubleQuote"coin"$DoubleQuote">Corners</div>
<div class="$DoubleQuote"btmlft"$DoubleQuote">
<div class="$DoubleQuote"loc-wkt"$DoubleQuote">
<div class="$DoubleQuote"position"$DoubleQuote">GEOMETRYCOLLECTION(POINT("$SudOuest3857"))</div><span class=$DoubleQuote"zoominfo$DoubleQuote">18</span>
<span class="$DoubleQuote"philicon-cible-UlLt"$DoubleQuote" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"Bottom left EPSG:3857"$QUOTE" data-content="$QUOTE"<div class="$DoubleQuote"epsg-3857"$DoubleQuote">$SudOuest3857</div><div class="$DoubleQuote"epsg-4326"$DoubleQuote">EPSG:4326 $SudOuest4326</div><div class="$DoubleQuote"epsg-27571"$DoubleQuote">EPSG:27561 $SudOuest</div>"$QUOTE"></span>
</div>
</div>
<div class="$DoubleQuote"btmrght"$DoubleQuote">
<div class="$DoubleQuote"loc-wkt"$DoubleQuote">
<div class="$DoubleQuote"position"$DoubleQuote">GEOMETRYCOLLECTION(POINT("$SudEst3857"))</div><span class=$DoubleQuote"zoominfo$DoubleQuote">18</span>
<span class="$DoubleQuote"philicon-cible-UlLt"$DoubleQuote" data-toggle="$QUOTE"popover"$QUOTE" data-original-title="$QUOTE"Bottom right EPSG:3857"$QUOTE" data-content="$QUOTE"<div class="$DoubleQuote"epsg-3857"$DoubleQuote">$SudEst3857</div><div class="$DoubleQuote"epsg-4326"$DoubleQuote">EPSG:4326 $SudEst4326</div><div class="$DoubleQuote"epsg-27571"$DoubleQuote">EPSG:27561 $SudEst</div>"$QUOTE"></span>
</div>
</div>
</div>
<div class="$QUOTE"btn btn-dark btn-xs showlayer"$QUOTE" data-img="$QUOTE"$PNGHTTP"$QUOTE" data-original-title="$QUOTE""$ShortTitleHeader""$QUOTE" data-toggle="$QUOTE"popover"$QUOTE" layer="$QUOTE"add_planche$NomMachine"$QUOTE" addlayertolist="$QUOTE"$TiffPrivatePath"$QUOTE">Voir</div>
<div class="$QUOTE"btn btn-dark btn-xs hidelayer"$QUOTE" layer="$QUOTE"planche_"$NomMachine"_rm"$QUOTE" removelayerfromlist="$DoubleQuote"$TiffPrivatePath"$DoubleQuote">Cacher</div>
<a class="$QUOTE"btn btn-dark btn-xs download-tif"$QUOTE" href="$QUOTE"$TiffHTTP"$QUOTE" data-toggle="$QUOTE"tooltip"$QUOTE" data-original-title="$QUOTE"$LayerHumanTitle"$QUOTE">$LayerHumanShortName<span class="$QUOTE"glyphicon glyphicon-download-alt"$QUOTE"></span></a>
<a class="$QUOTE"btn btn-dark btn-xs download-zip"$QUOTE" href="$QUOTE"$ZipHTTP"$QUOTE" data-toggle="$QUOTE"tooltip"$QUOTE" data-original-title="$QUOTE"$TheZipNameTooltip"$QUOTE">$LayerHumanShortName .WLD + .PRJ<span class="$QUOTE"glyphicon glyphicon-download-alt"$QUOTE"></span></a>
</div>" |tr -d '\n' > tmp/NewLayers/TheCureentNodeBody.csv






echo "body=\$(cat tmp/NewLayers/TheCureentNodeBody.csv)">>tmp/tmp_bash




source tmp/tmp_bash

echo "${bg_white}${black}---> Good Bye ! from GenrateBody.sh${reset}"


#doublequote='"'
#echo $purple SudEst27561 $SudEst27561
#echo "<div class='btn-group $WorkspaceNameLowCap btn-group-xs' year='$Year'>
#
#<div class='btn btn-dark btn-xs geometry layer-selected' data-toggle='popover' data-original-title='$LayerHumanShortName' data-placement='left' data-content='$WKT_Map_Extent'><div class='position'>$WKT_Map_Extent</div>Emprise</div>
#<div class='btn btn-dark btn-xs geometry corners'>
#<div class='tpl'>
#<div class='loc-wkt'>
#<div class='position'>GEOMETRYCOLLECTION(POINT("$NordOuest3857"))</div><span class=$'zoominfo'>18</span>
#<span class='philicon-cible-UlLt' data-toggle='popover' data-original-title='Top left EPSG:3857' data-content='<div class='epsg-3857'>$NordOuest3857</div><div class='epsg-4326'>EPSG:4326 $NordOuest4326</div><div class='epsg-27571'>EPSG:27561 $NordOuest</div>'></span>
#</div>
#</div>
#<div class='tprght'>
#<div class='loc-wkt'>
#<div class='position'>GEOMETRYCOLLECTION(POINT("$NordEst3857"))</div><span class=$'zoominfo'>18</span>
#<span class='philicon-cible-UlLt' data-toggle='popover' data-original-title='Top right EPSG:3857' data-content='<div class='epsg-3857'>$NordEst3857</div><div class='epsg-4326'>EPSG:4326 $NordEst4326</div><div class='epsg-27571'>EPSG:27561 $NordEst</div>'></span>
#</div>
#</div>
#<div class='coin'>Corners</div>
#<div class='btmlft'>
#<div class='loc-wkt'>
#<div class='position'>GEOMETRYCOLLECTION(POINT("$SudOuest3857"))</div><span class=$'zoominfo'>18</span>
#<span class='philicon-cible-UlLt' data-toggle='popover' data-original-title='Bottom left EPSG:3857' data-content='<div class='epsg-3857'>$SudOuest3857</div><div class='epsg-4326'>EPSG:4326 $SudOuest4326</div><div class='epsg-27571'>EPSG:27561 $SudOuest</div>'></span>
#</div>
#</div>
#<div class='btmrght'>
#<div class='loc-wkt'>
#<div class='position'>GEOMETRYCOLLECTION(POINT("$SudEst3857"))</div><span class=$'zoominfo'>18</span>
#<span class='philicon-cible-UlLt' data-toggle='popover' data-original-title='Bottom right EPSG:3857' data-content=$doublequote<div class='epsg-3857'>$SudEst3857</div><div class='epsg-4326'>EPSG:4326 $SudEst4326</div><div class='epsg-27571'>EPSG:27561 $SudEst27561</div>$doublequote></span>
#</div>
#</div>
#</div>
#<div class='btn btn-dark btn-xs showlayer' data-img='$PNGHTTP' data-original-title='$ShortTitleHeader' data-toggle='popover' layer='add_planche$NomMachine' addlayertolist='$TiffPrivatePath'>Voir</div>
#<div class='btn btn-dark btn-xs hidelayer' layer='planche_"$NomMachine"_rm' removelayerfromlist='$TiffPrivatePath'>Cacher</div>
#<a class='btn btn-dark btn-xs download-tif' href='$TiffHTTP' data-toggle='tooltip' data-original-title='$LayerHumanTitle'>$LayerHumanShortName<span class='glyphicon glyphicon-download-alt'></span></a>
#<a class='btn btn-dark btn-xs download-zip' href='$ZipHTTP' data-toggle='tooltip' data-original-title='$TheZipNameTooltip'>$LayerHumanShortName .WLD + .PRJ<span class='glyphicon glyphicon-download-alt'></span></a>
#</div>" |tr -d '\n' > tmp/NewLayers/TheCureentNodeBody.csv
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#echo "body=\$(cat tmp/NewLayers/TheCureentNodeBody.csv)">>tmp/tmp_bash
#
#
#
#
#
#
#
#source tmp/tmp_bash
#
#echo "${bg_white}${black}---> Good Bye ! from GenrateBody.sh${reset}"
