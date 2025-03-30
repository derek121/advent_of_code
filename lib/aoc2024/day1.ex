defmodule AOC2024.Day1 do
  # https://adventofcode.com/2024/day/1

  @moduledoc """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3

  Sort both vertical lists. Pair each row. Sum the diffs.
  """

  def go(lists) do
    lists
    # ["3   4", "4   3", "2   5", "1   3", "3   9", "3   3"]
    |> String.split("\n", trim: true)

    # [["3", "4"], ["4", "3"], ["2", "5"], ["1", "3"], ["3", "9"], ["3", "3"]]
    |> Enum.map(&String.split/1)

    # [{3, 4}, {4, 3}, {2, 5}, {1, 3}, {3, 9}, {3, 3}]
    |> Enum.map(fn [s1, s2] -> {String.to_integer(s1), String.to_integer(s2)} end)

    # {[3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]}
    |> Enum.unzip()

    # {[1, 2, 3, 3, 3, 4], [3, 3, 3, 4, 5, 9]}
    |> (fn {list1, list2} -> {Enum.sort(list1), Enum.sort(list2)} end).()

    # [{1, 3}, {2, 3}, {3, 3}, {3, 4}, {3, 5}, {4, 9}]
    |> (fn {list1, list2} -> Enum.zip(list1, list2) end).()

    # [2, 1, 0, 1, 2, 5]
    |> Enum.map(fn {m, n} -> abs(m - n) end)

    |> Enum.sum()
  end
end
