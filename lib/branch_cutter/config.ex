defmodule BranchCutter.Config do
  @moduledoc "Application configuration."

  @spec port :: pos_integer() | no_return()
  def port do
    Application.fetch_env!(:branch_cutter, :port)
    |> String.to_integer()
  end

  @spec github_secret :: String.t() | no_return()
  def github_secret do
    Application.fetch_env!(:branch_cutter, :github)
    |> Keyword.fetch!(:secret)
  end

  @spec github_token :: String.t() | no_return()
  def github_token do
    Application.fetch_env!(:branch_cutter, :github)
    |> Keyword.fetch!(:token)
  end
end
