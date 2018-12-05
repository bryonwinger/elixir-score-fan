defmodule ScoreFan.AccountsTest do
  use ScoreFan.DataCase
  alias ScoreFan.Accounts

  describe "users" do
    alias ScoreFan.Accounts.User

    @valid_attrs %{email: "some email", is_active: true, password: "P@ssw0rd"}
    @update_attrs %{email: "some updated email", is_active: false, password: "some_new_password"}
    @invalid_attrs %{email: nil, is_active: nil, password: nil}

    @valid_registration_attrs %{email: "some email", email_confirmation: "some email", identity_token: "token"}
    @invalid_registration_attrs %{email: nil, email_confirmation: nil, identity_token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [%User{user | password: nil}]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == %User{user | password: nil}
    end

    test "get_user_by_email/1 returns the user with given email" do
      user = user_fixture()
      assert Accounts.get_user_by_email(user.email) == %User{user | password: nil}
    end

    test "get_user_by_email/1 returns nil if the user is not found" do
      assert is_nil(Accounts.get_user_by_email("some@email.com"))
    end

    test "get_user_by_identity_token/1 returns the user with given token" do
      user = user_fixture(%{identity_token: "mytoken"})
      assert Accounts.get_user_by_identity_token(user.identity_token) == %User{user | password: nil}
    end

    test "get_user_by_identity_token/1 returns nil if the user is not found" do
      assert is_nil(Accounts.get_user_by_identity_token("sometoken"))
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.is_active == true
      refute is_nil(user.password_updated_at)
      assert is_nil(user.identity_token)
      assert is_nil(user.identity_token_updated_at)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_user_registration/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user_registration(@valid_registration_attrs)
      assert user.email == "some email"
      assert user.is_active == false
      assert is_nil(user.password_hash)
      assert is_nil(user.password_updated_at)
      refute is_nil(user.identity_token)
      refute is_nil(user.identity_token_updated_at)
    end

    test "create_user_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_registration(@invalid_registration_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = updated_user} = Accounts.update_user(user, @update_attrs)
      assert updated_user.email == "some updated email"
      assert updated_user.is_active == false
      refute user.password_hash == updated_user.password_hash
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert %User{user | password: nil} == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "generate_identity_token_for_user/1 updates the user" do
      user = user_fixture()
      assert is_nil(user.identity_token)

      assert {:ok, %User{} = updated_user} = Accounts.generate_identity_token_for_user(user)
      refute is_nil(updated_user.identity_token)
      refute is_nil(updated_user.identity_token_updated_at)
    end

    test "nilify_identity_token_for_user/1 updates the user" do
      user = user_fixture(%{identity_token: "token"})
      refute is_nil(user.identity_token)

      assert {:ok, %User{} = updated_user} = Accounts.nilify_identity_token_for_user(user)
      assert is_nil(updated_user.identity_token)
      refute is_nil(updated_user.identity_token_updated_at)
    end
  end
end
