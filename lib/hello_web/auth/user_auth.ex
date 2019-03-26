defmodule HelloWeb.UserAuth do
  import Plug.Conn

  def user_signed_in?(conn) do
    session_map = conn.private.plug_session
    session_map |> Map.has_key?("username") |> IO.inspect(label: "Map has key result")
  end

  def get_username(conn) do
    conn |> get_session("username")
  end
end
