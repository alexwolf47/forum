defmodule HelloWeb.Topic do
  use HelloWeb, :model

  schema "topics" do
    field(:title, :string)
    field(:created_by_user, :string)
    field(:user_id, :integer)
    field(:body, :string)
    field(:image_url, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :created_by_user, :user_id, :body, :image_url])
    |> validate_required([:title])
  end
end
