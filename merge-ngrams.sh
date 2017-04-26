#!/bin/bash

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n [CORPUS] [VERSION], e.g.: $SCRIPT 3"

source "$(dirname $0)/common.sh"

n=${1?$USAGE}

CORPUS=${2-$CORPUS}
VERSION=${3-$VERSION}

if [[ "$n" -gt 1 ]]; then
    c2s="_ $AZ"
else
    c2s="_"
fi

for c1 in $AZ; do
for c2 in $c2s; do
    prefix="$c1$c2"
    [[ $n -eq 1 ]] && prefix=$c1
    bzcat "$CORPUS-${n}gram-$VERSION-${prefix}.csv.bz2"
done
done
