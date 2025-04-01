defmodule AOC2024.Day6Test do
  use ExUnit.Case

  alias AOC2024.Day6

  def source_map() do
    """
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
    """
  end

  def source_map_up_from_top_edge() do
    """
    .^..#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#........
    ........#.
    #.........
    ......#...
    """
  end

  def source_map_right_from_right_edge() do
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    .........>
    .#........
    ........#.
    #.........
    ......#...
    """
  end

  def source_map_down_from_bottom_edge() do
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#........
    ........#.
    #.........
    ....v.#...
    """
  end

  def source_map_left_from_left_edge() do
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#........
    <.......#.
    #.........
    ......#...
    """
  end

  # test "create_map" do
  #   source_map = source_map()
  #   {map, num_rows, num_cols} = _map_creation = Day6.create_map(source_map)
  #   Day6.print_map(map, num_rows, num_cols)
  # end

  test "walk up" do
    source_map = source_map()
    {map, num_rows, num_cols} = _map_creation = Day6.create_map(source_map)

    start_coord = {4, 3}
    start_loc = {start_coord, :up}

    path = Day6.calc_path(start_loc, num_rows, num_cols)

    {map, _end_point} = Day6.walk(map, start_coord, path)

     path_expected =
      %{}
      |> Map.put({4,3}, "X")
      |> Map.put({4,4}, "X")
      |> Map.put({4,5}, "X")
      |> Map.put({4,6}, "X")
      |> Map.put({4,7}, "X")
      |> Map.put({4,8}, "X")

      map_expected = Map.merge(map, path_expected)

      assert map == map_expected
  end

  test "walk right" do
    source_map = source_map()
    {map, num_rows, num_cols} = _map_creation = Day6.create_map(source_map)

    start_coord = {4, 3}
    start_loc = {start_coord, :right}

    path = Day6.calc_path(start_loc, num_rows, num_cols)

    {map, _end_point} = Day6.walk(map, start_coord, path)

     path_expected =
      %{}
      |> Map.put({4,3}, "X")
      |> Map.put({5,3}, "X")
      |> Map.put({6,3}, "X")
      |> Map.put({7,3}, "X")
      |> Map.put({8,3}, "X")
      |> Map.put({9,3}, "X")

      map_expected = Map.merge(map, path_expected)

      assert map == map_expected
  end

  test "walk down" do
    source_map = source_map()
    {map, num_rows, num_cols} = _map_creation = Day6.create_map(source_map)

    start_coord = {4, 3}
    start_loc = {start_coord, :down}

    path = Day6.calc_path(start_loc, num_rows, num_cols)

    {map, _end_point} = Day6.walk(map, start_coord, path)

     path_expected =
      %{}
      |> Map.put({4,3}, "X")
      |> Map.put({4,2}, "X")
      |> Map.put({4,1}, "X")
      |> Map.put({4,0}, "X")

      map_expected = Map.merge(map, path_expected)

      assert map == map_expected
  end

  test "walk left" do
    source_map = source_map()
    {map, num_rows, num_cols} = _map_creation = Day6.create_map(source_map)

    start_coord = {4, 3}
    start_loc = {start_coord, :left}

    path = Day6.calc_path(start_loc, num_rows, num_cols)

    {map, _end_point} = Day6.walk(map, start_coord, path)

     path_expected =
      %{}
      |> Map.put({4,3}, "X")
      |> Map.put({3,3}, "X")
      |> Map.put({2,3}, "X")

      map_expected = Map.merge(map, path_expected)

      assert map == map_expected
  end

  test "go internal" do
    source_map = source_map()

    map = Day6.go(source_map)

    # Visually confirms the expected output from the puzzle description.
    # Programmatically verified in the assert below.
    #Day6.print_map(map, 10, 10)

    expected = 41

    actual =
      map
      |> Map.values()
      |> Enum.count(fn v -> v == "X" end)

    assert actual == expected
  end

  test "go up from top edge" do
    source_map = source_map_up_from_top_edge()

    map = Day6.go(source_map)

    expected = 1

    actual =
      map
      |> Map.values()
      |> Enum.count(fn v -> v == "X" end)

    assert actual == expected
  end

  test "go right from right edge" do
    source_map = source_map_right_from_right_edge()

    map = Day6.go(source_map)

    expected = 1

    actual =
      map
      |> Map.values()
      |> Enum.count(fn v -> v == "X" end)

    assert actual == expected
  end

  test "go down from bottom edge" do
    source_map = source_map_down_from_bottom_edge()

    map = Day6.go(source_map)

    expected = 1

    actual =
      map
      |> Map.values()
      |> Enum.count(fn v -> v == "X" end)

    assert actual == expected
  end

  test "go left from left edge" do
    source_map = source_map_left_from_left_edge()

    map = Day6.go(source_map)

    expected = 1

    actual =
      map
      |> Map.values()
      |> Enum.count(fn v -> v == "X" end)

    assert actual == expected
  end

  test "calc_path internal" do
    # Up
    actual = Day6.calc_path({{4, 3}, :up}, 10, 10)
    expected = [{4, 4}, {4, 5}, {4, 6}, {4, 7}, {4, 8}, {4, 9}]

    assert actual == expected

    # Right
    actual = Day6.calc_path({{4, 3}, :right}, 10, 10)
    expected = [{5, 3}, {6, 3}, {7, 3}, {8, 3}, {9, 3}]

    assert actual == expected

    # Down
    actual = Day6.calc_path({{4, 3}, :down}, 10, 10)
    expected = [{4, 2}, {4, 1}, {4, 0}]

    assert actual == expected

    # Left
    actual = Day6.calc_path({{4, 3}, :left}, 10, 10)
    expected = [{3, 3}, {2, 3}, {1, 3}, {0, 3}]

    assert actual == expected
  end

  test "calc_path edge" do
    # Up
    actual = Day6.calc_path({{4, 9}, :up}, 10, 10)
    expected = []
    assert actual == expected

    # Right
    actual = Day6.calc_path({{9, 3}, :right}, 10, 10)
    expected = []
    assert actual == expected

    # Down
    actual = Day6.calc_path({{4, 0}, :down}, 10, 10)
    expected = []
    assert actual == expected

    # Left
    actual = Day6.calc_path({{0, 3}, :left}, 10, 10)
    expected = []
    assert actual == expected
  end
end
