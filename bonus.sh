#!/bin/bash

chmod +x checker;
make -C .. bonus;
test_no_arg=("NO ARG" "sa sb ");

test_ok_0=("1" "");
test_ok_1=("1 2" "");
test_ok_2=("2 1" "sa ");
test_ok_3=("2 1" "ra ");
test_ok_4=("2 1" "rra ");
test_ok_5=("1" "sa sb ss pb ra rb rr rra rrb rrr pa ");
test_ok_6=("2147483647 -2147483648" "sa ");
test_ok_7=("1 0 4 2 3" "pb pb ra ra ra ra sb pa pa ");

test_ko_0=("2 1" "");
test_ko_1=("2 1" "sa ");
test_ko_2=("2 1" "pb ");
test_ko_3=("2 1" "pb pb ");
test_ko_4=("1 0 4 2 3" "pb pb ra ra ra ra sb pa pa sa ");

test_err_0=("" "");
test_err_1=("2 1" "sa");
test_err_2=("2 1" "sr ");
test_err_3=("two 1" "sa ");
test_err_4=("2147483648 1" "sa ");
test_err_5=("1 2147483648" "sa ");
test_err_6=("2 1 2" "sa ");

tests=(
	test_no_arg[@]
	test_ok_0[@]
	test_ok_1[@]
	test_ok_2[@]
	test_ok_3[@]
	test_ok_4[@]
	test_ok_5[@]
	test_ok_6[@]
	test_ok_7[@]
	test_ko_0[@]
	test_ko_1[@]
	test_ko_2[@]
	test_ko_3[@]
	test_ko_4[@]
	test_err_0[@]
	test_err_1[@]
	test_err_2[@]
	test_err_3[@]
	test_err_4[@]
	test_err_5[@]
	test_err_6[@]
	test_long_0[@]
);
if [ "$1" == "l" ]; then
	test_long_0=("$(./listgen/listgen 23500 0) -2 -1" "rra pb sb pa rra sa");
	tests=(test_long_0[@]);
fi

errcount=0;
for tst in "${tests[@]}"; do
	ARG=${!tst:0:1};
	IN=${!tst:1:1};
	echo -n "ARG='$ARG', IN='$(echo -n "$IN")', ";
	if [ "$ARG" == "NO ARG" ]; then
		EXPECT=$(printf "$IN" | tr ' ' '\n' | ./checker 2>&1);
		OUT=$(printf "$IN" | tr ' ' '\n' | ../checker 2>&1);
	else
		EXPECT=$(printf "$IN" | tr ' ' '\n' | ./checker "$ARG" 2>&1);
		OUT=$(printf "$IN" | tr ' ' '\n' | ../checker "$ARG" 2>&1);
	fi
	echo -n "expect='$EXPECT' ";
	if [ "$OUT" != "$EXPECT" ]; then
		errcount=$((errcount + 1));
		echo -e "\033[1;31mERROR\033[0m found $OUT";
	else
		echo -e "\033[1;32mOK\033[0m";
	fi
done

if [[ $errcount -eq 0 ]]; then
	echo -e "\033[1;32mALL OK!\033[0m";
elif [[ $errcount -eq 1 ]]; then
	echo -e "\033[1;31mONE TEST FAILED!\033[0m";
else
	echo -e "\033[1;31m${errcount} TESTS FAILED!\033[0m";
fi

