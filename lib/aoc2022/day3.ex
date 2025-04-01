defmodule Day3 do
  # https://adventofcode.com/2022/day/3

  @moduledoc """
  Lowercase item types a through z have priorities 1 through 26.
  Uppercase item types A through Z have priorities 27 through 52.
  """

  def go() do
    input = [
      "vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg",
      "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
      "ttgJtRGJQctTZtZT",
      "CrZsJsPPZsGzwwsLwLmpwMDw"
    ]

    # [
    # {"vJrwpWtwJgWr", "hcsFMMfFFhFp"},
    # {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"},
    # ...
    # ]
    rucksacks =
      input
      |> Enum.map(fn line ->
          String.trim(line)
          |> String.split_at(div(String.length(line), 2))
      end)

    # [
    # {["v", "J", "r", "w", "p", "W", "t", "w", "J", "g", "W", "r"],
    # ["h", "c", "s", "F", "M", "M", "f", "F", "F", "h", "F", "p"]},
    # ...
    # ]
    rucksacks_chars =
      rucksacks
      |> Enum.map(fn {first, second} ->
        {String.split(first, "", trim: :true), String.split(second, "", trim: :true)}
      end)

    # ["p", "L", "P", "v", "t", "s"]
    in_both =
      rucksacks_chars
      |> Enum.map(fn {first, second} ->
        set1 = MapSet.new(first)
        set2 = MapSet.new(second)
        [in_both] = MapSet.intersection(set1, set2) |> MapSet.to_list()
        in_both
      end)

      priorities = determine_priorities(in_both)

      sum = Enum.sum(priorities)

      IO.puts(sum)
  end

  def determine_priorities(types) do
    types
    |> Enum.map(&determine_priority(&1))

  end

  def determine_priority(type) when type >= "a" and type <= "z" do
    a = hd(~c"a") # 97
    this = hd(String.to_charlist(type))

    # 'c' for example is 99, and we want to get 3 for a "c" incoming, so
    # take the diff from 'a' and add 1
    this - a + 1

    # The clearer way to do it
#    case type do
#      "a" -> 1
#      "b" -> 2
#      "c" -> 3
#      "d" -> 4
#      "e" -> 5
#      "f" -> 6
#      "g" -> 7
#      "h" -> 8
#      "i" -> 9
#      "j" -> 10
#      "k" -> 11
#      "l" -> 12
#      "m" -> 13
#      "n" -> 14
#      "o" -> 15
#      "p" -> 16
#      "q" -> 17
#      "r" -> 18
#      "s" -> 19
#      "t" -> 20
#      "u" -> 21
#      "v" -> 22
#      "w" -> 23
#      "x" -> 24
#      "y" -> 25
#      "z" -> 26
#    end
  end

  def determine_priority(type) when type >= "A" and type <= "Z" do
    a = hd(~c"A") # 65
    this = hd(String.to_charlist(type))

    # 'C' for example is 67, and we want to get 29 for a "C" incoming, so
    # take the diff from 'a' and add 1 then 26
    this - a + 1 + 26

    # The clearer way to do it
#    case type do
#      "A" -> 27
#      "B" -> 28
#      "C" -> 29
#      "D" -> 30
#      "E" -> 31
#      "F" -> 32
#      "G" -> 33
#      "H" -> 34
#      "I" -> 35
#      "J" -> 36
#      "K" -> 37
#      "L" -> 38
#      "M" -> 39
#      "N" -> 40
#      "O" -> 41
#      "P" -> 42
#      "Q" -> 43
#      "R" -> 44
#      "S" -> 45
#      "T" -> 46
#      "U" -> 47
#      "V" -> 48
#      "W" -> 49
#      "X" -> 50
#      "Y" -> 51
#      "Z" -> 52
#    end
  end

end
