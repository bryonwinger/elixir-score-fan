defmodule ScoreFan.Repo.Migrations.AddSportTypeToTeam do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add(:sport_type, :string, null: false)
    end
  end
end
