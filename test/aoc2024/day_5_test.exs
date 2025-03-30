defmodule AOC2024.Day5Test do
  use ExUnit.Case

  alias AOC2024.Day5

  test "test read_ordering_rules" do
    ordering_rules = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13
    """

    actual = Day5.read_ordering_rules(ordering_rules)

    expected =
      [
        {47, 53},
        {97, 13},
        {97, 61},
        {97, 47},
        {75, 29},
        {61, 13},
        {75, 53},
        {29, 13},
        {97, 29},
        {53, 29},
        {61, 53},
        {97, 53},
        {61, 29},
        {47, 13},
        {75, 47},
        {97, 75},
        {47, 61},
        {75, 61},
        {47, 29},
        {75, 13},
        {53, 13}
      ]

    assert actual === expected
  end

  test "test process_ordering_rules" do
    ordering_rules =
      [
        {47, 53},
        {97, 13},
        {97, 61},
        {97, 47},
        {75, 29},
        {61, 13},
        {75, 53},
        {29, 13},
        {97, 29},
        {53, 29},
        {61, 53},
        {97, 53},
        {61, 29},
        {47, 13},
        {75, 47},
        {97, 75},
        {47, 61},
        {75, 61},
        {47, 29},
        {75, 13},
        {53, 13}
      ]

    actual = Day5.process_ordering_rules(ordering_rules)

    expected =
      %{
        29 => MapSet.new([13]),
        47 => MapSet.new([13, 29, 53, 61]),
        53 => MapSet.new([13, 29]),
        61 => MapSet.new([13, 29, 53]),
        75 => MapSet.new([13, 29, 47, 53, 61]),
        97 => MapSet.new([13, 29, 47, 53, 61, 75])
      }

    assert actual === expected
  end

  test "test check_updates" do
    updates = [
      [75, 47, 61, 53, 29],
      [97, 61, 53, 29, 13],
      [75, 29, 13],
      [75, 97, 47, 61, 53],
      [61, 13, 29],
      [97, 13, 75, 29, 47]
    ]

    ordering_rules =
      %{
        29 => MapSet.new([13]),
        47 => MapSet.new([13, 29, 53, 61]),
        53 => MapSet.new([13, 29]),
        61 => MapSet.new([13, 29, 53]),
        75 => MapSet.new([13, 29, 47, 53, 61]),
        97 => MapSet.new([13, 29, 47, 53, 61, 75])
      }

    actual = Day5.check_updates(ordering_rules, updates)
    expected = [[75, 47, 61, 53, 29], [97, 61, 53, 29, 13], [75, 29, 13]]
    assert actual === expected

    sum =
      actual
      |> Enum.map(&Enum.at(&1, div(length(&1), 2)))
      |> (fn mids -> Enum.sum(mids) end).()

    assert sum == 143
  end
end
