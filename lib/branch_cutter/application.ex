defmodule BranchCutter.Application do
  @moduledoc false

  use Application

  alias BranchCutter.Config

  require Logger

  @impl Application
  def start(_type, _args) do
    port = Config.port()

    children = [
      {Plug.Adapters.Cowboy2, scheme: :http, plug: BranchCutter.Webhook, options: [port: port]}
    ]

    Logger.info(fn ->
      "Listening on http://127.0.0.1:#{port}..."
    end)

    opts = [strategy: :one_for_one, name: BranchCutter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end