-module(ring).
-export([start/3,process_status/1]).

start(M, N, Message) ->
	io:format("Begin:~n"),
	spawn(fun() -> create_process(M, N, Message, self()) end),
	spawn(fun listen/0).

create_process(M, 1, Message, First_node) ->
	io:format("create the process ~p:~p~n~n",[1, self()]),
	%link(First_node),
	send_message(1, First_node, Message, M);

create_process(M, N, Message, First_node) -> 
	io:format("create process ~p:~p~n~n",[N, self()]),
	Pid = spawn_link(fun() -> create_process(M, N-1, Message, First_node) end),
	send_message(N, Pid, Message, M).

send_message(N, Pid, Message, 0) -> ok;
send_message(N, Pid, Message, M) ->
	io:format("process ~p send ~p to ~p~n",[self(), Message, Pid]),
	Pid ! Message,
	send_message(N, Pid, Message, M-1).

listen() ->
	receive
		quit -> exit(quit)
	end.

process_status(Pid) ->
	case erlang:is_process_alive(Pid) of
		true ->
			io:format("process ~p is alive~n",[Pid]);
		flase ->
			io:format("process ~p is dead~n",[Pid])
	end.
