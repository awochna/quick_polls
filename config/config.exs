# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quick_polls,
  ecto_repos: [QuickPolls.Repo]

# Configures the endpoint
config :quick_polls, QuickPolls.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EkIz2HvxIbGqVY1mIU6N4TiifJQuLlgSmgI8rpVx3sG+F+AlA5Or6iTNwJCzM6vh",
  render_errors: [view: QuickPolls.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuickPolls.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Doorman
config :doorman,
  repo: QuickPolls.Repo,
  secure_with: Doorman.Auth.Bcrypt,
  user_module: QuickPolls.User

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
