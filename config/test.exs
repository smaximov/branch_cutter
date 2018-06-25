use Mix.Config

config :branch_cutter,
  port: "4000"

config :branch_cutter, BranchCutter.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "branch-cutter-test",
  pool: Ecto.Adapters.SQL.Sandbox
