-module(yatzy_turn).

-export([start/0, roll/2, dice/1, stop/1, test/0]).

-spec start() -> {ok, pid()}.

-spec roll(TurnPid::pid(), Keep::any()) -> ok | invalid_keepers | finished.
%%Once the player has selected which dice to keep roll the remaining dice unless they
%%have already been rolled twice.

-spec dice(TurnPid::pid()) -> yatzy_score:roll().
%% Cust the rolled dice as it stands at this point.

-spec stop(TurnPid::pid()) -> yatzy_score:roll().
%% Just stop the procees and get out what was rolled.

start() ->
	NewRoll = [rand:uniform(6) || _ <- lists:seq(1,5)],
	Pid = spawn(fun()->first_roll(NewRoll) end),
	{ok, Pid}.

roll(TurnPid, Keep) ->
	TurnPid ! {self(), Keep},
	receive
		Result ->
			Result
	end.

dice(TurnPid) ->
	TurnPid ! {self(), dice},
	receive
		Roll ->
			Roll
	end.

stop(TurnPid) ->
	TurnPid ! {self(), stop},
	receive
		Roll ->
			Roll
	end.

first_roll(Roll) ->
	receive
		{From, dice} ->
			From ! Roll,
			first_roll(Roll);
		{From, stop} ->
			From ! Roll,
			true;
		{From, Keep} ->
			K = lists:sort(Keep),
			Token = new_roll(Roll, K),
			case Token of
				{ok, R} ->
					From ! ok,
					second_roll(R);
				_ ->
					From ! Token,
					first_roll(Roll)
			end
	end.

second_roll(Roll) ->
	receive
		{From, dice} ->
			From ! Roll,
			second_roll(Roll);
		{From, stop} ->
			From ! Roll,
			true;
		{From, Keep} ->
			K = lists:sort(Keep),
			Token = new_roll(Roll, K),
			case Token of
				{ok, R} ->
					From ! ok,
					third_roll(R);
				_ ->
					From ! Token,
					second_roll(Roll)
			end
	end.

third_roll(Roll) ->
	receive
		{From, dice} ->
			From ! Roll,
			third_roll(Roll);
		{From, stop} ->
			From ! Roll,
			true;
		{From, Keep} ->
			From ! finished,
			third_roll(Roll)
	end.

new_roll(Roll, Keep) ->
	case Keep -- Roll of
		[] ->
			Rolls = 5 - length(Keep),
			New = [ rand:uniform(6) || _ <- lists:seq(1,Rolls)],
			NewRoll = New ++ Keep,
			{ok, NewRoll};
		_ ->
			invalid_keepers
	end.


test() ->
	{_,B,_} = yatzy_turn:start(),
	yatzy_turn:dice(B),
	yatzy_turn:roll(B, [2,2,3]),
	yatzy_turn:dice(B),
	yatzy_turn:roll(B, [2,2,3]),
	yatzy_turn:dice(B),
	yatzy_turn:roll(B, [2,2,3]).