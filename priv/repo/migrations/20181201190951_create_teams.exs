defmodule ScoreFan.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :city, :string
      add :name, :string
      add :external_team_id, :integer
      add :conference_id, references(:conferences, on_delete: :nothing)
      add :division_id, references(:divisions, on_delete: :nothing)
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

    create index(:teams, [:conference_id])
    create index(:teams, [:division_id])
    create index(:teams, [:external_team_id])
  end
end
