#!/bin/bash

EXERCISE_FILE='exercise_09'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that subtracts nth element of the given list.
If length of the list is smaller than given n, the function returns the list intact.
The program must have one exported function ${EXERCISE_FILE}/2

Example
==================================================
        MODULE_NAME:${EXERCISE_FILE}(1, [a])           returns []
        MODULE_NAME:${EXERCISE_FILE}(4, [a,b,c,d,e,f]) returns [a,b,c,e,f]
        MODULE_NAME:${EXERCISE_FILE}(3, [a])           returns [a]
        MODULE_NAME:${EXERCISE_FILE}(2, [])            returns []

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

${EXERCISE_FILE}_subtract_first_element_in_given_list_test() ->
    ?assertEqual([], erlang_exercises:${EXERCISE_FILE}(1, [a])).

${EXERCISE_FILE}_subtract_nth_element_in_given_list_test() ->
    ?assertEqual([a,b,c,e,f], erlang_exercises:${EXERCISE_FILE}(4, [a,b,c,d,e,f])).

${EXERCISE_FILE}_do_not_subtract_nth_element_if_length_of_the_list_is_smaller_than_n_test() ->
    ?assertEqual([a], erlang_exercises:${EXERCISE_FILE}(3, [a])).

${EXERCISE_FILE}_do_not_subtract_if_list_is_empty_test() ->
    ?assertEqual([], erlang_exercises:${EXERCISE_FILE}(2, [])).

EOF
}

Args="${@}"
start ${@}
