#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n [a-z], e.g.: $SCRIPT 3 \"a b c\""

AZ="a b c d e f g h i j k l m n o p q r s t u v w x y z"

n=${1?$USAGE}
alpha=${2-$AZ}

for c1 in $alpha; do
for c2 in _ $AZ; do
    prefix="$c1$c2"

    echo "Fetching $prefix..."
    $(dirname $0)/get-ngrams.sh $n $prefix
done
done
