defmodule BranchCutter.MixProject do
  use Mix.Project

  def project do
    [
      app: :branch_cutter,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {BranchCutter.Application, []}
    ]
  end

  defp deps do
    [
      {:distillery, "~> 1.5.2", runtime: false},
      {:cowboy, "~> 2.4.0"},
      {:plug, "~> 1.5.1"}
    ]
  end
end
