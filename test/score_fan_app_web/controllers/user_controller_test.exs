defmodule ScoreFanWeb.UserControllerTest do
  use ScoreFanWeb.ConnCase

  alias ScoreFan.Accounts

  @register_attrs %{email: "abc@def.com", email_confirmation: "abc@def.com"}
  @invalid_register_attrs %{email: "abc@def.com", email_confirmation: "abc@123.com."}

  # def fixture(:user) do
  #   {:ok, user} = Accounts.create_user(@create_attrs)
  #   user
  # end

  describe "registration" do
    test "redirects to sign_in when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :register), user: @register_attrs)

      assert params = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :sign_in_new)

      # User was created
      assert %Accounts.User{} = user = Accounts.get_user_by_email(@register_attrs.email)
      assert user.email == @register_attrs.email
      refute is_nil(user.identity_token)
      refute is_nil(user.identity_token_updated_at)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :register), user: @invalid_register_attrs)
      assert html_response(conn, 200) =~ "Register New Account"
      assert html_response(conn, 200) =~ "does not match email"
    end
  end

  # describe "create user" do
  #   test "redirects to show when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

  #     assert %{id: id} = redirected_params(conn)
  #     assert redirected_to(conn) == Routes.user_path(conn, :show, id)

  #     conn = get(conn, Routes.user_path(conn, :show, id))
  #     assert html_response(conn, 200) =~ "Show User"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "New User"
  #   end
  # end

  # describe "edit user" do
  #   setup [:create_user]

  #   test "renders form for editing chosen user", %{conn: conn, user: user} do
  #     conn = get(conn, Routes.user_path(conn, :edit, user))
  #     assert html_response(conn, 200) =~ "Edit User"
  #   end
  # end

  # describe "update user" do
  #   setup [:create_user]

  #   test "redirects when data is valid", %{conn: conn, user: user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
  #     assert redirected_to(conn) == Routes.user_path(conn, :show, user)

  #     conn = get(conn, Routes.user_path(conn, :show, user))
  #     assert html_response(conn, 200)
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, user: user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "Edit User"
  #   end
  # end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert redirected_to(conn) == Routes.user_path(conn, :index)
  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end

  # defp create_user(_) do
  #   user = fixture(:user)
  #   {:ok, user: user}
  # end
end
