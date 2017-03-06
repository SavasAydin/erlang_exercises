#!/bin/bash

EXERCISE_FILE='exercise_01'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF

==================================================
Write a program that converts a tuple to list.
The program must have one exported function ${EXERCISE_FILE}/1

Example
==================================================
	MODULE_NAME:${EXERCISE_FILE}({1,2,3}) returns [1,2,3].


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

${EXERCISE_FILE}_tuple_to_list_test() ->
    ?assertEqual([1,2,3,4], ${1}:${EXERCISE_FILE}({1,2,3,4})).
EOF
}

Args="${@}"
start ${@}
