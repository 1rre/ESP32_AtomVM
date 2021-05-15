-module('EERover').
-export([start/0]).


start() ->
  GPIO = gpio:open(),
  spawn(vision, init, [GPIO]),
  spawn(command, init, [GPIO]),
  spawn(drive, init, [GPIO]),
  spawn(energy, init, [GPIO]),
  loop().

loop() -> receive
  Msg ->
    io:format("Recieived: ~p~n", [Msg]),
    loop()
end.
