use Mix.Config

config :branch_cutter,
  port: "${PORT}"

config :branch_cutter, :github, secret: "${GITHUB_SECRET}"
