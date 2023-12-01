defmodule BillboardTest do
  use ExUnit.Case
  doctest Billboard

  test "greets the world" do
    assert Billboard.hello() == :world
  end
end
