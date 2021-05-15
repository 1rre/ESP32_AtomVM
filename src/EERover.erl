-module('EERover').
-export([start/0]).


start() ->
  GPIO = gpio:open(),
  erlang:spawn(vision, init, [GPIO]),
  erlang:spawn(command, init, [GPIO]),
  erlang:spawn(drive, init, [GPIO]),
  erlang:spawn(energy, init, [GPIO]),
  loop().

loop() -> receive
  Msg ->
    erlang:display(Msg),
    loop()
end.
