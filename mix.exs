defmodule BranchCutter.MixProject do
  use Mix.Project

  def project do
    [
      app: :branch_cutter,
      version: "0.3.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
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
      {:cowboy, "~> 2.4.0"},
      {:distillery, "~> 1.5.2", runtime: false},
      {:jason, "~> 1.0.0"},
      {:hackney, "~> 1.12.1"},
      {:tesla, "~> 1.0.0"},
      {:plug, "~> 1.5.1"}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end
end
