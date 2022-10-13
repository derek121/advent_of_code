defmodule AOC2019.Day22Test do
  use ExUnit.Case

  @doc """
  """
  test "test deal_into_new_stack" do
    actual = AOC2019.Day22.shuffle(10, [:deal_into_new_stack])
    expected = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

    assert actual == expected
  end

  test "test cut_cards positive" do
    actual = AOC2019.Day22.shuffle(10, [{:cut_cards, 3}])
    expected = [3, 4, 5, 6, 7, 8, 9, 0, 1, 2]

    assert actual == expected
  end

  test "test cut_cards negative" do
    actual = AOC2019.Day22.shuffle(10, [{:cut_cards, -3}])
    expected = [7, 8, 9, 0, 1, 2, 3, 4, 5, 6]

    assert actual == expected
  end

  test "test [:deal_into_new_stack, {:cut_cards, 3}] cut positive" do
    actual = AOC2019.Day22.shuffle(10, [:deal_into_new_stack, {:cut_cards, 3}])

    # From :deal_into_new_stack: [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    # From {:cut_cards, 3}:      [6, 5, 4, 3, 2, 1, 0, 9, 8, 7]
    expected = [6, 5, 4, 3, 2, 1, 0, 9, 8, 7]

    assert actual == expected
  end

  test "test [:deal_into_new_stack, {:cut_cards, 3}] cut negative" do
    actual = AOC2019.Day22.shuffle(10, [:deal_into_new_stack, {:cut_cards, -3}])

    # From :deal_into_new_stack: [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    # From {:cut_cards, -3}:      [2, 1, 0, 9, 8, 7, 6, 5, 4, 3]
    expected = [2, 1, 0, 9, 8, 7, 6, 5, 4, 3]

    assert actual == expected
  end

  test "test deal_with_increment 3" do
    actual = AOC2019.Day22.shuffle(10, [{:deal_with_increment, 3}])

    expected = [0, 7, 4, 1, 8, 5, 2, 9, 6, 3]

    assert actual == expected
  end

  test "test [{:deal_with_increment, 3}, {:cut_cards, 2}]" do
    actual = AOC2019.Day22.shuffle(10, [{:deal_with_increment, 3}, {:cut_cards, 2}])

    expected = [4, 1, 8, 5, 2, 9, 6, 3, 0, 7]

    assert actual == expected
  end

  test "test deal_with_increment 1" do
    actual = AOC2019.Day22.shuffle(10, [{:deal_with_increment, 1}])

    expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    assert actual == expected
  end

  # Rest from the assignment

  test "test [{:deal_with_increment, 7}, :deal_into_new_stack, :deal_into_new_stack]" do
    actual = AOC2019.Day22.shuffle(10, [{:deal_with_increment, 7}, :deal_into_new_stack, :deal_into_new_stack])

    expected = [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]

    assert actual == expected
  end

  test "test [{:cut_cards, 6}, {:deal_with_increment, 7}, :deal_into_new_stack]" do
    actual = AOC2019.Day22.shuffle(10, [{:cut_cards, 6}, {:deal_with_increment, 7}, :deal_into_new_stack])

    expected = [3,0, 7, 4, 1, 8, 5, 2, 9, 6]

    assert actual == expected
  end

  test "test [{:deal_with_increment, 7}, {:deal_with_increment, 9}, {:cut_cards, -2}]" do
    actual = AOC2019.Day22.shuffle(10, [{:deal_with_increment, 7}, {:deal_with_increment, 9}, {:cut_cards, -2}])

    expected = [6, 3, 0, 7, 4, 1, 8, 5, 2, 9]

    assert actual == expected
  end

  test "test [
  :deal_into_new_stack,
  {:cut_cards, -2},
  {:deal_with_increment, 7},
  {:cut_cards, 8},
  {:cut_cards, -4},
  {:deal_with_increment, 7},
  {:cut_cards, 3},
  {:deal_with_increment, 9},
  {:deal_with_increment, 3},
  {:cut_cards, -1}"
    do
    actual = AOC2019.Day22.shuffle(10, [
      :deal_into_new_stack,
      {:cut_cards, -2},
      {:deal_with_increment, 7},
      {:cut_cards, 8},
      {:cut_cards, -4},
      {:deal_with_increment, 7},
      {:cut_cards, 3},
      {:deal_with_increment, 9},
      {:deal_with_increment, 3},
      {:cut_cards, -1}])

    expected = [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]

    assert actual == expected
  end


end
