defmodule HelloWeb.RegistrationController do
  use HelloWeb, :controller
  alias Hello.Auth

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

  def create(conn, %{"registration" => registration_params}) do
    case Auth.User.register(registration_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have successfully signed up!")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
