defmodule ScoreFan.ExternalAPI.NBA do
  @moduledoc """
  The NBA context.
  """

  alias ScoreFan.ExternalAPI
  alias ScoreFan.ExternalAPI.NBARoutes
  alias ScoreFan.Platform
  alias ScoreFan.Util

  def get_team_data do
    with {:lookup_route, route} <- {:lookup_route, NBARoutes.teams()},
         {:call_api, body} when is_binary(body) <- {:call_api, ExternalAPI.call(route)},
         {:parse_data, data} <- {:parse_data, parse_teams_from_resp_body(body)},
         team_data <- Util.convert_keys_to_underscore(data) do
      # TODO: Transform keys into the correct structure for a Team ?
      team_data
    end
  end

  defp parse_teams_from_resp_body(body) do
    with {:parse_result, result} <- {:parse_result, ExternalAPI.parse_json(body)},
        {:get_standard_teams, [_ | _] = team_data} <-
          # Just use 'standard' leagues for now
          {:get_standard_teams, get_in(result, ["league", "standard"])} do
            team_data
    else
      {:get_standard_teams, []} -> {:error, :empty_teams_data}
      error -> error
    end
  end

  def map_data_to_attrs(data) do
    %{
      name: Map.get(data, "nickname"),
      city: Map.get(data, "city"),
      sport_type: "BASKETBALL",
      external_team_id: Map.get(data, "team_id"),
      is_active: true
    }
  end

  def reload_teams do
    data = get_team_data()

    conferences =
      data
      |> Enum.map(&Map.get(&1, "conf_name"))
      |> Enum.uniq()
      |> Enum.filter(&String.length(&1) > 0)
      |> Enum.map(&Platform.get_or_create_conference(%{name: &1}))

    divisions =
      data
      |> Enum.map(&Map.get(&1, "div_name"))
      |> Enum.uniq()
      |> Enum.filter(&String.length(&1) > 0)
      |> Enum.map(&Platform.get_or_create_division(%{name: &1}))

    data
    |> Enum.filter(fn td ->
      String.length(Map.get(td, "div_name", "")) > 0 &&
        String.length(Map.get(td, "conf_name", "")) > 0
    end)
    |> Enum.map(fn team_data ->
      conference = Enum.find(conferences, & &1.name == Map.get(team_data, "conf_name"))
      division = Enum.find(divisions, & &1.name == Map.get(team_data, "div_name"))

      team_data
      |> map_data_to_attrs()
      |> Map.merge(
        %{conference_id: conference.id, division_id: division.id}
      )
      |> Platform.get_or_create_team()
    end)
  end
end
