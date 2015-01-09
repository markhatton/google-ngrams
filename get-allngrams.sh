#!/bin/sh

usage() {
    SCRIPT="$(basename $0)"
    echo "Usage: $SCRIPT [-p <m>] [-c <corpus>] [-v <version>] n [a-z]...

Examples:
    \$ $SCRIPT -p 4 1 a b c
    will fetch corpus data using 4 parallel workers for all unigrams with prefix a, b, or c.

    \$ $SCRIPT -c ger-all -v 20090715 2
    will fetch all bigrams in the German corpus published in 2009
" >&2
    exit 2
}

AZ="a b c d e f g h i j k l m n o p q r s t u v w x y z"

parallel=
corpus=eng-all
version=20120701
while getopts ":c:p:v:" opt; do
    case $opt in
        c)
            corpus=$OPTARG
            ;;
        p)
            parallel=$OPTARG
            if [[ ! "$parallel" -gt 0 ]]; then
                echo "Invalid p value: $parallel" >&2
                usage
            fi
            ;;
        v)
            version=$OPTARG
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
shift $((OPTIND-1))

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

echo $prefixes | xargs -n 1 -I {} "$(dirname $0)/get-ngrams.sh" "$n" {} "$corpus" "$version"
