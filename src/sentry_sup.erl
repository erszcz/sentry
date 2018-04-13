%%%-------------------------------------------------------------------
%% @doc sentry top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(sentry_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, { {one_for_all, 0, 1}, [
                                 #{id => sentry_worker,
                                   start => {sentry_worker, start_link, []},
                                   restart => permanent,
                                   shutdown => 5000,
                                   type => worker,
                                   modules => [sentry_worker]}
                                ]} }.

%%====================================================================
%% Internal functions
%%====================================================================
