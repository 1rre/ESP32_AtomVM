-module(drive).
-export([init/1]).

-define(DRIVE_PINS, [3,4,5]).

init(GPIO) ->
  [gpio:set_direction(GPIO, Pin, output) || Pin <- ?DRIVE_PINS],
  io:format("Hello World from Drive~n"),
  loop(GPIO, 1, on).

loop(GPIO, N, on) ->
  gpio:set_level(GPIO, lists:nth(N,?DRIVE_PINS), 1),
  timer:sleep(1000),
  loop(GPIO, N, off);

loop(GPIO, N, off) ->
  gpio:set_level(GPIO, lists:nth(N,?DRIVE_PINS), 0),
  timer:sleep(1000),
  loop(GPIO, N rem length(?DRIVE_PINS) + 1, on).
