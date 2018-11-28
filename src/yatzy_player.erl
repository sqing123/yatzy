-module(yatzy_player).

-export([new/1, fill/3, sheet/1]).

-spec new(Name::atom()) -> {ok, pid()}.
-spec fill(Name::atom(), yatzy:slot(), yatzy:roll()) -> {ok, Score::integer()}
                                                            | {error, Reason::any()}.
-spec sheet(Name::atom()) -> yatzy_sheet:t().

new(Name) ->
	S = yatzy_sheet:new(),
	Pid = spawn(fun() -> loop(S) end),
	register(Name, Pid),
	{ok, Pid}.

fill(Name, Slot, Roll) ->
	Name ! {self(), {fill, Slot, Roll}},
	receive
		{ok, X} ->
			{ok, X};
		X ->
			{error, X}
	end.

sheet(Name) ->
	Name ! {self(), sheet},
	receive
		Msg ->
			Msg
	end.

loop(S) ->
	receive
		{From, {fill, Slot, Roll}} ->
			case yatzy_sheet:fill(Slot, Roll, S) of
				{ok, X} ->
					From ! {ok, yatzy_score:calc(Slot, Roll)},
					loop(X);
				Msg ->
					From ! Msg,
					loop(S)
			end;
		{From, sheet} ->
			From ! S,
			loop(S);
		stop->
			true
	end.