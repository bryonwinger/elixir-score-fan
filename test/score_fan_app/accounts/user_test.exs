defmodule ScoreFan.UserTest do
  use ScoreFan.DataCase
  alias ScoreFan.Accounts.User

  @valid_attrs %{email: "some email", is_active: true, password: "P@ssw0rd"}
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

  test "registration_changeset with valid attributes" do
    attrs = %{email: "myemail@example.com", email_confirmation: "myemail@example.com", identity_token: "mytoken"}
    changeset = User.registration_changeset(%User{}, attrs)
    assert changeset.valid?
    assert changeset.changes.email == attrs.email
    assert changeset.changes.email_confirmation == attrs.email_confirmation
    assert changeset.changes.identity_token == attrs.identity_token
    refute is_nil(get_field(changeset, :identity_token_updated_at))
  end

  test "registration_changeset with invalid attributes" do
    attrs = %{email: "myemail@example.com", email_confirmation: "myemail2@example.com", identity_token: nil}
    changeset = User.registration_changeset(%User{}, attrs)
    refute changeset.valid?
    assert %{email_confirmation: ["does not match email"]} = errors_on(changeset)
    assert %{identity_token: ["can't be blank"]} = errors_on(changeset)
    assert is_nil(get_field(changeset, :identity_token_updated_at))
  end
end
