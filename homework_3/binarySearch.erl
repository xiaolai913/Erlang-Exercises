-module(binarySearch).
-export([binarySearch/2]).

getElm([H|T], 1) -> H;
getElm([H|T], N) -> getElm(T, N-1). 

binarySearch(L, E) -> binarySearch(L, E, 1, length(L)).

binarySearch(L, E, Left, Right)  when Left =< Right ->
	Mid = (Left + Right) div 2, MidElm = getElm(L,Mid),
	%% io:format("~p,~p,~p,~p~n",[Left,Right,Mid,MidElm]),
	if
		MidElm =:= E -> true;
		MidElm > E -> binarySearch(L, E, Left, Mid - 1);
		MidElm < E -> binarySearch(L, E, Mid + 1, Right)
	end;
binarySearch(L, E, Left, Right) -> false.
