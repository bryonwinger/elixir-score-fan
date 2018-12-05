defmodule ScoreFan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__
  alias ScoreFan.Accounts

  schema "users" do
    field :email, :string
    field :email_confirmation, :string, virtual: true
    field :is_active, :boolean, default: false
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :password_updated_at, :utc_datetime
    field :identity_token, :string
    field :identity_token_updated_at, :utc_datetime

    timestamps()
  end


  @required_fields [:email, :is_active]
  @fields @required_fields ++ [:password, :password_updated_at, :identity_token]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> put_password_hash()
    |> put_password_updated_at()
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :email_confirmation, :identity_token])
    |> validate_required([:email, :email_confirmation, :identity_token])
    |> validate_emails_match()
    |> unique_constraint(:email)
    |> put_identity_token_updated_at()
  end

  def password_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_passwords_match()
    |> put_password_hash()
    |> put_password_updated_at()
  end

  def identity_token_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:identity_token])
    |> validate_required([:identity_token])
    |> put_identity_token_updated_at()
  end

  def nilify_identity_token_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [])
    |> put_change(:identity_token, nil)
    |> put_identity_token_updated_at()
  end

  defp validate_emails_match(
    %Ecto.Changeset{changes: %{email: email1, email_confirmation: email2}} = changeset
  ) when not is_nil(email1) and not is_nil(email2) do
    if email1 == email2 do
      changeset
    else
      add_error(changeset, :email_confirmation, "does not match email")
    end
  end

  defp validate_emails_match(changeset), do: changeset

  defp validate_passwords_match(
    %Ecto.Changeset{valid?: true, changes: %{password: password1, password_confirmation: password2}} = changeset
  ) do
    if password1 == password2 do
      changeset
    else
      add_error(changeset, :password_confirmation, "does not match password")
    end
  end

  defp validate_passwords_match(changeset), do: changeset

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset

  defp put_password_updated_at(%Ecto.Changeset{valid?: true, changes: %{password: _}} = changeset) do
    dt = DateTime.utc_now() |> DateTime.truncate(:second)
    put_change(changeset, :password_updated_at, dt)
  end

  defp put_password_updated_at(changeset), do: changeset

  def put_identity_token_updated_at(
    %Ecto.Changeset{valid?: true, changes: %{identity_token: _}} = changeset
  ) do
    dt = DateTime.utc_now() |> DateTime.truncate(:second)

    changeset
    |> put_change(:identity_token_updated_at, dt)
  end

  def put_identity_token_updated_at(changeset) do
    changeset
  end
end
