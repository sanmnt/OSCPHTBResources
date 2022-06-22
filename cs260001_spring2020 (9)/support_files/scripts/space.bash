#!/bin/bash
# $1 == where
# $2 == what
find $1 -iname \*.$2 | {
    sum=0
    while read file; do
	size=$(stat -t "$file" | rev | cut -d' ' -f15 | rev)
	sum=$(( $sum + $size ))
    done
    echo -n "Total Space (in bytes): "
    echo $(echo "$sum / 2^30" | bc -l)
}



    

