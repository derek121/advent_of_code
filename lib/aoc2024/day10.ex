defmodule AOC2024.Day10 do
  # https://adventofcode.com/2024/day/10

  @target_height 9

  def go(source_map) do
    {map, num_rows, num_cols} =
      create_map(source_map)

    print_map(map, num_rows, num_cols)
    IO.puts("")

    # Find trailheads
    # This map has two:
    # 10..9..
    # 2...8..
    # 3...7..
    # 4567654
    # ...8..3
    # ...9..2
    # .....01

    # map of the form:
    # %{
    # {0, 0} => 0,
    # {0, 1} => nil,
    # {0, 2} => nil,
    # {0, 3} => 9,
    # {1, 0} => 1,
    # {1, 1} => 6,
    # ...
    # }

    trailheads =
      map
      |> Enum.filter(fn {_coord, height} -> height == 0 end)
      |> Enum.map(fn {coord, _} -> coord end)
      |> Enum.sort_by(fn {x, y} -> {y, x} end)
      # |> IO.inspect(label: "trailheads")

    all_paths_found =
      trailheads
      |> Enum.map(fn trailhead ->
        walk(MapSet.new(), map, trailhead, num_rows, num_cols)
      end)

    IO.inspect(all_paths_found, label: "all_paths_found")

    total = Enum.sum_by(all_paths_found, fn paths_found -> MapSet.size(paths_found) end)

    total
  end

  @doc """
  Starting at pos, follow a path monotonically increasing from the map value for
  that coordinate. In practice, the problem description specifies that we'll be
  starting at a height/value of 0. The up direction is travelled first, as far
  as possible with properly-increasing heights, with each new position
  a depth-first travel being done, when then backing out, the right direction
  is processed, followed by down, and then left.

  Params:
  all_found: the coordindates of each

  For:

  0123
  .654
  ...5
  9876

  Since each position has its four sides checked in order of top, right, down,
  then left, the order of traversal is as follows, and which can be seen by
  following the IO output. Since can't go off the grid, I'll leave off those
  checks in this description.

  0,0
  Right to 1,0
  Right to 2,0
  Right to 3,0
  Down to 3,1
  Down to 3,2
  Down to 3,3
  Left to 2,3
  Left to 1,3
  Left to 0,3 to reach height 9
  Back out to the 4 at 3,1
  Now left to 5 at 2,1
  Can't go up since it's not the next height of 6
  Can't go right for same reason (just happens to be where we came fromo)
  Can't go down because it's impassable
  Left to 6 at 1,1
  Can't go up, right, or down for same reasons as just previously at 2,1
  And can't go left since it's impassable
  This path now also backs out, and we're left with a result of 1 path to 9.
  """
  # def walk(all_found \\ MapSet.new(), map, pos, num_rows, num_cols) do
  def walk(all_found, map, pos, num_rows, num_cols) do
    height = map[pos]

    IO.puts("Walk at pos: #{inspect(pos)}, height: #{height}")

    # total =
    all_found =
      all_found
      |> walk(map, up(pos, num_rows, num_cols), :up, height + 1, num_rows, num_cols)
      |> walk(map, right(pos, num_rows, num_cols), :right, height + 1, num_rows, num_cols)
      |> walk(map, down(pos, num_rows, num_cols), :down, height + 1, num_rows, num_cols)
      |> walk(map, left(pos, num_rows, num_cols), :left, height + 1, num_rows, num_cols)

    IO.puts(
      "Total of #{MapSet.size(all_found)} from walking at " <>
        "pos: #{inspect(pos)}, height: #{height}: #{inspect(all_found)}"
    )

    all_found
  end

  ##

  # Off map
  def walk(all_found, _map, nil, dir, _needed_height, _num_rows, _num_cols) do
    IO.puts("Off the map: #{dir}")
    # 0
    all_found
  end

  def walk(all_found, map, pos, dir, needed_height, num_rows, num_cols) do
    height = map[pos]

    IO.puts("Walked #{dir} to #{inspect(pos)}. Height: #{height}. ")

    case height do
      ^needed_height when height == @target_height ->
        # 1
        if MapSet.member?(all_found, pos) do
          IO.puts("Found 9 (and found previously). Returning.")
          all_found
        else
          IO.puts("Found 9. Returning.")
          MapSet.put(all_found, pos)
        end

      ^needed_height ->
        IO.puts("Found #{needed_height}. Advancing.")
        walk(all_found, map, pos, num_rows, num_cols)

      ^height when is_integer(height) and height > needed_height ->
        IO.puts("Too high. Returning.")
        # 0
        all_found

      ^height when is_integer(height) and height < needed_height ->
        IO.puts("Too low. Returning.")
        # 0
        all_found

      ^height when is_nil(height) ->
        IO.puts("Impassable. Returning.")
        # 0
        all_found

        # Else we created the map with an invalid character
    end
  end

  #
  def up({_x, y}, _num_rows, _num_cols) when y == 0, do: nil
  def up({x, y}, _num_rows, _num_cols), do: {x, y - 1}

  def right({x, _y}, _num_rows, num_cols) when x == num_cols - 1, do: nil
  def right({x, y}, _num_rows, _num_cols), do: {x + 1, y}

  def down({_x, y}, num_rows, _num_cols) when y == num_rows - 1, do: nil
  def down({x, y}, _num_rows, _num_cols), do: {x, y + 1}

  def left({x, _y}, _num_rows, _num_cols) when x == 0, do: nil
  def left({x, y}, _num_rows, _num_cols), do: {x - 1, y}

  # # Off the map
  # def walk(map, _need, nil), do: 0

  # # # Found next height
  # # def walk(map, need, need), do: 0

  # # # Too high
  # # def walk(map, _need, _height), do: 0

  #

  def create_map(source_map) do
    # For source_map:
    # """
    # 0123
    # 1234
    # 8765
    # 9876
    # """

    # {map, num_rows, num_cols} =

    split =
      source_map
      # ["0123", "...4", "...5", "9876"]
      |> String.split("\n", trim: true)

      #

      # [
      # ["0", "1", "2", "3"],
      # [".", ".", ".", "4"],
      # [".", ".", ".", "5"],
      # ["9", "8", "7", "6"]
      # ]
      |> Enum.map(fn row -> String.split(row, "", trim: true) end)
      |> Enum.map(fn row ->
        Enum.map(row, fn val ->
          case val do
            "." -> nil
            ^val -> String.to_integer(val)
          end
        end)
      end)

    num_rows = length(split)
    num_cols = length(hd(split))

    keys = for y <- 0..(num_rows - 1), x <- 0..(num_cols - 1), do: {x, y}
    vals = List.flatten(split)

    # %{
    # {0, 0} => 0,
    # {0, 1} => nil,
    # {0, 2} => nil,
    # {0, 3} => 9,
    # {1, 0} => 1,
    # {1, 1} => 6,
    # ...
    # }
    map =
      Enum.zip(keys, vals)
      |> Map.new()

    {map, num_rows, num_cols}
  end

  ##

  def print_map(map, num_rows, num_cols) do
    IO.puts("")

    for y <- 0..(num_rows - 1), x <- 0..(num_cols - 1), into: "" do
      # <<String.at(Map.get(map, {x, y}), 0) |> String.to_charlist() |> hd()>>
      <<String.at(cell_to_string(Map.get(map, {x, y})), 0) |> String.to_charlist() |> hd()>>
    end
    |> String.to_charlist()
    |> Enum.chunk_every(num_cols)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  def cell_to_string(nil), do: "."
  def cell_to_string(val) when is_integer(val), do: Integer.to_string(val)
end
