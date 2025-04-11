defmodule AOC2024.Day10Test do
  use ExUnit.Case

  alias AOC2024.Day10

  test "Run with source map 2" do
    source_map = source_map_2()

    num_found = Day10.go(source_map)
    |> IO.inspect()

    assert num_found == 1
  end

  test "Run with source map from desc 1" do
    source_map = source_map_from_desc_1()

    num_found = Day10.go(source_map)
    |> IO.inspect()

    assert num_found == 2
  end

  test "Run with source map from desc 2" do
    source_map = source_map_from_desc_2()

    num_found = Day10.go(source_map)
    |> IO.inspect()

    assert num_found == 4
  end

  test "Run with source map from desc 3" do
    source_map = source_map_from_desc_3()

    num_found = Day10.go(source_map)
    |> IO.inspect()

    assert num_found == 3
  end

  test "Run with source map from desc 4" do
    source_map = source_map_from_desc_4()

    num_found = Day10.go(source_map)
    |> IO.inspect()

    assert num_found == 36
  end

  test "print_map" do
    {map, num_rows, num_cols} =
      Day10.create_map(source_map_2())
      |> IO.inspect(label: "Got map")

    Day10.print_map(map, num_rows, num_cols)
  end

  test "walk" do
    # source_map = source_map_1()
    # start_pos = {0,0}

    # source_map = source_map_2()
    # start_pos = {0,0}

    # source_map = source_map_from_desc_1()
    # start_pos = {3,0}

    source_map = source_map_from_desc_2()
    start_pos = {3, 0}

    {map, num_rows, num_cols} =
      Day10.create_map(source_map)

    # |> IO.inspect(label: "Map")

    Day10.print_map(map, num_rows, num_cols)
    IO.puts("")

    # ret = Day10.walk(map, start_pos, num_rows, num_cols)
    ret = Day10.walk(MapSet.new(), map, start_pos, num_rows, num_cols)

    IO.puts("Result: #{inspect(ret)}")
  end

  #

  # def source_map_1() do
  #   """
  #   01
  #   .2
  #   .3
  #   """
  # end

  def source_map_2() do
    """
    0123
    .654
    ...5
    9876
    """
  end

  def source_map_from_desc_1() do
    """
    ...0...
    ...1...
    ...2...
    6543456
    7.....7
    8.....8
    9.....9
    """
  end

  def source_map_from_desc_2() do
    """
    ..90..9
    ...1.98
    ...2..7
    6543456
    765.987
    876....
    987....
    """
  end

  def source_map_from_desc_3() do
    """
    10..9..
    2...8..
    3...7..
    4567654
    ...8..3
    ...9..2
    .....01
    """
  end

  def source_map_from_desc_4() do
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """
  end
end
