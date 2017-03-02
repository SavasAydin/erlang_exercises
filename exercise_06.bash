#!/bin/bash

EXERCISE_FILE='exercise_06'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that counts occurrences of character in string.
The program must have one exported function ${EXERCISE_FILE}/2

Example
==================================================
        MODULE_NAME:${EXERCISE_FILE}(\$s, "savas is a palindrome") returns 3
        MODULE_NAME:${EXERCISE_FILE}(\$z, "savas is a palindrome") returns 0

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

${EXERCISE_FILE}_count_occurrences_of_a_char_in_a_string_test() ->
    ?assertEqual(3, erlang_exercises:${EXERCISE_FILE}(\$s, "savas is a palindrome")).

${EXERCISE_FILE}_returns_0_if_a_char_does_not_appaer_in_a_string_test() ->
    ?assertEqual(0, erlang_exercises:${EXERCISE_FILE}(\$z, "savas is a palindrome")).

EOF
}

Args="${@}"
start ${@}
