use Mix.Config

config :branch_cutter,
  port: "${PORT}"

config :branch_cutter, :github,
  secret: "${GITHUB_SECRET}",
  token: "${GITHUB_TOKEN}"

config :branch_cutter, BranchCutter.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}"
