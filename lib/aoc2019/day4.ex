defmodule AOC2019.Day4 do
  @moduledoc """
  https://adventofcode.com/2019/day/4

  It is a six-digit number.
  The value is within the range given in your puzzle input.
  Two adjacent digits are the same (like 22 in 122345).
  Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
  """

  def how_many_meet_criteria() do
    # Can use Streams to do this?

    (for n <- 100000..999999, meets_criteria?(n), do: n) |> length()

    # This simple case is 9
    #(for n <- 111110..111120, meets_criteria?(n), do: n) |> length()
  end

  def meets_criteria?(num) do
    never_decreases?(num) and adjacent_same?(num)
  end

  def never_decreases?(num) do
    as_charlist = Integer.to_charlist(num)
    as_charlist_sorted = Integer.to_charlist(num) |> Enum.sort()

    as_charlist == as_charlist_sorted
  end

  def adjacent_same?(num) do
    as_string = Integer.to_string(num)

    Regex.match?(~r/(.)\1/, as_string)
  end

end
