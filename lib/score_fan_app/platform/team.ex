defmodule ScoreFan.Platform.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScoreFan.Platform.{Conference, Division}

  schema "teams" do
    field :city, :string
    field :name, :string
    field :sport_type, :string
    # The ID used in external API calls
    field :external_team_id, :integer
    field :is_active, :boolean, default: false
    belongs_to(:conference, Conference)
    belongs_to(:division, Division)

    timestamps()
  end

  @required_fields [:city, :name, :external_team_id, :conference_id, :division_id, :is_active, :sport_type]
  @fields @required_fields

  @sport_types ["HOCKEY", "BASEBALL", "BASKETBALL", "FOOTBALL", "DISC_GOLF"]

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:sport_type, sport_types())
    |> assoc_constraint(:conference, required: true)
    |> assoc_constraint(:division, required: true)
  end

  def sport_types do
    @sport_types
  end
end
