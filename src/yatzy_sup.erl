%%%-------------------------------------------------------------------
%% @doc yatzy top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(yatzy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([new_player/1, new_turn/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

new_player(Name) ->
    supervisor:start_child(?SERVER, {Name, {otp_yatzy_player, start_link, [Name]}, permanent, 2000, worker, [otp_yatzy_player]}).

new_turn(Name) ->
    supervisor:start_child(?SERVER, {Name, {otp_yatzy_turn, start_link, []}, permanent, 2000, worker, [otp_yatzy_turn]}).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, {{one_for_one, 0, 1}, []}}.

%%====================================================================
%% Internal functions
%%====================================================================
