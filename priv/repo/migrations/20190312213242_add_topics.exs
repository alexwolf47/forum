defmodule Hello.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add(:title, :string)
      add(:created_by_user, :string)
      add(:user_id, :integer)
      add(:body, :string)
      add(:image_url, :string)

      timestamps()
    end
  end
end
