defmodule BranchCutter.PullRequestsTest do
  use BranchCutter.RepoCase, async: true

  alias BranchCutter.PullRequests

  describe "insert/3" do
    alias BranchCutter.Schema.PullRequest

    import PullRequests, only: [insert: 3, count: 2]

    test "it is successful with valid values and duplicates" do
      repo = "repo"
      branch = "branch"
      number = 42

      assert {:ok, %PullRequest{repo: ^repo, branch: ^branch, number: ^number}} =
               insert(repo, branch, number)

      assert count(repo, branch) == 1

      assert {:ok, %PullRequest{repo: ^repo, branch: ^branch, number: ^number}} =
               insert(repo, branch, number)

      assert count(repo, branch) == 1
    end

    test "it fails with blank values" do
      assert {:error, %Ecto.Changeset{} = changeset} = insert("", "", nil)

      assert %{
               repo: ["can't be blank"],
               branch: ["can't be blank"],
               number: ["can't be blank"]
             } = errors_on(changeset)
    end
  end
end
