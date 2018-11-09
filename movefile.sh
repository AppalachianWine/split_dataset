#!/bin/bash

trainPath="/home/dukang/imagenet/examples/imagenet/imagenet/train/"
validationPath="/home/dukang/imagenet/examples/imagenet/imagenet/val/"

trainDirList=`ls $trainPath`


for DirName in $trainDirList
do
    cd $trainPath/$DirName

    dirNum=`ls -l|grep "^-"|wc -l`
    picList=`ls *.jpg`
    k=0
    for fileName in $picList
    do
        fileNameArr[k]=$fileName
        k=$k+1
    done

    arr=($(seq 1 $dirNum))
    num=${#arr[*]}

    let filterNum=$num*1/3

    res=${arr[$(($RANDOM%num))]}
    fileArr[1]=$res
    let i=2

    while(( i<=filterNum ));
    do
        res=${arr[$(($RANDOM%num))]}
        fileArr[i]=$res
        for((j=1;j<i;j++));
        do
        numJ=${fileArr[j]}
        if [[ $res == $numJ ]]; then
            unset fileArr[i]
            i=$i-1
            break
        fi
        done
        i=$i+1
    done

    cd $validationPath
#    mkdir $DirName
    for((indexNum=0;indexNum<$filterNum;indexNum++))
    do
        echo ${fileNameArr[fileArr[indexNum]-1]}
        mv $trainPath/$DirName/${fileNameArr[fileArr[indexNum]-1]} $validationPath/$DirName
    done
    echo "done."
done
