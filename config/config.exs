# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sheet_text,
  ecto_repos: [SheetText.Repo]

# Configures the endpoint
config :sheet_text, SheetTextWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Pd2cfgKFMMFUvtYWo3b345P4o1VsGL3Y2N4NVlmyDIoo+MVpIJt5qj4OlzuG5Wga",
  render_errors: [view: SheetTextWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SheetText.PubSub,
  live_view: [signing_salt: "b51QfIl2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sheet_text, SheetText.Oauth.Google,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
