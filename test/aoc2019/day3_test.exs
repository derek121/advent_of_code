defmodule AOC2019.Day3Test do
  use ExUnit.Case

  @doc """
  """
  test "test parse_wire" do
    wire = "R8,U5,L5,D3"

    assert AOC2019.Day3.parse_wire(wire) == [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]
  end

  test "test move_right" do
    coords = %{{98, 99} => 9, {3, 2} => 1}
    point = {2, 2}
    count = 3

    res = AOC2019.Day3.move_right(point, count, coords)

    assert res == {{5, 2}, %{{98, 99} => 9, {3, 2} => 2, {4, 2} => 1, {5, 2} => 1}}
  end

  test "test move_left" do
    coords = %{{98, 99} => 9, {5, 2} => 1}
    point = {7, 2}
    count = 3

    res = AOC2019.Day3.move_left(point, count, coords)

    assert res == {{4, 2}, %{{98, 99} => 9, {4, 2} => 1, {5, 2} => 2, {6, 2} => 1}}
  end

  test "test move_up" do
    coords = %{{98, 99} => 9, {2, 4} => 1}
    point = {2, 2}
    count = 3

    res = AOC2019.Day3.move_up(point, count, coords)

    assert res == {{2, 5}, %{{98, 99} => 9, {2, 3} => 1, {2, 4} => 2, {2, 5} => 1}}
  end

  test "test move_down" do
    coords = %{{98, 99} => 9, {0, 2} => 1}
    point = {0, 3}
    count = 3

    res = AOC2019.Day3.move_down(point, count, coords)

    assert res == {{0, 0}, %{{98, 99} => 9, {0, 2} => 2, {0, 1} => 1, {0, 0} => 1}}
  end

  test "travel_wire" do
    coords = %{}
    wire = [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]

    actual = AOC2019.Day3.travel_wire(coords, wire)
    expected = %{
      {1,0} => 1,
      {2,0} => 1,
      {3,0} => 1,
      {4,0} => 1,
      {5,0} => 1,
      {6,0} => 1,
      {7,0} => 1,
      {8,0} => 1,

      {8,1} => 1,
      {8,2} => 1,
      {8,3} => 1,
      {8,4} => 1,
      {8,5} => 1,

      {7,5} => 1,
      {6,5} => 1,
      {5,5} => 1,
      {4,5} => 1,
      {3,5} => 1,

      {3,4} => 1,
      {3,3} => 1,
      {3,2} => 1
    }

    assert actual == expected
  end

  test "go 1" do
    wire1 = "R8,U5,L5,D3"
    wire2 = "U7,R6,D4,L4"

    actual = AOC2019.Day3.go(wire1, wire2)

#    _expected = %{
#      {1,0} => 1,
#      {2,0} => 1,
#      {3,0} => 1,
#      {4,0} => 1,
#      {5,0} => 1,
#      {6,0} => 1,
#      {7,0} => 1,
#      {8,0} => 1,
#
#      {8,1} => 1,
#      {8,2} => 1,
#      {8,3} => 1,
#      {8,4} => 1,
#      {8,5} => 1,
#
#      {7,5} => 1,
#      {6,5} => 2,
#      {5,5} => 1,
#      {4,5} => 1,
#      {3,5} => 1,
#
#      {3,4} => 1,
#      {3,3} => 2,
#      {3,2} => 1,
#
#      #
#      {0,1} => 1,
#      {0,2} => 1,
#      {0,3} => 1,
#      {0,4} => 1,
#      {0,5} => 1,
#      {0,6} => 1,
#      {0,7} => 1,
#
#      {1,7} => 1,
#      {2,7} => 1,
#      {3,7} => 1,
#      {4,7} => 1,
#      {5,7} => 1,
#      {6,7} => 1,
#
#      {6,6} => 1,
#      # {6,5} is in intersection, seen above
#      {6,4} => 1,
#      {6,3} => 1,
#
#      {5,3} => 1,
#      {4,3} => 1,
#      # {3,3} is in intersection, seen above
#      {2,3} => 1
#    }

    expected = 6

#    IO.inspect(actual)

    assert actual == expected
  end

  # HOW CAN IT GO D30 when still at y == 0 ????
#  test "go 2" do
#    wire1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
#    wire2 = "U62,R66,U55,R34,D71,R55,D58,R83"
#
#    actual = AOC2019.Day3.go(wire1, wire2)
#
#    expected = 159
#
#    #    IO.inspect(actual)
#
#    assert actual == expected
#  end

  test "go 3" do
    wire1 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
    wire2 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"

    actual = AOC2019.Day3.go(wire1, wire2)

    expected = 135

    #    IO.inspect(actual)

    assert actual == expected
  end
end
