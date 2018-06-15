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
    if protected_branch?(branch) do
      require Logger

      Logger.warn(fn ->
        "Skip deleting protected branch #{branch} on #{repo_slug}"
      end)
    else
      spawn(BranchCutter.Handler, :pull_request_closed, [repo_slug, branch])
    end

    send_resp(conn, 200, "")
  end

  defp handle_payload(_, _, conn), do: send_resp(conn, 200, "")

  # TODO(smaximov): move this to configuration.
  @protected_branches MapSet.new(~w[master dev])

  defp protected_branch?(branch) do
    MapSet.member?(@protected_branches, branch)
  end
end
