#!/bin/bash

count=100
max=700
if [ -n "$1" ]; then
	count="$1";
fi
if [ -n "$2" ]; then
	max="$2";
fi
if ! [[ $count =~ ^[0-9]+$ && $max =~ ^[0-9]+$ ]]; then
	echo "expected numeric arguments"
	exit 1
fi;

chmod u+x checker;
make --silent -C ./listgen;
make --silent -C ..;
if [[ $? -ne 0 ]]; then
	echo -e "\033[1;31mCompilation failed\033[0m"
	exit 1
fi

echo "testing $count random numbers with limit of $max"

ops=0;
ok="OK";
fmax=0;
fmin=$max;
num=0;
sum=0;
ARG="no args";
while [ $ops -lt $max ] && [ $ok == "OK" ]
do
	if [[ $num -gt 0 ]]; then
		echo -ne "\033[1;33m$num: average=$((sum / num)), min=$fmin, max=$fmax\033[0m"
	fi
	RAN=$(od -A n -t u -N 4 /dev/urandom | tr -d ' ');
	ARG=$(./listgen/listgen $count 2 $RAN);
	OUT=$(../push_swap $ARG);
	ops=$(echo "$OUT" | wc -l);
	ok=$(echo "$OUT" | ./checker $ARG);
	echo -e '\r' "number of ops: $ops $ok                      ";
	num=$((num + 1))
	sum=$((sum + ops))
	[[ $ops -lt $fmin ]] && fmin=$ops;
	[[ $ops -gt $fmax ]] && fmax=$ops;
done
echo "$ARG";

