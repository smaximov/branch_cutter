defmodule BranchCutter.Schema.PullRequest do
  use Ecto.Schema

  import Ecto.Changeset

  @type t() :: %__MODULE__{
          repo: String.t() | nil,
          branch: String.t() | nil,
          number: integer() | nil,
          inserted_at: NaiveDateTime.t() | nil,
          updated_at: NaiveDateTime.t() | nil
        }

  @primary_key false
  schema "pull_requests" do
    field :repo, :string, primary_key: true
    field :branch, :string, primary_key: true
    field :number, :integer, primary_key: true

    timestamps()
  end

  @spec changeset(t(), map()) :: Changeset.t()
  def changeset(pull_request, params \\ %{}) do
    pull_request
    |> cast(params, ~w[repo branch number]a)
    |> validate_required(~w[repo branch number]a)
    |> unique_constraint(:number, name: :pull_requests_pkey)
  end
end
