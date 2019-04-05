defmodule Hello.Repo.Migrations.CreateTopicComments do
  use Ecto.Migration

  def change do
    create table(:topic_comments) do
      add :user_id, :integer
      add :topic_id, :integer
      add :comment, :string
      add :likes, :integer
      add :reply_to, :integer

      timestamps()
    end

  end
end
