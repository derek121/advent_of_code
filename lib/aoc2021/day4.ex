defmodule AOC2021.Day4 do

  @doc """
  (incomplete)

  https://adventofcode.com/2021/day/4

  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
  8  2 23  4 24
  21  9 14 16  7
  6 10  3 18  5
  1 12 20 15 19
  """
  def run() do
    # board = generate_board()
#    mark_board(board, 20)

#    result = check_board(board)
#    IO.inspect(result, label: "result")
  end

  @doc """
  %{
  {1, 1} => {1, false},
  {1, 2} => {19, false},
  {1, 3} => {16, false},
  {1, 4} => {6, false},
  {1, 5} => {4, false},
  {2, 1} => {14, false},
  {2, 2} => {15, false},
  {2, 3} => {13, false},
  {2, 4} => {10, false},
  ...
  """
  def generate_board() do
    nums = Enum.shuffle (1..29) |> Enum.take(25)
    #nums = Enum.shuffle (1..29) |> Enum.take(5)

    {_row_num, board} =
      Enum.chunk_every(nums, 5)
      |> Enum.reduce(
           {1, %{}},
           fn nums, {row_num, m} = _acc ->
             row_map = generate_row(row_num, nums)
             {row_num + 1, Map.merge(m, row_map)}
           end)

      board
  end

  def generate_row(row_num, nums) do
    keys = Enum.zip(List.duplicate(row_num, 5), 1..5)
    vals = Enum.map nums, &{&1, false}

    Enum.zip(keys, vals)
    |> Map.new()
  end

#  def mark_board(board, num) do
#    board
#    |> Enum.map(fn
#      {k, {^num, false}} -> {k, {num, true}}
#      entry -> entry
#    end)
#    |> Map.new()
#  end

  def print_board(board) do
    board
    |> Map.to_list()
    |> Enum.sort()
    |> Enum.chunk_every(5)
    |> Enum.each(&print_row/1)
  end

  def print_row(row) do
#    IO.inspect(row, label: "ROW")

    row
    |> Enum.each(fn
      {_k, {num, false}} -> :io.format("~3w", [num])
      {_k, {num, true}}  -> IO.write("#{IO.ANSI.green()}#{:io_lib.format("~3w", [num])}#{IO.ANSI.reset()}")
    end)

    :io.format("\n")
  end

  def check_board(board) do
    grouped = group_by_row(board)
    IO.inspect(grouped, label: "grouped")

    result = check_rows(grouped)
    IO.inspect(result, label: "result")

    a = length(result) > 0
    IO.inspect(a, label: "Bingo result")
  end

  @doc """
  Output:
  %{
  1 => [
    {{1, 1}, {2, false}},
    {{1, 2}, {3, false}},
    {{1, 3}, {23, false}},
    {{1, 4}, {15, false}},
    {{1, 5}, {5, false}}
  ],
  2 => [
    {{2, 1}, {19, false}},
    {{2, 2}, {1, false}},
    {{2, 3}, {6, false}},
    {{2, 4}, {20, false}},
    {{2, 5}, {13, false}}
  ],
  ...
  }
  """
  def group_by_row(board) do
    board
    |> Enum.group_by(fn {{r, _c}, _v} -> r end)
  end

  @doc """
  Input is the output of group_by_row/1

  Return:
  true if any row has all true
  false otherwise
  """
  def check_rows(grouped) do
    grouped
    |> Enum.filter(&check_row/1)
    |> IO.inspect(label: "end")
  end

  @doc """
  E.g.:
  {1,
  [
   {{1, 1}, {11, false}},
   {{1, 2}, {19, false}},
   {{1, 3}, {3, false}},
   {{1, 4}, {15, false}},
   {{1, 5}, {8, false}}
  ]}
  """
  def check_row(row) do
    IO.inspect(row, label: "row")

    {_row_num, row_entries} = row

    found =
      row_entries
      |> Enum.filter(fn {_, {_, match}} -> match == true end)
      |> IO.inspect(label: "found")

    length(found) > 0
  end




#  def check_rows(board) do
#    # {1, 1} => {1, false},
#
##    1..5
##    |> Enum.reduce(false,
##         fn row_num, found = _acc ->
##           1
##         end)
#
#    1..5
#    |> (fn row_num ->
#      case Enum.filter(board, fn {{rn, _}, _} -> rn == row_num end) do
#        x -> IO.puts("row #{row_num}. #{x}}")
#      end
#        end).()
#  end

end
