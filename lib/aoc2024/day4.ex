defmodule AOC2024.Day4 do
  # https://adventofcode.com/2024/day/4

  @moduledoc """
  How many times XMAS appears in the grid- horizontal, vertical diagonal;
  frontwards or backwards, up or down.

  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  def go(rows) do
    {board, num_rows, num_cols} = create_board(rows)

    # Horizontal
    words = generate_horizontal_words(board, num_rows, num_cols)
    count_horizontal = Enum.filter(words, &(&1 === "XMAS")) |> length()

    # Vertical
    words = generate_vertical_words(board, num_rows, num_cols)
    count_vertical = Enum.filter(words, &(&1 === "XMAS")) |> length()

    # Diagonal TL-BR
    words = generate_diagonal_tl_br_words(board, num_rows, num_cols)
    count_diagonal_tl_br = Enum.filter(words, &(&1 === "XMAS")) |> length()

    # Diagonal TR-BL
    words = generate_diagonal_tr_bl_words(board, num_rows, num_cols)
    count_diagonal_tr_bl = Enum.filter(words, &(&1 === "XMAS")) |> length()

    count_total =
      count_horizontal +
      count_vertical +
      count_diagonal_tl_br +
      count_diagonal_tr_bl

    count_total
  end

  @doc """
  Parse the input board from string into a map with keys of the form
  {row, col}, and the value being the letter, as a string.

  For incoming board:
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX

  The entries for the first row is:
  %{
    {0, 0} => "M",
    {0, 1} => "M",
    {0, 2} => "M",
    {0, 3} => "S",
    {0, 4} => "X",
    {0, 5} => "X",
    {0, 6} => "M",
    {0, 7} => "A",
    {0, 8} => "S",
    {0, 9} => "M",
  }
  """
  def create_board(rows) do
    # Comments are for a subset of first row.

    {board, num_rows, num_cols} =
      rows
      # ["MMMSXXM", "MSAMXMS", "AMXSXMA", "MSAMASM", "XMASAMX", "XXAMMXX", "SMSMSAS"]
      |> String.split("\n", trim: true)

      #  [
      #    ["M", "M", "M", "S", "X", "X", "M"],
      #    ["M", "S", "A", "M", "X", "M", "S"],
      #    ["A", "M", "X", "S", "X", "M", "A"]
      #  ]
      |> Enum.map(fn row -> String.split(row, "", trim: true) end)

      |> List.foldl({%{}, 0, :undefined}, fn row, {map, row_num, _num_cols} ->
        width = length(row)

        # [{0, 0}, {0, 1}, {0, 2}, ...]
        keys = for col <- 0..(width - 1), do: {row_num, col}

        # The zip return:
        # [
        #   {{0, 0}, "M"},
        #   {{0, 1}, "M"},
        #   {{0, 2}, "M"},
        #   {{0, 3}, "S"},
        #   {{0, 4}, "X"},
        #   {{0, 5}, "X"},
        #   {{0, 6}, "M"}
        # ]
        this_row_map = Enum.zip(keys, row)

          # %{
          #   {0, 0} => "M",
          #   {0, 1} => "M",
          #   {0, 2} => "M",
          #   {0, 3} => "S",
          #   {0, 4} => "X",
          #   {0, 5} => "X",
          #   {0, 6} => "M"
          # }
          |> Map.new()

        map = Map.merge(map, this_row_map)

        # Seems hacky to have to pass around width (num columns) like this
        {map, row_num + 1, width}
      end)

    {board, num_rows, num_cols}
  end

  @doc """
  Generate all 4-letter words in each row, forwards and backwards.

  ["MXMX", "XMXA", "MXAX", "XAXM", "AXMA", "XMAS", "MASX", "XMXM", "AXMX", "XAXM",
  "MXAX", "AMXA", "SAMX", "XSAM", ...]
  """
  def generate_horizontal_words(board, num_rows, num_cols) do
    Range.to_list(0..(num_rows - 1))
    |> List.foldl([], fn row_num, acc ->
      forward =
        for col_num <- 0..(num_cols - 4) do
          Map.get(board, {row_num, col_num}) <>
            Map.get(board, {row_num, col_num + 1}) <>
            Map.get(board, {row_num, col_num + 2}) <>
            Map.get(board, {row_num, col_num + 3})
        end

      backward = forward |> Enum.map(&String.reverse/1)

      [forward, backward | acc]
    end)
    |> List.flatten()
  end

  @doc """
  Generate all 4-letter words in each column, forwards and backwards.

  ["MAMX", "AMXM", "MXMA", "XMAS", "MASA", "ASAM", "SAMX", "XMAM", "MXMA", "AMXM",
  "SAMX", "ASAM", "MASA", "XMAS", ...]
  """
  def generate_vertical_words(board, num_rows, num_cols) do
    Range.to_list(0..(num_cols - 1))
    |> List.foldl([], fn col_num, acc ->
      forward =
        for row_num <- 0..(num_rows - 4) do
          Map.get(board, {row_num, col_num}) <>
            Map.get(board, {row_num + 1, col_num}) <>
            Map.get(board, {row_num + 2, col_num}) <>
            Map.get(board, {row_num + 3, col_num})
        end

      backward = forward |> Enum.map(&String.reverse/1)

      [forward, backward | acc]
    end)
    |> List.flatten()
  end

  @doc """
  Generate all 4-letter words in each diagonal between top left and
  bottom right, forwards and backwards.
  """
  def generate_diagonal_tl_br_words(board, num_rows, num_cols) do
    Range.to_list(0..(num_rows - 4))
    |> List.foldl([], fn row_num, acc ->
      forward =
        for col_num <- 0..(num_cols - 4) do
          Map.get(board, {row_num, col_num}) <>
            Map.get(board, {row_num + 1, col_num + 1}) <>
            Map.get(board, {row_num + 2, col_num + 2}) <>
            Map.get(board, {row_num + 3, col_num + 3})
        end

      backward = forward |> Enum.map(&String.reverse/1)

      [forward, backward | acc]
    end)
    |> List.flatten()
  end

  @doc """
  Generate all 4-letter words in each diagonal between top left and
  bottom right, forwards and backwards.
  """
  def generate_diagonal_tr_bl_words(board, num_rows, num_cols) do
    Range.to_list(0..(num_rows - 4))
    |> List.foldl([], fn row_num, acc ->
      forward =
        for col_num <- (num_cols - 1)..3//-1 do
          Map.get(board, {row_num, col_num}) <>
            Map.get(board, {row_num + 1, col_num - 1}) <>
            Map.get(board, {row_num + 2, col_num - 2}) <>
            Map.get(board, {row_num + 3, col_num - 3})
        end

      backward = forward |> Enum.map(&String.reverse/1)

      [forward, backward | acc]
    end)
    |> List.flatten()
  end

end
