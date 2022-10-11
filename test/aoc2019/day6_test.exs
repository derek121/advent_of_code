defmodule Day1Test do
  use ExUnit.Case


  @doc """
  """
  test "test create_map 1" do
    data = """
    COM)B
    B)C
    C)D
    D)E
    """

    actual = AOC2019.Day6.create_map(data)
    expected = %{"B" => "COM", "C" => "B", "D" => "C", "E" => "D"}

    assert actual == expected
  end

  test "test create_map 2" do
    data = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
"""

    actual = AOC2019.Day6.create_map(data)
    expected = %{
      "B" => "COM",
      "C" => "B",
      "D" => "C",
      "E" => "D" ,
      "F" => "E",
      "G" => "B",
      "H" => "G",
      "I" => "D",
      "J" => "E",
      "K" => "J",
      "L" => "K"
    }

    assert actual == expected
  end

  test "test go" do
    data = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
"""

    actual = AOC2019.Day6.go(data)

    assert actual == 42
  end

end
