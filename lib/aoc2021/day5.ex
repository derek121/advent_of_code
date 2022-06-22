defmodule AOC2021.Day5 do

  @doc """
  https://adventofcode.com/2021/day/5

  Sample input lines:
  [
    {{0,9}, {5,9}},
    {{9,4}, {3,4}},
    {{2,2}, {2,1}},
    {{7,0}, {7,4}},
    {{0,9}, {2,9}},
    {{3,4}, {1,4}}
  ]

  Output for that input:
  . . . . . . . 1 . .
  . . 1 . . . . 1 . .
  . . 1 . . . . 1 . .
  . . . . . . . 1 . .
  . 1 1 2 1 1 1 2 1 1
  . . . . . . . . . .
  . . . . . . . . . .
  . . . . . . . . . .
  . . . . . . . . . .
  2 2 2 1 1 1 . . . .
  """
  def run(lines) do
    lines
    |> expand()
    |> mark_locations()
    |> output()
  end

  def expand(lines) when is_list(lines) do
    lines
    |> Enum.map(&expand/1)
    |> List.flatten()
  end

  # Expand horizontal
  def expand({{x1, y}, {x2, y}}) do
    # {{0,2}, {4,2}} -> [{0,2}, {1,2}, {2,2}, {3,2}, {4,2}]

    for n <- x1..x2, do: {n, y}
  end

  # Expand vertical
  def expand({{x, y1}, {x, y2}}) do
    # {{2,1}, {2,5}} -> [{2,1}, {2,2}, {2,3}, {2,4}, {2,5}]

    for n <- y1..y2, do: {x, n}
  end

  @doc """
  Set the number of intersections of each coordinate.

  Input example:
  [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {2, 0}, {2, 1}, {2, 2}, {2, 3}, {2, 4}]

  Return:
  Map of {x,y} => count
  """
  def mark_locations(coords) do
    coords
    |> Enum.reduce(%{}, &update_with_coord/2)
  end

  def update_with_coord(coord, m) do
    {_, m} =
      m
      |> Map.get_and_update(coord, fn current_value ->
        case current_value do
          nil -> {current_value, 1}
          current_value -> {current_value, current_value + 1}
        end
      end)

    m
  end

  @doc """
  Input is from mark_locations/1

  Example:
  %{
      {0, 2} => 1,
      {1, 2} => 1,
      {2, 0} => 1,
      {2, 1} => 1,
      {2, 2} => 2,
      {2, 3} => 1,
      ...
  """
  def output(counts) do
    max_x =
      counts
      |> Map.keys()
      |> Enum.map(&(elem(&1, 0)))
      |> Enum.max()

    max_y =
      counts
      |> Map.keys()
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.max()

    all_coords = for y <- 0..max_y, x <- 0..max_x, do: {x, y}

    # Set all coordinates to 0 to start with
    all_coords_with_0 = Enum.zip(all_coords, List.duplicate(".", length(all_coords))) |> Map.new()

    counts_as_string =
      counts
      |> Enum.map(fn {k, v} -> {k, Integer.to_string(v)} end)
      |> Map.new()

    # Merge to set the coordinates corresponding to the input lines
    totals = Map.merge(all_coords_with_0, counts_as_string)

    # Sort after Map.to_list to get it sorted by the coord tuples, since undefined what the
    # order of Map.to_list will be. This will be by the x value, then y, so it will be going
    # down, since y goes down. But we want to order going across, so we then sort by the
    # second element of the coord, which is the y coord.
    chunked =
      Map.to_list(totals)
      |> Enum.sort()
      |> Enum.sort_by(&(elem(elem(&1, 0), 1)))
      |> Enum.chunk_every(max_x + 1) # +1 since it's 0-based

    as_strings =
      chunked
      |> Enum.map(&join_row/1)
      |> Enum.join("\n")

    IO.puts(as_strings)
  end

  @doc """
  Concatenate the second elements of each tuple.
  """
  def join_row(row) do
    # [{{0, 0}, "."}, {{0, 1}, "."}, {{0, 2}, "1"}, {{0, 3}, "."}, {{0, 4}, "."}],
    row
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join(" ")
  end


end
