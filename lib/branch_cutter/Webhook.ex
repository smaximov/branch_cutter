defmodule BranchCutter.Webhook do
  @behaviour Plug

  import Plug.Conn

  require Logger

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    Logger.info(fn ->
      "In webhook handler: #{inspect(conn)}"
    end)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello from Elixir!")
  end
end
