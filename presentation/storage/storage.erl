-module(storage).
-export([new/0,
         add/3,
         delete/2,
         find/2,
         is_defined/2]).

new() ->
    [].

add(Key, Value, Storage) ->
    Pair = {Key, Value},
    [Pair | Storage].

delete(Key, Storage) ->
    [ {K,V} || {K, V} <- Storage, K /= Key ].

find(Key, Storage) ->
    [ Pair || Pair <- Storage, element(1, Pair) == Key ].

is_defined(Key, Storage) ->
    Matches = find(Key, Storage),
    case Matches of
        [] ->
            false;
        _ ->
            true
    end.

%% is_defined(Key, Storage) ->
%%     find(Key, Storage) /= [].
               
%% is_defined(_, []) ->
%%     false;
%% is_defined(Key, [{Key, _} | _]) ->
%%     true;
%% is_defined(Key, [_ | T]) ->
%%     is_defined(Key, T).
    

%% delete(Key, Storage) ->
%%     delete(Key, Storage, []).

%% delete(_, [], Acc) ->
%%     Acc;
%% delete(Key, [{Key, _} | T], Acc) ->
%%     delete(Key, T, Acc);
%% delete(Key, [Pair | T], Acc) ->
%%     delete(Key, T, [Pair | Acc]).
