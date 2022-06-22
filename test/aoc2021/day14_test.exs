defmodule AOC2021.Day6Test do
  use ExUnit.Case

  alias AOC2021.Day14

  test "test calc" do
    template = "NNCB"

    actual = Day14.run2(4, template)
    IO.inspect(actual)

    expected = 'NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB'

    assert actual == expected
  end

  test "test calc 10" do
    template = "NNCB"

    actual = Day14.run2(10, template)
    IO.inspect(actual)

    assert length(actual) == 3073
  end

  test "test result" do
    template = "NNCB"

    actual = Day14.run(10, template)

    assert actual == 1588
  end

end
