-module(yatzy_score).

-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(ones, Roll) -> helper(1, Roll);
calc(twos, Roll) -> helper(2, Roll);
calc(threes, Roll) -> helper(3, Roll);
calc(fours, Roll) -> helper(4, Roll);
calc(fives, Roll) -> helper(5, Roll);
calc(sixes, Roll) -> helper(6, Roll);
%calc(one_pair, Roll) -> ;
%calc(two_pairs, Roll) -> ;
%calc(three_of_a_kind, Roll) -> ;
%calc(four_of_a_kind, Roll) -> ;
%calc(small_straight, Roll) -> 

%calc(large_straight, Roll) -> ;
%calc(full_house, Roll) -> ;
%calc(yatzy, Roll) -> ;
calc(chance, Roll) -> lists:sum(Roll).

helper(Y, Roll) -> lists:sum(lists:filter(fun(X) -> X == Y end, Roll)).