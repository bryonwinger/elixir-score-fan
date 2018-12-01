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

  @fields [:email, :is_active]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @fields ++ [:password])
    |> validate_required(@fields)
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

  defp put_password_updated_at(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: _}} ->
        dt = DateTime.utc_now() |> DateTime.truncate(:second)
        put_change(changeset, :password_updated_at, dt)

      _ ->
        changeset
    end
  end
end
