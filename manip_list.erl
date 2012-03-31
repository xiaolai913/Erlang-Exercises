-module(manip_list).
-export([filter/2,reverse/1,concatenate/1,flatten/1]).

filter(L,Num) ->
	[X || X <- L, X =< Num].

reverse(L) ->
	reverse(L,[]).

reverse([],R) -> R;
reverse([H|T],R) ->
	reverse(T,[H|R]).

concatenate(L) ->	concatenate(L,[]).

concatenate([],R) -> R;
concatenate([H|T],R) -> concatenate(T,R++H).

flatten(L) -> reverse(flatten(L,[])).

flatten([],R) -> R;
flatten([H|T],R) ->
	case is_list(H) of
		true -> flatten(T,flatten(H,R));
		false -> flatten(T,[H|R])
	end.
