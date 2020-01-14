startpoint="$(pwd)/images"
cd "$startpoint"

find . -type d | while read foldername; do
    echo "$foldername"
    cd "$foldername"
    for filename in *.jpg; do
        echo "Compresing $foldername/$filename"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "ORIGINAL_$filename" | grep -q 'jpeg' ) && convert "ORIGINAL_$filename" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename" )
    done;
    
    for filename in *.jpeg; do
        echo "Compressing $foldername/$filename"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "ORIGINAL_$filename" | grep -q 'jpeg' ) && convert "ORIGINAL_$filename" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename" )
    done;
    for filename in *.JPG; do
        echo "Compressing $foldername/$filename"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "ORIGINAL_$filename" | grep -q 'jpeg' ) && convert "ORIGINAL_$filename" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename" )
    done;
    for filename in *.JPEG; do
        echo "Compressing $foldername/$filename"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "ORIGINAL_$filename" | grep -q 'jpeg' ) && convert "ORIGINAL_$filename" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename" )
    done;





    for filename in *.png; do
        echo "$foldername/$filename"
        convert "$filename" "$filename.jpg"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "$filename.jpg" | grep -q 'jpeg' ) && convert "$filename.jpg" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename.jpg" ) 
        rename -v .png.jpg .jpg *.png.jpg
    done;
    for filename in *.PNG; do
        echo "$foldername/$filename"
        convert "$filename" "$filename.jpg"
        mv "$filename" "ORIGINAL_$filename"
        $( $( file -b --mime-type "$filename.jpg" | grep -q 'jpeg' ) && convert "$filename.jpg" -resize '1260x>' -resize 'x1260>'  -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB "$filename.jpg" )
        rename -v .png.jpg .jpg *.png.jpg
    done;
    cd $startpoint  
done






# find * -type f | while read filename; do
#     # echo $filename | cut -c 3-
#     basename $filename
#     # cp
#     # mkdir -p ../compresed/$filename && rmdir ../compresed/$filename
#     # $( file -b --mime-type $filename | grep -q 'png' ) && pngquant --force --quality=40-50 --skip-if-larger --strip --verbose "$filename" --output ../compresed/"$filename"
#     # convert "$filename" -sampling-factor 4:2:0 -strip -quality 45 -interlace JPEG -colorspace RGB ../compresed/"$filename"
# done


# for filename in *.jpg; do mv "$filename" "ORIGINAL_$filename"; done;




# for filename in $(find . -type f -name "*.jpg"); do mv "$filename" "ORIGINAL_$filename"; done;
