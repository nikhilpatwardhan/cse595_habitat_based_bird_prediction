#!/bin/sh
# Script to check the aspect ratio of .jpg files and resize them
# Resizing is done only if the aspect ratio is within 1.333 +- 10%
# New file is saved in the folder specified as second argument
# Sample usage:
# sh scaleScript.sh $PWD/inputfolder $PWD/outputfolder
# Note that there is no / after inputfolder or outputfolder

for filename in $1/*.jpg
do
	width=0;
	height=0;
	width=`identify -format "%[fx:w]" "$filename"`
	height=`identify -format "%[fx:h]" "$filename"`
	ratio=`echo "scale=3;$width/$height" | bc`
	lowerbound=`echo "1.25" | bc`
	upperbound=`echo "1.52" | bc`
	
#	echo "Dimensions: $width x $height"

	if [ $(echo "$ratio >= $lowerbound" | bc) -eq 1 ] 
	then
		if [ $(echo "$ratio <= $upperbound" | bc) -eq 1 ]
		then
			if [ $width -ge 400 -a $height -ge 300 ]
			then # echo "File is good."
				echo "processing $filename";
				newfilename=`echo ${filename##*/}`
				convert "$filename" -resize 400x300 "${2}/${newfilename}_filtered.jpg"
			fi
	#	else echo "File is bad."
		fi
	#else echo "File is bad."
	fi

	# echo "$lowerbound $upperbound"
done;
