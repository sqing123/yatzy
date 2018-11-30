-module(otp_yatzy_turn).

-export([start_link/0, roll/2, dice/1, stop/1]).
-export([init/1, callback_mode/0, terminate/3, code_change/4]).
-export([first_roll/3, second_roll/3, third_roll/3]).

-spec start_link() -> {ok, pid()}.

-behaviour(gen_statem).

-spec roll(TurnPid::pid(), Keep::any()) -> ok | invalid_keepers | finished.
%%Once the player has selected which dice to keep roll the remaining dice unless they
%%have already been rolled twice.

-spec dice(TurnPid::pid()) -> yatzy_score:roll().
%% Cust the rolled dice as it stands at this point.

-spec stop(TurnPid::pid()) -> yatzy_score:roll().
%% Just stop the procees and get out what was rolled.

start_link() ->
    gen_statem:start_link(?MODULE, [], []).


roll(TurnPid, Keep) ->
    gen_statem:call(TurnPid, {roll, Keep}).


dice(TurnPid) ->
    gen_statem:call(TurnPid, dice).


stop(TurnPid) ->
    gen_statem:call(TurnPid, stop).


init([])->
    State = first_roll,
    Data = [rand:uniform(6) || _ <- lists:seq(1,5)],
    {ok, State, Data}.


terminate(_Reason, _State, _Data) -> 
    void.


code_change(_Vsn, State, Data, _Extra) ->
    {ok, State, Data}.


callback_mode() ->
    state_functions.


first_roll({call, From}, {roll, Keep}, Roll) ->
    case new_roll(Roll, lists:sort(Keep)) of
        {ok, NewRoll} ->
            {next_state, second_roll, NewRoll, [{reply, From, ok}]};
        _ ->
            {keep_state, Roll, [{reply, From, invalid_keepers}]}
    end;
first_roll({call, From}, dice, Roll) ->
    {keep_state, Roll, [{reply, From, Roll}]};
first_roll({call, From}, stop, Roll) ->
    {stop_and_reply, normal, [{reply, From, Roll}], Roll}.


second_roll({call, From}, {roll, Keep}, Roll) ->
    case new_roll(Roll, lists:sort(Keep)) of
        {ok, NewRoll} ->
            {next_state, third_roll, NewRoll, [{reply, From, ok}]};
        Error ->
            {keep_state, Roll, [{reply, From, invalid_keepers}]}
    end;
second_roll({call, From}, dice, Roll) ->
    {keep_state, Roll, [{reply, From, Roll}]};
second_roll({call, From}, stop, Roll) ->
    {stop_and_reply, normal, [{reply, From, Roll}], Roll}.


third_roll({call, From}, {roll, Keep}, Roll) ->
    {keep_state, Roll, [{reply, From, finished}]};
third_roll({call, From}, dice, Roll) ->
    {keep_state, Roll, [{reply, From, Roll}]};
third_roll({call, From}, stop, Roll) ->
    {stop_and_reply, normal, [{reply, From, Roll}], Roll}.


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