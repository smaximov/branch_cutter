defmodule BranchCutter.Plug.Payload do
  @behaviour Plug

  import Plug.Conn

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    event = BranchCutter.Util.get_header(conn, "x-github-event")
    payload = conn.body_params

    handle_payload(event, payload, conn)
  end

  defp handle_payload(
         "pull_request",
         %{
           "action" => "closed",
           "pull_request" => %{
             "head" => %{"ref" => branch, "repo" => %{"full_name" => repo_slug}}
           }
         },
         conn
       ) do
    spawn(BranchCutter.Handler, :pull_request_closed, [repo_slug, branch])
    send_resp(conn, 200, "")
  end

  defp handle_payload(_, _, conn), do: send_resp(conn, 200, "")
end
