defmodule BranchCutter.Plug.Webhook do
  use Plug.Builder

  plug Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason,
    body_reader: {BranchCutter.CacheBodyReader, :read_body, []}

  plug BranchCutter.Plug.Authenticate
  plug BranchCutter.Plug.Payload
end
