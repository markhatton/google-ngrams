#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n, e.g.: $SCRIPT 3"

n=${1?$USAGE}

AZ="a b c d e f g h i j k l m n o p q r s t u v w x y z"

if [[ "$n" -gt 1 ]]; then
    c2s="_ $AZ"
else
    c2s="_"
fi

for c1 in $AZ; do
for c2 in $c2s; do
    prefix="$c1$c2"
    [[ $n -eq 1 ]] && prefix=$c1
    bzcat ${n}gram-${prefix}.csv.bz2
done
done
