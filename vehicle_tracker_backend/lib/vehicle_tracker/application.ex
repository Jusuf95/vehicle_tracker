defmodule VehicleTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VehicleTrackerWeb.Telemetry,
      VehicleTracker.Repo,
      {DNSCluster, query: Application.get_env(:vehicle_tracker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VehicleTracker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VehicleTracker.Finch},
      # Start a worker by calling: VehicleTracker.Worker.start_link(arg)
      # {VehicleTracker.Worker, arg},
      # Start to serve requests, typically the last entry
      VehicleTrackerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VehicleTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VehicleTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
