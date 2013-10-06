#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n [a-z], e.g.: $SCRIPT 3 \"a b c\""

AZ="a b c d e f g h i j k l m n o p q r s t u v w x y z"

n=${1?$USAGE}
c1s=${2-$AZ}
c2s="_ $AZ"

[[ $n -eq 1 ]] && c2s="n/a"

for c1 in $c1s; do
for c2 in $c2s; do
    prefix="$c1$c2"
    [[ $n -eq 1 ]] && prefix=$c1

    echo "Fetching $prefix..."
    $(dirname $0)/get-ngrams.sh $n $prefix
done
done
