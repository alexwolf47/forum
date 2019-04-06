defmodule Hello.Topic.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  import Ecto.Query, warn: false
  alias Hello.Repo
  alias HelloWeb.Topic
  alias Hello.Topic.Comment

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
    |> validate_required([:user_id, :topic_id, :comment])
  end



  def list_topic_comments do
    Repo.all(Comment)
  end

  def list_topic_comments(topic_id) do
    (from c in Comment,
      where: c.topic_id == ^topic_id
    )
    |> Repo.all()
  end


  def get_comment!(id), do: Repo.get!(Comment, id)

  def get_topic!(topic_id), do: Repo.get!(Topic, topic_id)

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

end
