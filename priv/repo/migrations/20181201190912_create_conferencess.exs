defmodule ScoreFan.Repo.Migrations.CreateConferences do
  use Ecto.Migration

  def change do
    create table(:conferences) do
      add :name, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
