-module(yatzy_score_eqc).

-include_lib("eqc/include/eqc.hrl").

-compile(export_all).

gen_dice() ->
    choose(1,6).

gen_dice(Num) ->
    [gen_dice() || _ <- lists:seq(1, Num)].

gen_roll() ->
    gen_dice(5).

gen_other(Len, Eyes) ->
    ?LET(O, 
            (?SUCHTHAT(Other, gen_dice(Len), 
            not has_higher_pair(Eyes, lists:sort(Other)))),
            lists:duplicate(5-Len, Eyes) ++ O).

gen_unique(Len) ->
    ?SUCHTHAT(Roll, eqc_gen:sublist([1,2,3,4,5,6]), 
                length(Roll) == Len).

gen_n_of_a_kind(Eyes, N) ->
    ?LET(Roll, gen_dice(5-N), 
        lists:duplicate(N, Eyes)++Roll).
    
all_same([X,X,X,X,X]) ->
    true;
all_same(_) ->
    false.

has_higher_pair(Eyes, [X,X, _]) when X > Eyes ->
    true;
has_higher_pair(Eyes, [_, X, X]) when X > Eyes ->
    true;
has_higher_pair(Eyes, _) ->
    false.

gen_two_pairs(Eyes) ->
    ?LET(Last, gen_dice(),
            lists:merge(Eyes, Eyes) ++ [Last]).

gen_not_yatzy() ->
    ?SUCHTHAT(Roll, gen_roll(), not all_same(Roll)).

prop_is_yatzy() ->
    ?FORALL(Eyes, gen_dice(),
            begin 
                Roll = lists:duplicate(5, Eyes),
                50 == yatzy_score:calc(yatzy, Roll)
            end).

prop_is_not_yatzy() ->
    ?FORALL(Roll, gen_not_yatzy(),
            0 == yatzy_score:calc(yatzy, Roll)).

prop_is_one_pair() ->
    ?FORALL({Eyes, Roll}, ?LET(Eyes, gen_dice(), {Eyes, gen_other(3, Eyes)}), 
                Eyes*2 == yatzy_score:calc(one_pair, Roll)).

prop_is_not_pair() ->
    ?FORALL(Roll, gen_unique(5), 
                0 == yatzy_score:calc(one_pair, Roll)).

prop_is_two_pairs() ->
    ?FORALL({Eyes, Roll}, ?LET(Eyes, gen_unique(2), {Eyes, gen_two_pairs(Eyes)}),
            lists:sum(Eyes)*2 ==yatzy_score:calc(two_pairs, Roll)).

prop_is_three_of_a_kind() ->
    ?FORALL({Eyes, Roll}, ?LET(Eyes, gen_dice(), {Eyes, gen_n_of_a_kind(Eyes, 3)}),
            Eyes*3 == yatzy_score:calc(three_of_a_kind, Roll)).

prop_is_four_of_a_kind() ->
    ?FORALL({Eyes, Roll}, ?LET(Eyes, gen_dice(), {Eyes, gen_n_of_a_kind(Eyes, 4)}),
            Eyes*4 == yatzy_score:calc(four_of_a_kind, Roll)).

prop_is_full_house() ->
    ?FORALL([D1,D2], gen_unique(2),
            begin
                Roll = [D1, D1, D1, D2, D2],
                lists:sum(Roll) == yatzy_score:calc(full_house, Roll)
            end).

prop_is_small_straight() ->
    ?FORALL(Roll, eqc_gen:shuffle([1,2,3,4,5]),
            lists:sum(Roll) == yatzy_score:calc(small_straight, Roll)).

prop_is_large_straight() ->
    ?FORALL(Roll, eqc_gen:shuffle([2,3,4,5,6]),
            lists:sum(Roll) == yatzy_score:calc(large_straight, Roll)).

prop_is_chance() ->
    ?FORALL(Roll, gen_dice(5),
            lists:sum(Roll) == yatzy_score:calc(chance, Roll)).