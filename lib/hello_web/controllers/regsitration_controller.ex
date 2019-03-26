defmodule HelloWeb.RegistrationController do
  use HelloWeb, :controller

  def new(conn, _params) do
    conn |> render("new.html")
  end

  def create(conn, _params) do
    conn
  end
end
