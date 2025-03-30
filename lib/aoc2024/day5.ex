defmodule AOC2024.Day5 do
  # https://adventofcode.com/2024/day/5

  @doc """
  Find the entries in updates that are in accordance with the ordering rules,
  which indicate that value m must come at some point in a given update list
  before value n in ordering rule "m|n".

  Taking updates as a list of lists of ints, rather than as a string for simplicity,
  as doing that string parsing and converting to ints already in a prior day, so
  wouldn't gain me anything, and I'm not running this on the AOC system itself against
  their dataset, just my test.

  ordering_rules:
    \"""
    47|53
    97|13
    97|61
    97|47
    75|29
    \"""

  updates:
    [
      [75, 47, 61, 53, 29],
      [97, 61, 53, 29, 13],
      [75, 29, 13],
      [75, 97, 47, 61, 53],
      [61, 13, 29],
      [97, 13, 75, 29, 47]
    ]
  """
  def go(ordering_rules, updates) do
    # [
    # {47, 53},
    # {97, 13},
    # {97, 61},
    # {97, 47},
    # {75, 29},
    # ...
    # ]
    ordering_rules = read_ordering_rules(ordering_rules)

    # %{47 => MapSet.new([53]), 75 => MapSet.new([29]), 97 => MapSet.new([47, 61, 13]), ...}
    ordering_rules = process_ordering_rules(ordering_rules)

    check_updates(ordering_rules, updates)
  end

  @doc """
  Convert input ordering rules as a string into a list of tuples.
  """
  def read_ordering_rules(source_ordering_rules) do
    source_ordering_rules
    # ["47|53", "97|13", "97|61", ...]
    |> String.split("\n", trim: true)

    # [
    # ["47", "53"],
    # ["97", "13"],
    # ["97", "61"],
    # ["97", "47"],
    #  ...
    #  ]
    |> Enum.map(fn rule ->
      String.split(rule, "|")
    end)

    # [
    # {47, 53},
    # {97, 13},
    # {97, 61},
    # {97, 47},
    # ...
    # ]
    |> Enum.map(fn [first, second] ->
      {
        String.to_integer(first),
        String.to_integer(second)
      }
    end)
  end

  @doc """
  Return a Map with keys as each distinct update entry value, and values
  being a MapSet of the values required to come after it.

  input:
    [
      {47, 53},
      {97, 13},
      {97, 61},
      {97, 47},
      {75, 29},
    ...
    ]

    output:
      %{47 => MapSet.new([53]), 75 => MapSet.new([29]), 97 => MapSet.new([47, 61, 13]), ...}
  """
  def process_ordering_rules(input) do
    input
    |> List.foldl(%{}, fn rule, acc ->
      {first, second} = rule

      {_, ordering_rules} =
        Map.get_and_update(acc, first, fn current_value ->
          case current_value do
            nil -> {nil, MapSet.new([second])}
            _ -> {current_value, MapSet.put(current_value, second)}
          end
        end)

      ordering_rules
    end)
  end

  @doc """
  Given the updates and ordering rules, find the updates that don't violate
  the rules.

  ordering_rules:
    %{47 => MapSet.new([53]), 75 => MapSet.new([29]), 97 => MapSet.new([47, 61, 13]), ...}

  updates:
    [
      [75, 47, 61, 53, 29],
      [97, 61, 53, 29, 13],
      [75, 29, 13],
      [75, 97, 47, 61, 53],
      [61, 13, 29],
      [97, 13, 75, 29, 47],
      ...
    ]
  """
  def check_updates(ordering_rules, updates) do
    updates
    |> List.foldl([], fn update, acc ->
      case check_update(ordering_rules, update) do
        # The update violated the ordering rules
        false -> acc
        #
        # The update is ok, so accumulate it
        _ -> [update | acc]
      end
    end)
    |> Enum.reverse()
  end

  @doc """
  Check a given update as passed into check_updates/2.
  """
  def check_update(ordering_rules, update) do
    [h | t] = update

    # Used if an update val doesn't have any rules specified, resulting
    # in no rule violation from the intersection, since this is empty.
    default_rule = MapSet.new()

    # The first entry will never be in violation, since there's nothing
    # before it that could be a problem. So we prime the accumulator's
    # MapSet with it, and we'll add each subsequent value that's ok to it,
    # with that MapSet being checked for any intersection with the ordering
    # for val, which would indicate a violation, since the acc contains all
    # values that came before the val being checked.
    result =
      t
      |> Enum.reduce_while(
        MapSet.new([h]),
        fn val, acc ->
          rule = Map.get(ordering_rules, val, default_rule)
          intersection = MapSet.intersection(acc, rule)

          case MapSet.size(intersection) do
            0 -> {:cont, MapSet.put(acc, val)}
            _ -> {:halt, false}
          end
        end
      )

    case result do
      # Rules violated
      false -> false
      #
      # Rules ok. Only need to indicate such with true. result in this case
      # will be the MapSet containing all values in the update.
      _ -> true
    end
  end
end
