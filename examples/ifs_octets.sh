#!/bin/bash -x

# http://blog.commandlinekungfu.com/2011/05/episode-146-hard-cidr.html
# "that all the commands presented today only work with 24+ bit masks"

IFS=./
while read o1 o2 o3 o4 exp; do 
    for ((i=o4; $i < $(( $o4 + 2 ** (32-$exp) )); i++)); do 
        echo $o1.$o2.$o3.$i; 
    done; 
done < input

