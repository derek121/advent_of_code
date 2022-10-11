defmodule AOC2019.Day6 do
  @moduledoc """
  https://adventofcode.com/2019/day/6

  Whenever A orbits B and B orbits C, then A indirectly orbits C. This chain can be any number of objects long: if A orbits B, B orbits C, and C orbits D, then A indirectly orbits D.

  For example, suppose you have the following map:

  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L

  Visually, the above map of orbits looks like this:

        G - H       J - K - L
       /           /
  COM - B - C - D - E - F
               \
                I

  In this visual representation, when two objects are connected by a line, the one on the right directly orbits the one on the left.

  Here, we can count the total number of orbits as follows:

    D directly orbits C and indirectly orbits B and COM, a total of 3 orbits.
    L directly orbits K and indirectly orbits J, E, D, C, B, and COM, a total of 7 orbits.
    COM orbits nothing.

  The total number of direct and indirect orbits in this example is 42.
  """

  def go(data) do
    # %{"B" => "COM", "C" => "B", "D" => "C", "E" => "D"}
    map = create_map(data)

    # Stack-based calls
    # calc_stack(Map.keys(map), map)

    # Tail-recursive calls
    calc_tail(Map.keys(map), map, 0)
  end

  ### Tail-recursive

  # Could keep a cache of already-computed values, to avoid a lot of duplicate work

  @doc """
  Tail-recursive version.
  """
  def calc_tail([], _map, count) do
    count
  end

  def calc_tail([orbiter | rest], map, count) do
    count = calc_tail(map[orbiter], map, count + 1)
    calc_tail(rest, map, count)
  end

  #
  def calc_tail("COM", _map, count) do
    count
  end

  def calc_tail(orbiter, map, count) do
    calc_tail(map[orbiter], map, count + 1)
  end


  ### Stack

  @doc """
  Call stack-based.
  """
  def calc_stack([], _map) do
    0
  end

  def calc_stack([orbiter | rest], map) do
    1 + calc_stack(map[orbiter], map) + calc_stack(rest, map)
  end

  #
  def calc_stack("COM", _map) do
    0
  end

  def calc_stack(orbiter, map) do
    1 + calc_stack(map[orbiter], map)
  end

  @doc """
  E.g.:
  COM)B
  B)C
  C)D
  D)E
  """
  def create_map(data) do
    data
    # ["COM)B", "B)C", "C)D", "D)E"]
    |> String.split()
    # E.g., each element into form ["COM", "B"], so a list of lists
    |> Enum.map(fn line -> String.split(line, ")") end)
    # %{"B" => "COM", "C" => "B", "D" => "C", "E" => "D"}
    |> Enum.reduce(%{}, fn [orbited, orbiter], acc -> Map.put(acc, orbiter, orbited) end)
  end

end
