-module(energy).
-export([init/1]).

-define(ENERGY_PINS, []).

init(GPIO) ->
  io:format("Hello World from Energy~n").