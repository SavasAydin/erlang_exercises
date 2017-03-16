#!/bin/bash

EXERCISE_FILE='exercise_12'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that applies a given function to each element of a list.
The program must have one exported function ${EXERCISE_FILE}/2

Example
==================================================
Let the function be
	Fun = fun(X) -> X*2 end,
Then
	MODULE_NAME:${EXERCISE_FILE}(Fun, [1,2,3,4]) returns [2,4,6,8]

Verification of the exercise
==================================================
You can verify your answer using your answer file as an argument to the option f.
       bash ${EXERCISE_FILE}.bash -f ANSWER_FILE

EOF
}

generate_test_module()
{

    cat > ${1}_tests.erl <<EOF
-module(${1}_tests).
-include_lib("eunit/include/eunit.hrl").

${EXERCISE_FILE}_implement_lists_map_test() ->
    Fun = fun(X) -> X * 2 end,
    ?assertEqual([2,4,6,8], ${1}:${EXERCISE_FILE}(Fun, [1,2,3,4])).

EOF
}

Args="${@}"
start ${@}
