defmodule BackstageTest do
  use ExUnit.Case
  doctest Backstage

  test "starts successfully" do
    {:ok, _pid} = Backstage.start_link()
  end
end
