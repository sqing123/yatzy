-module(yatzy_ui).

-export([generate_sheet/1]).

-spec generate_sheet(Sheet :: map()) -> any().

generate_sheet(Sheet) ->
	Maps_list = maps:to_list(Sheet),
	lists:foreach(fun pretty_print/1, Maps_list).

pretty_print({A,B}) ->
	io:format("|~8w|~4w|~n", [A, B]).