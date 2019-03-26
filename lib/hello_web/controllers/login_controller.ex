defmodule HelloWeb.LoginController do
  use HelloWeb, :controller
  alias Hello.Auth

  def new(conn, _params) do
    conn |> render("new.html")
  end

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case Auth.User.sign_in(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have successfully signed in!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid Email or Password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.User.sign_out()
    |> redirect(to: "/")
  end
end
