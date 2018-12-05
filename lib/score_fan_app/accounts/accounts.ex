defmodule ScoreFan.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ScoreFan.Repo

  alias ScoreFan.Accounts.User
  alias ScoreFan.Util

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by email.

  Returns nil if the User does not exist.

  ## Examples

      iex> get_user_by_email("some@body.net")
      %User{}

      iex> get_user_by_email("no@body.net")
      nil

  """
  def get_user_by_email(email), do: Repo.get_by(User, %{email: email})

  @doc """
  Gets a single user by identity_token.

  Returns nil if the User does not exist.

  ## Examples

      iex> get_user_by_identity_token!("s0met0k3n")
      %User{}

      iex> get_user_by_identity_token!("badtoken")
      nil

  """
  def get_user_by_identity_token(token), do: Repo.get_by(User, %{identity_token: token})

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a registered user without a password.

  ## Examples

      iex> create_user_registration(%{email: "email@example.com", email_confirmation: "email@example.com"})
      {:ok, %User{}}

      iex> create_user_registration(%{email: "email@example.com", email_confirmation: "bad@example.com"})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_registration(attrs \\ %{}) do
    # Stringify keys before the call to cast. We are converting to strings instead
    # of atoms as those are not garbage collected and to_existing_atom/1 would bork
    # on unexpected keys.
    attrs =
      attrs
      |> Util.stringify_keys()
      |> Map.merge(%{"identity_token" => generate_identity_token()})

    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for user password changes.

  ## Examples

      iex> change_user_password(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user_password(%User{} = user) do
    User.password_changeset(user, %{})
  end


  @doc """
  Generates an :identity_token for the user and sets the timestamp
  for :identity_token_updated_at.
  """
  def generate_identity_token_for_user(%User{} = user) do
    attrs = %{identity_token: generate_identity_token()}

    user
    |> User.identity_token_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Nillifies a users :identity_token
  """
  def nilify_identity_token_for_user(%User{} = user) do
    user
    |> User.nilify_identity_token_changeset(%{})
    |> Repo.update()
  end

  @doc """
  Generates a random URL-safe string for identity tokens.

  ## Examples

      iex> generate_identity_token()
      %Ecto.Changeset{source: %User{}}

  """
  def generate_identity_token do
    :crypto.strong_rand_bytes(128)
    |> Base.url_encode64(padding: false)
  end

  @doc """
  Check if a User's :identity_token has expired.

  TODO: This may fit better in Auth.
  """
  def validate_identity_token_for_user(%User{} = user) do
    with now <- DateTime.utc_now(),
         stale_dt <- DateTime.add(now, 15 * 60, :second),
         {:identity_token, token} when not is_nil(token) <- {:identity_token, user.identity_token},
          {:identity_token_dt, %DateTime{} = inserted_at} <-
            {:identity_token_dt, user.identity_token_updated_at},
            result when result in [:lt, :eq] <- DateTime.compare(inserted_at, stale_dt) do
      {:ok, token}
    else
      {:identity_token, nil} -> {:error, :no_token}
      {:identity_token_dt, nil} -> {:error, :no_token_timestamp}
      :gt -> {:error, :expired_token}
    end
  end
end
