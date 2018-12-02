defmodule ScoreFan.Platform do
  @moduledoc """
  The Platform context.
  """

  import Ecto.Query, warn: false
  alias ScoreFan.Repo

  alias ScoreFan.Platform.{Conference, Division, Team}

  #
  # Conferences
  #

  @doc """
  Returns the list of conferences.

  ## Examples

      iex> list_conferences()
      [%Conference{}, ...]

  """
  def list_conferences do
    Repo.all(Conference)
  end

  @doc """
  Gets a single conference.

  Raises `Ecto.NoResultsError` if the Conference does not exist.

  ## Examples

      iex> get_conference!(123)
      %Conference{}

      iex> get_conference!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conference!(id), do: Repo.get!(Conference, id)

  @doc """
  Creates a conference.

  ## Examples

      iex> create_conference(%{field: value})
      {:ok, %Conference{}}

      iex> create_conference(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conference(attrs \\ %{}) do
    %Conference{}
    |> Conference.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a conference. Raises on failure.

  ## Examples

      iex> create_conference!(%{field: value})
      %Conference{}

      iex> create_conference!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_conference!(attrs \\ %{}) do
    %Conference{}
    |> Conference.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Gets an existing conference or creates it if it doesn't exist.

  ## Examples

      iex> get_or_create_conference(%{field: value})
      {:ok, %Conference{}}

      iex> get_or_create_conference(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def get_or_create_conference(attrs \\ %{}) do
    lookup_attrs = Map.take(attrs, [:name])
    Repo.get_by(Conference, lookup_attrs) || create_conference!(attrs)
  end

  @doc """
  Updates a conference.

  ## Examples

      iex> update_conference(conference, %{field: new_value})
      {:ok, %Conference{}}

      iex> update_conference(conference, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conference(%Conference{} = conference, attrs) do
    conference
    |> Conference.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Conference.

  ## Examples

      iex> delete_conference(conference)
      {:ok, %Conference{}}

      iex> delete_conference(conference)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conference(%Conference{} = conference) do
    Repo.delete(conference)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conference changes.

  ## Examples

      iex> change_conference(conference)
      %Ecto.Changeset{source: %Conference{}}

  """
  def change_conference(%Conference{} = conference) do
    Conference.changeset(conference, %{})
  end

  #
  # Divisions
  #

  @doc """
  Returns the list of divisions.

  ## Examples

      iex> list_divisions()
      [%Division{}, ...]

  """
  def list_divisions do
    Repo.all(Division)
  end

  @doc """
  Gets a single division.

  Raises `Ecto.NoResultsError` if the Division does not exist.

  ## Examples

      iex> get_division!(123)
      %Division{}

      iex> get_division!(456)
      ** (Ecto.NoResultsError)

  """
  def get_division!(id), do: Repo.get!(Division, id)

  @doc """
  Creates a division.

  ## Examples

      iex> create_division(%{field: value})
      {:ok, %Division{}}

      iex> create_division(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_division(attrs \\ %{}) do
    %Division{}
    |> Division.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a division. Raises on failure.

  ## Examples

      iex> create_division!(%{field: value})
      %Division{}

      iex> create_division!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_division!(attrs \\ %{}) do
    %Division{}
    |> Division.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Gets an existing division or creates it if it doesn't exist.

  ## Examples

      iex> get_or_create_division(%{field: value})
      {:ok, %Division{}}

      iex> get_or_create_division(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def get_or_create_division(attrs \\ %{}) do
    lookup_attrs = Map.take(attrs, [:name])
    Repo.get_by(Division, lookup_attrs) || create_division!(attrs)
  end

  @doc """
  Updates a division.

  ## Examples

      iex> update_division(division, %{field: new_value})
      {:ok, %Division{}}

      iex> update_division(division, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_division(%Division{} = division, attrs) do
    division
    |> Division.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Division.

  ## Examples

      iex> delete_division(division)
      {:ok, %Division{}}

      iex> delete_division(division)
      {:error, %Ecto.Changeset{}}

  """
  def delete_division(%Division{} = division) do
    Repo.delete(division)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking division changes.

  ## Examples

      iex> change_division(division)
      %Ecto.Changeset{source: %Division{}}

  """
  def change_division(%Division{} = division) do
    Division.changeset(division, %{})
  end

  #
  # Teams
  #

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Returns the list of teams matching the given criteria.

  ## Examples

      iex> list_teams_by(sport_type: "BASEBALL")
      [%Team{}, ...]

  """
  def list_teams_by(criteria) when is_list(criteria) do
    Team
    |> where([_team], ^criteria)
    |> Repo.all()
  end

  # @doc """
  # Gets a single team.

  # Returns `nil` if the Team does not exist.

  # ## Examples

  #     iex> get_team!(123)
  #     %Team{}

  #     iex> get_team!(456)
  #     nil

  # """
  # def get_team(id), do: Repo.get(Team, id)

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a team. Raises on failure.

  ## Examples

      iex> create_team!(%{field: value})
      %Team{}

      iex> create_team!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_team!(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Gets an existing team or creates it if it doesn't exist.

  ## Examples

      iex> get_or_create_team(%{field: value})
      %Team{}

      iex> get_or_create_team(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def get_or_create_team(attrs \\ %{}) do
    lookup_attrs = Map.take(attrs, [:name, :sport_type])
    Repo.get_by(Team, lookup_attrs) || create_team!(attrs)
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end
end
