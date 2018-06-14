defmodule BranchCutter.Authenticate do
  @moduledoc """
  A plug for validating webhook payload signature.

  Responds with HTTP 401 Unauthorized if either the signature header
  (`X-Hub-Signature`) is missing or the signature is invalid.
  """

  @behaviour Plug

  alias BranchCutter.{Config, Util}
  alias Plug.Conn

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    authenticate(Util.get_header(conn, "x-hub-signature"), Config.github_secret(), conn)
  end

  defp authenticate(nil, _, conn), do: forbid(conn)

  defp authenticate(signature, secret, %Conn{assigns: assigns} = conn) do
    if valid_signature?(Enum.reverse(assigns[:raw_body]), signature, secret) do
      conn
    else
      forbid(conn)
    end
  end

  defp forbid(conn) do
    require Logger

    Logger.error(fn ->
      "Payload signature validation failed"
    end)

    import Plug.Conn

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, "Unauthorized.")
    |> halt()
  end

  defp valid_signature?(body_chunks, signature, secret) do
    signature == "sha1=#{Util.hmac_sha1(body_chunks, secret)}"
  end
end
