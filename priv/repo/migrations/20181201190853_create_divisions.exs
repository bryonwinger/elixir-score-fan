defmodule ScoreFan.Repo.Migrations.CreateDivisions do
  use Ecto.Migration

  def change do
    create table(:divisions) do
      add :name, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
