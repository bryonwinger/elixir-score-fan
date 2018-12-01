defmodule ScoreFan.Repo do
  use Ecto.Repo,
    otp_app: :score_fan_app,
    adapter: Ecto.Adapters.Postgres
end
