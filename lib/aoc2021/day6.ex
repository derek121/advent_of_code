defmodule AOC2021.Day6 do

  @moduledoc """
  https://adventofcode.com/2021/day/6

  Reproducing lanternfish.
  """

  @doc """
  Example: [3,4,3,1,2]
  """
  def run(fish, num_generations) do
    1..num_generations
    |> Enum.reduce(fish, fn _n, acc ->
      do_generation(acc)
    end)
    |> length()
  end

  @doc """
  For example: [3,4,3,1,2]
  """
  def do_generation(fish) do
    {existing, num_new} =
      fish
      |> Enum.reduce({[], 0}, fn n, {existing, num_new} = _acc ->
        case n do
          0 -> {[6 | existing], num_new + 1}
          ^n -> {[n - 1 | existing], num_new}
        end
      end)

    existing = existing |> Enum.reverse()
    new = List.duplicate(8, num_new)

    existing ++ new
  end


end
