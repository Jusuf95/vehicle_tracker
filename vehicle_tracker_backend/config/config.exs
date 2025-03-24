# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :vehicle_tracker,
  ecto_repos: [VehicleTracker.Repo],
  generators: [timestamp_type: :utc_datetime]

#Configuration for auth
config :vehicle_tracker, VehicleTrackerWeb.Auth.Guardian,
  issuer: "vehicle_tracker",
  secret_key: "super_secret_key"

# Configures the endpoint
config :vehicle_tracker, VehicleTrackerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: VehicleTrackerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: VehicleTracker.PubSub,
  live_view: [signing_salt: "6ZNexE3F"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :vehicle_tracker, VehicleTracker.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
