#!/bin/sh

usage() {
    SCRIPT="$(basename $0)"
    echo "Usage: $SCRIPT [-p m] n [a-z]...

e.g.: $SCRIPT -p 4 1 a b c
      will fetch data using 4 parallel workers for all _uni_grams with prefix a, b, or c." >&2
    exit 2
}

AZ="a b c d e f g h i j k l m n o p q r s t u v w x y z"

parallel=
while getopts ":p:" opt; do
    case $opt in
        p)
            parallel=$OPTARG
            shift
            shift
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

[[ $# -lt 1 ]] && usage

n=$1
shift
c1s=${*-$AZ}

if [[ "$n" -lt 1 || "$n" -gt 5 ]]; then
    echo "Invalid n value: $n" >&2
    usage
elif [[ "$n" -gt 1 ]]; then
    c2s="_ $AZ"
else
    c2s="_"
fi

prefixes=""
for c1 in $c1s; do
for c2 in $c2s; do
    prefix="$c1$c2"
    [[ $n -eq 1 ]] && prefix=$c1
    prefixes="$prefixes $prefix"
done
done

if [[ -n "$parallel" ]]; then
    alias xargs="parallel -j${parallel} --trim lr -ud ' '"
fi

echo $prefixes | xargs -n 1 -I {} "$(dirname $0)/get-ngrams.sh" "$n" {}
