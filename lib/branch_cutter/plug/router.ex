defmodule BranchCutter.Plug.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Nothing to do here ATM, move along!")
  end

  post "/webhook", to: BranchCutter.Plug.Webhook

  match _ do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "Not found.")
  end
end
