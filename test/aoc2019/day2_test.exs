defmodule AOC2019.Day2Test do
  use ExUnit.Case

  @doc """
  """
  test "test it" do
    prog = [1,0,0,0,99]
    assert AOC2019.Day2.go(prog) == [2,0,0,0,99]

    prog = [2,3,0,3,99]
    assert AOC2019.Day2.go(prog) == [2,3,0,6,99]

    prog = [2,4,4,5,99,0]
    assert AOC2019.Day2.go(prog) == [2,4,4,5,99,9801]

    prog = [1,1,1,4,99,5,6,0,99]
    assert AOC2019.Day2.go(prog) == [30,1,1,4,2,5,6,0,99]
  end

end
