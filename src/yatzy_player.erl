-module(yatzy_player).

-export([new/1, fill/3, sheet/1]).

-spec new(Name::atom()) → {ok, Pid}.
-spec fill(Name::atom(), yatzy:slot(), yatzy:roll()) → {ok, Score::integer()}
                                                            | {error, Reason}.
-spec sheet(Name::atom()) → yatzy_sheet:t()).

