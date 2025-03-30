defmodule AOC2024.Day4Test do
  use ExUnit.Case

  alias AOC2024.Day4

  test "test it" do
    grid = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    expected = 18

    actual = Day4.go(grid)

    assert actual === expected
  end
end
