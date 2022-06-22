defmodule Day2 do

  @doc """
  https://adventofcode.com/2021/day/2

  Calculate the horizontal position and depth you would have after following the planned course.

  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """
  def run(lst) do
    lst
    |> Enum.reduce(
         {0, 0},
         fn cmd, {horz, vert} = _acc ->
           [dir, num] = String.split(cmd)
           num = String.to_integer(num)


           case dir do
             "forward" -> {horz + num, vert}
             "down" -> {horz, vert + num}
             "up" -> {horz, vert - num}
           end
         end)
  end


end
