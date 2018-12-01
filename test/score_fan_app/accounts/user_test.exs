defmodule ScoreFan.UserTest do
  use ScoreFan.DataCase
  alias ScoreFan.Accounts.User

  @valid_attrs %{email: "some email", is_active: true, password: "P@ssw0rd"}
  @update_attrs %{email: "some updated email", is_active: false, password: "some_new_password"}
  @invalid_attrs %{email: nil, is_active: nil, password: nil}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.email == @valid_attrs.email
    assert changeset.changes.is_active == @valid_attrs.is_active
    refute is_nil(changeset.changes.password_hash)
    refute is_nil(changeset.changes.password_updated_at)
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
    assert %{email: ["can't be blank"]} = errors_on(changeset)
    assert %{is_active: ["can't be blank"]} = errors_on(changeset)
  end
end
