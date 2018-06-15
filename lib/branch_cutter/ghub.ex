defmodule BranchCutter.Ghub do
  @moduledoc """
  GitHub API client.
  """

  use Tesla, only: [:delete]

  adapter Tesla.Adapter.Hackney

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"user-agent", __MODULE__}]
  plug Tesla.Middleware.JSON

  @spec client(String.t()) :: Tesla.Client.t()
  def client(token) do
    Tesla.build_client([
      {Tesla.Middleware.Headers, [{"authorization", ["token ", token]}]}
    ])
  end

  @spec delete_branch(Tesla.Client.t(), String.t(), String.t()) :: Tesla.Env.result()
  def delete_branch(client, repo_slug, branch) do
    delete(client, "/repos/#{repo_slug}/git/refs/heads/#{branch}")
  end
end
