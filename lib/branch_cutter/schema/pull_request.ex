defmodule BranchCutter.Schema.PullRequest do
  use Ecto.Schema

  @type t() :: %__MODULE__{
          repo: String.t(),
          branch: String.t(),
          number: integer(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @primary_key false
  schema "pull_requests" do
    field :repo, :string, primary_key: true
    field :branch, :string, primary_key: true
    field :number, :integer, primary_key: true

    timestamps()
  end
end
