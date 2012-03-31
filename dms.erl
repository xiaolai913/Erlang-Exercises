-module(dms).
-export([start/0,func/1,func/3]).

start() ->
	rpc:call(node1@flashDB,erlang,node,[]),
	rpc:call(node2@flashDB,erlang,node,[]),
	register(server,spawn(fun loop/0)).

func(C) ->
	%io:format("option is ~p~n",[C]),
	if
		C =:= "-list" -> server!ls;
		C =:= "-quit" -> server!quit
	end.

func(Info,Cmd,Nodes) ->
	server!{Info,Cmd,Nodes}.

exec(_C,[]) -> ok;
exec(C,[H|T]) ->
	io:format("~p~n",[rpc:call(H,os,cmd,[C])]),
	exec(C,T).

loop() ->
	receive
		ls -> 
			io:format("~p~n",[nodes()]),
			loop();
		quit ->
			disconnect_node(node1@flashDB),
			disconnect_node(node2@flashDB),
			exit(quit);	
		{"-cmd",Cmd,Nodes} ->
			exec(Cmd,Nodes),
			loop()
	end.	
