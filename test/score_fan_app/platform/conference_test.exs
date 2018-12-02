defmodule ScoreFan.ConferenceTest do
  use ScoreFan.DataCase
  alias ScoreFan.Platform.Conference

  @valid_attrs %{name: "some name", is_active: true}
  @invalid_attrs %{name: nil, is_active: nil}

  test "changeset with valid attributes" do
    changeset = Conference.changeset(%Conference{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.name == @valid_attrs.name
    assert changeset.changes.is_active == @valid_attrs.is_active
  end

  test "changeset with invalid attributes" do
    changeset = Conference.changeset(%Conference{}, @invalid_attrs)
    refute changeset.valid?
    assert %{name: ["can't be blank"]} = errors_on(changeset)
    assert %{is_active: ["can't be blank"]} = errors_on(changeset)
  end
end
