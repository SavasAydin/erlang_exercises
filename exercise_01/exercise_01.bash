#!/bin/bash

EXERCISE_FILE='exercise_01'
BEAM_DIR=$(mktemp -d)

start()
{
    [ $# -lt 2 ] && description_and_usage
    while getopts ":f:" file
    do
     	case ${file} in
     	    f)
     		verify_exercise ${OPTARG}
     		;;
     	    \?)
     		description_and_usage
     	esac
    done
}

description_and_usage()
{
    cat <<EOF

==================================================
Write a program that converts a tuple to list.
The program must have one exported function run/1

Example
==================================================
        MODULE_NAME:run({1,2,3}) returns [1,2,3].


Verification of the exercise
================================================== 
You can verify your answer using your answer file as an argument to the option f.
       bash ${EXERCISE_FILE}.bash -f ANSWER_FILE

EOF
}

verify_exercise()
{
    MODULE_NAME=$(basename ${1} .erl)
    generate_test_module ${MODULE_NAME}
    compile_and_run_test ${MODULE_NAME}
}

generate_test_module()
{

    cat > ${1}_tests.erl <<EOF
-module(${1}_tests).
-include_lib("eunit/include/eunit.hrl").

${EXERCISE_FILE}_tuple_to_list_test() ->
    ?assertEqual([1,2,3,4], ${1}:run({1,2,3,4})).
EOF
}

compile_and_run_test()
{
    compile ${MODULE_NAME}.erl 
    compile ${MODULE_NAME}_tests.erl
    pushd ${BEAM_DIR} &> /dev/null
    run_test ${MODULE_NAME}
    popd &> /dev/null
    rm -fr ${BEAM_DIR}
}

compile()
{
    erlc  -o ${BEAM_DIR} ${1} || { echo "Compilation error"  
	                           rm -fr ${BEAM_DIR}
				   exit 1; }
}

run_test()
{
    erl -noshell -eval "eunit:test(${1}, [verbose])" -s init stop > test_results
    grep -qiP '.*[T|t]est.* passed' test_results && echo "You're done!" || cat test_results
}

start ${@}


