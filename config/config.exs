# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :url_shortener,
  ecto_repos: [UrlShortener.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :url_shortener, UrlShortenerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UrlShortenerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: UrlShortener.PubSub,
  live_view: [signing_salt: "Xw8wgaK1"]

config :url_shortener,
  open_page_rank_api_key: "YOUR_API_KEY",
  # In seconds
  default_expiration: 24 * 60 * 60,
  # Length of shortKey
  key_byte_count: 15,
  # Delete expired urls every n secondss
  sweep_every: 10 * 60

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
