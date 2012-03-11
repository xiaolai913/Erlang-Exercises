-module(exercises).
-export([fibonacci/1]).
-export([average/1]).
-export([pingFang/1]).
-export([togather/2]).
-export([sum/1,sum/2]).
-export([create/1,reverse_create/1]).
-export([print_series/1,print_even/1]).
-export([hanoi/1]).
-export([qsort/1]).
-export([caculate/1]).

%% No.1: Fibonacci sequence
fibonaqi(0) -> 1;
fibonaqi(1) -> 1;
fibonaqi(N) -> 
	fibonaqi(N-2) + fibonaqi(N-1).

%% simple method: fibonaqi_list(M) -> [ fibonaqi(X) || X <- lists:seq(0,M) ]. 
fibonacci(M) -> fibonacci(M,[]).

fibonacci(-1,L) -> L;
fibonacci(M,L) -> fibonacci(M-1,[fibonaqi(M)|L]).

%% No.2: Caculate the average of a list
average(L) -> average(L,0,0,0).

average([], Sum, Len, Avr) -> Avr;
average([H|T], Sum, Len, Avr) -> average(T, H+Sum, 1+Len, (Sum+H)/(Len+1)).

%% No.3: Caculate 1^2 + 2^2 + ... + n^n
pingfang(N) -> pingfang(N, []).

pingfang(0, L) -> L;
pingfang(N, L) -> pingfang(N-1, [N*N|L]).

pingFang(N) -> pingFang(pingfang(N),0).

pingFang([], Results) -> Results;
pingFang([H|T], Results) -> pingFang(T, H + Results).

%% No.4: Join two lists

togather(L,M) -> togather(L,M,[]).

togather([], [], S) -> lists:reverse(S);
togather([H1|T1], M, S)  when [H1|T1] =/= [] ->
	togather(T1, M, [H1|S]);
togather(Y, [H2|T2], S) ->
	togather(Y, T2, [H2|S]).

%% No.5: Evaluating expressions
sum(N) -> sum_aid1(N,0).

sum_aid1(0,S) -> S;
sum_aid1(N,S) -> sum_aid1(N-1,N+S).

sum_aid(N, M) when N =< M -> 
	sum_aid(N, M, 0);
sum_aid(N, M) -> throw("Wrong arguments, N shouldn't be bigger than M!").

sum_aid(N, M, S) when N =< M ->
	sum_aid(N+1, M, N+S);
sum_aid(N, M, S) -> S.

sum(N,M) ->
	try sum_aid(N,M) of
		Results -> Results
	catch
		throw:X -> X 
	end.

%% No.6: Create lists
create(N) -> create(N,[]).

create(0,L) -> L;
create(N,L) -> create(N-1,[N|L]).

reverse_create(N) -> reverse_create(N,1,[]).

reverse_create(N,M,L) when M =< N -> reverse_create(N,M+1,[M|L]);
reverse_create(N,M,L) -> L.

%% No.7: Side effects
print_series(1) -> io:format("Number:~p~n",[1]);
print_series(N) -> print_series(N-1), io:format("Number:~p~n",[N]). 


print_even(2) -> io:format("Number:~p~n",[2]);
print_even(N) when (N rem 2) =:= 0 ->
	print_even(N-1), io:format("Number:~p~n",[N]);
print_even(N) -> print_even(N-1).

%% No.8: Tower of Hanoi
hanoi(N) -> hanoi(N, a, c, b).

hanoi(1, X, Z, Y) -> io:format("{~p->",[1]),io:format("~p}~n",[Z]);
hanoi(N, X, Z, Y) -> 
	hanoi(N-1, X, Y, Z), 
	io:format("{~p->",[N]),io:format("~p}~n",[Z]),
	hanoi(N-1, Y, Z, X).

%% No.9: qsort
qsort([]) -> [];
qsort([H|T]) -> 
	qsort([X || X <- T, X < H])
	++[H]++
	qsort([X || X <- T, X >= H]). 

%% No.10 Caculate 1-2+3-...+n
caculate(N) -> caculate(N,0).

caculate(0,Sum) -> Sum;
caculate(N,Sum) ->
	case (N rem 2) of
	   1 -> caculate(N-1,N+Sum);
	   0 -> caculate(N-1,-N+Sum)
    end.	   

