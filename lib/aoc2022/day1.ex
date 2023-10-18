defmodule Day1 do
  # https://adventofcode.com/2022/day/1

  @moduledoc """
  Find largest sum of the groups.

  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  def go() do
    groups =
      """
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
      """

    max =
      String.split(groups, "\n\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn lst ->
        Enum.map(lst, &String.to_integer/1)
        |> Enum.sum()
      end)
      |> Enum.max()


    IO.inspect(max)
  end

end
