-module(wordCount).
-export([word_count/1]).

word_count(File) ->
	{ok,F} = file:open(File,read),
	{ok,IndexF} = file:open("index.txt",write),
	parse(F,1,IndexF).

output_token([],_N,_indexF) -> ok;
output_token([H|T],N,IndexF) ->
	io:format("~p~n",[{H,N}]),
	io:format(IndexF,"~p~n",[{H,N}]),
	output_token(T,N,IndexF).


parse(F,N,IndexF) ->
	String = io:get_line(F,''),
	case String =:= eof of
		true -> ok;
		false ->
			Tokens = string:tokens(String,",.!;\n "),
			output_token(Tokens,N,IndexF),
			parse(F,N+1,IndexF)
	end.
