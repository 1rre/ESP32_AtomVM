-module(energy).
-export([init/1]).

-include("pins.hrl").

% Energy gets analogue & input only pins
-define(ENERGY_PINS, [?A0,?A1,?A2,?A3,?A4,?A5]).

init(GPIO) ->
  erlang:display("Hello World from Energy").