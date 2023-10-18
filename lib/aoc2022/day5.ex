defmodule Day5 do
  # https://adventofcode.com/2022/day/5

  @moduledoc """
  The Elves just need to know which crate will end up on top of each stack; in this example,
  the top crates are C in stack 1, M in stack 2, and Z in stack 3, so you should combine
  these together and give the Elves the message CMZ.

  After the rearrangement procedure completes, what crate ends up on top of each stack?

  They do, however, have a drawing of the starting stacks of crates and the rearrangement
  procedure (your puzzle input). For example:

      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  def go() do
    # Stacks will be lists in order of top to bottom
    s1 = ["N", "Z"]
    s2 = ["D", "C", "M"]
    s3 = ["P"]

    # Operations are a list of tuples specifying how many to move and from which to which stack
    ops = [
      {1, {2, 1}},
      {3, {1, 3}},
      {2, {2, 1}},
      {1, {1, 2}}
    ]

    stacks =
      List.foldl(
        ops,
        {s1, s2, s3},
        fn {count, {src_num, dst_num}} = _op, {_source_stack_1, _source_stack_2, _source_stack_3} = acc ->
          src = elem(acc, src_num - 1) # -1 since elem is 0-based
          dst = elem(acc, dst_num - 1) # -1 since elem is 0-based

          # Get count elements from src, then remove them
          from_src = Enum.slice(src, 0, count)
          src = Enum.drop(src, count)

          # Have to reverse since the specification is that they're moved one at a time
          from_src = Enum.reverse(from_src)

          # And add to dest
          dst = Enum.concat(from_src, dst )

          # Persist the changes in the acc
          acc = put_elem(acc, src_num - 1, src)
          put_elem(acc, dst_num - 1, dst)
        end)

      # Get the top of each stack per the spec
      as_list = Tuple.to_list(stacks)
      List.foldl(as_list, "", fn list, acc -> acc <> hd(list) end)
    end
end
