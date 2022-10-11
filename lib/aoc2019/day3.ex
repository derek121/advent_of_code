defmodule AOC2019.Day3 do
  @moduledoc """
  https://adventofcode.com/2019/day/3

  For example, if the first wire's path is R8,U5,L5,D3, then starting from the central port (o), it goes right 8,
  up 5, left 5, and finally down 3:

  ...........
  ...........
  ...........
  ....+----+.
  ....|....|.
  ....|....|.
  ....|....|.
  .........|.
  .o-------+.
  ...........

  Then, if the second wire's path is U7,R6,D4,L4, it goes up 7, right 6, down 4, and left 4:

  ...........
  .+-----+...
  .|.....|...
  .|..+--X-+.
  .|..|..|.|.
  .|.-X--+.|.
  .|..|....|.
  .|.......|.
  .o-------+.
  ...........

  These wires cross at two locations (marked X), but the lower-left one is closer to the central port: its
  distance is 3 + 3 = 6.
  """

  @doc """
  E.g.:
  R8,U5,L5,D3
  U7,R6,D4,L4
  """
  def go(wire1_in, wire2_in) do
    # E.g., [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]
    wire1 = parse_wire(wire1_in)
    wire2 = parse_wire(wire2_in)

    coords = %{}

    # {x, y} (x: horizontal, y: vertical)
    # Origin is bottom left

    coords =
      travel_wire(coords, wire1)
      |> travel_wire(wire2)

    intersections =
      coords
      |> Enum.filter(fn {_k, v} -> v == 2 end)

    {{min_x, min_y}, _} =
      intersections
      |> Enum.min_by(fn {{x, y}, _} -> x + y end)

    min_x + min_y
  end

  @doc """
  In:
    coords: Map of point => count of crossings (nil, 1, or 2)
    wire: [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]

  Out:
    updated coords map
  """
  def travel_wire(coords, wire) do
    {_, new_coords} =
      wire
      |> Enum.reduce({{0, 0}, coords}, fn
        {:right, count}, {point, coords} = _acc -> move_right(point, count, coords)
        {:left, count},  {point, coords} = _acc -> move_left(point, count, coords)
        {:up, count},    {point, coords} = _acc -> move_up(point, count, coords)
        {:down, count},  {point, coords} = _acc -> move_down(point, count, coords)
      end)

    new_coords
  end

  @doc """
  In:
  Starting point
  How many to move
  coords: Map of point => count of crossings

  Return:
  {new point after moving, updated coords)
  """
  def move_right({x, y} = _point, count, coords = _acc) do
    # E.g., with {x, y} as {0, 0}, count as 4, and empty coords:
    points = for n <- (x + 1)..(x + count), do: {n, y}

    merged = add_new_coords(points, coords)

    # Will be returned to Enum.reduce as the new accumulator:
    #   {new point after moving, updated coords map}
    {{x + count, y}, merged}
  end

  def move_left({x, y} = _point, count, coords = _acc) do
    # E.g., with {x, y} as {4, 4}, count as 4, and empty coords:
    # [{0, 4}, {1, 4}, {2, 4}, {3, 4}]
    points = for n <- (x - count)..(x - 1), do: {n, y}

    merged = add_new_coords(points, coords)

    # Will be returned to Enum.reduce as the new accumulator
    {{x - count, y}, merged}
  end

  def move_up({x, y} = _point, count, coords = _acc) do
    # E.g., with {x, y} as {0, 3}, count as 4, and empty coords:
    # [{0, 4}, {0, 5}, {0, 6}, {0, 7}]
    points = for n <- (y + 1)..(y + count), do: {x, n}

    merged = add_new_coords(points, coords)

    # Will be returned to Enum.reduce as the new accumulator
    {{x, y + count}, merged}
  end

  def move_down({x, y} = _point, count, coords = _acc) do
    # E.g., with {x, y} as {0, 4}, count as 4, and empty coords:
    # [{0, 3}, {0, 2}, {0, 1}, {0, 0}]
    points = for n <- (y - count)..(y - 1), do: {x, n}

    merged = add_new_coords(points, coords)

    # Will be returned to Enum.reduce as the new accumulator
    {{x, y - count}, merged}
  end

  def add_new_coords(points, coords) do
    # Coords for the new line, each coords set to 1
    new_line_coords =
      points
      |> Enum.zip(List.duplicate(1, length(points)))
      |> Map.new()

    # Merge with existing coords, adding new val with existing if a coord is already present
    Map.merge(coords, new_line_coords, fn _k, v1, v2 -> v1 + v2 end)
  end


  @doc """
  In: "R8,U5,L5,D3"
  Out: [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]
  """
  def parse_wire(wire) do
    wire
    # ["R8", "U5", "L5", "D3"]
    |> String.split(",")
    # [{"R", "8"}, {"U", "5"}, {"L", "5"}, {"D", "3"}]
    |> Enum.map(&(String.split_at(&1, 1)))
    # [right: 8, up: 5, left: 5, down: 3] (in keyword list format)
    |> Enum.map(fn
      {"R", count} -> {:right, String.to_integer(count)}
      {"L", count} -> {:left, String.to_integer(count)}
      {"U", count} -> {:up, String.to_integer(count)}
      {"D", count} -> {:down, String.to_integer(count)}
    end)
  end

end
