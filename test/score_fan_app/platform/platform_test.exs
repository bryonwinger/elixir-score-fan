defmodule ScoreFan.PlatformTest do
  use ScoreFan.DataCase
  alias ScoreFan.Platform
  alias ScoreFan.Platform.{Conference, Division, Team}

  @valid_conference_attrs %{name: "some name", is_active: true}
  @update_conference_attrs %{name: "updated name"}
  @invalid_conference_attrs %{name: nil, is_active: nil}

  def conference_fixture(attrs \\ %{}) do
    {:ok, conference} =
      attrs
      |> Enum.into(@valid_conference_attrs)
      |> Platform.create_conference()

    conference
  end

  @valid_division_attrs %{name: "some name", is_active: true}
  @update_division_attrs %{name: "updated name"}
  @invalid_division_attrs %{name: nil, is_active: nil}

  def division_fixture(attrs \\ %{}) do
    {:ok, division} =
      attrs
      |> Enum.into(@valid_division_attrs)
      |> Platform.create_division()

    division
  end

  @valid_team_attrs  %{
    name: "Some Name",
    city: "Some City",
    sport_type: "BASEBALL",
    external_team_id: 999999,
    is_active: true
  }

  @update_team_attrs %{
    name: "New Name",
    city: "Some Other City",
    sport_type: "FOOTBALL",
    external_team_id: 999998,
    is_active: false
  }

  @invalid_team_attrs %{
    name: nil,
    city: nil,
    sport_type: nil,
    external_team_id: nil,
    conference_id: nil,
    division_id: nil,
    is_active: nil
  }

  def conference_division_and_team_fixture do
    conference = conference_fixture()
    division = division_fixture()

    attrs =
      @valid_team_attrs
      |> Map.merge(%{conference_id: conference.id, division_id: division.id})

    {:ok, team} =
      attrs
      |> Platform.create_team()

    {conference, division, team}
  end

  describe "conferences" do
    test "list_conferences/0 returns all conferences" do
      conference = conference_fixture()
      assert Platform.list_conferences() == [conference]
    end

    test "get_conference!/1 returns the conference with given id" do
      conference = conference_fixture()
      assert Platform.get_conference!(conference.id) == conference
    end

    test "create_conference/1 with valid data creates a conference" do
      assert {:ok, %Conference{} = conference} = Platform.create_conference(@valid_conference_attrs)
      assert conference.name == @valid_conference_attrs.name
    end

    test "create_conference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platform.create_conference(@invalid_conference_attrs)
    end

    test "update_conference/2 with valid data updates the conference" do
      conference = conference_fixture()
      assert {:ok, %Conference{} = updated_conference} = Platform.update_conference(conference, @update_conference_attrs)
      assert updated_conference.name == @update_conference_attrs.name
    end

    test "update_conference/2 with invalid data returns error changeset" do
      conference = conference_fixture()
      assert {:error, %Ecto.Changeset{}} = Platform.update_conference(conference, @invalid_conference_attrs)
      assert conference == Platform.get_conference!(conference.id)
    end

    test "delete_conference/1 deletes the conference" do
      conference = conference_fixture()
      assert {:ok, %Conference{}} = Platform.delete_conference(conference)
      assert_raise Ecto.NoResultsError, fn -> Platform.get_conference!(conference.id) end
    end

    test "change_conference/1 returns a conference changeset" do
      conference = conference_fixture()
      assert %Ecto.Changeset{} = Platform.change_conference(conference)
    end
  end

  describe "divisions" do
    test "list_divisions/0 returns all divisions" do
      division = division_fixture()
      assert Platform.list_divisions() == [division]
    end

    test "get_division!/1 returns the division with given id" do
      division = division_fixture()
      assert Platform.get_division!(division.id) == division
    end

    test "create_division/1 with valid data creates a division" do
      assert {:ok, %Division{} = division} = Platform.create_division(@valid_division_attrs)
      assert division.name == @valid_division_attrs.name
    end

    test "create_division/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platform.create_division(@invalid_division_attrs)
    end

    test "update_division/2 with valid data updates the division" do
      division = division_fixture()
      assert {:ok, %Division{} = updated_division} = Platform.update_division(division, @update_division_attrs)
      assert updated_division.name == @update_division_attrs.name
    end

    test "update_division/2 with invalid data returns error changeset" do
      division = division_fixture()
      assert {:error, %Ecto.Changeset{}} = Platform.update_division(division, @invalid_division_attrs)
      assert division == Platform.get_division!(division.id)
    end

    test "delete_division/1 deletes the division" do
      division = division_fixture()
      assert {:ok, %Division{}} = Platform.delete_division(division)
      assert_raise Ecto.NoResultsError, fn -> Platform.get_division!(division.id) end
    end

    test "change_division/1 returns a division changeset" do
      division = division_fixture()
      assert %Ecto.Changeset{} = Platform.change_division(division)
    end
  end

  describe "teams" do
    test "list_teams/0 returns all teams" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert Platform.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert Platform.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      conference = conference_fixture()
      division = division_fixture()

      attrs =
        @valid_team_attrs
        |> Map.merge(%{conference_id: conference.id, division_id: division.id})

      assert {:ok, %Team{} = team} = Platform.create_team(attrs)
      assert team.name == attrs.name
      assert team.city == attrs.city
      assert team.sport_type == attrs.sport_type
      assert team.external_team_id == attrs.external_team_id
      assert team.is_active == attrs.is_active
      assert team.conference_id == attrs.conference_id
      assert team.division_id == attrs.division_id
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platform.create_team(@invalid_team_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert {:ok, %Team{} = updated_team} = Platform.update_team(team, @update_team_attrs)
      assert updated_team.name == @update_team_attrs.name
      assert updated_team.name == @update_team_attrs.name
      assert updated_team.city == @update_team_attrs.city
      assert updated_team.sport_type == @update_team_attrs.sport_type
      assert updated_team.external_team_id == @update_team_attrs.external_team_id
      assert updated_team.is_active == @update_team_attrs.is_active
    end

    test "update_team/2 with invalid data returns error changeset" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert {:error, %Ecto.Changeset{}} = Platform.update_team(team, @invalid_team_attrs)
      assert team == Platform.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert {:ok, %Team{}} = Platform.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Platform.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      {_conference, _division, team} = conference_division_and_team_fixture()
      assert %Ecto.Changeset{} = Platform.change_team(team)
    end
  end


end
