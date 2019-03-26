defmodule HelloWeb.RegistrationController do
  use HelloWeb, :controller
  alias HelloWeb.UserAuth

  # def new(conn, _params) do
  #   conn |> render("new.html")
  # end

  # def create(conn, %{"registration" => %{"email" => email, "password" => password}}) do
  #   case UserAuth.sign_in(email, password) do
  #     {:ok, user} ->
  #       conn
  #       |> put_session(:current_user_id, user.id)
  #       |> put_flash(:info, "You have successfully signed in!")
  #       |> redirect(to: Routes.page_path(conn, :index))

  #     {:error, _reason} ->
  #       conn
  #       |> put_flash(:error, "Invalid Email or Password")
  #       |> render("new.html")
  #   end
  # end

  def new(conn, _params) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, _params) do
  end
end
