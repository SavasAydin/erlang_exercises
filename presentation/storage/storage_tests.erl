-module(storage_tests).
-include_lib("eunit/include/eunit.hrl").

create_a_new_storage_test() ->
    Res = storage:new(),
    Expected = [],
    ?assertEqual(Expected, Res).

add_key_value_pair_into_a_new_storage_test() ->
    Key = key_1,
    Value = value_1,
    Storage = storage:new(),
    Res = storage:add(Key, Value, Storage),
    Expected = [{key_1, value_1}],
    ?assertEqual(Expected, Res).

add_key_value_pair_into_already_existing_storage_test() ->
    Key = key_2,
    Value = value_2,
    Storage = [{key_1, value_1}],
    Res = storage:add(Key, Value, Storage),
    Expected = [{key_2, value_2}, 
                {key_1, value_1}],
    ?assertEqual(Expected, Res).

removes_the_entry_associated_with_key_from_list_test() ->
    Key = key_2,
    Storage = [{key_2, value_2}, 
               {key_1, value_1}],
    Res = storage:delete(Key, Storage),
    Expected = [{key_1, value_1}],
    ?assertEqual(Expected, Res).

removes_all_entries_associated_with_key_from_list_test() ->
    Key = key_2,
    Storage = [{key_2, value_2}, 
               {key_2, value_duplicated}, 
               {key_1, value_1}],
    Res = storage:delete(Key, Storage),
    Expected = [{key_1, value_1}],
    ?assertEqual(Expected, Res).

finds_no_entries_associated_with_key_from_list_test() ->
    Key = key_3,
    Storage = [{key_2, value_2}, 
               {key_1, value_1}],    
    Res = storage:find(Key, Storage),
    Expected = [],
    ?assertEqual(Expected, Res).

finds_the_entry_associated_with_key_from_list_test() ->
    Key = key_1,
    Storage = [{key_2, value_2}, 
               {key_1, value_1}],    
    Res = storage:find(Key, Storage),
    Expected = [{key_1, value_1}],
    ?assertEqual(Expected, Res).

finds_all_entries_associated_with_key_from_list_test() ->
    Key = key_1,
    Storage = [{key_2, value_2}, 
               {key_1, value_1},
               {key_1, value_duplicated}],    
    Res = storage:find(Key, Storage),
    Expected = [{key_1, value_1},
                {key_1, value_duplicated}],
    ?assertEqual(Expected, Res).

returns_true_if_list_contains_at_least_one_entry_associated_with_key_test() ->
    Key = key_1,
    Storage = [{key_2, value_2}, 
               {key_1, value_1}],
    Res = storage:is_defined(Key, Storage),
    Expected = true,
    ?assertEqual(Expected, Res).

returns_false_if_list_does_not_contain_one_entry_associated_with_key_test() ->
    Key = key_3,
    Storage = [{key_2, value_2}, 
               {key_1, value_1}],
    Res = storage:is_defined(Key, Storage),
    Expected = false,
    ?assertEqual(Expected, Res).      
