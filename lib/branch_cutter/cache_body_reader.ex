defmodule BranchCutter.CacheBodyReader do
  @moduledoc """
  This is a callback module to be used with `Plug.Parsers`. It reads the request
  body and caches it as a list of chunks in `conn.assings[:raw_body]`
  (in the reverse order).
  """

  alias Plug.Conn

  def read_body(conn, opts) do
    case Conn.read_body(conn, opts) do
      {:error, _} = res ->
        res

      {success, chunk, conn} ->
        {success, chunk, update_in(conn.assigns[:raw_body], &[chunk | &1 || []])}
    end
  end
end
