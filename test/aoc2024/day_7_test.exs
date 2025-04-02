defmodule AOC2024.Day7Test do
  use ExUnit.Case

  alias AOC2024.Day7

  test "go" do
    all_input =
      """
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
      """

    actual = Day7.go(all_input)
    expected = 3749

    assert actual == expected
  end

  test "process_one_input" do
    s = "3267: 81 40 27"

    Day7.process_one_input(s)
  end

  test "execute" do
    nums = [81, 40, 27]
    ops = [~c"+", ~c"*"]

    actual = Day7.execute(nums, ops)
    expected = 3267

    assert actual == expected
  end

  test "process_nums" do
    nums = [81, 40, 27]

    actual = Day7.process_nums(nums)

    expected = [148, 3267, 3267, 87480]

    assert actual == expected
  end

  test "roll" do
    l = [~c"+", ~c"+"]
    # l = [~c"+", ~c"+", ~c"+"]

    t = List.to_tuple(l)

    actual =
      Day7.roll(t)

    expected = [[~c"+", ~c"+"], [~c"+", ~c"*"], [~c"*", ~c"+"], [~c"*", ~c"*"]]

    assert actual == expected
  end

  test "gen_ops" do
    actual = Day7.gen_start_ops(length([1, 2, 3, 4]))
    expected = {~c"+", ~c"+", ~c"+"}

    assert actual == expected
  end
end
