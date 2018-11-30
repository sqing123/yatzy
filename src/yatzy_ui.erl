-module(yatzy_ui).

% -export([generate_sheet/1, setup/0, new_game/0]).

% -spec generate_sheet(Sheet :: map()) -> any().


% new_game()->
% 	{ok, [X]} = io:fread("How many players? ", "~d"),
% 	Players = get_players(X, []).
% 	play(Players).


% get_players(N, Players) when N > 0 ->
% 	{ok, NewPlayer} = io:fread("Please enter player name: ", "~a"),
% 	yatzy_player:new(NewPlayer),
% 	Players1 = Players ++ NewPlayer,
% 	get_players(N-1, Players1);
% get_players(0, Players) ->
% 	Players.


% % 	yatzy_player:new(H),
% % 	{ok, Turn} = yatzy_turn:start()
% % 	io:format("Your roll is: ~w", yatzy_turn:dice(Turn)),
% % 	{ok, Reroll} = io:fread('Would you like to roll the dice again: ', '~w'),
% % 	{ok, Keep} = io:fread('Which dice would you like to keep? ', '~w'),
% % 	yatzy_turn:roll(Turn, Keep),
% % 	io:format("Your roll is: ~w", yatzy_turn:dice(Turn))

% play([H|T]) ->
% 	{ok, TurnPid} = yatzy_turn:start(),
% 	io:format("It is now ~w's turn.", H),
% 	turn(H, TurnPid, Roll, ok),
% 	play(T ++ H);
% play([]) ->
% 	io:format("Game over!").


% turn(CurrentPlayer, Turn, Roll, ok) ->
%  	{ok, Turn} = yatzy_turn:start(),
%  	NewRoll = yatzy_turn:dice(Turn),
% 	io:format("Your roll is: ~w", NewRoll),
%  	{ok, [Reroll]} = io:fread("Would you like to roll the dice again: Y/N", "~s"),
% 	case Reroll of
% 		"N" ->
% 			NewRoll = yatzy_turn:stop(Turn),
% 			io:format("Your roll is: ~w", NewRoll),
% 			{ok, [Slot]} = io:fread("Which slot would you like to fill? ", "~a"),
% 			yatzy_player:fill(CurrentPlayer, Slot, NewRoll),
% 			io:format("Your score for ~w is ~d", Slot, yatzy_score:calc(Slot, NewRoll)),
% 			{ok, [Response]} = io:fread("Would you like to see your sheet? Y/N", "~s"),
% 			case Response of
% 				"N" ->
% 					turn_complete;
% 				"Y" ->
% 					generate_sheet(yatzy_player:sheet(CurrentPlayer)),
% 					turn_complete
% 			end;
% 		"Y" ->
% 			{ok, Keep} = io:fread("Which dice would you like to keep? ", "~w"),
% 			Result = yatzy_turn:roll(Turn, Keep),
% 			turn(NewRoll, Result)
% 	end;
% turn(Turn, Roll, invalid_keepers) ->
%  	io:fread("You cannot keep those dice. Please choose new dice: ", "~s"),
% 	Result = yatzy_turn:roll(Turn, Keep),
% 	turn(Roll, Result);
% turn(Turn, Roll, finished) ->
%  	io:format("Your turn is over! "),
% 	turn_complete.


% generate_sheet(Sheet) ->
% 	List = [ones, twos, threes, fours, fives, sixes, one_pair,
% 			two_pairs, three_of_a_kind, four_of_a_kind, small_straight,
% 			large_straight, full_house, chance, yatzy],
% 	generate_helper(List, Sheet).


% generate_helper([], _) ->
% 	io:format('~s~n', [""]);
% generate_helper([H|T], Sheet) ->
% 	case maps:get(H, Sheet, blank) of
% 		blank ->
% 			io:format("|~-18s|~4s|~n", [print_value(H), "-"]);
%         _ ->
% 			io:format("|~-18s|~4w|~n", [print_value(H), maps:get(H, Sheet)])
%     end,
% 	generate_helper(T, Sheet).


% print_value(ones) -> "Ones";
% print_value(twos) -> "Twos";
% print_value(threes) -> "Threes";
% print_value(fours) -> "Fours";
% print_value(fives) -> "Fives";
% print_value(sixes) -> "Sixes";
% print_value(one_pair) -> "One Pair";
% print_value(two_pairs) -> "Two Pairs";
% print_value(three_of_a_kind) -> "Three of a Kind";
% print_value(four_of_a_kind) -> "Four of a Kind";
% print_value(small_straight) -> "Small Straight";
% print_value(large_straight) -> "Large Straight";
% print_value(full_house) -> "Full House";
% print_value(chance) -> "Chance";
% print_value(yatzy) -> "Yatzy".


% pretty_print({A, B}) ->
% 	io:format("|~-18s|~4w|~n", [print_value(A), B]).


% setup() ->
% 	yatzy_player:new('P1'),
% 	yatzy_player:fill('P1', ones, [1,1,1,1,1]),
% 	yatzy_player:fill('P1', twos, [2,2,2,1,1]),
% 	yatzy_player:fill('P1', threes, [1,3,3,1,1]),
% 	yatzy_player:fill('P1', fours, [1,4,4,4,1]),
% 	yatzy_player:fill('P1', one_pair, [1,1,3,2,1]),
% 	yatzy_player:fill('P1', two_pair, [2,2,1,1,5]),
% 	yatzy_player:fill('P1', chance, [1,2,3,5,6]),
% 	yatzy_player:fill('P1', small_straight, [1,2,3,4,5]),
% 	yatzy_player:fill('P1', full_house, [1,1,1,2,2]).