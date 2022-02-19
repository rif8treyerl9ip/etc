#!/bin/bash

# $ ./script1.sh aaa bbb ccc

echo -n '$@:'; echo $@

for i in "$@"
do
    echo "$i"
done

echo; echo '**"$@"をループさせた場合**'
for var1 in "$@" ; do
  echo $var1
done

echo '**"$*"をループさせた場合**'
for var2 in "$*" ; do
  echo $var2
done

echo; echo '**IFSを'"','"'に変更**'
IFS=','
echo -n '$@:'; echo "$@"
echo -n '$*:'; echo "$*"

# echo ; echo '-----------------------------------------'
# echo -n '$@:'; echo $@
# echo -n '$*:'; echo $*
# echo -n '$#:'; echo $#
 
# echo ; echo 'shiftコマンドの実行'
# shift
# echo -n '$@:'; echo $@
# echo -n '$*:'; echo $*
# echo -n '$#:'; echo $# # 渡されている引数の数


echo; echo '** 1～10 のループ**'
for i in {1..10}
do
    echo "$i"
done

echo; echo '** 1～10 のループ bash では下記の様な記述もできます。**'
for ((i = 0; i <= 10; i++)) {
    echo "$i"
}

# echo; echo '** 標準入力から入力が無くなるまで read コマンドで1行ずつ読み込み、処理**'
# while read line
# do
#     echo $line
# done

echo; echo '** until文は、条件が真になるまで処理をループします。下記の例は、0～9 のループ**'
i=1
until [ $i -eq 10 ]
do
    echo $i
    i=`expr $i + 1`
done

case $FILENAME in
  *.txt)  echo "Text file." ;;
  *.html) echo "HTML file." ;;
  *.sh) echo "sh file." ;;
  *)      echo "Unknwown file." ;;
esac