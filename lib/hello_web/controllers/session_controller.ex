defmodule HelloWeb.SessionController do
  use HelloWeb, :controller
  alias HelloWeb.Session

  def index(%{private: %{plug_session: %{"username" => name}}} = conn, _params) do
    IO.puts("USER ALREADY")

    conn
    |> put_flash(:info, "You are already registered, #{name}")
    |> IO.inspect(label: "conn after trying to create session")
    |> redirect(to: "/")
  end

  # Called when there is no user session

  def index(conn, _params) do
    IO.puts("NO SESSION")
    conn.private.plug_session |> IO.inspect(label: "12")
    changeset = Session.changeset(%Session{}, %{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"session" => %{"name" => name}}) do
    name |> IO.inspect(label: "10")

    conn
    |> put_session(:username, name)
    |> put_flash(:info, "Welcome, #{name}")
    |> IO.inspect(label: "16: Conn, after adding session")
    |> redirect(to: "/")
  end

  def create(_conn, _) do
    IO.puts("Catch all")
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end

  # defp check_session(conn) do
  # end
end
