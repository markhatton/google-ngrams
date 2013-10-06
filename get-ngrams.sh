#!/bin/sh

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n prefix, e.g.: $SCRIPT 3 aa"

n=${1?$USAGE}
prefix=${2?$USAGE}

FILTER_PATTERN="[a-zA-Z' ]\+.[0-9][0-9][0-9][0-9].[0-9]\+.[0-9]\+"

BASEURL="http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all"
PUBDATE="20120701"

echo "Fetching $prefix..."

curl -s "$BASEURL-${n}gram-$PUBDATE-${prefix}.gz" | \
    gunzip | \
    LC_ALL=C grep -x "$FILTER_PATTERN" | \
    awk -F'\t' '{ if ($1 == last) { count+=$3 } else if (last != "") { print last"\t"count; count=$3 }; last=$1 }' | \
    LC_ALL=C sort | \
    bzip2 > ${n}gram-${prefix}.csv.bz2

