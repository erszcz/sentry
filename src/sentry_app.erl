-module(sentry_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, prep_stop/1]).

start(_StartType, _StartArgs) ->
    sentry_sup:start_link().

stop(_State) ->
    ok.

prep_stop(State) ->
    Delay = timer:seconds(5),
    error_logger:error_msg("sentry prep-stop: delay ~pms\n", [Delay]),
    timer:sleep(Delay),
    State.
