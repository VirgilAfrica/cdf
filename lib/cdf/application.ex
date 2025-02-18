defmodule Cdf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CdfWeb.Telemetry,
      Cdf.Repo,
      {DNSCluster, query: Application.get_env(:cdf, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cdf.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Cdf.Finch},
      # Start a worker by calling: Cdf.Worker.start_link(arg)
      # {Cdf.Worker, arg},
      # Start to serve requests, typically the last entry
      CdfWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cdf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CdfWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
