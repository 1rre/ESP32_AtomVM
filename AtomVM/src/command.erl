-module(command).
-export([init/1]).

init(_GPIO) ->
  Self = self(),
  Config = [
    {sta, [
      {ssid, esp:nvs_get_binary(atomvm, sta_ssid, ?WIFI_SSID)},
      {psk,  esp:nvs_get_binary(atomvm, sta_psk, )},
      {connected, fun() -> Self ! connected end},
      {got_ip, fun(IpInfo) -> Self ! {ok, IpInfo} end},
      {disconnected, fun() -> Self ! disconnected end}
    ]}
  ],
  case network_fsm:start(Config) of
    ok ->
      wait_for_message();
    Error ->
      erlang:display(Error)
  end.

wait_for_message() ->
  receive
    connected ->
      erlang:display(connected);
    {ok, IpInfo} ->
      erlang:display(IpInfo);
    disconnected ->
      erlang:display(disconnected)
  after 15000 ->
    ok
  end,
  wait_for_message().
