defmodule BranchCutter.Util do
  @moduledoc """
  Various utitity functions.
  """

  @doc ~S"""
  Return the first occurence of a request header.

  If there're no occurences of the request header, return the default value
  (`nil` if no default value).
  """
  @spec get_header(Plug.Conn.t(), String.t(), String.t() | nil) :: String.t() | nil
  def get_header(%Plug.Conn{} = conn, header, default \\ nil) do
    case Plug.Conn.get_req_header(conn, header) do
      [header | _] -> header
      [] -> default
    end
  end
end
