serve:
	iex -S mix phx.server

start_psql:
	pg_ctl -D /usr/local/var/postgres start


phxr:
	mix phx.routes