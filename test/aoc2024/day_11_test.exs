defmodule AOC2024.Day11Test do
  use ExUnit.Case

  alias AOC2024.Day11

  test "eval_stones example 1" do
    stones = [0, 1, 10, 99, 999]

    actual = Day11.eval_stones(stones)
    expected = [1, 2024, 1, 0, 9, 9, 2021976]

    assert actual == expected
  end

  test "eval_stones example 2" do
    stones = [125, 17]

    actual = Day11.eval_stones(stones)
    expected = [253000, 1, 7]

    assert actual == expected
  end

  test "go example 1, 1 time" do
    stones = [0, 1, 10, 99, 999]

    actual = Day11.go(stones, 1)
    expected = [1, 2024, 1, 0, 9, 9, 2021976]

    assert actual == expected
  end

  test "go example 2, 1 time" do
    stones = [125, 17]

    actual = Day11.go(stones, 1)
    expected = [253000, 1, 7]

    assert actual == expected
  end

  test "go example 2, 2 times" do
    stones = [125, 17]

    actual = Day11.go(stones, 2)
    expected = [253, 0, 2024, 14168]

    assert actual == expected
  end

  test "go example 2, 6 times" do
    stones = [125, 17]

    actual = Day11.go(stones, 6)
    expected = [
      2097446912, 14168, 4048, 2, 0, 2, 4, 40, 48, 2024, 40, 48, 80,
      96, 2, 8, 6, 7, 6, 0, 3, 2
    ]

    assert actual == expected
  end

  test "go example 2, 25 times" do
    stones = [125, 17]

    actual = Day11.go(stones, 25) |> length()
    expected = 55312

    assert actual == expected
  end

end
