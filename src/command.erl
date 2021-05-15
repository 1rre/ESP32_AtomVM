-module(command).
-export([init/1]).

init(_GPIO) ->
  Self = self(),
  Config = [
    {sta, [
      {ssid, esp:nvs_get_binary(atomvm, sta_ssid, <<"WIFI_SSID">>)},
      {psk,  esp:nvs_get_binary(atomvm, sta_psk, <<"WIFI_PASSWORD">>)},
      {connected, fun() -> Self ! connected end},
      {got_ip, fun(IpInfo) -> Self ! {ok, IpInfo} end},
      {disconnected, fun() -> Self ! disconnected end}
    ]}
  ],
  case network_fsm:start(Config) of
    ok ->
      wait_for_message();
    Error ->
      io:format("Error: ~p~n", [Error])
  end.

wait_for_message() ->
  receive
    connected ->
      io:format("Connected~n"),
      wait_for_message();
    {ok, IpInfo} ->
      io:format("IP: ~p~n", [IpInfo]),
      wait_for_message();
    disconnected ->
      io:format("Disconnected~n")
  after 15000 ->
    ok
  end.
