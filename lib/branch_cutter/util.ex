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

  @doc ~S"""
  Calculate HMAC SHA1 hexdigest.

  ## Example

  ```
  iex> BranchCutter.Util.hmac_sha1("data", "secret")
  "9818e3306ba5ac267b5f2679fe4abd37e6cd7b54"

  iex> BranchCutter.Util.hmac_sha1(["da", "ta"], "secret")
  "9818e3306ba5ac267b5f2679fe4abd37e6cd7b54"

  iex> BranchCutter.Util.hmac_sha1("data", "secret", case: :upper)
  "9818E3306BA5AC267B5F2679FE4ABD37E6CD7B54"
  ```
  """
  @spec hmac_sha1(String.t() | [String.t()], String.t(), Keyword.t()) :: String.t()
  def hmac_sha1(data, key, opts \\ [])

  def hmac_sha1(data, key, opts) when is_list(data) and is_binary(key) do
    import :crypto

    data
    |> Enum.reduce(hmac_init(:sha, key), &hmac_update(&2, &1))
    |> hmac_final()
    |> Base.encode16(case: Keyword.get(opts, :case, :lower))
  end

  def hmac_sha1(data, key, opts) when is_binary(data) and is_binary(key) do
    hmac_sha1([data], key, opts)
  end
end
