defmodule ScoreFan.PlatformTest do
  use ScoreFan.DataCase
  alias ScoreFan.Platform

  describe "conferences" do
    alias ScoreFan.Platform.Conference

    @valid_attrs %{name: "some name", is_active: true}
    @update_attrs %{name: "updated name"}
    @invalid_attrs %{name: nil, is_active: nil}

    def conference_fixture(attrs \\ %{}) do
      {:ok, conference} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Platform.create_conference()

      conference
    end

    test "list_conferences/0 returns all conferences" do
      conference = conference_fixture()
      assert Platform.list_conferences() == [conference]
    end

    test "get_conference!/1 returns the conference with given id" do
      conference = conference_fixture()
      assert Platform.get_conference!(conference.id) == conference
    end

    test "create_conference/1 with valid data creates a conference" do
      assert {:ok, %Conference{} = conference} = Platform.create_conference(@valid_attrs)
      assert conference.name == @valid_attrs.name
    end

    test "create_conference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platform.create_conference(@invalid_attrs)
    end

    test "update_conference/2 with valid data updates the conference" do
      conference = conference_fixture()
      assert {:ok, %Conference{} = updated_conference} = Platform.update_conference(conference, @update_attrs)
      assert updated_conference.name == @update_attrs.name
    end

    test "update_conference/2 with invalid data returns error changeset" do
      conference = conference_fixture()
      assert {:error, %Ecto.Changeset{}} = Platform.update_conference(conference, @invalid_attrs)
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
    alias ScoreFan.Platform.Division

    @valid_attrs %{name: "some name", is_active: true}
    @update_attrs %{name: "updated name"}
    @invalid_attrs %{name: nil, is_active: nil}

    def division_fixture(attrs \\ %{}) do
      {:ok, division} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Platform.create_division()

      division
    end

    test "list_divisions/0 returns all divisions" do
      division = division_fixture()
      assert Platform.list_divisions() == [division]
    end

    test "get_division!/1 returns the division with given id" do
      division = division_fixture()
      assert Platform.get_division!(division.id) == division
    end

    test "create_division/1 with valid data creates a division" do
      assert {:ok, %Division{} = division} = Platform.create_division(@valid_attrs)
      assert division.name == @valid_attrs.name
    end

    test "create_division/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platform.create_division(@invalid_attrs)
    end

    test "update_division/2 with valid data updates the division" do
      division = division_fixture()
      assert {:ok, %Division{} = updated_division} = Platform.update_division(division, @update_attrs)
      assert updated_division.name == @update_attrs.name
    end

    test "update_division/2 with invalid data returns error changeset" do
      division = division_fixture()
      assert {:error, %Ecto.Changeset{}} = Platform.update_division(division, @invalid_attrs)
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


end
