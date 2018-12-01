defmodule ScoreFan.ExternalAPI do
  @moduledoc """
  The APICaller context.
  """

  require Logger

  def call(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 301, headers: headers}} ->
        case List.keyfind(headers, "Location", 0) do
          {"Location", new_location} ->
            call(new_location)

          _ ->
            nil
        end

      {:ok, _resp} ->
        nil

      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Could not retreive data from '#{url}': #{inspect(reason)}")
        {:error, reason}
    end
  end

  def parse_json(json_body) do
    case Jason.decode(json_body) do
      {:ok, result} -> result
      {:error, reason} ->
        Logger.error("[#{__MODULE__}] Could not parse data as json: #{inspect(reason)}")
      {:error, reason}
      end
  end
end
