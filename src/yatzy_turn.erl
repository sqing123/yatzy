-module(yatzy_turn).

-export([start/0, roll/2, dice/1, stop/1]).

-spec start() -> {ok, pid()}.

-spec roll(pid(), Keep::any()) -> ok | invalid_keepers | finished.
%%Once the player has selected which dice to keep roll the remaining dice unless they
%%have already been rolled twice.

-spec dice(pid()) -> yatzy_score:roll().
%% Cust the rolled dice as it stands at this point.

-spec stop(pid()) -> yatzy_score:roll().
%% Just stop the procees and get out what was rolled.

start() ->
	{ok, self()}.

roll(Pid, Keep) ->
	ok.

dice(Pid) ->
	[1,2,3,4,5,6].

stop(Pid) ->
	[1,2,3,4,5,6].