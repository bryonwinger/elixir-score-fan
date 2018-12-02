defmodule ScoreFan.Platform.Conference do
  use Ecto.Schema
  import Ecto.Changeset
  alias ScoreFan.Platform.Team

  schema "conferences" do
    field :name, :string
    field :is_active, :boolean, default: false
    has_many(:teams, Team)

    timestamps()
  end

  @required_fields [:name, :is_active]
  @fields @required_fields

  @doc false
  def changeset(conference, attrs) do
    conference
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
