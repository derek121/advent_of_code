defmodule Day3Test do
  use ExUnit.Case

  alias AOC2021.Day3

  @doc """

  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2

  """
  test "test it" do
    lst = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]

    {gamma, epsilon} = Day3.run(lst)

    assert gamma == 22
    assert epsilon == 9
  end

end
