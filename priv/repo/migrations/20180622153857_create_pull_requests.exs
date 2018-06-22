defmodule BranchCutter.Repo.Migrations.CreatePullRequests do
  use Ecto.Migration

  def change do
    create table(:pull_requests, primary_key: false) do
      add(:repo, :string, null: false, primary_key: true)
      add(:branch, :string, null: false, primary_key: true)
      add(:number, :integer, null: false, primary_key: true)

      timestamps()
    end
  end
end
