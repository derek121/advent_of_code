defmodule AOC2024.Day1Test do
  use ExUnit.Case

  alias AOC2024.Day1

  test "test it" do
    lists = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert 11 == Day1.go(lists)
  end
end
