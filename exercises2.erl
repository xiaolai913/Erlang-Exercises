-module(exercises2).
-export([jionAndSort/2]).
-export([bubbleSort/1]).
-export([insertSort/1]).
-export([printTable/0]).
-export([getMid/1]).
-export([partition/1, getSeqElm/2]).

%% NO.1
jionAndSort(L, M) -> jionAndSort(L, M, []).

jionAndSort([], [], S) -> lists:reverse(S);
jionAndSort([], X, S) -> lists:reverse(S)++X;
jionAndSort([H1|T1], [H2|T2], S) -> 
	if 
	    H1 =< H2 -> jionAndSort(T1, [H2|T2], [H1|S]);
	    H1 > H2 -> jionAndSort([H1|T1], T2, [H2|S])
	end.
	    
%% NO.2
len(L) -> len(L, 0).

len([], N) -> N;
len([H|T], N) -> len(T, N+1).

bubbleSort(L) -> bubbleSort(L, len(L)).

bubbleSort(L, 1) -> L;
bubbleSort(L, N) -> bubbleSort(bubbleAid(L), N-1).

bubbleAid(L) -> bubbleAid(L, []).

bubbleAid([X], S) -> lists:reverse([X|S]);
bubbleAid([H1,H2|T], S) -> 
	if
	    H1 > H2 -> bubbleAid([H1|T], [H2|S]);
	    H1 =< H2 -> bubbleAid([H2|T], [H1|S])
	end.

% NO.3
insertSort(L) -> insertSort(L,[]).

insertSort([], S) -> S;
insertSort([H|T], S) -> insertSort(T,insertSortAid(S,H)).

insertSortAid([], X) -> [X];
insertSortAid([H|T] = L, X) ->
	if
		X =< H -> [X|L];
		X > H -> [H]++insertSortAid(T,X)
	end.

% NO.4
printTable() -> printTable(1).

printTable(9) -> printLine(9);
printTable(N) when N < 9 -> printLine(N), printTable(N+1).

printLine(N) -> printLine(N, 1).

printLine(N, N) -> 
	io:format("~p*~p=~p~n",[N,N,N*N]);
printLine(N, M) when N > M ->
	io:format("~p*~p=~p ",[M,N,M*N]), printLine(N, M+1).

% NO.5
% getElm([H|T], 1) -> H;
% getElm([H|T], N) -> getElm(T, N-1). 

partition([H|T]) -> {[X || X <- T, X < H], [X || X <- T, X >= H], H}. 

getSeqElm(S, Index) ->
	{L, R, M} = partition(S), Length = len(L),
	if
		Length =:= Index - 1 -> M;
		Length > Index - 1 -> getSeqElm(L,Index);
		Length < Index - 1 -> getSeqElm(R,Index - Length - 1)
	end.

getMid(L) ->
	Length = len(L),
	case (Length rem 2) of
		0 -> (getSeqElm(L, Length div 2) + getSeqElm(L, Length div 2 + 1))/2;
	    1 -> getSeqElm(L, Length div 2 + 1)
	end.	
