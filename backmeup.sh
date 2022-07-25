#!/bin/bash

#get input
while getopts 'd:w:' OPTION; do
  case "$OPTION" in
    d) domain=$OPTARG
       echo "The domain provided is $OPTARG" ;;
    w) keywords=($OPTARG)
       IFS=,
       echo "The keywords provided are $OPTARG" ;;
    ?) echo "script usage: $(basename \$0) [-d somevalue] [-w somevalue]" >&2 
       exit 1 ;;
  esac
done

echo $domain >> $domain.txt
for w in ${keywords[@]};do echo $w >> $domain.txt;done

#handle the domainname
a=`echo $domain | awk -F "." '{print $1}'`
b=`echo $domain | awk -F "." '{print $2}'`
c=`echo $domain | awk -F "." '{print $3}'`
ab=`echo $domain | awk -F "." '{print $1$2}'`
bc=`echo $domain | awk -F "." '{print $2$3}'`
cd=`echo $domain | awk -F "." '{print $3$4}'`
abc=`echo $domain | awk -F "." '{print $1$2$3}'`
abcd=`echo $domain | awk -F "." '{print $1$2$3$4}'`
bdotc=`echo $domain | awk -F "." '{print $2"'\.'"$3}'`
cdotd=`echo $domain | awk -F "." '{print $3"'\.'"$4}'`
adotbdotc=`echo $domain | awk -F "." '{print $2"'\.'"$3"'\.'"$4}'`

#year+month
for y in 2019 2020 2021 2022
do
    for m in 01 02 03 04 05 06 07 08 09 10 11 12
    do echo $y$m >> $domain.txt 
    done
done

#arrays 
base_array=($domain ${keywords[@]} $a $b $c $ab $bc $cd $abc $abcd $bdotc $cdotd $adotbdotc)
suffix_array=(0 1 2 3 4 5 6 7 8 9 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 000 0000 00000 000000 001 002 003 004 005 006 007 008 009 010 11 111 1111 11111 111111 22 33 66 666 6666 666666 88 888 8888 $y$m "备份" "bak" "bakup" "backup")

for suffix in "${suffix_array[@]}"
do
    for base in "${base_array[@]}"
    do
    echo $base$suffix >> $domain.txt
    done
done
echo "wordlist generated successfully to "$domain".txt"
echo "possible backup suffixes: rar,zip,7z,tar,gz,tar,gz,bz2,tar.bz2,sql,bak,dat,txt,log,mdb,old"
