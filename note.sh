PATH_NOTE=.myNote.txt

function addNote()
{
    n=`cat $PATH_NOTE | wc -l`
    ((n++))
    echo "$n : $toAdd" >> $PATH_NOTE
    stampaNote
}

function removeNote()
{
    `sed -i /^${toDel}/d $PATH_NOTE`
    resetN
    stampaNote
}

function resetN()
{
    n=1
    >.tempNote
    while read line; do
    # reading each line
    echo "$n : ${line:4}" >> .tempNote
    n=$((n+1))
    done < $PATH_NOTE
    cat .tempNote > $PATH_NOTE
}

function stampaNote()
{
    cat $PATH_NOTE
}

while getopts a:r:f: flag
do
    case "${flag}" in
        a)  str="$@"
            toAdd="${str:3}"
            addNote
            ;;
        r)  str="$@"
            toDel="${str:3}"
            removeNote
            ;;
        f)  resetN
            ;;
    esac
done

