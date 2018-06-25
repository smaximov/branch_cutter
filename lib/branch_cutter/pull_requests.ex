defmodule BranchCutter.PullRequests do
  alias BranchCutter.Repo
  alias BranchCutter.Schema.PullRequest

  @spec insert(String.t(), String.t(), integer()) ::
          {:ok, PullRequest.t()} | {:error, Ecto.Changeset.t()}
  def insert(repo, branch, number) do
    %PullRequest{}
    |> PullRequest.changeset(%{repo: repo, branch: branch, number: number})
    |> Repo.insert(on_conflict: :nothing)
  end
end
