defmodule AOC2021.Day7 do

  @moduledoc """
  https://adventofcode.com/2021/day/7

  Minimal horizontal position.
  """

  @doc """
  Sample positions: [16,1,2,0,4,2,7,1,2,14]
  """
  def run(positions) do
    {min, max} = Enum.min_max(positions)

    # [{0, 13}, {1, 10}, {2, 9}, {3, 8}, {4, 9}, {5, 12}]
    diffs =
      min..max
      |> Enum.map(fn target ->
        diff = calc(target, positions)
        {target, diff}
      end)

    {pos, smallest} = t = diffs |> Enum.min_by(fn {_n, total} -> total end)

    IO.puts("Position with smallest total: #{pos}: #{smallest}")

    t
  end

  def calc(target, positions) do
    total =
      positions
      |> Enum.reduce(0, fn pos, acc ->
        acc + abs(target - pos)
      end)
  end
end
