defmodule HelloWeb.LoginController do
  use HelloWeb, :controller
  alias HelloWeb.UserAuth

  def new(conn, _params) do
    conn |> render("new.html")
  end

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case UserAuth.sign_in(email, password) do
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
    |> UserAuth.sign_out()
    |> redirect(to: "/")
  end
end
