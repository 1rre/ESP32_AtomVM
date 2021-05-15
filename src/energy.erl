-module(energy).
-export([init/1]).

% Energy gets analogue & input only pins
-define(ENERGY_PINS, []).

init(GPIO) ->
  erlang:display("Hello World from Energy").