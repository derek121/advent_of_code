defmodule Day4Test do
  use ExUnit.Case


  test "test generate" do
    Day4.generate_board()
    |> IO.inspect()
  end

#  test "test print" do
#    b =
#      Day4.generate_board()
#      |> Day4.mark_board(1)
#      |> Day4.mark_board(2)
#      |> Day4.mark_board(3)
#      |> Day4.mark_board(12)
#
#    IO.inspect(b)
#
#    b
#    |> Day4.print_board()
#  end

#  @doc """
#  """
#  test "test it" do
#    board = Day4.generate_board()
#
#    chosen =( Enum.shuffle (1..29)) |> Enum.take(5)
#    IO.inspect(chosen, label: "chosen")
#
#    marked =
#      chosen
#      |> Enum.reduce(board, fn n, b = _acc -> Day4.mark_board(b, n) end)
#
#    IO.inspect(marked)
#  end

  test "filtering" do
    board = Day4.generate_board()
    IO.inspect(board, label: "board")

    board = set_true(board, 3)
    IO.inspect(board, label: "Now board")

    grouped = group_by_row(board)
    IO.inspect(grouped, label: "grouped")

    result = check_rows(grouped)
    IO.inspect(result, label: "result")

    a = length(result) > 0
    IO.inspect(a, label: "Bingo result")
  end

  test "check_board" do
    board = Day4.generate_board()
    IO.inspect(board, label: "board")

    assert !Day4.check_board(board)

    #
    board = set_true(board, 3)
    assert Day4.check_board(board)
  end

  @doc """
  Input:
  %{
  {1, 1} => {22, false},
  {1, 2} => {7, false},
  {1, 3} => {4, false},
  {1, 4} => {8, false},
  {1, 5} => {13, false},
  {2, 1} => {6, false},
  {2, 2} => {5, false},
  ...
  """
  def set_true(board, row_num) do
    IO.inspect(row_num, label: "set_true row_num")
    board
    |> Enum.map(fn
      {{^row_num, _col} = coord, vals} ->
        IO.inspect(vals, label: "Got vals")
        {coord, set_val_true(vals)}
        |> IO.inspect(label: "Set to true")

      row ->
        IO.inspect(row, label: "Just row")
        row
    end)
  end

  def set_val_true(val) do
#    row
#    |> Enum.map(fn
#      {coord, {val, _}} -> {coord, {val, true}}
#    end)

    {num, _} = val

    {num, true}
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
#
#    a
#    |> IO.inspect(label: "a")
#
#    Enum.any?(a, fn r -> length (r) > 0 end)

#    |> Enum.filter(fn z ->
#      IO.inspect(z, label: "z")
#      length(z) > 0 end)


  end

end
