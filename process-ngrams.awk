#
# Simple AWK script to process lines of the corpus and print summed instance count for each unique n-gram.
#
# NB:-
# * n-grams containing characters other than a-z and quote are ignored.  You may wish to modify the regex.
# * Assumes the input corpus is sorted.
#
{
    if ( $1 ~ /^[a-zA-Z' ]+$/ ) {
        if ( $1 == last ) {
            count+=$3
        } else if ( last != "" ) {
            print last"\t"count
            count=$3
        }
        last=$1
    }
}
END { print last"\t"count }
