use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quick_polls, QuickPolls.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Drop requirements for password hashing intensiveness.
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# Configure your database
config :quick_polls, QuickPolls.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "secret",
  database: "quick_polls_test",
  hostname: System.get_env("POSTGRES_HOST") || "172.17.0.2",
  pool: Ecto.Adapters.SQL.Sandbox
