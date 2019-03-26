start_psql:
	pg_ctl -D /usr/local/var/postgres start

serve:
	mix phx.server