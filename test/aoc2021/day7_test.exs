defmodule AOC2021.Day6Test do
  use ExUnit.Case

  alias AOC2021.Day7

  test "test calc" do
    positions = [5,3,4,1,0]
    target = 2
    actual = Day7.calc(target, positions)
    expected = 9 # Sum of the differences between each position and target

    assert actual == expected
  end

  test "test run" do
    positions = [16,1,2,0,4,2,7,1,2,14]
    actual = Day7.run(positions)

    assert actual == {2, 37}
  end

end
