google-ngrams
=============

Shell scripts to assist downloading &amp; processing the Google Books n-grams corpora v2: http://storage.googleapis.com/books/ngrams/books/datasetsv2.html

### Example usage

    ./get-allngrams.sh 3

Will download the complete English Google Books trigrams corpus sequentially and output bzip'ed tab separated files named `3gram-??.csv.bz2`.  The file contents will be of the form:

    Abundant supplies of    1276
    Abundant supplies were  111
    Abundant supply of  540
    Abundant testimony exists   43

Where:
- Each n-gram precedes a TAB character
- The value following TAB is the match count (instance count) of each n-gram *summed* across all years.  (The page count and volume count values in the corpus are discarded)
- The output file is sorted by the n-gram's ASCII value
- Only n-grams matching the pattern defined in `get-ngrams.sh` will be included, all others will be discarded.  The hard-coded pattern is all n-grams matching `[A-Za-z' ]+`, i.e. only terms containing alphabetical characters and the apostrophe character.  You may wish to modify this pattern to, e.g. include accented characters or numerals.

To download a subset of the corpus:

    ./get-allngrams 3 "a b c"

Will download only trigrams beginning with the letters A, B, C.

Or:

    ./get-ngrams 4 ab

Will download only 4-grams beginning with the literal "ab".

### Notes

The dataset is processed using a simple `awk` one-liner in `get-ngrams.sh`.  You may wish to edit this in order to modify the output format or apply alternate calculations.

`LC_ALL=C` locale is used for the grep statement applying the filter.  This vastly improves the performance (and avoids the script becoming CPU bound) but somewhat precludes the handling of multibyte UTF-8 characters.
