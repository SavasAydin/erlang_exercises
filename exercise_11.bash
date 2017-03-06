#!/bin/bash

EXERCISE_FILE='exercise_11'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that finds the index of last occurrence of an element in a list.
If the element is not in the list, the function returns element_not_found.
The program must have one exported function ${EXERCISE_FILE}/2

Example
==================================================
	MODULE_NAME:${EXERCISE_FILE}(b, [1,2,a,b,c]) returns 4
	MODULE_NAME:${EXERCISE_FILE}(3, [1,3,2,4,3]) returns 5
	MODULE_NAME:${EXERCISE_FILE}(5, [1,3,2,4,3]) returns element_not_found

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

${EXERCISE_FILE}_get_index_of_last_occurrence_of_an_element_in_a_list_01_test() ->
    ?assertEqual(4, erlang_exercises:${EXERCISE_FILE}(b, [1,2,a,b,c])).

${EXERCISE_FILE}_get_index_of_last_occurrence_of_an_element_in_a_list_02_test() ->
    ?assertEqual(5, erlang_exercises:${EXERCISE_FILE}(3, [1,3,2,4,3])).

${EXERCISE_FILE}_returns_not_found_if_an_element_is_not_in_a_list_test() ->
    ?assertEqual(element_not_found, erlang_exercises:${EXERCISE_FILE}(5, [1,3,2,4,3])).

EOF
}

Args="${@}"
start ${@}
