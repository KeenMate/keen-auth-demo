defmodule TestKeenAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
#      TestKeenAuth.Repo,
      # Start the Telemetry supervisor
      TestKeenAuthWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestKeenAuth.PubSub},
      # Start the Endpoint (http/https)
      TestKeenAuthWeb.Endpoint
      # Start a worker by calling: TestKeenAuth.Worker.start_link(arg)
      # {TestKeenAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestKeenAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestKeenAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
