#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n prefix, e.g.: $SCRIPT 3 aa"

n=${1?$USAGE}
prefix=${2?$USAGE}

BASEURL="http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all"
PUBDATE="20120701"

echo "Fetching $prefix..."

curl -s "$BASEURL-${n}gram-$PUBDATE-${prefix}.gz" | \
    gunzip | \
    awk -F'\t' -f "$(dirname $0)/process-ngrams.awk" | \
    LC_ALL=C sort | \
    bzip2 > ${n}gram-${prefix}.csv.bz2

