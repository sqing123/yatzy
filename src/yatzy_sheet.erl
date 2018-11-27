-module(yatzy_sheet).

% -type t() :: map().
% -spec new() -> t().
% -spec fill(yatzy:slot(), yatzy:roll(), t()) -> {'ok', t()}
%                                              | 'already_filled'
%                                              | 'invalid_slot'.
% -spec get(yatzy:slot(), t()) -> {'filled', non_neg_integer()}
%                               | 'invalid_slot'
%                               | 'empty'.
% -spec upper_total(t()) -> non_neg_integer().
% -spec bonus(to()) -> 0 | 50.
% -spec lower_total(t()) -> non_neg_integer().
% -spec total(t()) -> non_neg_integer().