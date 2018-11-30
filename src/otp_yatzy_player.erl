-module(otp_yatzy_player).

-export([start_link/1, fill/3, sheet/1]).
-export([init/1, handle_call/3, handle_cast/2]).

-behavior(gen_server).

-spec start_link(Name::atom()) -> {ok, pid()}.
-spec fill(Name::atom(), yatzy:slot(), yatzy:roll()) -> {ok, Score::integer()}
                                                            | {error, Reason::any()}.
-spec sheet(Name::atom()) -> yatzy_sheet:t().

start_link(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, na, []).


fill(Name, Slot, Roll) ->
    gen_server:call(Name, {fill, Slot, Roll}).


sheet(Name) ->
    gen_server:call(Name, sheet).


init(na) ->
    {ok, yatzy_sheet:new()}.


handle_cast(stop, Sheet) ->
    {stop, {error, actionnotallowed}, Sheet}.


handle_call({fill, Slot, Roll}, _From, Sheet)->
    case yatzy_sheet:fill(Slot, Roll, Sheet) of
		{ok, NewSheet} ->
			Reply = {ok, yatzy_score:calc(Slot, Roll)},
            {reply, Reply, NewSheet};
		Reason ->
			Reply = {error, Reason},
            {reply, Reply, Sheet}
	end;
handle_call(sheet, _From, Sheet) ->
    Reply = Sheet,
    {reply, Reply, Sheet}.