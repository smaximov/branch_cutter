defmodule BranchCutter.Webhook do
  use Plug.Builder

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason,
    body_reader: {BranchCutter.CacheBodyReader, :read_body, []}

  plug BranchCutter.Authenticate
  plug BranchCutter.Payload
end
