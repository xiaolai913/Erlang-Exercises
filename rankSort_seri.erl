-module(rankSort_seri).
-export([rankSort/1,memLoc/3]).

%start() -> register(ranksort,spawn(fun() -> loop() end)).

rankSort(L) -> 
	statistics(wall_clock),
	rankSort(L,length(L),L).

rankSort(_L,0,SortList) ->
	{_,Time} = statistics(wall_clock),
	io:format("Time cost is ~p ms.~n",[Time*1000]),
   	SortList;

rankSort(L,N,SortList) ->
	%io:format("N=~p,mem=~p~n",[N,lists:nth(N,L)]),
	Tuple = list_to_tuple(SortList),
	Mem = lists:nth(N,L),
	Loc = memLoc(L,N,Mem),
	NewTuple = setelement(Loc,Tuple,Mem),
	rankSort(L,N-1,tuple_to_list(NewTuple)).


memLoc(L,Index,Mem) -> memLoc(L,Index,Mem,1,1).

memLoc([],_Index,_Mem,_I,K) -> K;
memLoc([H|T],Index,Mem,I,K) ->
	Temp = ((Mem > H) or ((Mem =:= H) and (Index > I))), 
	%io:format("i=~p,k=~p,Temp=~p~n",[I,K,Temp]),
	case Temp of
		true -> memLoc(T,Index,Mem,I+1,K+1);
		false -> memLoc(T,Index,Mem,I+1,K)
	end.

