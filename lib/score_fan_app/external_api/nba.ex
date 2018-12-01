defmodule ScoreFan.ExternalAPI.NBA do
  @moduledoc """
  The NBA context.
  """

  alias ScoreFan.ExternalAPI
  alias ScoreFan.ExternalAPI.NBARoutes
  alias ScoreFan.Util

  def load_team_data do
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
end
