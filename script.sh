#!/bin/bash
# set -e
clear
imgFolder="images"
logFile="error.log"

maxHeight="1260" #In pixel
maxWidth="1260" #In pixel

#Convert variables
imgFolder="$(pwd)/$imgFolder"
logFile="$(pwd)/$logFile"
maxHeight="'""$maxHeight""x>'"
maxHeight="'x""$maxWidth"">'"


function checkJpegtype {
    $( file -b --mime-type "$1" | grep -q 'jpeg' )
    if [  $? == "0" ]; then
        echo "File: $1 is type is JPG"
    else
        false
    fi
}

function checkPngtype {
    $( file -b --mime-type "$1" | grep -q 'png' )
    if [  $? == "0" ]; then
        echo "File: $1 is type is PNG"
    else
        false
    fi
}

function convertPngToJpeg {
    convert "ORIGINAL_$1" "$1.jpg"
    rename -v .png.jpg .jpg *.png.jpg
}

function makeBackUp {
    echo "Making BackUp of $1"
    mv "$1" "ORIGINAL_$1"
}

function restoreBackUp {
    mv "ORIGINAL_$1" "$1"
}

function makeLog {
    echo "Error, is been saved in $logFile"
    date >> "$logFile"
    fileType=$( file -b --mime-type "$1" )

    echo  "$1 -> Type is $fileType is NOT valid" >> "$logFile"
}

function dontDuplicate {
    ( ls "ORIGINAL_$1" 2>/dev/null ) || ( ls "$1" 2>/dev/null | grep -e "ORIGINAL_")
}

function compressImg {
    dontDuplicate "$1"
    if [ $? == "1" ]; then
        checkJpegtype "$1"
        if [ $? == "0" ]; then
            { # Try 
                makeBackUp "$1"
                echo "Compressing $folderName/$fileName"
                convert "ORIGINAL_$1" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$1"
                echo "Done!"
            } || { #Catch
                restoreBackUp "$1"
            }
        else
            checkPngtype "$1"
            if [ $? == "0" ]; then
            { # Try 
                makeBackUp "$1"
                convertPngToJpeg "$1"
            } || { #Catch
                restoreBackUp "$1"
            }
            else
                makeLog "$1"
            fi 
        fi        
    else
        echo "Original file exist"
    fi
}


#Starting point
cd "$imgFolder"
totalFiles=$( find . -type f | wc -l )
originalSize=$( du -B 1 . | cut -f1 )
iteration='1'
find "$imgFolder" -type d | while read folderName; do
    cd "$folderName"
    for fileName in *; do
        echo " "
        echo "Progress: $iteration out of $totalFiles"
        echo "Trying $folderName/$fileName"
        compressImg "$fileName";
        ((iteration++))
    done;
    cd $imgFolder
done
finalSize=$( du -B 1 . | cut -f1 )
totalSave=$((finalSize-originalSize))
totalSave=$( echo "$totalSave/1024" | bc -l)
totalSave=$( echo "$totalSave/1024" | bc -l)
echo "Total save: $totalSave MB"