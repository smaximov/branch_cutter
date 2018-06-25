defmodule BranchCutter.PullRequests do
  alias Ecto.Query
  alias BranchCutter.Repo
  alias BranchCutter.Schema.PullRequest

  require Ecto.Query

  @spec insert(String.t(), String.t(), integer()) ::
          {:ok, PullRequest.t()} | {:error, Ecto.Changeset.t()}
  def insert(repo, branch, number) do
    %PullRequest{}
    |> PullRequest.changeset(%{repo: repo, branch: branch, number: number})
    |> Repo.insert(on_conflict: :nothing)
  end

  @spec count(String.t(), String.t()) :: integer()
  def count(repo, branch) do
    PullRequest
    |> Query.where(repo: ^repo, branch: ^branch)
    |> Repo.aggregate(:count, :number)
  end

  @spec delete(String.t(), String.t(), integer()) :: {integer(), nil} | no_return()
  def delete(repo, branch, number) do
    PullRequest
    |> Query.where(repo: ^repo, branch: ^branch, number: ^number)
    |> Repo.delete_all()
  end
end
