defmodule Hello.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Plug.Conn
  alias Hello.Repo
  alias Hello.Auth.User

  schema "users" do
    field(:email, :string)
    field(:encrypted_password, :string)
    field(:username, :string)
    field(:user_desc, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :user_desc])
    |> validate_required([:email, :username])
    |> validate_length(:username, min: 3, max: 30)
    |> validate_length(:user_desc, max: 60)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  @doc false
  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_confirmation(:password)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 128)
    |> encrypt_password()
  end

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        {:ok, user}

      true ->
        {:error, :unauthorized}
    end
  end

  def sign_out(conn) do
    configure_session(conn, drop: true)
  end

  def register(params) do
    User.registration_changeset(%User{}, params) |> Repo.insert()
  end

  def current_user(conn) do
    user_id = get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User, user_id)
  end

  def user_signed_in?(conn) do
    !!current_user(conn)
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
