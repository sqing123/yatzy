-module(yatzy_score).

-export([calc/2]).
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
	one_pair(lists:sort(Roll));
calc(two_pairs, Roll) -> 
	two_pairs(lists:sort(Roll));
calc(three_of_a_kind, Roll) -> 
	three_of_a_kind(lists:sort(Roll));
calc(four_of_a_kind, Roll) -> 
	four_of_a_kind(lists:sort(Roll));
calc(small_straight, Roll) -> 
	case lists:sort(Roll) of
 		[1,2,3,4,5] -> 15;
 		_ -> 0
 	end;
calc(large_straight, Roll) -> 
 	case lists:sort(Roll) of
 		[2,3,4,5,6] -> 20;
 		_ -> 0
 	end;
calc(yatzy, Roll) -> 
	case lists:sort(Roll) of
 		[X, X, X, X, X] -> 50;
 		_ -> 0
 	end;
calc(full_house, Roll) -> 
	full_house(lists:sort(Roll));
calc(chance, Roll) -> 
	lists:sum(Roll).

uppers(Y, Roll) -> 
	lists:sum(lists:filter(fun(X) -> X =:= Y end, Roll)).

full_house([X,X,X,Y,Y]) when X/=Y ->
	3*X + 2*Y;
full_house([X,X,Y,Y,Y]) when X/=Y ->
	2*X + 3*Y;
full_house(_) ->
	0.

four_of_a_kind([X,X,X,X,_]) ->
	4*X;
four_of_a_kind([_,X,X,X,X]) ->
	4*X;
four_of_a_kind(_) ->
	0.

three_of_a_kind([X,X,X,_,_]) ->
	3*X;
three_of_a_kind([_,X,X,X,_]) ->
	3*X;
three_of_a_kind([_,_,X,X,X]) ->
	3*X;
three_of_a_kind(_) ->
	0.

two_pairs([X,X,Y,Y,_]) when X/=Y ->
	X*2 + Y*2;
two_pairs([X,X,_,Y,Y]) when X/=Y ->
	X*2 + Y*2;
two_pairs([_,X,X,Y,Y]) when X/=Y ->
	X*2 + Y*2;
two_pairs(_) ->
	0.

one_pair([_,_,_,X,X]) ->
	2*X;
one_pair([_,_,X,X,_]) ->
	2*X;
one_pair([_,X,X,_,_]) ->
	2*X;
one_pair([X,X,_,_,_]) ->
	2*X;
one_pair(_) ->
	0.