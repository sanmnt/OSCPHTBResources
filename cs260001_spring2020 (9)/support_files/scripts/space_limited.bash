#!/bin/bash
# $1 == where
# $2 == what

if [[ -z $1 ]]; then
    echo "usage: space where what"
    exit
fi

if [[ ! -d $1 ]]; then
    echo "usage: space where what"
    exit
fi

if [[ -z $2 ]]; then
    echo "usage: space where what"
    exit
fi

sum=0
for file in $(find $1 -iname *.$2); do
    size=$(stat -t "$file" | cut -d' ' -f2)
    sum=$(( $sum + $size ))
done

echo -n "Total Space (in bytes): "
echo $(echo "$sum / 2^30" | bc -l)

    

