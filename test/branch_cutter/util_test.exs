defmodule BranchCutter.UtilTest do
  use ExUnit.Case, async: true

  alias BranchCutter.Util

  describe "get_header/2,3" do
    use Plug.Test

    @header "header"
    @default "[DEFAULT]"

    defp conn_with_headers(headers \\ []) do
      conn = conn(:post, "/")

      headers
      |> Enum.reverse()
      |> Enum.reduce(conn, fn {header, value}, conn -> put_req_header(conn, header, value) end)
    end

    test "returns the default value when there're no occurences of the header" do
      value =
        conn_with_headers()
        |> Util.get_header(@header, @default)

      assert value == @default
    end

    test "returns the value of the first occurence of the header" do
      expected = "value"

      value =
        conn_with_headers([{@header, expected}])
        |> Util.get_header(@header, @default)

      assert value == expected

      value =
        conn_with_headers([{@header, expected}, {@header, "overriden"}])
        |> Util.get_header(@header, @default)

      assert value == expected
    end
  end
end
