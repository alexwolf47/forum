defmodule HelloWeb.Session do
  use HelloWeb, :model

  schema "session" do
    field(:name, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
