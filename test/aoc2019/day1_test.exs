defmodule AOC2019.Day1Test do
  use ExUnit.Case

  @doc """
  """
  test "test it" do
    assert AOC2019.Day1.go(12) == 2
    assert AOC2019.Day1.go(14) == 2
    assert AOC2019.Day1.go(1969) == 654
    assert AOC2019.Day1.go(100756) == 33583
  end

end
