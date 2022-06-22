#!/bin/bash
##############################################################################
#
# Randomly pick a BroncoName and extract last name from about file.
#
##############################################################################
STUDENT_DIR=/home/gershman/data/instruction/cal_poly_pomona/CS_2600/2018_fall/students

NUM_STUDENTS=$(ls -1d $STUDENT_DIR/[a-z]* | wc -l)
RANDOM_NUM=$(($RANDOM % $NUM_STUDENTS + 1))
#echo "RN=$RANDOM_NUM; NS=$NUM_STUDENTS"
FULL_BPATH=$(ls -1d $STUDENT_DIR/[a-z]* | head -n $RANDOM_NUM | tail -n 1)
BRONCONAME=$(basename $FULL_BPATH)

head -n 4 $STUDENT_DIR/$BRONCONAME/about | tail -n 1 | cut -d',' -f1



