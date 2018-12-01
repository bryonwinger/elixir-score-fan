defmodule ScoreFan.ExternalAPI.NBARoutes do
  @moduledoc """
  The NBARoutes context. Mostly a static collection of API URLs that would be
  better stored somewhere configurable and reloadable. This is just easier for now.

  The list of routes comes from routes defined at http://data.nba.net/10s/prod/v1/today.json
  """

  def root_url do
    "http://data.nba.net/10s"
  end

  def today(format \\ "json") do
    [root_url(), "10s/prod/v1/today.#{format}"]
    |> Enum.join("/")
  end

  def calendar(format \\ "json") do
    [root_url(), "prod/v1/calendar.#{format}"]
    |> Enum.join("/")
  end

  def today_scoreboard(format \\ "json") do
    [root_url(), "prod/v1/20181130/scoreboard.#{format}"]
    |> Enum.join("/")
  end

  def current_scoreboard(format \\ "json") do
    [root_url(), "prod/v1/20181130/scoreboard.#{format}"]
    |> Enum.join("/")
  end

  def scoreboard(game_date, format \\ "json") do
    [root_url(), "prod/v2/#{game_date}/scoreboard.#{format}"]
    |> Enum.join("/")
  end

  def teams(format \\ "json") do
    [root_url(), "prod/v2/2018/teams.#{format}"]
    |> Enum.join("/")
  end

  def league_roster_players(format \\ "json") do
    [root_url(), "prod/v1/2018/players.#{format}"]
    |> Enum.join("/")
  end

  def allstar_roster(format \\ "json") do
    [root_url(), "prod/v1/allstar/2017/AS_roster.#{format}"]
    |> Enum.join("/")
  end

  def league_roster_coaches(format \\ "json") do
    [root_url(), "prod/v1/2018/coaches.#{format}"]
    |> Enum.join("/")
  end

  def league_schedule(format \\ "json") do
    [root_url(), "prod/v1/2018/schedule.#{format}"]
    |> Enum.join("/")
  end

  def league_conference_standings(format \\ "json") do
    [root_url(), "prod/v1/current/standings_conference.#{format}"]
    |> Enum.join("/")
  end

  def league_division_standings(format \\ "json") do
    [root_url(), "prod/v1/current/standings_division.#{format}"]
    |> Enum.join("/")
  end

  def league_ungrouped_standings(format \\ "json") do
    [root_url(), "prod/v1/current/standings_all.#{format}"]
    |> Enum.join("/")
  end

  def league_mini_standings(format \\ "json") do
    [root_url(), "prod/v1/current/standings_all_no_sort_keys.#{format}"]
    |> Enum.join("/")
  end

  def league_team_stats_leaders(format \\ "json") do
    [root_url(), "prod/v1/2018/team_stats_rankings.#{format}"]
    |> Enum.join("/")
  end

  def league_last_five_game_team_stats(format \\ "json") do
    [root_url(), "prod/v1/2018/team_stats_last_five_games.#{format}"]
    |> Enum.join("/")
  end

  def preview_article(game_date, game_id, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_preview_article.#{format}"]
    |> Enum.join("/")
  end

  def recap_article(game_date, game_id, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_recap_article.#{format}"]
    |> Enum.join("/")
  end

  def boxscore(game_date, game_id, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_boxscore.#{format}"]
    |> Enum.join("/")
  end

  def mini_boxscore(game_date, game_id, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_mini_boxscore.#{format}"]
    |> Enum.join("/")
  end

  def pbp(game_date, game_id, period_num, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_pbp_#{period_num}.#{format}"]
    |> Enum.join("/")
  end

  def lead_tracker(game_date, game_id, period_num, format \\ "json") do
    [root_url(), "prod/v1/#{game_date}/#{game_id}_lead_tracker_#{period_num}.#{format}"]
    |> Enum.join("/")
  end

  def player_game_log(person_id, format \\ "json") do
    [root_url(), "prod/v1/2018/players/#{person_id}_gamelog.#{format}"]
    |> Enum.join("/")
  end

  def player_profile(person_id, format \\ "json") do
    [root_url(), "prod/v1/2018/players/#{person_id}_profile.#{format}"]
    |> Enum.join("/")
  end

  def player_uber_stats(person_id, format \\ "json") do
    [root_url(), "prod/v1/2018/players/#{person_id}_uber_stats.#{format}"]
    |> Enum.join("/")
  end

  def team_schedule(team_url_code, format \\ "json") do
    [root_url(), "prod/v1/2018/teams/#{team_url_code}/schedule.#{format}"]
    |> Enum.join("/")
  end

  def teams_config(format \\ "json") do
    [root_url(), "prod/2018/teams_config.#{format}"]
    |> Enum.join("/")
  end

  def team_roster(team_url_code, format \\ "json") do
    [root_url(), "prod/v1/2018/teams/#{team_url_code}/roster.#{format}"]
    |> Enum.join("/")
  end

  def teams_config_year(season_schedule_year, format \\ "json") do
    [root_url(), "prod/#{season_schedule_year}/teams_config.#{format}"]
    |> Enum.join("/")
  end

  def team_schedule_year(season_schedule_year, team_url_code, format \\ "json") do
    [root_url(), "prod/v1/#{season_schedule_year}/teams/#{team_url_code}/schedule.#{format}"]
    |> Enum.join("/")
  end

  def team_leaders(team_url_code, format \\ "json") do
    [root_url(), "prod/v1/2018/teams/#{team_url_code}/leaders.#{format}"]
    |> Enum.join("/")
  end

  def team_schedule_year2(season_schedule_year, team_id, format \\ "json") do
    [root_url(), "prod/v1/#{season_schedule_year}/teams/#{team_id}/schedule.#{format}"]
    |> Enum.join("/")
  end

  def team_leaders2(team_id, format \\ "json") do
    [root_url(), "prod/v1/2018/teams/#{team_id}/leaders.#{format}"]
    |> Enum.join("/")
  end

  def playoffs_bracket(format \\ "json") do
    [root_url(), "prod/v1/2017/playoffsBracket.#{format}"]
    |> Enum.join("/")
  end

  def playoff_series_leaders(series_id, format \\ "json") do
    [root_url(), "prod/v1/2018/playoffs_#{series_id}_leaders.#{format}"]
    |> Enum.join("/")
  end
end
