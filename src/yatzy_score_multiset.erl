-module(yatzy_score_multiset).

-export([calc/2]).
-export([list_to_multiset/1, sort_multiset/1]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(ones, Roll) -> 
	uppers(1, Roll);
calc(twos, Roll) -> 
	uppers(2, Roll);
calc(threes, Roll) -> 
	uppers(3, Roll);
calc(fours, Roll) -> 
	uppers(4, Roll);
calc(fives, Roll) -> 
	uppers(5, Roll);
calc(sixes, Roll) -> 
	uppers(6, Roll);
calc(one_pair, Roll) -> 
	one_pair(list_to_multiset(Roll));
calc(two_pairs, Roll) -> 
	two_pairs(list_to_multiset(Roll));
calc(three_pairs, Roll) ->
	three_pairs(list_to_multiset(Roll));
calc(three_of_a_kind, Roll) -> 
	three_of_a_kind(list_to_multiset(Roll));
calc(four_of_a_kind, Roll) -> 
	four_of_a_kind(list_to_multiset(Roll));
calc(small_straight, Roll) -> 
	small_straight(lists:sort(Roll));
calc(large_straight, Roll) -> 
 	large_straight(lists:sort(Roll));
calc(full_straight, Roll)->
	full_straight(Roll);
calc(castle, Roll)->
	castle(list_to_multiset(Roll));
calc(tower, Roll) ->
	tower(list_to_multiset(Roll));
calc(yatzy, Roll) -> 
	yatzy(list_to_multiset(Roll));
calc(five_of_a_kind, Roll)->
	five_of_a_kind(list_to_multiset(Roll));
calc(full_house, Roll) -> 
	full_house(list_to_multiset(Roll));
calc(maxi_yatzy, Roll) ->
	maxi_yatzy(Roll);
calc(chance, Roll) -> 
	lists:sum(Roll).

one_pair([{X,_}, {Y, C} | _ ]) when C >= 2 ->
	2*max(X, Y);
one_pair([{X, C} | _]) when C >= 2 ->
	2*X;
one_pair(_) ->
	0.

two_pairs([{X,_}, {Y, C} | _]) when C>=2 ->
	2*X + 2*Y;
two_pairs(_) ->
	0.

three_pairs([{X,2}, {Y,2}, {Z,2} | _]) ->
	2*X + 2*Y + 2*Z;
three_pairs(_) ->
	0.

three_of_a_kind([{X, C} | _]) when C >= 3 ->
	X*3;
three_of_a_kind(_) ->
	0.

four_of_a_kind([{X,C} | _]) when C >= 4 ->
	X*4;
four_of_a_kind(_) ->
	0.

five_of_a_kind([{X,C} | _]) when C >= 5 ->
	X*5;
five_of_a_kind(_) ->
	0.

castle([{X, _}, {Y, C} | _]) when C >= 3 ->
	X*3 + Y*3;
castle(_) ->
	0.

tower([{X, C1}, {Y, C2} | _]) when C1 >= 4, C2 >= 2 ->
	X*4 + Y*2;
tower(_) ->
	0.

full_house([{X, C1}, {Y, C2} | _]) when C1 >= 3, C2 >= 2 ->
	X*3 + Y*2;
full_house(_) ->
	0.

yatzy([{X, C} | _]) when C >= 5 ->
	50;
yatzy(_) ->
	0.

uppers(Y, Roll) -> 
	lists:sum(lists:filter(fun(X) -> X =:= Y end, Roll)).

maxi_yatzy([X,X,X,X,X,X])->
	100;
maxi_yatzy(_)->
	0.

small_straight([X,1,2,3,4,5]) ->
	15;
small_straight([1,2,3,4,5,X]) ->
	15;
small_straight([1,2,3,4,5])->
	15;
small_straight(_) ->
	0.

large_straight([X, 2,3,4,5,6]) ->
	20;
large_straight([2,3,4,5,6,X]) ->
	20;
large_straight([2,3,4,5,6]) ->
	20;
large_straight(_) -> 
	0.

full_straight([1,2,3,4,5,6]) ->
	21;
full_straight(_) ->
	0.

list_to_multiset(List) ->
	list_to_multiset(List, #{}).

list_to_multiset([H|T], Map) ->
	case maps:is_key(H, Map) of 
		true ->
			NewMap = maps:put(H, maps:get(H,Map)+1, Map),
			list_to_multiset(T, NewMap);
		false->
			NewMap = maps:put(H, 1, Map),
			list_to_multiset(T, NewMap)
	end;
list_to_multiset([], Map) ->
	sort_multiset(Map).

sort_multiset(Map)->
	MapList = maps:to_list(Map),
	lists:sort(fun sort_fun/2, MapList).

sort_fun({_, A}, {_, B}) when A>B->
	true;
sort_fun({X,C}, {Y,C}) ->
	X>Y;
sort_fun(_, _) ->
	false.