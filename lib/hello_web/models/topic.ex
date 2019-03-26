defmodule HelloWeb.Topic do
  use HelloWeb, :model

  schema "topics" do
    field(:title, :string)
    field(:created_by_user, :string)
    field(:body, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :created_by_user, :body])
    |> validate_required([:title])
  end
end
