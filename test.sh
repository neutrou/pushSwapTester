#!/bin/bash

run_test() {
	count=100
	max=700
	mode=2
	if [ -n "$1" ]; then
		count="$1";
	fi
	if [ -n "$2" ]; then
		max="$2";
	fi
	if [ -n "$3" ]; then
		mode="$3";
	fi
	if ! [[ $count =~ ^[0-9]+$ && $max =~ ^[0-9]+$  && $max =~ ^[0-9]+$ ]]; then
		echo "expected numeric arguments"
		exit 1
	fi;

	echo "testing $count numbers with limit of $max in mode $mode"

	chmod u+x checker;
	make --silent -C ./listgen;
	make --silent -C ..;
	ARG=$(./listgen/listgen $count $mode);
	if [[ $4 -ne "no" ]]; then
		echo "ARG=$ARG";
	fi
	OUT=$(../push_swap $ARG);
	if [ "$OUT" == "" ]; then
		ops=0
		check=$(echo -n "" | ./checker $ARG);
	else
		ops=$(echo "$OUT" | wc -l);
		check=$(echo "$OUT" | ./checker $ARG);
	fi

	if [[ $ops -lt $max ]]; then
		echo -e -n "number of ops: \033[1;32m$ops\033[0m"
	else
		echo -e -n "number of ops: \033[1;31m$ops\033[0m"
	fi
	if [[ $check -eq "OK" ]]; then
		echo -e ", checker: \033[1;32mOK\033[0m"
	else
		echo -e ", checker: \033[1;31mKO\033[0m"
	fi
}

if [[ $1 -eq "a" ]]; then
	run_test 0 1 0
	run_test 1 1 0
	run_test 42 1 0
	run_test 2 1 0
	run_test 2 2 1
	run_test 3 4 1
	run_test 3 4 2
	run_test 5 13 1
	run_test 5 13 2
	run_test 100 700 1 no
	run_test 100 700 2 no
	run_test 500 5500 1 no
	run_test 500 5500 2 no
else
	run_test $1 $2 $3
fi
