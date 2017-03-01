-module(erlang_exercises).
-export([exercise_01/1,
	 exercise_02/1,
	 exercise_03/1,
	 exercise_04/1,
	 exercise_05/1,
	 exercise_06/2,
	 exercise_07/2,
	 exercise_08/2,
	 exercise_09/2,
	 exercise_10/2,
	 exercise_11/2,
	 exercise_12/2,
	 exercise_13/0,
	 exercise_14/1,
	 exercise_15/0,
	 exercise_16/0
	]).

-define(DIR, get_files_dir()).
-define(SHOPPING_LIST_FILE,
	filename:join(?DIR, "shopping_list.txt")).
-define(CATEGORIES_AND_SHOPPING_LIST_FILE,
	filename:join(?DIR, "categories_and_shopping_list.txt")).

%%% ----------------------------------------------------------------------------
exercise_01(X) ->
    tuple_to_list(X).

%%% ----------------------------------------------------------------------------
exercise_02(L) ->
    [ X+1 || X <- L ].

%%% ----------------------------------------------------------------------------
exercise_03(L) ->
    [ X || X <- L, X rem 2 == 0 ].

%%% ----------------------------------------------------------------------------
exercise_04(L) ->
    lists:partition(fun(X) -> X rem 2 == 0 end, L).

%%% ----------------------------------------------------------------------------
exercise_05(Text) ->
    L = string:tokens(Text, " "),
    [ X || X <- L, X == lists:reverse(X) ].

%%% ----------------------------------------------------------------------------
exercise_06(Char, Text) ->
    Occurrences = [ X || X <- Text, X == Char],
    length(Occurrences).

%%% ----------------------------------------------------------------------------
exercise_07(E, L) ->
    case lists:member(E, L) of
	false ->
	    [E|L];
	true ->
	    L
    end.

%%% ----------------------------------------------------------------------------
exercise_08(E, L) ->
    L ++ [E].

%%% ----------------------------------------------------------------------------
exercise_09(N, L) ->
    Zipped = lists:zip(lists:seq(1, length(L)), L),
    [ V || {I, V} <- Zipped, I /= N].

%%% ----------------------------------------------------------------------------
exercise_10(N, L) ->
    Indices = indices_of(N, L),
    case Indices of
	[] ->
	    not_found;
	_ ->
	    hd(Indices)
    end.

exercise_11(N, L) ->
    Indices = indices_of(N, L),
    case Indices of
	[] ->
	    not_found;
	_ ->
	    lists:last(Indices)
    end.

indices_of(Element, L) ->
    Indices = lists:zip(lists:seq(1,length(L)), L),
    [ I || {I, E} <- Indices, E == Element ].

%%% ----------------------------------------------------------------------------
exercise_12(F, L) ->
    [ F(X) || X <- L ].

%%% ----------------------------------------------------------------------------
exercise_13() ->
    File = ?SHOPPING_LIST_FILE,
    {ok, Bin} = file:read_file(File),
    Text = binary_to_list(Bin),
    Tokens = tokinize(Text),
    Prices = take_every_third_element(Tokens),
    Res = remove_blank_spaces(Prices),
    lists:sum(Res).

tokinize(Text) ->
    string:tokens(Text, ",\n").

take_every_third_element(Tokens) ->
    [ lists:nth(N, Tokens) || N <- lists:seq(3, length(Tokens), 3) ].

remove_blank_spaces(L) ->
    [ list_to_integer(X -- " ") || X <- L ].

%%% ----------------------------------------------------------------------------
exercise_14(Category) ->
    CategoriesList = ?CATEGORIES_AND_SHOPPING_LIST_FILE,
    {ok, [Categories, ShoppingList]} = file:consult(CategoriesList),
    calculate_total_for_category(Category, Categories, ShoppingList).

exercise_15() ->
    CategoriesList = ?CATEGORIES_AND_SHOPPING_LIST_FILE,
    {ok, [Categories, ShoppingList]} = file:consult(CategoriesList),
    Keys = proplists:get_keys(Categories),
    [ {K, calculate_total_for_category(K, Categories, ShoppingList)} || K <- Keys ].

calculate_total_for_category(Category, Categories, ShoppingList) ->
    L = proplists:get_value(Category, Categories),
    Total = [ Price ||  {Product, {_, Price}} <- ShoppingList, lists:member(Product, L) ],
    lists:sum(Total).

%%% ----------------------------------------------------------------------------
exercise_16() ->
    CategoriesPrices = exercise_15(),
    Text = [ io_lib:format("~p, ~p~n", [C, P]) || {C, P} <- CategoriesPrices ],
    File = "/tmp/result",
    ok = file:write_file(File, Text),
    File.

%%% ----------------------------------------------------------------------------
get_files_dir() ->
    SrcDir = filename:absname(""),
    filename:join(lists:droplast(filename:split(SrcDir))).
