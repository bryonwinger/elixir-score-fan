defmodule ScoreFan.Repo.Migrations.AddRegistrationTokenToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:identity_token, :string)
      add(:identity_token_updated_at, :utc_datetime)
    end
  end
end
