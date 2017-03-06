-module(erlang_exercises_tests).
-include_lib("eunit/include/eunit.hrl").

exercise_01_tuple_to_list_test() ->
    ?assertEqual([1,2,3,4], erlang_exercises:exercise_01({1,2,3,4})).

exercise_02_increment_elements_of_list_by_one_test() ->
    ?assertEqual([2,3,4,5], erlang_exercises:exercise_02([1,2,3,4])).

exercise_03_find_even_numbers_in_a_given_list_test() ->
    ?assertEqual([2,4], erlang_exercises:exercise_03([1,2,3,4])).

exercise_04_partition_list_into_even_numbers_and_odd_numbers_test() ->
    ?assertEqual({[2,4],[1,3]}, erlang_exercises:exercise_04([1,2,3,4])).

exercise_05_find_palindrome_words_in_a_given_text_test() ->
    ?assertEqual(["savas", "a"], erlang_exercises:exercise_05("savas is a palindrome")).

exercise_06_count_occurrences_of_a_char_in_a_string_test() ->
    ?assertEqual(3, erlang_exercises:exercise_06($s, "savas is a palindrome")).

exercise_06_returns_0_if_a_char_does_not_appaer_in_a_string_test() ->
    ?assertEqual(0, erlang_exercises:exercise_06($z, "savas is a palindrome")).

exercise_07_prepend_list_if_element_is_not_present_in_the_list_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_07(1, [2,a,b])).

exercise_07_do_not_prepend_list_if_element_is_present_in_the_list_01_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_07(1, [1,2,a,b])).

exercise_07_do_not_prepend_list_if_element_is_present_in_the_list_02_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_07(a, [1,2,a,b])).

exercise_08_append_list_if_element_is_not_present_in_the_list_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_08(b, [1,2,a])).

exercise_08_do_not_append_list_if_element_is_present_in_the_list_01_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_08(b, [1,2,a,b])).

exercise_08_do_not_append_list_if_element_is_present_in_the_list_02_test() ->
    ?assertEqual([1,2,a,b], erlang_exercises:exercise_08(2, [1,2,a,b])).

exercise_09_subtract_first_element_in_given_list_test() ->
    ?assertEqual([], erlang_exercises:exercise_09(1, [a])).

exercise_09_subtract_nth_element_in_given_list_test() ->
    ?assertEqual([a,b,c,e,f], erlang_exercises:exercise_09(4, [a,b,c,d,e,f])).

exercise_09_do_not_subtract_nth_element_if_length_of_the_list_is_smaller_than_n_test() ->
    ?assertEqual([a], erlang_exercises:exercise_09(3, [a])).

exercise_09_do_not_subtract_if_list_is_empty_test() ->
    ?assertEqual([], erlang_exercises:exercise_09(2, [])).

exercise_10_get_index_of_first_occurrence_of_an_element_in_a_list_01_test() ->
    ?assertEqual(4, erlang_exercises:exercise_10(b, [1,2,a,b,c])).

exercise_10_get_index_of_first_occurrence_of_an_element_in_a_list_02_test() ->
    ?assertEqual(2, erlang_exercises:exercise_10(3, [1,3,2,4,3])).

exercise_10_returns_not_found_if_the_element_is_not_in_the_list_test() ->
    ?assertEqual(element_not_found, erlang_exercises:exercise_10(5, [1,3,2,4,3])).

exercise_11_get_index_of_last_occurrence_of_an_element_in_a_list_01_test() ->
    ?assertEqual(4, erlang_exercises:exercise_11(b, [1,2,a,b,c])).

exercise_11_get_index_of_last_occurrence_of_an_element_in_a_list_02_test() ->
    ?assertEqual(5, erlang_exercises:exercise_11(3, [1,3,2,4,3])).

exercise_11_returns_not_found_if_an_element_is_not_in_a_list_test() ->
    ?assertEqual(element_not_found, erlang_exercises:exercise_11(5, [1,3,2,4,3])).

%% map applies a given function to each element of a list,
%% returning a list of results in the same order.
exercise_12_implement_lists_map_test() ->
    Fun = fun(X) -> X * 2 end,
    ?assertEqual([2,4,6,8], erlang_exercises:exercise_12(Fun, [1,2,3,4])).

exercise_13_calculate_cost_of_shopping_list_test() ->
    ?assertEqual(411, erlang_exercises:exercise_13()).

exercise_14_calculate_cost_for_a_particular_category_test() ->
    Category = meat,
    ?assertEqual(133, erlang_exercises:exercise_14(Category)).

exercise_15_generate_list_of_categories_and_their_cost_test() ->
    Expected = [{beverages, 59},
		{bread_bakery, 12},
		{meat, 133},
		{canned_jarred_goods, 26},
		{dairy, 43},
		{produce, 0},
		{personal_care, 28},
		{other, 110}],
    ?assertEqual(lists:sort(Expected),
		 lists:sort(erlang_exercises:exercise_15())).

exercise_16_write_file_each_category_with_its_cost_comma_separated_test() ->
    OutFile = erlang_exercises:exercise_16(),
    {ok, Bin} = file:read_file(OutFile),
    Expected = "beverages, 59\n"
	       "bread_bakery, 12\n"
		"meat, 133\n"
		"canned_jarred_goods, 26\n"
		"dairy, 43\n"
		"produce, 0\n"
		"personal_care, 28\n"
		"other, 110\n",
    ?assertEqual([], Expected -- binary_to_list(Bin)).
