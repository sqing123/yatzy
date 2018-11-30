-module(driver).

-export([test/0]).

test() ->
    yatzy_sup:new_player(john),
    yatzy_sup:new_player(jill),
    yatzy_sup:new_turn(turn1),
    yatzy_sup:new_turn(turn2),
    observer:start().