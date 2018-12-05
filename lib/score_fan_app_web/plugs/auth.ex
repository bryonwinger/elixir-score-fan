defmodule ScoreFanWeb.Plugs.Auth do
  @moduledoc """
  Plug for authorization functions.
  """

  import Plug.Conn
  alias ScoreFan.Accounts
  alias ScoreFan.Accounts.User

  def login_by_identity_token(conn, token) do
    # TODO: this might be better handled as a transaction
    with {:get_user, %User{} = user} <-
           {:get_user, Accounts.get_user_by_identity_token(token)},
         {:ok, _token} <-
            Accounts.validate_identity_token_for_user(user),
         {:ok, %User{} = user} <-
            Accounts.nilify_identity_token_for_user(user) do
      {:ok, login(conn, user)}
    else
      {:get_user, nil} -> {:error, :invalid_token, conn}
      {:error, :no_token} -> {:error, :invalid_token, conn}
      {:error, :no_token_dt} -> {:error, :expired_token, conn}
    end
  end

  defp login(conn, user) do
    conn
    |> assign(:user, user)
    |> configure_session(renew: true)
  end
end
