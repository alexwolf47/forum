# defmodule HelloWeb.UserAuth do
#   import Plug.Conn
#   alias Hello.Repo
#   alias Hello.Auth.User

#   # def sign_in(email, password) do
#   #   user = Repo.get_by(User, email: email)

#   #   cond do
#   #     user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
#   #       {:ok, user}

#   #     true ->
#   #       {:error, :unauthorized}
#   #   end
#   # end

#   # def sign_out(conn) do
#   #   configure_session(conn, drop: true)
#   # end

#   # def register(params) do
#   #   User.registration_changeset(%User{}, params) |> Repo.insert()
#   # end

#   # def current_user(conn) do
#   #   user_id = get_session(conn, :current_user_id)
#   #   if user_id, do: Repo.get(User, user_id)
#   # end

#   # def user_signed_in?(conn) do
#   #   !!current_user(conn)
#   # end

#   # # def user_signed_in?(conn) do
#   # #   session_map = conn.private.plug_session
#   # #   session_map |> Map.has_key?("username") |> IO.inspect(label: "Map has key result")
#   # # end

#   # def get_username(conn) do
#   #   conn |> get_session("username")
#   # end
# end
