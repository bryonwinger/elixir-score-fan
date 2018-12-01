defmodule ScoreFan.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :is_active, :boolean, default: false, null: false
      add :password_hash, :string
      add :password_updated_at, :utc_datetime

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
