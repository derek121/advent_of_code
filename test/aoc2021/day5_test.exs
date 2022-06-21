defmodule Day5Test do
  use ExUnit.Case

  test "expand horizontal" do
    actual = Day5.expand({{0,9}, {4,9}})
    expected = [{0,9}, {1,9}, {2,9}, {3,9}, {4,9}]

    assert actual == expected
  end

  test "expand veritical" do
    actual = Day5.expand({{2,1}, {2,5}})
    expected = [{2,1}, {2,2}, {2,3}, {2,4}, {2,5}]

    assert actual == expected
  end

  @doc """
  0,9 -> 5,9
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  0,9 -> 2,9
  3,4 -> 1,4
  """
  test "test expand" do
    lines = [
      {{0,2}, {4,2}},
      {{2,0}, {2,4}}
    ]

    actual = Day5.expand(lines) |> Enum.sort()
    expected = [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {2, 0}, {2, 1}, {2, 2}, {2, 3}, {2, 4}] |> Enum.sort()

    assert expected == actual
  end

  test "mark_locations" do
    coords = [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {2, 0}, {2, 1}, {2, 2}, {2, 3}, {2, 4}]

    expected = %{
      {0, 2} => 1,
      {1, 2} => 1,
      {2, 0} => 1,
      {2, 1} => 1,
      {2, 2} => 2,
      {2, 3} => 1,
      {2, 4} => 1,
      {3, 2} => 1,
      {4, 2} => 1
    }

    actual =
      Day5.mark_locations(coords)

    assert actual == expected
  end

  test "processing" do

    lines =
      [
        {{0,9}, {5,9}},
        {{9,4}, {3,4}},
        {{2,2}, {2,1}},
        {{7,0}, {7,4}},
        {{0,9}, {2,9}},
        {{3,4}, {1,4}}
      ]

    actual =
      lines
      |> Day5.expand()
      |> Day5.mark_locations()

    expected = %{
      {0, 9} => 2,
      {1, 4} => 1,
      {1, 9} => 2,
      {2, 1} => 1,
      {2, 2} => 1,
      {2, 4} => 1,
      {2, 9} => 2,
      {3, 4} => 2,
      {3, 9} => 1,
      {4, 4} => 1,
      {4, 9} => 1,
      {5, 4} => 1,
      {5, 9} => 1,
      {6, 4} => 1,
      {7, 0} => 1,
      {7, 1} => 1,
      {7, 2} => 1,
      {7, 3} => 1,
      {7, 4} => 2,
      {8, 4} => 1,
      {9, 4} => 1
    }

    assert actual == expected
  end

  test "run" do
    # The expected output, with the same input as the "processing" test above. The run() call
    # here results in the processed values being output as well, as seen here:

    # . . . . . . . 1 . .
    # . . 1 . . . . 1 . .
    # . . 1 . . . . 1 . .
    # . . . . . . . 1 . .
    # . 1 1 2 1 1 1 2 1 1
    # . . . . . . . . . .
    # . . . . . . . . . .
    # . . . . . . . . . .
    # . . . . . . . . . .
    # 2 2 2 1 1 1 . . . .

    lines =
      [
        {{0,9}, {5,9}},
        {{9,4}, {3,4}},
        {{2,2}, {2,1}},
        {{7,0}, {7,4}},
        {{0,9}, {2,9}},
        {{3,4}, {1,4}}
      ]

    Day5.run(lines)
  end
end
