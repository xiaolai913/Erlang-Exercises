-module(rankSort).
-export([start/0,stop/0,rankSort/1,memLoc/3]).

start() -> register(server,spawn(fun loop/0)).

rankSort(L) -> 
	server ! {sortedList,len,L,length(L)},
	rankSort(L,length(L)).


rankSort(_L,0) -> ok;
rankSort(L,N) ->
	%io:format("N=~p,mem=~p~n",[N,lists:nth(N,L)]),
	Mem1 = lists:nth(N,L),
	Mem2 = lists:nth(N-1,L),
	case (N rem 2) of
		0 -> 
			spawn(node1@flashDB,fun() -> memLoc(L,N,Mem1) end),
			spawn(node2@flashDB,fun() -> memLoc(L,N-1,Mem2) end),
			rankSort(L,N-2);
		1 ->
			spawn(node1@flashDB,fun() -> memLoc(L,N-1,Mem1) end),
			rankSort(L,N-1)
	end.

memLoc(L,Index,Mem) -> memLoc(L,Index,Mem,1,1).

memLoc([],_Index,Mem,_I,K) -> 
	%io:format("Mem=~p,K=~p~n",[Mem,K]),
	server ! {Mem,K};
	%server ! hi;
	%ok;

memLoc([H|T],Index,Mem,I,K) ->
	Temp = ((Mem > H) or ((Mem =:= H) and (Index > I))), 
	%io:format("i=~p,k=~p,Temp=~p~n",[I,K,Temp]),
	case Temp of
		true -> memLoc(T,Index,Mem,I+1,K+1);
		false -> memLoc(T,Index,Mem,I+1,K)
	end.

stop() ->
	%io:format("sortList:=~p,Len=~p~n",[get(sortedList),get(len)]),
	server ! quit.

loop() ->
	receive
		hi -> 
			io:format("hahahahahahha"),
			loop();
		{sortedList,len,L,Length} -> 
			io:format("begin:L=~p,Len=~p~n",[L,Length]),
			put(sortedList,L),
			put(len,Length),
			%io:format("sortList:=~p,Len=~p~n",[get(sortedList),get(len)]),
			loop();
		{Mem,K} ->
			io:format("receive:Mem=~p,K=~p~n",[Mem,K]),
			case (get(len) =:= 0) of
				true -> get(sortedList);
				false -> 
					Tuple = list_to_tuple(get(sortedList)),
					NewTuple = setelement(K,Tuple,Mem),
					put(sortedList,tuple_to_list(NewTuple)),
					put(len,get(len)-1)
			end,
			loop();
		quit ->	exit(quit)
	end.
