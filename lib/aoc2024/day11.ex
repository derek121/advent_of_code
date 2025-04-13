defmodule AOC2024.Day11 do
  # https://adventofcode.com/2024/day/11

  @moduledoc """
  From the puzzle link above:

  - If the stone is engraved with the number 0, it is replaced by a stone engraved
  with the number 1.
  - If the stone is engraved with a number that has an even number of digits, it
  is replaced by two stones. The left half of the digits are engraved on the new
  left stone, and the right half of the digits are engraved on the new right stone. (The new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
  - If none of the other rules apply, the stone is replaced by a new stone; the
  old stone's number multiplied by 2024 is engraved on the new stone.

  "If you have an arrangement of five stones engraved with the numbers
  0 1 10 99 999 and you blink once, the stones transform as follows:

    The first stone, 0, becomes a stone marked 1.
    The second stone, 1, is multiplied by 2024 to become 2024.
    The third stone, 10, is split into a stone marked 1 followed by a stone marked 0.
    The fourth stone, 99, is split into two stones marked 9.
    The fifth stone, 999, is replaced by a stone marked 2021976.

  So, after blinking once, your five stones would become an arrangement of
  seven stones engraved with the numbers 1 2024 1 0 9 9 2021976."

  The test for the challenge is blinking 25 times, as seen in the last test.
  """

  def go(stones, n) do
    Range.to_list(1..n)
    |> List.foldl(stones, fn _n, acc ->
      eval_stones(acc)
    end)
  end

  def eval_stones(stones) do
    stones
    |> List.foldl([], fn stone, acc ->
      result = eval_stone(stone)
      [result | acc]
    end)
    |> Enum.reverse()
    |> List.flatten()
  end

  def eval_stone(0), do: 1

  def eval_stone(stone) do
    s = Integer.to_string(stone)

    if rem(len = String.length(s), 2) == 0 do
      String.split_at(s, div(len, 2))
      |> (fn {a, b} -> [String.to_integer(a), String.to_integer(b)] end).()
    else
      stone * 2024
    end
  end
end
