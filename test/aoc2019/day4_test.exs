defmodule AOC2019.Day4Test do
  use ExUnit.Case

  test "test never_decreases?" do
    num = 134578
    assert AOC2019.Day4.never_decreases?(num) == true

    num = 134378
    assert AOC2019.Day4.never_decreases?(num) == false
  end

  test "test adjacent_same?" do
    num = 834402
    assert AOC2019.Day4.adjacent_same?(num) == true

    num = 883449
    assert AOC2019.Day4.adjacent_same?(num) == true

    num = 134378
    assert AOC2019.Day4.never_decreases?(num) == false
  end

  test "test meets_critera?" do
    num = 122467
    assert AOC2019.Day4.meets_criteria?(num) == true

    # Decreases
    num = 121466
    assert AOC2019.Day4.meets_criteria?(num) == false

    # No adjacent
    num = 124678
    assert AOC2019.Day4.meets_criteria?(num) == false
  end

  test "how_many_meet_criteria" do
    actual = AOC2019.Day4.how_many_meet_criteria()

    assert actual == 2919
  end

end
