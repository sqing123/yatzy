%%%-------------------------------------------------------------------
%% @doc yatzy public API
%% @end
%%%-------------------------------------------------------------------

-module(yatzy_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    yatzy_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

-type slot() :: 'ones' | 'twos' | 'threes' | 'fours' | 'fives' | 'sixes' | 'one_pair' | 'two_pairs' | 'three_of_a_kind' | 'four_of_a_kind' | 'small_straight' | 'large_straight' | 'full_house' | 'yatzy' | 'chance'.

-type slot_type() :: 'upper' | 'lower'.

-type roll() :: [1..6].