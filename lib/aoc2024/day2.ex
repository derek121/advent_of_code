defmodule AOC2024.Day2 do
  # https://adventofcode.com/2024/day/2

  @moduledoc """
  Find rows (reports) that are either monotonically increasing or decreasing,
  and whose adjacent entries (levels) differ between 1 and 3, inclusive.

  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  def go(reports) do
    reports
    # ["7 6 4 2 1", "1 2 7 8 9", "9 7 6 2 1", "1 3 2 4 5", "8 6 4 4 1", "1 3 6 7 9"]
    |> String.split("\n", trim: true)

    # [
    #  ["7", "6", "4", "2", "1"],
    #  ["1", "2", "7", "8", "9"],
    #  ["9", "7", "6", "2", "1"],
    #  ["1", "3", "2", "4", "5"],
    #  ["8", "6", "4", "4", "1"],
    #  ["1", "3", "6", "7", "9"]
    # ]
    |> Enum.map(&String.split/1)

    # [
    #   [7, 6, 4, 2, 1]
    #   [1, 2, 7, 8, 9]
    #   [9, 7, 6, 2, 1]
    #   [1, 3, 2, 4, 5]
    #   [8, 6, 4, 4, 1]
    #   [1, 3, 6, 7, 9]
    # ]
    |> Enum.map(fn [l1, l2, l3, l4, l5] ->
      [
        String.to_integer(l1),
        String.to_integer(l2),
        String.to_integer(l3),
        String.to_integer(l4),
        String.to_integer(l5)
      ]
    end)

    # [
    #  [7, 6, 4, 2, 1],
    #  [1, 2, 7, 8, 9],
    #  [9, 7, 6, 2, 1],
    #  [8, 6, 4, 4, 1],
    #  [1, 3, 6, 7, 9]
    # ]
    |> filter_reports_monotonic()

    # [[7, 6, 4, 2, 1], [1, 3, 6, 7, 9]]
    |> filter_reports_diff()
  end

  @doc """
    Filter out non-monotonically-increasing or -decreasing reports.
  """
  def filter_reports_monotonic(reports) do
    reports
    |> Enum.filter(fn report ->
      report === Enum.sort(report) or report === Enum.sort(report, :desc)
    end)
  end

  @doc """
    Filter out reports with any diffs of <1 or >3.
  """
  def filter_reports_diff(reports) do
    # Comments for [1, 2, 7, 8, 9]

    reports
    |> Enum.filter(fn report ->
      report
      # [[1, 2], [2, 7], [7, 8], [8, 9]]
      |> Enum.chunk_every(2, 1, :discard)

      # [1, 5, 1, 1]
      |> Enum.map(fn [m, n] -> abs(m - n) end)

      # false
      |> Enum.all?(fn val -> val >= 1 and val <= 3 end)
    end)
  end
end
