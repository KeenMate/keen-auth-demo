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

common_auth_processor = KeenAuthDemoWeb.Auth.Processor
config :keen_auth,
  # storage: KeenAuthDemoWeb.Auth.SessionStorage,
  strategies: [
    aad: [
      strategy: Assent.Strategy.AzureAD,
      mapper: KeenAuth.UserMappers.AzureAD,
      processor: common_auth_processor,
      config: [
        tenant_id: "REPLACE_WITH_PROPPER_VALUE",
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "http://localhost:4000/aad/callback"
      ]
    ],
    github: [
      strategy: Assent.Strategy.Github,
      mapper: KeenAuth.UserMappers.Github,
      processor: common_auth_processor,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/github/callback"
      ]
    ],
    facebook: [
      strategy: Assent.Strategy.Facebook,
      mapper: KeenAuth.UserMappers.Facebook,
      processor: common_auth_processor,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/facebook/callback"
      ]
    ]
  ]


config :ecto_gen,
  otp_app: :keen_auth_demo,
  db_config: KeenAuthDemo.Repo,
  # relative path should be relative to the project root
  output_location: "lib/keen_auth_demo/database",
  # Module prefix that will be used for generated content
  output_module: "KeenAuthDemo.Database",

  # This way, you can provide custom template for individual parts of generation
  # default files are in /priv/templates directory of this package
  # template_overrides: [
  #   db_module: "/path/to/db_module.ex.eex",
  #   routine: "/path/to/db_routine.ex.eex",
  #   routine_result: "/path/to/db_routine_result.ex.eex",
  #   routine_parser: "/path/to/db_routine_parser.ex.eex"
  # ],

  # This config holds information about what routines (funcs) from database will have generated elixir functions etc.
  # db project has keys, each representing database's schema which has config for what routines it includes/ingores
  db_project: [
    auth: [
      funcs: "*"
    ],
    public: [
      # or ["func_name_1", "func_name_2"]
      funcs: "*",

      # makes sense to specify ignored functions (routines) only when funcs equal "*"
      ignored_funcs: []
    ]
  ]

config :keen_auth_permissions,
  tenant_id: nil,
  db_context: KeenAuthDemo.Database.DbContext

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

File.regular?("config/.local.exs") && import_config ".local.exs"
