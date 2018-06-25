defmodule BranchCutter.PullRequestsTest do
  use BranchCutter.RepoCase, async: true

  alias BranchCutter.PullRequests
  alias BranchCutter.Schema.PullRequest

  describe "insert/3" do
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

  describe "delete/3" do
    import PullRequests, only: [insert: 3, count: 2, delete: 3]

    test "it deletes a pull request" do
      repo = "repo"
      branch = "branch"
      number = 42

      assert {:ok, _} = insert(repo, branch, number)
      assert {1, nil} = delete(repo, branch, number)
      assert count(repo, branch) == 0
      assert {0, nil} = delete(repo, branch, number)
    end
  end
end
