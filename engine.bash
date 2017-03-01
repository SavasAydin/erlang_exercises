#!/bin/bash

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

verify_exercise()
{
    MODULE_NAME=$(basename ${1} .erl)
    generate_test_module ${MODULE_NAME}
    compile_and_run_test ${1}
}

compile_and_run_test()
{
    BEAM_DIR=$(mktemp -d)    
    compile ${BEAM_DIR} ${1}.erl 
    compile ${BEAM_DIR} ${MODULE_NAME}_tests.erl
    pushd ${BEAM_DIR} &> /dev/null
    run_test ${MODULE_NAME}
    popd &> /dev/null
    rm -fr ${BEAM_DIR}
    rm ${MODULE_NAME}_tests.erl
}

compile()
{
    erlc  -o ${1} ${2} || error ${1}
}

error()
{
    echo "Compilation error"  
    rm -fr ${1}
    rm -fr ${MODULE_NAME}_tests.erl
    exit 1
}
run_test()
{
    erl -noshell -eval "eunit:test(${1}, [verbose])" -s init stop > test_results
    grep -qiE '.*[T|t]est.* passed' test_results && echo "You're done!" || cat test_results
}
