# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :score_fan_app,
  namespace: ScoreFan,
  ecto_repos: [ScoreFan.Repo]

# Configures the endpoint
config :score_fan_app, ScoreFanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5RYs1TjstwXMhmrx49crz0pGsNhag8nlY397Ie+ZCJ0QkgyOmcUu8TnKpOtk4k3L",
  render_errors: [view: ScoreFanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ScoreFan.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
