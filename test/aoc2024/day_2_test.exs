defmodule AOC2024.Day2Test do
  use ExUnit.Case

  alias AOC2024.Day2

  test "test it" do
    reports = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    expected = [[1, 3, 6, 7, 9], [7, 6, 4, 2, 1]]
    actual = Day2.go(reports) |> Enum.sort()

    assert expected == actual
  end
end
