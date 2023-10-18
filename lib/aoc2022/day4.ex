defmodule Day4 do
  # https://adventofcode.com/2022/day/4

  @moduledoc """
  In how many assignment pairs does one range fully contain the other?

  .234.....  2-4
  .....678.  6-8

  .23......  2-3
  ...45....  4-5

  ....567..  5-7
  ......789  7-9

  .2345678.  2-8
  ..34567..  3-7

  .....6...  6-6
  ...456...  4-6

  .23456...  2-6
  ...45678.  4-8
  """

  def go() do
    pairs =
      [
        {2..4, 6..8},
        {2..3, 4..5},
        {5..7, 7..9},
        {2..8, 3..7},
        {6..6, 4..6},
        {2..6, 4..8}
      ]

    is_fully_contained =
      pairs
      |> Enum.map(&check_fully_contained(&1))

    Enum.count(is_fully_contained, fn b -> b end)
  end

  def check_fully_contained({r1, r2}) do
    l1 = Range.to_list(r1)
    l2 = Range.to_list(r2)

    ms1 = MapSet.new(l1)
    ms2 = MapSet.new(l2)

    intersection = MapSet.intersection(ms1, ms2)

    # If the intersection exactly equals one of ms1 or ms2, that one is fully enclosed
    # So just return the boolean of if that's the case
    ms1 == intersection or ms2 == intersection
  end

end
