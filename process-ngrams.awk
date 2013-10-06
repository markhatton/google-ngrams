{
    if ( $1 == last ) {
        count+=$3
    } else if ( last != "" ) {
        print last"\t"count
        count=$3
    }
    last=$1
}
