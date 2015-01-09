#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n prefix [CORPUS] [VERSION], e.g.: $SCRIPT 3 aa"

n=${1?$USAGE}
prefix=${2?$USAGE}

CORPUS=${3-"eng-all"}
VERSION=${4-"20120701"}

echo "Fetching $prefix..."
URL="http://storage.googleapis.com/books/ngrams/books/googlebooks-$CORPUS-${n}gram-$VERSION-${prefix}.gz"

curl -s "$URL" | \
    gunzip | \
    awk -F'\t' -f "$(dirname $0)/process-ngrams.awk" | \
    LC_ALL=C sort | \
    bzip2 > "$CORPUS-${n}gram-$VERSION-${prefix}.csv.bz2"

