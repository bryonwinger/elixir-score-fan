defmodule ScoreFan.Platform.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScoreFan.Platform.{Conference, Division}

  schema "teams" do
    field :city, :string
    field :name, :string
    # The ID used in external API calls
    field :external_team_id, :integer
    field :is_active, :boolean, default: false
    belongs_to(:conference, Conference)
    belongs_to(:division, Division)

    timestamps()
  end

  @required_fields [:city, :name, :external_team_id, :conference_id, :division_id, :is_active]
  @fields @required_fields

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:conference, required: true)
    |> assoc_constraint(:division, required: true)
  end
end
