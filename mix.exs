defmodule KeenAuthDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :keen_auth_demo,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {KeenAuthDemo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.10"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.3"},
      {:plug_cowboy, "~> 2.5"},
      {:ecto_gen, "~> 0.8"},
      {:bcrypt_elixir, "~> 3.0"},
      {:simplificator_3000, git: "git@github.com:KeenMate/simplificator_3000.git"},
      {:keen_auth_permissions, path: "../keen-auth-permissions"},
      {:keen_auth, path: "../keen_auth", override: true}
      # {:keen_auth, git: "https://github.com/keenmate/keen_auth.git", branch: "new-vision"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      # setup: ["deps.get", "ecto.setup"],
      # "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      # "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
