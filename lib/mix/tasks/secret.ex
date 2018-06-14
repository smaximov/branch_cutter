defmodule Mix.Tasks.Secret do
  @default_length 32

  @shortdoc "Generate a cryptographically secure secret key"

  @moduledoc """
  Generate a cryptographically secure secret key, hex-encoded.

  ## Usage

  ```
  mix secret [LENGTH]
  ```

  ## Arguments

  * `LENGTH` - secret key length in bytes. Defaults to #{@default_length}.
  """

  use Mix.Task

  def run([]), do: secret(@default_length)

  def run([num]) do
    case Integer.parse(num) do
      {num, ""} -> secret(num)
      _ -> usage()
    end
  end

  def run(_), do: usage()

  @usage """
  Usage:
    mix secret [LENGTH]
  """

  defp usage do
    IO.puts(:stderr, @usage)

    System.halt(1)
  end

  defp secret(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode16(case: :lower)
    |> IO.puts()
  end
end
