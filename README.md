# sentry


## What

A containerised deployment environment (Docker Swarm, Mesos/Marathon,
Kubernetes) dictates what resources are virtualised and available in
a container's sandbox and what kind of information is left after a
container terminates.
Sometimes, it's nothing more than logs which were captured during its
lifetime.
Due to asynchronous initialisation of a service's components
and due to network delays,
not all logs might be captured instantly.
This app tries to make Erlang/Elixir service initialisation debugging
easier be delaying Erlang VM shutdown enough for logs to get flushed.


## How

This app is intended to be included as a dependency of an Erlang/Elixir
service release.
This app has no dependencies other than `kernel`, `stdlib` and `sasl`,
and starts only a single process.
This means the startup of this app can't fail.
If the main service app startup fails,
this app will be terminated by the application controller.
However, it won't exit immediately - `sentry_app:prep_stop/1` will make it
pause for a configurable amount of time, so that the VM and other apps
running withing have enough time to flush any human readable information
which might ease the debugging of main service app startup.
