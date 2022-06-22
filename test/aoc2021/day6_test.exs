defmodule AOC2021.Day6Test do
  use ExUnit.Case

  alias AOC2021.Day6

  test "test run" do
    fish = [3,4,3,1,2]
    actual = Day6.run(fish, 80)
    expected = 5934

    assert actual == expected
  end

end
