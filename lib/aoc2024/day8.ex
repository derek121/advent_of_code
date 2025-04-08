defmodule AOC2024.Day8 do
  # https://adventofcode.com/2024/day/8

  @moduledoc """
  """

  def go(source_map) do
    {map, num_rows, num_cols} = create_map(source_map)

    antennae_for_all_freqs = find_antennae_for_all_freqs(map)

    _antinodes_for_all_freqs =
      find_antinodes_for_all_freqs(
        antennae_for_all_freqs,
        num_rows,
        num_cols
      )

    # From the find_antinodes_for_all_freqs call:
    # find_antinodes_for_antennae_list(antennae, num_rows, num_cols)
    # find_antinodes_for_antennae_list(antennae, num_rows, num_cols, acc)
    # find_antinodes_for_antennae(antennae, num_rows, num_cols)
    # find_antinodes_for_antennae_pair(antenna1, antenna2, num_rows, num_cols)
  end

  @doc """
  Given map, of the form
    %{
      {0,0} => ".",
      {1,0} => "a",
      {2,0} => "b",
      {3,0} => ".",
      {4,0} => "a",
      {0,1} => "c",
      {1,1} => "a",
      {2,1} => "a",
      {3,1} => "b",
      {4,1} => "."
    }
  }

  Create a map %{freq => [coord]}, where the coord list is sorted by
  column/row (so the coords for a given frequency on a given row appearing in
  the list after those on rows above it).  So in the demo map with two antennae
  for frequency "a" at {4,3} and {5,5}, our resultant map will have a pair
  "a" => [{4,3}, {5,5}].

  For the above input map, the following would be returned:
    # [
    # {"a", [{1,0}, {1,1}, {2,1}, {4,0}]},
    # {"b", [{2,0}, {3,1}]},
    # {"c", [{0,}]}
    # ]
  """
  def find_antennae_for_all_freqs(map) do
    map
    |> Enum.group_by(fn {_k, v} -> v end)
    # |> IO.inspect(label: "After group_by")
    #
    # [
    # {"a", [{{1,0}, "a"}, {{1,1}, "a"}, {{2,1}, "a"}, {{4,0}, "a"}]},
    # {"b", [{{2,0}, "b"}, {{3,1}, "b"}]},
    # {"c", [{{0,1}, "c"}]}
    # ]
    |> Enum.filter(fn {k, _v} -> k != "." end)
    |> IO.inspect(label: "Before clean")
    #
    # [
    # {"a", [{1,0}, {1,1}, {2,1}, {4,0}]},
    # {"b", [{2,0}, {3,1}]},
    # {"c", [{0,1}]}
    # ]
    |> Enum.map(&clean_antennae_coord_list/1)
    |> IO.inspect(label: "After clean")
    #
    |> Enum.map(fn {freq, antennae} -> {freq, Enum.sort(antennae)} end)
    |> IO.inspect(label: "After sort")
  end

  def clean_antennae_coord_list(entry) do
    {freq, list} = entry

    list =
      list
      |> Enum.map(fn {coord, _freq} -> coord end)

    {freq, list}
  end

  # TODO: if antennae list is just 1

  ##

  @doc """
  In:
  [
    {"0", [{7, 3}, {5, 2}, {8, 1}, {4, 4}]},
    {"A", [{8, 8}, {6, 5}, {9, 9}]}
  ]
  """

  def find_antinodes_for_all_freqs(antennae_for_all_freqs, num_rows, num_cols) do
    all_antinodes =
      antennae_for_all_freqs
      |> List.foldl([], fn {freq, antennae}, acc ->
        antinodes = find_antinodes_for_antennae_list(antennae, num_rows, num_cols)
        IO.inspect(antinodes, label: "Got antinodes for freq #{freq}")

        antinodes ++ acc
      end)
      |> Enum.sort()
      |> Enum.uniq()

    IO.inspect(all_antinodes, label: "all_antinodes")
  end

  ##

  @doc """
  For a list of antennae such as the following (for the example above for
  frequency "a"):

  [{6,5}, {8,8}, {9,9}]

  Call find_antinodes_for_antennae/3 with
  [{6,5}, {8,8}, {9,9}]
  [{8,8}, {9,9}]

  Result:
  [{4,2}, {10,11}, {3,1}]
  ++
  [{7,7}, {10,11}]
  """
  def find_antinodes_for_antennae_list(antennae, num_rows, num_cols) do
    find_antinodes_for_antennae_list(antennae, num_rows, num_cols, [])
  end

  # TODO: ensure no lone antenna in map

  ##

  def find_antinodes_for_antennae_list(antennae, _num_rows, _num_cols, acc)
      when length(antennae) < 2 do
    Enum.sort(acc)
  end

  def find_antinodes_for_antennae_list(antennae, num_rows, num_cols, acc) do
    acc =
      find_antinodes_for_antennae(antennae, num_rows, num_cols) ++
        acc

    find_antinodes_for_antennae_list(tl(antennae), num_rows, num_cols, acc)
  end

  ##
  @doc """
  For a list of antennae such as the following (from test's source_map/0):
  [{6,5}, {8,8}, {9,9}]

  Return the antinodes for
  {6,5}/{8,8} and {6,5}/{9,9}

  Result:
  [{4,2}, {10,11}, {3,1}]
  """
  def find_antinodes_for_antennae(antennae, num_rows, num_cols) do
    [first | rest] = antennae

    found =
      rest
      |> List.foldl([], fn second, acc ->
        found_for_this =
          find_antinodes_for_antennae_pair(first, second, num_rows, num_cols)

        IO.inspect(found_for_this, label: "Found for #{inspect(first)}")

        acc ++ found_for_this
      end)

    IO.inspect(found, label: "Found all for #{inspect(first)}")
  end

  @doc """
  For the two antennae of form {x, y}, find the antinodes that are not off
  the map.

  For example, from the example in the puzzle description page, with antennae
  at {4,3} and {5,5}, the antinodes are at {3,1} and {6,7}. They are found by
  moving away from antenna1 the same direction in both axes as it is from
  antenna2.

  Return value is list of 0 or more coords.
  """
  def find_antinodes_for_antennae_pair(antenna1, antenna2, num_rows, num_cols) do
    {x1, y1} = antenna1
    {x2, y2} = antenna2

    {x_delta, y_delta} = {x2 - x1, y2 - y1}

    anti1 = {x1 - x_delta, y1 - y_delta}

    IO.inspect(anti1,
      label:
        "anti1 for " <>
          "#{inspect(antenna1)} / #{inspect(antenna2)}"
    )

    anti2 = {x2 + x_delta, y2 + y_delta}

    IO.inspect(anti2,
      label:
        "anti2 for " <>
          "#{inspect(antenna1)} / #{inspect(antenna2)}"
    )

    [anti1, anti2]
    |> IO.inspect(label: "Antinodes before validate")
    |> Enum.filter(fn coord -> validate_anti_coords(coord, num_rows, num_cols) end)
    |> IO.inspect(label: "Antinodes after validate")
  end

  def validate_anti_coords({x, y}, num_rows, num_cols) do
    x >= 0 and x < num_cols and
      (y >= 0 and y < num_rows)
  end

  @spec create_map(binary()) :: any()
  def create_map(source_map) do
    {map, num_rows, num_cols} =
      source_map
      # [" ..........", " ...#......", " ..........", " ....a.....", " ..........",
      # " .....a....", " ..........", " ......#...", " ..........", " .........."]
      |> String.split("\n", trim: true)
      # |> IO.inspect()
      #
      # [
      # [" ", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      # [" ", ".", ".", ".", "#", ".", ".", ".", ".", ".", "."],
      # ...
      # ]
      |> Enum.map(fn row -> String.split(row, "", trim: true) end)
      # |> IO.inspect()
      #
      # %{
      # {1,3} => ".",
      # {9,9} => ".",
      # {1,1} => ".",
      # {1,5} => ".",
      # ...
      # }
      |> List.foldl({%{}, 0, :undefined}, fn row, {map, row_num, _num_cols} ->
        width = length(row)

        # [{0,0}, {1,0}, {2,0}, ...]
        keys = for col <- 0..(width - 1), do: {col, row_num}

        # The zip return:
        # [
        #   {{0,0}, "."},
        #   {{1,0}, "."},
        #   {{2,0}, "."},
        #   {{3,0}, "."},
        #   {{4,0}, "."},
        #   {{5,0}, "."},
        #   {{6,0}, "."},
        #   {{7,0}, "."},
        #   {{8,0}, "."},
        #   {{9,0}, "."},
        #   {{10,0}, "."},
        #   {{11,0}, "."}
        # ]
        this_row_map =
          Enum.zip(keys, row)
          # |> IO.inspect()

          # %{
          #   {0,0} => ".",
          #   {1,0} => ".",
          #   {2,0} => ".",
          #   {3,0} => ".",
          #   {4,0} => ".",
          #   {5,0} => ".",
          #   {6,0} => ".",
          #   {7,0} => ".",
          #   {8,0} => ".",
          #   {9,0} => ".",
          #   {10,0} => ".",
          #   {11,0} => "."
          # }
          |> Map.new()

        map = Map.merge(map, this_row_map)

        # Seems hacky to have to pass around width (num columns) like this
        {map, row_num + 1, width}
      end)

    IO.inspect(Enum.sort(map), label: "Created map", limit: :infinity)

    {map, num_rows, num_cols}
  end

  def print_map(map, num_rows, num_cols) do
    IO.puts("")

    for y <- 0..(num_rows - 1), x <- 0..(num_cols - 1), into: "" do
      <<String.at(Map.get(map, {x, y}), 0) |> String.to_charlist() |> hd()>>
    end
    |> String.to_charlist()
    |> Enum.chunk_every(num_cols)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end
end
