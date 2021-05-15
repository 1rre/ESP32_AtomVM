-module(vision).
-export([init/1]).

-define(VISION_PINS, [0,1,2]).


init(GPIO) ->
  [gpio:set_direction(GPIO, N, output) || N <- ?VISION_PINS],
  erlang:display("Hello World from Vision"),
  loop(GPIO, 1, on).  
  
loop(GPIO, N, on) ->
  gpio:set_level(GPIO, lists:nth(N,?VISION_PINS), 1),
  timer:sleep(1000),
  loop(GPIO, N, off);

loop(GPIO, N, off) ->
  gpio:set_level(GPIO, lists:nth(N,?VISION_PINS), 0),
  timer:sleep(1000),
  loop(GPIO, N rem length(?VISION_PINS) + 1, on).


