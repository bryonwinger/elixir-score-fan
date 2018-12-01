use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :score_fan_app, ScoreFanWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :score_fan_app, ScoreFan.Repo,
  username: "postgres",
  password: "postgres",
  database: "score_fan_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Speed up password hashing during tests
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
