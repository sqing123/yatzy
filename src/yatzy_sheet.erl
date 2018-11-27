-module(yatzy_sheet).

-export([new/0,fill/3,get/2,upper_total/1,bonus/1,lower_total/1,total/1]).

-type t() :: map().
-spec new() -> t().
-spec fill(yatzy:slot(), yatzy:roll(), t()) -> {'ok', t()}
                                             | 'already_filled'
                                             | 'invalid_slot'.
-spec get(yatzy:slot(), t()) -> {'filled', non_neg_integer()}
                              | 'invalid_slot'
                              | 'empty'.
-spec upper_total(t()) -> non_neg_integer().
-spec bonus(t()) -> 0 | 50.
-spec lower_total(t()) -> non_neg_integer().
-spec total(t()) -> non_neg_integer().

new() -> maps:new().

fill(Slot, Roll, Sheet) -> 
	case check_valid(Slot) of
		false -> 
			invalid_slot;
		true -> 
			case check_filled(Slot, Sheet) of 
				{filled, _} ->
					already_filled;
				empty -> 
					Sheet2 = maps:put(Slot, yatzy_score:calc(Slot, Roll) , Sheet),
					{ok, Sheet2}
			end
	end.

get(Slot, Sheet) -> 
	case check_valid(Slot) of
		false -> 
			invalid_slot;
		true -> 
			check_filled(Slot, Sheet)
	end.

upper_total(Sheet) ->
	Targets = [ones, twos, threes, fours, fives, sixes],
	calc_total(Targets, Sheet).

bonus(Sheet) ->
	case upper_total(Sheet) of
		Upper when Upper>=63 -> 50;
		_ -> 0
	end.

lower_total(Sheet) ->
	Targets = [one_pair, two_pairs, three_of_a_kind,
			four_of_a_kind, small_straight, large_straight,
			full_house, yatzy, chance],
	calc_total(Targets, Sheet).

total(Sheet) ->
	upper_total(Sheet) + bonus(Sheet) + lower_total(Sheet).

calc_total(Targets, Sheet) ->
	Sheet2 = maps:with(Targets, Sheet),
	lists:sum(maps:values(Sheet2)).

check_filled(Slot, Sheet) ->
	Value = maps:get(Slot, Sheet, empty),
	case Value of
		empty -> 
			empty;
		_ -> 
			{filled, Value}
	end.

check_valid(Slot) ->
	Valid = [ones, twos, threes, fours, fives, sixes, one_pair,
			two_pairs, three_of_a_kind, four_of_a_kind, small_straight,
			large_straight, full_house, yatzy, chance],
	lists:member(Slot, Valid).