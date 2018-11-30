-module(otp_yatzy_turn_tests).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

roll_valid_test() ->
	{_, A} = otp_yatzy_turn:start(),
	R = otp_yatzy_turn:dice(A),
	K = lists:sublist(R, 1, 4),
	?assertEqual(ok, otp_yatzy_turn:roll(A, K)),
	?assertEqual(invalid_keepers, otp_yatzy_turn:roll(A, [6,6,6,6,6])),
	?assertEqual(invalid_keepers, otp_yatzy_turn:roll(A, [6,6,5,6,6])),
	?assertEqual(invalid_keepers, otp_yatzy_turn:roll(A, [1,1,1,1,1])),
	R1 = otp_yatzy_turn:dice(A),
	K1 = lists:sublist(R1, 1, 5),
	?assertEqual(ok, otp_yatzy_turn:roll(A, K1)),
	?assertEqual(finished, otp_yatzy_turn:roll(A, [])),
	?assertEqual(finished, otp_yatzy_turn:roll(A, [])),

	{_, B} = otp_yatzy_turn:start(),
	R2 = otp_yatzy_turn:dice(B),
	K2 = lists:sublist(R2, 1, 5),

	
	?assertEqual(ok, otp_yatzy_turn:roll(B, K2)),
	?assertEqual(invalid_keepers, otp_yatzy_turn:roll(B, [1,2,3,4,5])),
	?assertEqual(invalid_keepers, otp_yatzy_turn:roll(B, [2,3,4,5,6])),
	R3 = otp_yatzy_turn:dice(B),
	K3 = lists:sublist(R3, 1, 5),

	?assertEqual(ok, otp_yatzy_turn:roll(B, K3)),
	?assertEqual(finished, otp_yatzy_turn:roll(B, [])),
	?assertEqual(finished, otp_yatzy_turn:roll(B, [])),

	otp_yatzy_turn:stop(A),
	otp_yatzy_turn:stop(B).

evil_roll_test() ->
	[evil_test_gen() || _ <- lists:seq(1, 100)].

evil_test_gen() ->
	{_, A} = otp_yatzy_turn:start(),
	R = otp_yatzy_turn:dice(A),
	K = lists:sublist(R, 1, 4),
	otp_yatzy_turn:roll(A, K),
	R1 = otp_yatzy_turn:dice(A),
	otp_yatzy_turn:stop(A),
	?assertEqual(K--R1, []).

% dice_test() ->
% 	A = otp_yatzy_turn:start(),
% 	otp_yatzy_turn:stop(A).

% stop_test() ->
% 	A = otp_yatzy_turn:start(),
% 	otp_yatzy_turn:stop(A).