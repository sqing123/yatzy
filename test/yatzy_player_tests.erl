-module(yatzy_player_tests).

% -compile(export_all).

-include_lib("eunit/include/eunit.hrl").

setup() ->
	yatzy_player:new('P1'),
	yatzy_player:new('P2'),
	yatzy_player:new('P3'),
	yatzy_player:new('P4'),
	yatzy_player:fill('P1', ones, [1,1,1,1,1]),
	yatzy_player:fill('P1', twos, [2,2,2,1,1]),
	yatzy_player:fill('P1', threes, [1,3,3,1,1]),
	yatzy_player:fill('P1', fours, [1,4,4,4,1]),
	yatzy_player:fill('P1', one_pair, [1,1,3,2,1]),
	yatzy_player:fill('P1', two_pair, [2,2,1,1,5]),
	yatzy_player:fill('P1', chance, [1,2,3,5,6]),
	yatzy_player:fill('P1', small_straight, [1,2,3,4,5]),
	yatzy_player:fill('P1', full_house, [1,1,1,2,2]),
	yatzy_player:fill('P2', fours, [1,4,4,4,1]),
	yatzy_player:fill('P2', fives, [1,5,5,1,1]),
	yatzy_player:fill('P2', sixes, [1,6,6,6,6]),
	yatzy_player:fill('P2', one_pair, [1,1,3,2,1]),
	yatzy_player:fill('P2', two_pair, [2,2,1,1,5]),
	yatzy_player:fill('P2', three_of_a_kind, [3,3,3,1,1]),
	yatzy_player:fill('P2', four_of_a_kind, [2,2,2,2,1]),
	yatzy_player:fill('P3', ones, [1,1,1,1,1]),
	yatzy_player:fill('P3', twos, [2,2,2,1,1]),
	yatzy_player:fill('P3', threes, [1,3,3,1,1]),
	yatzy_player:fill('P3', fours, [1,4,4,4,1]),
	yatzy_player:fill('P3', one_pair, [1,1,3,2,1]),
	yatzy_player:fill('P3', small_straight, [1,2,3,4,5]),
	yatzy_player:fill('P3', large_straight, [2,3,4,5,6]),
	yatzy_player:fill('P3', full_house, [1,1,1,2,2]),
	yatzy_player:fill('P4', ones, [1,1,1,1,1]),
	yatzy_player:fill('P4', twos, [2,2,2,1,1]),
	yatzy_player:fill('P4', threes, [1,3,3,1,1]),
	yatzy_player:fill('P4', one_pair, [1,1,3,2,1]),
	yatzy_player:fill('P4', two_pair, [2,2,1,1,5]),
	yatzy_player:fill('P4', small_straight, [1,2,3,4,5]),
	yatzy_player:fill('P4', large_straight, [2,3,4,5,6]),
	yatzy_player:fill('P4', full_house, [1,1,1,2,2]).

