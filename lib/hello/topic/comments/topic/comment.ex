defmodule Hello.Topic.Comments.Topic.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topic_comments" do
    field :comment, :string
    field :likes, :integer
    field :reply_to, :integer
    field :topic_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:user_id, :topic_id, :comment, :likes, :reply_to])
    |> validate_required([:user_id, :topic_id, :comment, :likes, :reply_to])
  end
end
