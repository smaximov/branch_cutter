defmodule BranchCutter.Handler do
  alias BranchCutter.{Config, Ghub}

  require Logger

  @spec pull_request_closed(String.t(), String.t()) :: nil
  def pull_request_closed(repo_slug, branch) do
    response =
      Config.github_token()
      |> Ghub.client()
      |> Ghub.delete_branch(repo_slug, branch)

    case response do
      {:ok, %Tesla.Env{status: 204}} ->
        Logger.debug(fn ->
          "Successfully deleted branch #{branch} in #{repo_slug}"
        end)

      {:ok, %Tesla.Env{status: status, body: body}} ->
        Logger.error(fn ->
          """
          Failed to delete branch #{branch} in #{repo_slug}:
            status=#{status}
            body=#{inspect(body)}
          """
        end)

      {:error, error} ->
        Logger.error(fn ->
          "Request error when trying to delete branch #{branch} in #{repo_slug}: #{error}"
        end)
    end

    nil
  end
end
