import Config

# Configure your database
#config :keen_auth_demo, TestKeenAuth.Repo,
#  username: "postgres",
#  password: "postgres",
#  hostname: "localhost",
#  database: "keen_auth_demo_dev",
#  stacktrace: true,
#  show_sensitive_data_on_connection_error: true,
#  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :keen_auth_demo, TestKeenAuthWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  https: [
    ip: {127, 0, 0, 1},
    port: 4000,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "DNWc3Z4mQIqP40WsslODpOiwLo/6SYymX4CrDSWhB0DR8EaZeKRVtksEeEUDVgIF",
  watchers: []

config :keen_auth,
#  auth_controller: MyAppWeb.AuthController,
  strategies: [
    azure_ad: [
      strategy: Assent.Strategy.Azure,
      config: [
        tenant_id: "REPLACE_WITH_PROPPER_VALUE",
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "http://localhost:4000/azure_ad/callback"
      ]
    ],
    github: [
      strategy: Assent.Strategy.Github,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/github/callback"
      ]
    ],
    facebook: [
      strategy: Assent.Strategy.Facebook,
      config: [
        client_id: "REPLACE_WITH_PROPPER_VALUE",
        client_secret: "REPLACE_WITH_PROPPER_VALUE",
        redirect_uri: "https://localhost:4000/auth/facebook/callback"
      ]
    ]
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :keen_auth_demo, TestKeenAuthWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/keen_auth_demo_web/(live|views)/.*(ex)$",
      ~r"lib/keen_auth_demo_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
