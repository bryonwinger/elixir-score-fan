defmodule ScoreFan.TeamTest do
  use ScoreFan.DataCase
  alias ScoreFan.Platform
  alias ScoreFan.Platform.Team

  @valid_attrs %{
    name: "some name",
    city: "Some City",
    sport_type: "BASEBALL",
    external_team_id: 999999,
    is_active: true
  }

  @invalid_attrs %{
    name: nil,
    city: nil,
    sport_type: nil,
    external_team_id: nil,
    conference_id: nil,
    division_id: nil,
    is_active: nil
  }

  def setup_conference_and_division do
    {:ok, conference} =
      %{name: "conference1", is_active: true}
      |> Platform.create_conference()

    {:ok, division} =
        %{name: "division1", is_active: true}
        |> Platform.create_division()

    {conference, division}
  end

  test "changeset with valid attributes" do
    {conference, division} = setup_conference_and_division()

    attrs =
      @valid_attrs
      |> Map.merge(%{conference_id: conference.id, division_id: division.id})

    changeset = Team.changeset(%Team{}, attrs)
    assert changeset.valid?
    assert changeset.changes.name == attrs.name
    assert changeset.changes.city == attrs.city
    assert changeset.changes.sport_type == attrs.sport_type
    assert changeset.changes.external_team_id == attrs.external_team_id
    assert changeset.changes.conference_id == attrs.conference_id
    assert changeset.changes.division_id == attrs.division_id
    assert changeset.changes.is_active == attrs.is_active
  end

  test "changeset with invalid attributes" do
    changeset = Team.changeset(%Team{}, @invalid_attrs)
    refute changeset.valid?
    assert %{name: ["can't be blank"]} = errors_on(changeset)
    assert %{city: ["can't be blank"]} = errors_on(changeset)
    assert %{sport_type: ["can't be blank"]} = errors_on(changeset)
    assert %{external_team_id: ["can't be blank"]} = errors_on(changeset)
    assert %{conference_id: ["can't be blank"]} = errors_on(changeset)
    assert %{division_id: ["can't be blank"]} = errors_on(changeset)
    assert %{is_active: ["can't be blank"]} = errors_on(changeset)
  end
end
