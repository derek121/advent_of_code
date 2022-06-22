defmodule Day2Test do
  use ExUnit.Case

  alias AOC2021.Day2

  @doc """

  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2

  """
  test "test it" do
    lst =
      [
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2",
      ]

    expected = {15, 10}
    actual = Day2.run(lst)

    assert actual == expected
end

end
