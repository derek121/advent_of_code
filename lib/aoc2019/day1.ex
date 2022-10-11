defmodule AOC2019.Day1 do
  @moduledoc """
  https://adventofcode.com/2019/day/1

  Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module,
  take its mass, divide by three, round down, and subtract 2.0
  """

  def go(mass) do
    div(mass, 3) - 2
  end

end
