defmodule AOC2024.Day7 do
  # https://adventofcode.com/2024/day/7

  @doc """
  In:
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
  def go(all_input) do
    # [
    #   {190, [29, 190]},
    #   {3267, [148, 3267, 3267, 87480]},
    #   {83, [22, 85]},
    #   {156, [21, 90]},
    #   {7290, [35, 300, 99, 1260, 69, 810, 303, 4320]},
    #   {161011, [39, 338, 173, 2080]},
    #   {192, [39, 350, 150, 1904]},
    #   {21037, [47, 442, 301, 3744, 94, 1053, 1147, 14742]},
    #   {292, [53, 660, 292, 5440, 102, 1640, 1076, 21120]}
    # ]
    all_computations =
      all_input
      |> String.split("\n", trim: true)
      |> Enum.map(&process_one_input/1)

    all_computations
    |> Enum.filter(fn {target, computed} ->
      target in computed
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  @doc """
  In: "3267: 81 40 27"
  Out: {3267, [148, 3267, 3267, 87480]}
  """
  def process_one_input(input) do
    # ["3267", "81 40 27"]
    [target, nums_in] = String.split(input, ": ")

    target = String.to_integer(target)

    # [81, 40, 27]
    nums =
      nums_in
      |> String.split()
      |> Enum.map(fn a -> String.to_integer(a) end)
      |> process_nums()

    {target, nums}
  end

  @doc """
  nums: [81, 40, 27]

  Evaluate the values in nums with each permutation of the operators + and *
  between them.
  """
  def process_nums(nums) do
    # [{~c"+", ~c"+"}, {~c"+", ~c"*"}, {~c"*", ~c"+"}, {~c"*", ~c"*"}]
    # {~c"+", ~c"+"}
    all_ops =
      gen_start_ops(length(nums))
      |> roll()

    all_ops
    |> List.foldl([], fn ops, acc ->
      [execute(nums, ops) | acc]
    end)
    |> Enum.reverse()
  end

  @doc """
  nums: [81, 40, 27]
  ops: [~c"+", ~c"*"]

  Evaluate the values in nums with the operators in ops.
  """
  def execute(nums, ops) do
    [h | t] = nums

    # [{~c"+", 40}, {~c"*", 27}]
    paired =
      Enum.zip(ops, t)

    paired
    |> List.foldl(h, fn {op, val}, acc ->
      result =
        case op do
          ~c"+" ->
            acc + val

          ~c"*" ->
            acc * val
        end

      result
    end)
  end

  @doc """
  Return: Tuple of starting operators to be executed between num_operands operands.
  Of size num_operands - 1 since they go between the operands. The values are charlists
  of +, with the tuple then being used to generate all permutations of + and *.
  E.g., [~c"+", ~c"+"]
  """
  def gen_start_ops(num_operands) do
    List.duplicate(~c"+", num_operands - 1)
    |> List.to_tuple()
  end

  @doc """
  Generate all permutations of the start tuple of +'s. This is named "roll" in
  reference to counters like a car odometer's turning of the tenths of a mile
  0 to 9, and when it rolls back to 0, the mile digit in the ones place
  advances. Continuting till the the ones place rolls back to 0, and the counter
  in the tens place rolls over.

  For this function, the low order + rolls over to *, then back to + as the next
  highest order + rolls to *, and so on.
  """
  def roll(tup) do
    # {~c"+", ~c"+"}

    roll(tup, tuple_size(tup) - 1, [tup])
  end

  def roll(_tup, -1, acc) do
    Enum.reverse(acc)
    |> Enum.map(&Tuple.to_list/1)
  end

  def roll(tup, n, acc) do
    case elem(tup, n) do
      ~c"+" ->
        tup = tuple_replace_at(tup, n, ~c"*")

        roll(tup, tuple_size(tup) - 1, [tup | acc])

      #
      ~c"*" ->
        tup = tuple_replace_at(tup, n, ~c"+")
        roll(tup, n - 1, acc)
    end
  end

  def tuple_replace_at(t, n, val) do
    t
    |> Tuple.delete_at(n)
    |> Tuple.insert_at(n, val)
  end
end
