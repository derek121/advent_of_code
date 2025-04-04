defmodule AOC2024.Day9 do
  # https://adventofcode.com/2024/day/9

  @moduledoc """
  See the link above for the description of the problem. Too detailed to
  repeat here.
  """

  @doc """
  Compact file and free space on disk.

  In: representing alternating used and free space, each integer being the
  number of blocks that one takes. E.g., "12345"

  Out:
  """
  def go(disk_map_in) do
    disk_map_input_to_blocks(disk_map_in)
    |> condense()
    |> calc_checksum()
  end

  @doc """
  "To calculate the checksum, add up the result of multiplying each of these
   blocks' position with the file ID number it contains. The leftmost block is
   in position 0. If a block contains free space, skip it instead."
  """
  def calc_checksum(blocks) do
    # "022111222......"
    blocks
    |> String.split(".", trim: true)
    # "022111222"
    |> hd()
    # ["0", "2", "2", "1", "1", "1", "2", "2", "2"]
    |> String.split("", trim: true)
    # [0, 2, 2, 1, 1, 1, 2, 2, 2]
    |> Enum.map(&String.to_integer/1)
    # {9, 60}
    |> List.foldl({0, 0}, fn id, {n, sum} ->
      {n + 1, sum + n * id}
    end)
    # 60
    |> elem(1)
  end

  @doc """
  From the problem description:

  "So, a disk map like 12345 would represent a one-block file, two blocks of
  free space, a three-block file, four blocks of free space, and then a
  five-block file. A disk map like 90909 would represent three nine-block
  files in a row (with no free space between them).

  "Each file on disk also has an ID number based on the order of the files as
  they appear before they are rearranged, starting with ID 0. So, the disk map
  12345 has three files: a one-block file with ID 0, a three-block file with
  ID 1, and a five-block file with ID 2. Using one character for each block
  where digits are the file ID and . is free space, the disk map 12345
  represents these individual blocks:"
  (The "Out:" values below:)

  In: "12345"
  Out: "0..111....22222"

  or

  In: "2333133121414131402"
  Out: "00...111...2...333.44.5555.6666.777.888899"
  """
  def disk_map_input_to_blocks(disk_map_in) do
    # [1, 2, 3, 4, 5]
    disk_map =
      disk_map_in
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    # "0..111....22222"
    disk_map_to_blocks(disk_map)
  end

  @doc """
  Called by disk_map_input_to_blocks/1 after splitting its input and converting
  to ints.

  In: [1, 2, 3, 4, 5]
  Out: "0..111....22222"
  """
  def disk_map_to_blocks(disk_map) do
    {_, _, blocks} =
      disk_map
      |> List.foldl({0, true, ""}, fn
        len, {id, true = _is_file, acc} ->
          {id + 1, false, acc <> String.duplicate("#{id}", len)}

        len, {id, false = _is_file, acc} ->
          {id, true, acc <> String.duplicate(".", len)}
      end)

    blocks
  end

  @doc """
  Move file blocks one at a time from the end of the disk to the leftmost free
  space block (until there are no gaps remaining between file blocks).

  In: "0..111....22222"
  Out: "022111222......"

  or

  In: "00...111...2...333.44.5555.6666.777.888899"
  Out: "0099811188827773336446555566.............."
  """
  def condense(blocks) do
    # This inspect is how we see the iterative moving of the blocks to the open
    # spaces on the left, like in the problem description page.
    IO.inspect(blocks)

    # Find index of first . with a numeral somwhere after it (meaning we're
    # not done), and the index of the last numeral.
    # Translation: find the first . that has a digit somewhere after it
    # (if there are none after it, we're done), also capturing the last digit
    # (if there are more than one, we want the last one).
    search_ret =
      case Regex.run(~r/(\.).*(\d)[\D.]*$/, blocks, return: :index) do
        nil ->
          # No digits left- we're done
          nil

        [_whole_match, {first_period_idx, _}, {last_digit_idx, _}] ->
          {first_period_idx, last_digit_idx}
      end

    case search_ret do
      nil ->
        blocks

      {first_period_idx, last_digit_idx} ->
        # Get last digit and replace it with .
        # And replace first period with the last digit
        # find_and_replace_last_digit

        cl = String.to_charlist(blocks)
        last_digit = Enum.at(cl, last_digit_idx)

        List.replace_at(cl, last_digit_idx, ~c".")
        |> List.replace_at(first_period_idx, last_digit)
        |> List.to_string()
        |> condense()
    end
  end
end
