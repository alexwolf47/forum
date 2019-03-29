defmodule Hello.Repo.Migrations.ChangeBodyToText do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      modify(:body, :text)
    end
  end
end
