defmodule JpInput.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JpInputWeb.Telemetry,
      JpInput.Repo,
      {DNSCluster, query: Application.get_env(:jp_input, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JpInput.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JpInput.Finch},
      # Start a worker by calling: JpInput.Worker.start_link(arg)
      # {JpInput.Worker, arg},
      # Start to serve requests, typically the last entry
      JpInputWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JpInput.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JpInputWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
