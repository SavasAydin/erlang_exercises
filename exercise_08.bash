#!/bin/bash

EXERCISE_FILE='exercise_08'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that appends a given element to a given list if element is not already present.
Your function must append the list only if the element is not in the list.
The program must have one exported function ${EXERCISE_FILE}/2

Example
==================================================
	MODULE_NAME:${EXERCISE_FILE}(b, [1,2,a])   returns [1,2,a,b]
	MODULE_NAME:${EXERCISE_FILE}(b, [1,2,a,b]) returns [1,2,a,b]
	MODULE_NAME:${EXERCISE_FILE}(2, [1,2,a,b]) returns [1,2,a,b]

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

${EXERCISE_FILE}_append_list_if_element_is_not_present_in_the_list_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:${EXERCISE_FILE}(b, [1,2,a])).

${EXERCISE_FILE}_do_not_append_list_if_element_is_present_in_the_list_01_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:${EXERCISE_FILE}(b, [1,2,a,b])).

${EXERCISE_FILE}_do_not_append_list_if_element_is_present_in_the_list_02_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:${EXERCISE_FILE}(2, [1,2,a,b])).

EOF
}

Args="${@}"
start ${@}
