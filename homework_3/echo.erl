-module(echo).
-export([start/0,print/1,stop/0,loop/0]).

start() ->
	register(server, spawn(fun loop/0)).

print(Term) -> 
	server!{self(),Term},
	%io:format("~p~p~n",[server,Term]),
	receive
		{server,Response} -> io:format("~p~n",[Response])
	end.

stop() ->
	%exit(server,"Bye").
	server!quit.

loop() ->
	receive
		{From,Term} ->
			%io:format("~p~p~n",[From,Term]),
			From ! {server,Term},
			loop();
		quit -> exit("quit!")
	end.
		

