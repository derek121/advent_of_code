defmodule AOC2024.Day3Test do
  use ExUnit.Case

  alias AOC2024.Day3

  test "test it" do
    mem = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    expected = (2 * 4) + (5 * 5) + (11 * 8) + (8 * 5)
    actual = Day3.go(mem)

    assert expected == actual
  end

end
