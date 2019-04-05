defmodule Hello.Repo.Migrations.AddUserImages do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:user_image, :string)
    end
  end
end
