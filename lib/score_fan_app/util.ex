defmodule ScoreFan.Util do
  @moduledoc """
  The Util context.
  """

  def convert_keys_to_underscore(list) when is_list(list) do
    list
    |> Enum.map(&convert_keys_to_underscore/1)
  end

  def convert_keys_to_underscore(%{} = map) do
    map
    |> Enum.into(%{}, fn {k, v} -> {Macro.underscore(k), v} end)
  end

  def stringify_keys(map) when is_map(map) do
    map
    |> Enum.into(%{}, fn {k, v} -> {to_string(k), v} end)
  end
end
