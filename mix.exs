defmodule BranchCutter.MixProject do
  use Mix.Project

  def project do
    [
      app: :branch_cutter,
      version: "0.5.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
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
      {:ecto, "~> 2.2.10"},
      {:jason, "~> 1.0.0"},
      {:hackney, "~> 1.12.1"},
      {:tesla, "~> 1.0.0"},
      {:plug, "~> 1.5.1"},
      {:postgrex, "~> 0.13.5"},
      {:execv, "~> 0.1.2", only: [:dev]}
    ]
  end

  defp elixirc_paths(:test), do: ~w[lib test/support]
  defp elixirc_paths(_), do: ~w[lib]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
