#!/bin/bash

EXERCISE_FILE='exercise_05'

CURRENT_DIR=$(dirname ${0})
source ${CURRENT_DIR}/engine.bash

description_and_usage()
{
    cat <<EOF
==================================================
Write a program that finds palindrome words in a given text.
The program must have one exported function ${EXERCISE_FILE}/1

Example
==================================================
        MODULE_NAME:${EXERCISE_FILE}("savas is a palindrome") returns ["savas", "a"]

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

${EXERCISE_FILE}_find_palindrome_words_in_a_given_text_test() ->
    ?assertEqual(["savas", "a"], ${1}:${EXERCISE_FILE}("savas is a palindrome")).

EOF
}

Args="${@}"
start ${@}
