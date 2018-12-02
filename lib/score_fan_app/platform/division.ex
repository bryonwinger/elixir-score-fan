defmodule ScoreFan.Platform.Division do
  use Ecto.Schema
  import Ecto.Changeset
  alias ScoreFan.Platform.Team

  schema "divisions" do
    field :name, :string
    field :is_active, :boolean, default: false
    has_many(:teams, Team)

    timestamps()
  end

  @required_fields [:name, :is_active]
  @fields @required_fields

  @doc false
  def changeset(division, attrs) do
    division
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