fill_test() ->
	yatzy_player:new('P1'),
	yatzy_player:new('P2'),
	yatzy_player:new('P3'),
	yatzy_player:new('P4'),
	?assertEqual({ok, 5}, yatzy_player:fill('P1', ones, [1,1,1,1,1])),
	?assertEqual({error, already_filled}, yatzy_player:fill('P1', ones, [1,1,1,1,1])),
	?assertEqual({error, invalid_slot}, yatzy_player:fill('P1', dos, [1,1,1,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P1', twos, [2,2,2,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P1', threes, [1,3,3,1,1])),
	?assertEqual({ok, 12}, yatzy_player:fill('P1', fours, [1,4,4,4,1])),
	?assertEqual({ok, 2}, yatzy_player:fill('P1', one_pair, [1,1,3,2,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P1', two_pairs, [2,2,1,1,5])),
	?assertEqual({ok, 17}, yatzy_player:fill('P1', chance, [1,2,3,5,6])),
	?assertEqual({ok, 15}, yatzy_player:fill('P1', small_straight, [1,2,3,4,5])),
	?assertEqual({ok, 7}, yatzy_player:fill('P1', full_house, [1,1,1,2,2])),
	?assertEqual({ok, 12}, yatzy_player:fill('P2', fours, [1,4,4,4,1])),
	?assertEqual({error, already_filled}, yatzy_player:fill('P1', fours, [1,1,1,1,1])),
	?assertEqual({error, invalid_slot}, yatzy_player:fill('P1', sevens, [1,1,1,1,1])),
	?assertEqual({ok, 10}, yatzy_player:fill('P2', fives, [1,5,5,1,1])),
	?assertEqual({ok, 24}, yatzy_player:fill('P2', sixes, [1,6,6,6,6])),
	?assertEqual({ok, 2}, yatzy_player:fill('P2', one_pair, [1,1,3,2,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P2', two_pairs, [2,2,1,1,5])),
	?assertEqual({ok, 9}, yatzy_player:fill('P2', three_of_a_kind, [3,3,3,1,1])),
	?assertEqual({ok, 8}, yatzy_player:fill('P2', four_of_a_kind, [2,2,2,2,1])),
	?assertEqual({ok, 5}, yatzy_player:fill('P3', ones, [1,1,1,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P3', twos, [2,2,2,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P3', threes, [1,3,3,1,1])),
	?assertEqual({ok, 12}, yatzy_player:fill('P3', fours, [1,4,4,4,1])),
	?assertEqual({error, already_filled}, yatzy_player:fill('P1', fours, [1,1,1,1,1])),
	?assertEqual({error, invalid_slot}, yatzy_player:fill('P1', sevens, [1,1,1,1,1])),
	?assertEqual({ok, 2}, yatzy_player:fill('P3', one_pair, [1,1,3,2,1])),
	?assertEqual({ok, 15}, yatzy_player:fill('P3', small_straight, [1,2,3,4,5])),
	?assertEqual({ok, 20}, yatzy_player:fill('P3', large_straight, [2,3,4,5,6])),
	?assertEqual({ok, 7}, yatzy_player:fill('P3', full_house, [1,1,1,2,2])),
	?assertEqual({ok, 5}, yatzy_player:fill('P4', ones, [1,1,1,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P4', twos, [2,2,2,1,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P4', threes, [1,3,3,1,1])),
	?assertEqual({error, already_filled}, yatzy_player:fill('P1', threes, [1,1,1,1,1])),
	?assertEqual({error, invalid_slot}, yatzy_player:fill('P1', sevens, [1,1,1,1,1])),
	?assertEqual({ok, 2}, yatzy_player:fill('P4', one_pair, [1,1,3,2,1])),
	?assertEqual({ok, 6}, yatzy_player:fill('P4', two_pairs, [2,2,1,1,5])),
	?assertEqual({ok, 15}, yatzy_player:fill('P4', small_straight, [1,2,3,4,5])),
	?assertEqual({ok, 20}, yatzy_player:fill('P4', large_straight, [2,3,4,5,6])),
	?assertEqual({ok, 7}, yatzy_player:fill('P4', full_house, [1,1,1,2,2])).

 sheet_test() ->
 	?assertEqual(#{chance => 17, fours => 12, full_house => 7, one_pair => 2, ones => 5, 
 			small_straight => 15, threes => 6, two_pairs => 6, twos => 6}, yatzy_player:sheet('P1')),
 	?assertEqual(#{fives => 10, four_of_a_kind => 8, fours => 12, one_pair => 2, 
 			sixes => 24, three_of_a_kind => 9, two_pairs => 6}, yatzy_player:sheet('P2')),
 	?assertEqual(#{fours => 12, full_house => 7, large_straight => 20, one_pair => 2,
 			ones => 5, small_straight => 15, threes => 6, twos => 6}, yatzy_player:sheet('P3')),
 	?assertEqual(#{full_house => 7, large_straight => 20, one_pair => 2, 
 			ones => 5, small_straight => 15, threes => 6, two_pairs => 6, twos => 6}, yatzy_player:sheet('P4')).