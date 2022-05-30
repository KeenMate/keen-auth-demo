defmodule KeenAuthDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
#      KeenAuthDemo.Repo,
      # Start the Telemetry supervisor
      KeenAuthDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KeenAuthDemo.PubSub},
      # Start the Endpoint (http/https)
      KeenAuthDemoWeb.Endpoint
      # Start a worker by calling: KeenAuthDemo.Worker.start_link(arg)
      # {KeenAuthDemo.Worker, arg}
    ]

    create_session_table()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KeenAuthDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KeenAuthDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp create_session_table() do
    :ets.new(:session, [:named_table, :public, read_concurrency: true])
  end
end
