defmodule AOC2024.Day3 do
  # https://adventofcode.com/2024/day/3

  @moduledoc """
  Extract all strings of the form "mul(m, n)", where m and n are integers.
  Multiple m and n, and sum all the products.

  Example:
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))

  The following are extracted, multiplied, and summed:
  mul(2,4)
  mul(5,5)
  mul(11,8)
  mul(8,5)
  """

  def go(mem) do
    # [
    #  ["mul(2,4)", "2", "4"],
    #  ["mul(5,5)", "5", "5"],
    #  ["mul(11,8)", "11", "8"],
    #  ["mul(8,5)", "8", "5"]
    # ]
    Regex.scan(~r/mul\((\d+)\,(\d+)\)/, mem)

    # [8, 25, 88, 40]
    |> Enum.map(fn [_src, m, n] -> String.to_integer(m) * String.to_integer(n) end)

    # 161
    |> Enum.sum()
  end
end
