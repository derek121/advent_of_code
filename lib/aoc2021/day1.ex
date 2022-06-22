defmodule Day1 do

  @doc """
  https://adventofcode.com/2021/day/1

  To do this, count the number of times a depth measurement increases from the previous measurement.
  (There is no measurement before the first measurement.) In the example above, the changes are as follows:

  199 (N/A - no previous measurement)
  200 (increased)
  208 (increased)
  210 (increased)
  200 (decreased)
  207 (increased)
  240 (increased)
  269 (increased)
  260 (decreased)
  263 (increased)

  In this example, there are 7 measurements that are larger than the previous measurement.

  How many measurements are larger than the previous measurement?
  """
  def run(lst) do
    [first | rest] = lst

    {_, total} =
      rest
      |> Enum.reduce(
           {first, 0},
           fn
             num, {previous, count} when num > previous -> {num, count + 1}
             num, {_previous, count} -> {num, count}
           end)

      total
  end


end