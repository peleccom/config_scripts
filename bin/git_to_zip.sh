#!/bin/sh
# Make zip archive from git project HEAD state

today=`date '+%Y_%m_%d__%H_%M_%S'`;
cd $1
git archive -o ../$1_$today.zip HEAD
cd -
