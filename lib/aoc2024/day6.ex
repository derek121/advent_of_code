defmodule AOC2024.Day6 do
  # https://adventofcode.com/2024/day/6

  @moduledoc """
  From the above link.

  -
  The map shows the current position of the guard with ^ (to indicate the guard
  is currently facing up from the perspective of the map). Any obstructions -
  crates, desks, alchemical reactors, etc. - are shown as #.

  Lab guards in 1518 follow a very strict patrol protocol which involves
  repeatedly following these steps:

      If there is something directly in front of you, turn right 90 degrees.
      Otherwise, take a step forward.

  Following the above protocol, the guard moves up several times until she
  reaches an obstacle.
  -

  Then turns right and continues the process.

  -
  This process continues for a while, but the guard eventually leaves the
  mapped area.
  -

  Each position visited is marked with an X, including the starting location.
  Then the total number of X's are counted and validated.

  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...

  The resulting map indeed matches the expected output as seen in the puzzle
  description:

  ....#.....
  ....XXXXX#
  ....X...X.
  ..#.X...X.
  ..XXXXX#X.
  ..X.X.X.X.
  .#XXXXXXX.
  .XXXXXXX#.
  #XXXXXXX..
  ......#X..
  """

  def go(source_map) do
    {map, num_rows, num_cols} = create_map(source_map)

    # {{4,3}, :up}
    guard_loc = find_guard_loc(map)

    process(map, guard_loc, num_rows, num_cols)
  end

  @doc """
  loc:
  {{4,3}, :up}
  or
  {nil, dir} when go off edge of map

  Return: map
    map will have X'd out locations traversed, and coord will be the space
    that were stopped at by an obstruction, turned 90 degrees to the right,
    or nil if went off side.
  """
  def process(map, {nil, _dir}, _num_rows, _num_cols) do
    map
  end

  def process(map, loc, num_rows, num_cols) do
    # [{4, 4}, {4, 5}, {4, 6}, {4, 7}, {4, 8}, {4, 9}]
    path = calc_path(loc, num_rows, num_cols)

    {map, coord} = walk(map, elem(loc, 0), path)

    # Call turn/1 even if coord is nil, as will be when go off the edge
    loc = {coord, turn(elem(loc, 1))}

    process(map, loc, num_rows, num_cols)
  end

  def turn(:up), do: :right
  def turn(:right), do: :down
  def turn(:down), do: :left
  def turn(:left), do: :up

  @doc """
  #loc: {{4, 3}, :up}
  start_coord: {4,3}
  path: [{4, 4}, {4, 5}, {4, 6}, {4, 7}, {4, 8}, {4, 9}]

  Return: {map, coord}
    map will have X'd out locations traversed, and coord will be the space
    that were stopped at by an obstruction, or nil if went off side.
  """
  def walk(map, start_coord, path) do
    # Mark starting position
    map = Map.put(map, start_coord, "X")

    # {map, val}, where val is the coord of an obstruction, or nil if walked
    # off the edge
    halt_point =
      path
      |> Enum.reduce_while(
        {map, nil},
        fn this_coord, {map, _} ->
          case map[this_coord] do
            "#" ->
              # Obstruction found
              {:halt, {map, this_coord}}

            "." ->
              # Mark as visited
              map = Map.put(map, this_coord, "X")
              {:cont, {map, nil}}

            "X" ->
              # Already crossed this point. Ignore.
              {:cont, {map, nil}}
          end
        end
      )

    {map, end_coord} = halt_point

    # Set end_coord to be the one prior to its value, which is the obstruction, unless
    # it's nil, in which case we're off the edge.

    # nil if off the map
    prior_coord = set_to_prior_point(end_coord, path)

    {map, prior_coord}
  end

  def set_to_prior_point(nil, _path), do: nil

  def set_to_prior_point(coord, path) do
    idx = Enum.find_index(path, fn c -> c == coord end)

    Enum.at(path, idx - 1)
  end

  @doc """
  start_loc: E.g., {{4,3}, :up}

  Return: List of coords (e.g., [{4,4}, {4,5}, {4,6}]), to the edge of the map.
  """
  def calc_path(start_loc, num_rows, num_cols) do
    {{x_loc, y_loc}, dir} = start_loc

    case dir do
      # [{4, 4}, {4, 5}, {4, 6}, {4, 7}, {4, 8}, {4, 9}]
      :up when y_loc < num_rows - 1 ->
        for y <- (y_loc + 1)..(num_rows - 1), do: {x_loc, y}

      # [{5, 3}, {6, 3}, {7, 3}, {8, 3}, {9, 3}]
      :right when x_loc < num_cols - 1 ->
        for x <- (x_loc + 1)..(num_cols - 1), do: {x, y_loc}

      # [{4, 2}, {4, 1}, {4, 0}]
      :down when y_loc > 0 ->
        for y <- (y_loc - 1)..0//-1, do: {x_loc, y}

      # [{3, 3}, {2, 3}, {1, 3}, {0, 3}]
      :left when x_loc > 0 ->
        for x <- (x_loc - 1)..0//-1, do: {x, y_loc}

        # Else, must be at the edge at dir points out
      _ ->
        []
    end
  end

  @doc """
  Return: Coordinate and direction of the guard position, e.g., {{4,3}, :up}
  """
  def find_guard_loc(map) do
    map
    # E.g., {{4,9}, :up}
    |> Enum.find(fn {_, c} -> c in ["^", ">", "v", "<"] end)
    |> case do
      {coord, "^"} -> {coord, :up}
      {coord, ">"} -> {coord, :right}
      {coord, "v"} -> {coord, :down}
      {coord, "<"} -> {coord, :left}
    end
  end

  def print_map(map, num_rows, num_cols) do
    IO.puts("")

    for y <- (num_rows - 1)..0//-1, x <- 0..(num_cols - 1), into: "" do
      <<String.at(Map.get(map, {x, y}), 0) |> String.to_charlist() |> hd()>>
    end
    |> String.to_charlist()
    |> Enum.chunk_every(10)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  @doc """
  Create Map representing source_map. Origin ({0, 0}) is the bottom left corner.
  """
  def create_map(source_map) do
    {map, num_rows, num_cols} =
      source_map
      # ["....#.....", ".........#", "..........", "..#.......", ".......#..",
      #  "..........", ".#..^.....", "........#.", "#.........", "......#..."]
      |> String.split("\n", trim: true)

      # [
      #   [".", ".", ".", ".", "#", ".", ".", ".", ".", "."],
      #   [".", ".", ".", ".", ".", ".", ".", ".", ".", "#"],
      #   ...
      # ]
      |> Enum.map(fn row -> String.split(row, "", trim: true) end)
      # Reverse because our origin will be bottom left, so the fold now will
      # start numbering the rows from 0 starting what is the bottom in the source,
      # as we want.
      |> Enum.reverse()
      |> List.foldl({%{}, 0, :undefined}, fn row, {map, row_num, _num_cols} ->
        width = length(row)

        # [{0, 0}, {1, 0}, {2, 0}, ...]
        keys = for col <- 0..(width - 1), do: {col, row_num}

        # The zip return:
        # [
        #   {{0, 0}, "."},
        #   {{1, 0}, "."},
        #   {{2, 0}, "."},
        #   {{3, 0}, "."},
        #   {{4, 0}, "."},
        #   {{5, 0}, "."},
        #   {{6, 0}, "#"}
        #   {{7, 0}, "."}
        #   {{8, 0}, "."}
        #   {{9, 0}, "."}
        # ]
        this_row_map =
          Enum.zip(keys, row)

          # %{
          #   {0, 0} => ".",
          #   {1, 0} => ".",
          #   {2, 0} => ".",
          #   {3, 0} => ".",
          #   {4, 0} => ".",
          #   {5, 0} => ".",
          #   {6, 0} => "#"
          #   {7, 0} => "."
          #   {8, 0} => "."
          #   {9, 0} => "."
          # }
          |> Map.new()

        map = Map.merge(map, this_row_map)

        # Seems hacky to have to pass around width (num columns) like this
        {map, row_num + 1, width}
      end)

    {map, num_rows, num_cols}
  end
end
