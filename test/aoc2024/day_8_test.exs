defmodule AOC2024.Day8Test do
  use ExUnit.Case

  alias AOC2024.Day8

  def source_map_demo() do
    # Antinodes at {3, 1} and {6, 7}
    """
    ..........
    ..........
    ..........
    ....a.....
    ..........
    .....a....
    ..........
    ..........
    ..........
    ..........
    """
  end

  @doc """
  Antennae A: {6,5}, {8,8}, {9,9}
  Antinodes for first and second:
  {4,2}, {10,11}
  Antinodes for first and third:
  {3,1}
  Antinodes for second and third:
  {7,7}, {10,10}

    0123456789ab (a and b for 10 and 11)
  0 ............
  1 ...#........
  2 ....#.......
  3 ............
  4 ............
  5 ......A.....
  6 ............
  7 .......#....
  8 ........A...
  9 .........A..
  a ..........#.
  b ..........#.

  --
  Antennae 0:

    0123456789ab (a and b for 10 and 11)
  0 ......#....#
  1 ...#....0...
  2 .....0....#.
  3 ..#....0....
  4 ....0....#..
  5 .#....#.....
  6 ...#........
  7 #...........
  8 ............
  9 ............
  a ............
  b ............

  """
  def source_map() do
    """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """
  end

  test "find and display antinodes" do
    antinodes = Day8.go(source_map())

    {map, num_rows, num_cols} = _map_creation = Day8.create_map(source_map())
    # Day8.print_map(map, num_rows, num_cols)

    {map, overlapping} = Day8.merge_antinodes_into_map(map, antinodes)

    IO.puts("#{length(antinodes)} antinodes found: #{inspect(antinodes)}")

    if length(overlapping) > 0 do
      IO.puts("Antinodes overlapping antennae:")

      Enum.each(overlapping, fn coord ->
        IO.puts("#{inspect(coord)}: #{inspect(map[coord])}")
      end)
    end

    Day8.print_map(map, num_rows, num_cols)
  end

  @tag :skip
  test "create_map" do
    source_map = source_map()
    # source_map = source_map_demo()

    {map, num_rows, num_cols} = _map_creation = Day8.create_map(source_map)

    Day8.print_map(map, num_rows, num_cols)
  end

  test "find_antennae_for_all_freqs misc a b c" do
    m = %{
      {0, 0} => ".",
      {1, 0} => "a",
      {2, 0} => "b",
      {3, 0} => ".",
      {4, 0} => "a",
      {0, 1} => "c",
      {1, 1} => "a",
      {2, 1} => "a",
      {3, 1} => "b",
      {4, 1} => "."
    }

    # {m, _num_rows, _num_cols} = Day8.create_map(source_map_demo())

    actual =
      Day8.find_antennae_for_all_freqs(m)

    # |> IO.inspect(label: "find_antennae_for_all_freqs return")

    expected = [
      {"a", [{1, 0}, {1, 1}, {2, 1}, {4, 0}]},
      {"b", [{2, 0}, {3, 1}]},
      {"c", [{0, 1}]}
    ]

    assert actual == expected
  end

  test "find_antennae_for_all_freqs 2 a's" do
    {m, _num_rows, _num_cols} = Day8.create_map(source_map_demo())

    actual =
      Day8.find_antennae_for_all_freqs(m)

    # |> IO.inspect(label: "find_antennae_for_all_freqs return")

    expected = [{"a", [{4, 3}, {5, 5}]}]

    assert actual == expected
  end

  ##
  test "find_antinodes_for_all_freqs" do
    {m, num_rows, num_cols} = Day8.create_map(source_map())

    # [
    #   {"0", [{7, 3}, {5, 2}, {8, 1}, {4, 4}]},
    #   {"A", [{8, 8}, {6, 5}, {9, 9}]}
    # ]
    antennae_for_all_freqs =
      Day8.find_antennae_for_all_freqs(m)

    # |> IO.inspect(label: "done")

    expected = [
      {0, 7},
      {1, 5},
      {2, 3},
      {3, 1},
      {3, 6},
      {4, 2},
      {6, 0},
      {6, 5},
      {7, 7},
      {9, 4},
      {10, 2},
      {10, 10},
      {10, 11},
      {11, 0}
    ]

    actual = Day8.find_antinodes_for_all_freqs(antennae_for_all_freqs, num_rows, num_cols)

    assert actual == expected
  end

  test "find_antinodes_for_antenna_list" do
    # For Antenna A in source_map/0 above
    antennae = [{6, 5}, {8, 8}, {9, 9}]

    # The antinodes for {6,5}/{8,8} and {6,5}/{9,9}:
    # plus those for {8,8}/{9,9}
    expected =
      [{4, 2}, {10, 11}, {3, 1}] ++
        [{7, 7}, {10, 10}]

    expected = Enum.sort(expected)

    actual =
      Day8.find_antinodes_for_antennae_list(antennae, 12, 12)

    # |> IO.inspect(label: "All")

    assert actual == expected
  end

  test "find_antinodes_for_antennae" do
    # For Antenna A in source_map/0 above
    antennae = [{6, 5}, {8, 8}, {9, 9}]

    # The antinodes for {6,5}/{8,8} and {6,5}/{9,9}:
    expected = [{4, 2}, {10, 11}, {3, 1}]

    actual = Day8.find_antinodes_for_antennae(antennae, 12, 12)
    # |> IO.inspect()

    assert actual == expected
  end

  # We don't have to check anything N, NE, NW, or W, since we work down
  # checking antennae from top to bottom, left to right.

  test "find_antinodes_for_antennae_pair SE" do
    ant1 = {4, 3}
    ant2 = {5, 5}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    expected = [{3, 1}, {6, 7}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SW" do
    ant1 = {4, 3}
    ant2 = {3, 5}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    expected = [{5, 1}, {2, 7}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair E" do
    ant1 = {4, 3}
    ant2 = {6, 3}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    expected = [{2, 3}, {8, 3}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair S" do
    ant1 = {4, 3}
    ant2 = {4, 5}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    expected = [{4, 1}, {4, 7}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SE off E" do
    ant1 = {6, 3}
    ant2 = {8, 5}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {10,7} is off the grid E
    expected = [{4, 1}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SE off S" do
    ant1 = {2, 6}
    ant2 = {3, 8}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {4,10} is off the grid S
    expected = [{1, 4}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SE off E and S" do
    ant1 = {6, 6}
    ant2 = {8, 8}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {10,10} is off the grid E and S
    expected = [{4, 4}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SW off W" do
    ant1 = {3, 4}
    ant2 = {1, 5}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {-1,6} is off the grid E
    expected = [{5, 3}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair SW off S" do
    ant1 = {6, 6}
    ant2 = {5, 8}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {4,10} is off the grid S
    expected = [{7, 4}]
    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair E off E" do
    ant1 = {4, 6}
    ant2 = {7, 6}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {10,6} is off the grid S
    expected = [{1, 6}]

    assert antinodes == expected
  end

  test "find_antinodes_for_antennae_pair S off S" do
    ant1 = {4, 6}
    ant2 = {4, 8}

    antinodes = Day8.find_antinodes_for_antennae_pair(ant1, ant2, 10, 10)
    # IO.inspect(antinodes, label: "Found antinodes")

    # {4,10} is off the grid S
    expected = [{4, 4}]

    assert antinodes == expected
  end

  # test "test it" do
  #   source_map = source_map()
  #   {map, num_rows, num_cols} = _map_creation = Day8.create_map(source_map)
  # end
end
