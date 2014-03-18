#!/bin/sh
for i in 1 2 3 4 5 6 7 8 9
do
    set -x
    for t in $(ls -d ../phylesystem_test/study/${i}*)
    do
        f=$(basename $t)
        # a few studies have been deleted, since phylesystem_test
        #   was created.
        if test $f != 718 -a $f != 234 -a $f != 720 -a $f != 227  -a $f != 1582
        then 
            d=study/$f
            dest=$d/${f}.json
            if ! test -f $dest
            then
                src=../phylesystem/${dest}
                cd ../phylesystem
                pwd
                python bin/refresh_nexsons_from_phylografter.py -v $f || exit
                cd -
                python bin/phylografter2hbf.py $src .tmp || exit
                mkdir -p $d || exit
                nexson_nexml.py -e 1.2 .tmp -o $dest|| exit
            fi
        fi
    done
done