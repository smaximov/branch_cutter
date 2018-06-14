defmodule BranchCutter.Logger do
  @moduledoc """
  A plug for logging webhook event type and payload, loosely based on
  `Plug.Logger`.

  ## Options

  * `:level` - The log level at which this plug should log payload info.
    Defaults to `:info`.
  """

  @behaviour Plug

  require Logger

  @impl Plug
  def init(opts), do: Keyword.get(opts, :level, :info)

  @impl Plug
  def call(%Plug.Conn{body_params: payload} = conn, level) do
    Logger.log(level, fn ->
      event = BranchCutter.Util.get_header(conn, "x-github-event", "[NONE]")

      ["event=", event, " payload=", inspect(payload)]
    end)

    conn
  end
end
