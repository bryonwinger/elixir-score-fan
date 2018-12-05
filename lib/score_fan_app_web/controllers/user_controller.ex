defmodule ScoreFanWeb.UserController do
  use ScoreFanWeb, :controller

  alias ScoreFan.Accounts
  alias ScoreFan.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def register_new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "register.html", changeset: changeset)
  end

  def register(conn, %{"user" => params}) do
    case Accounts.user_registration_changeset(params) do
      %Ecto.Changeset{valid?: true} ->
        conn
        |> put_flash(:info, "Thanks for signing up!")
        |> redirect(to: Routes.user_path(conn, :sign_in_new))

      %Ecto.Changeset{valid?: false} = changeset ->
        IO.inspect(changeset)
        conn
        |> render("register.html", changeset: changeset)
    end
  end

  def sign_in_new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "sign_in.html", changeset: changeset)
  end

  def sign_in(conn, %{"user" => params}) do
    require IEx
    IEx.pry()

    # case User.create_session(session_params) do
    #   {:ok, user} ->
    #     conn
    #     |> put_flash(:info, "Session created successfully.")
    #     |> redirect(to: Routes.user_path(conn, :show, user))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end

  def sign_out(conn, %{"id" => id}) do
  #   session = Session.get_session!(id)
  #   {:ok, _session} = Session.delete_session(session)

  #   conn
  #   |> put_flash(:info, "Session deleted successfully.")
  #   |> redirect(to: Routes.user_path(conn, :index))
  end
end
