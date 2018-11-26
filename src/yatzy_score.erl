-module(yatzy_score).

-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(chance, Roll) -> lists:sum(Roll);
calc(ones, Roll) -> lists:sum(Roll);
calc(twos, Roll) -> lists:sum(Roll);
calc(threes, Roll) -> lists:sum(Roll);
calc(fours, Roll) -> lists:sum(Roll);
calc(fives, Roll) -> lists:sum(Roll);
calc(sixes, Roll) -> lists:sum(Roll);
calc(ones, Roll) -> lists:sum(Roll).