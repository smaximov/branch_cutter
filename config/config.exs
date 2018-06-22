use Mix.Config

config :branch_cutter,
  ecto_repos: [BranchCutter.Repo]

import_config "#{Mix.env()}.exs"
