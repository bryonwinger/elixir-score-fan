defmodule ScoreFan.DivisionTest do
  use ScoreFan.DataCase
  alias ScoreFan.Platform.Division

  @valid_attrs %{name: "some name", is_active: true}
  @invalid_attrs %{name: nil, is_active: nil}

  test "changeset with valid attributes" do
    changeset = Division.changeset(%Division{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.name == @valid_attrs.name
    assert changeset.changes.is_active == @valid_attrs.is_active
  end

  test "changeset with invalid attributes" do
    changeset = Division.changeset(%Division{}, @invalid_attrs)
    refute changeset.valid?
    assert %{name: ["can't be blank"]} = errors_on(changeset)
    assert %{is_active: ["can't be blank"]} = errors_on(changeset)
  end
end
