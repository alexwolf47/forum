defmodule Hello.Repo.Migrations.AddHellos do
  use Ecto.Migration

  def change do
    create table(:hellos) do
      add(:from, :string)
      add(:hello, :string)
    end
  end
end
