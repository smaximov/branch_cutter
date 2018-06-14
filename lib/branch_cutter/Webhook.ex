defmodule BranchCutter.Webhook do
  use Plug.Builder

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason

  plug BranchCutter.Logger
  plug BranchCutter.Payload
end
