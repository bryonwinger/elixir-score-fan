defmodule ScoreFan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  schema "users" do
    field :email, :string
    field :is_active, :boolean, default: false
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_updated_at, :utc_datetime

    timestamps()
  end


  @required_fields [:email, :is_active]
  @fields @required_fields ++ [:password, :password_updated_at]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> put_password_hash()
    |> put_password_updated_at()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end

  defp put_password_updated_at(%Ecto.Changeset{valid?: true, changes: %{password: _}} = changeset) do
    dt = DateTime.utc_now() |> DateTime.truncate(:second)
    cs = put_change(changeset, :password_updated_at, dt)
    cs
  end

  defp put_password_updated_at(changeset) do
    changeset
  end
end
