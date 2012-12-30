#!/bin/sh

####################################################
#  Original author for vim backup manager script:  #
#                  Ari Simonen                     #
####################################################

DIR="/home/niko/.vim-backup"

# How old files we want to remove?
THISOLD=$((`date +%m` - 1))

# How many versions we want to keep?
VERSIONCOUNT=5

LOGFILE="$DIR/removelog_`date +%y%m%d`-`date +%H%M`"
FILUT=`ls $DIR|sed "s/\(.*\)_\([0-9]\{6\}\)-\([0-9]\{4\}\)/\\1/"|sort|uniq`
echo `ls $DIR` > $LOGFILE
for i in $FILUT; do
    COUNT=`ls $DIR/$i*|wc -l`
    if [ $COUNT -gt $VERSIONCOUNT ]; then
        GTFO=`ls $DIR/$i*|sort`
        for j in $GTFO; do
            MM=`echo $j|sed "s/\(.*\)_\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)-\([0-9]\{4\}\)/\\3/"`
            if [ $MM -lt $THISOLD -a $COUNT -gt $VERSIONCOUNT ]; then
                echo "let me remove $j for you" > $LOGFILE
                /bin/rm $j
            fi
            COUNT=$(($COUNT - 1))
        done
    fi
done
