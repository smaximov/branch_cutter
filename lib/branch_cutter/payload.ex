defmodule BranchCutter.Payload do
  @behaviour Plug

  import Plug.Conn

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    send_resp(conn, 200, "")
  end
end
