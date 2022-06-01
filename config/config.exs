# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :keen_auth_demo,
  ecto_repos: [KeenAuthDemo.Repo]

# Configures the endpoint
config :keen_auth_demo, KeenAuthDemoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: KeenAuthDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: KeenAuthDemo.PubSub,
  live_view: [signing_salt: "V0+46nvI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :keen_auth,
#  auth_controller: MyAppWeb.AuthController,
  strategies: [
    aad: [
      strategy: Assent.Strategy.Azure,
      processor: KeenAuthDemoWeb.Auth.Processor,
      config: [
        tenant_id: "REPLACE_WITH_PROPPER_VALUE",
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "http://localhost:4000/aad/callback"
      ]
    ],
    github: [
      strategy: Assent.Strategy.Github,
      processor: KeenAuthDemoWeb.Auth.Processor,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/github/callback"
      ]
    ],
    facebook: [
      strategy: Assent.Strategy.Facebook,
      processor: KeenAuthDemoWeb.Auth.Processor,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/facebook/callback"
      ]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

File.regular?("config/.local.exs") && import_config ".local.exs"
