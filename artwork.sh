#!/bin/zsh

# atomicparsley で m4a ファイルにイメージを添付するスクリプト
# -f をつけてフォルダをターミナルに投下する。
# フォルダ内のすべての m4a にアートワークが添付される。
#
# sh artwork.sh -f path/to/dir path/to/image.jpg
#
# もしくはフォルダのかわりに m4a ファイルそのものを指定する。
# その場合はオプションは必要ない。
#
# sh artwork.sh path/to/audio.m4a path/to/image.jpg

artwork=""; audio=""; dir=""; dir_on="off";

while [ $# -gt 0 ]
do
    case $1 in
        *.jpg) artwork="$1" ;;
        *.jpeg) artwork="$1" ;;
        *.png) artwork="$1" ;;
        *.m4a) audio="$1" ;;
        -f) shift; dir="$1" ;;
        *) break ;;
    esac
    shift
done

if [ -z "${dir}" ]; then
    if [ -z "${audio}" ]; then
        echo 'オーディオファイルかフォルダの入力が必須です。'
        exit 0
    else
        dir=`dirname "${audio}"`
        filename=`basename "${audio}"`
    fi
else
    dir_on="on"
fi

cd "${dir}"
if ! test -e 'temp'; then
    mkdir 'temp'
fi

if [ -z "${artwork}" ]; then
    echo 'アートワークの入力が必須です（jpg or png）'
    exit 0
fi

IFS_BACKUP=$IFS
IFS=$'\n'
if test "$dir_on" = 'off'; then
    atomicparsley "${audio}" --artwork "${artwork}"
    fname=`echo ${filename%.*}`
    tempfile=`echo "${fname}"'-temp-'`

    for f in $(ls .);
    do
        if echo "$f" | grep -sq "$tempfile"; then
            mv "$f" temp/"$filename"
        fi
    done
else
    for M4A in $(ls .);
    do
        ext=`echo ${M4A##*.}`
        if test "$ext" = 'm4a'; then
            filename=`basename "${M4A}"`
            fname=`echo ${filename%.*}`
            tempfile=`echo "${fname}"'-temp-'`
            atomicparsley "${M4A}" --artwork "${artwork}"
                for t in $(ls .);
                do
                    if echo "$t" | grep -sq "$tempfile"; then
                        mv "$t" temp/"$filename"
                    fi
                done
        fi
    done
fi
IFS=$IFS_BACKUP
