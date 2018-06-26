defmodule Mix.Tasks.Ecto.Cli do
  @shortdoc "Run the database console"

  @moduledoc """
  Run database CLI for the given repo (or the default one).

  ## Examples

      mix ecto.cli
      mix ecto.cli -r Custom.Repo

  ## Command line options

  * `-r`, `--repo` - repo to connect to.
  """

  use Mix.Task

  import Mix.Ecto

  def run(args) do
    case parse_repo(args) do
      [repo] ->
        repo.config
        |> Enum.into(%{})
        |> run_cli()

      repos ->
        die("""
        Found multiple Ecto repositories: #{inspect(repos)}.

        Pick one using the `--repo` option.
        """)

        System.halt(1)
    end
  end

  defp run_cli(%{adapter: adapter} = conf), do: run_cli(adapter(adapter), conf)

  defp run_cli(adapter, conf) do
    client = find_executable(adapter.clients())
    args = adapter.args(client, conf)

    Execv.exec([client | args])
  end

  defp find_executable(clients) do
    case Enum.find_value(clients, &System.find_executable/1) do
      nil -> die("Unable to find any of the clients: #{inspect(clients)}")
      client -> client
    end
  end

  defp die(msg) do
    Mix.shell().error(msg)
    System.halt(1)
  end

  defmodule Postgres do
    @scheme "postgresql"

    def clients, do: ~w[pgcli psql]

    def args(_, %{url: database_url}), do: [database_url]

    def args(_, conf) do
      uri = %URI{
        host: conf[:hostname] || "",
        path: "/#{conf[:database]}",
        port: conf[:port],
        query: conf[:parameters],
        scheme: @scheme,
        userinfo: userinfo(conf[:username], conf[:password])
      }

      [URI.to_string(uri)]
    end

    defp userinfo(nil, nil), do: nil
    defp userinfo(user, nil), do: user

    defp userinfo(nil, pass) do
      case System.get_env("USER") do
        nil -> nil
        user -> userinfo(user, pass)
      end
    end

    defp userinfo(user, pass), do: "#{user}:#{pass}"
  end

  defp adapter(Ecto.Adapters.Postgres), do: Postgres
end
