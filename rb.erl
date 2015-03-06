-module(rb).

-export([init/1]).
-export([lookup/2]).
-export([hash/1]).
-export([valid_card/1]).

init(Count) ->
  {T, M} = timer:tc(fun() -> setup(Count) end),
  io:format("Time to setup lookup table: ~ps~n", [T / (1000 * 1000)]),
  io:format("Size of table ~p.~n", [dict:size(M)]),
  M.

lookup(H, M) ->
  {ok, [X]} = dict:find(H, M),
  X.

%% Using IIN/BIN 455262.
setup(Count) -> loop("455262", dict:new(), Count).

loop(_Iin, M, 0) ->
  M;
loop(Iin, M, N) ->
  C = lists:flatten(io_lib:format("~s~10..0B", [Iin, N])),
  progress(list_to_integer(C)),
  case valid_card(C) of
    true  -> loop(Iin, dict:append(hash(C), C, M), N - 1);
    false -> loop(Iin, M, N - 1)
  end.

progress(N) when  N rem 1000000 =:= 0 -> io:format("N = ~p~n", [N]);
progress(_)                           -> ok.

hash(Data) -> crypto:hash(sha256, Data).

%%%_* Luhn =============================================================
valid_card(C) -> sum([X - $0 || X <- lists:reverse(C)]) rem 10 =:= 0.

sum([Odd, Even | Rest]) when Even >= 5 -> Odd + 2 * Even - 10 + 1 + sum(Rest);
sum([Odd, Even | Rest])                -> Odd + 2 * Even + sum(Rest);
sum([Odd])                             -> Odd;
sum([])                                -> 0.
