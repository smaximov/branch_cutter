defmodule BranchCutter.Config do
  @moduledoc "Application configuration."

  @spec port :: pos_integer() | no_return()
  def port do
    {:ok, port} = Application.fetch_env(:branch_cutter, :port)

    String.to_integer(port)
  end
end
