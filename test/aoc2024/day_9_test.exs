defmodule AOC2024.Day9Test do
  use ExUnit.Case

  alias AOC2024.Day9

  test "calc_checksum 1" do
    blocks = "022111222......"

    actual = Day9.calc_checksum(blocks)
    expected = 60

    assert actual == expected
  end

  test "calc_checksum 2" do
    blocks = "0099811188827773336446555566.............."

    actual = Day9.calc_checksum(blocks)
    expected = 1928

    assert actual == expected
  end

  test "go 1" do
    disk_map_in = "12345"

    actual = Day9.go(disk_map_in)
    expected = 60

    assert actual == expected
  end

  test "go 2" do
    disk_map_in = "2333133121414131402"

    actual = Day9.go(disk_map_in)
    expected = 1928

    assert actual == expected
  end

  test "disk_map_input_to_blocks 1" do
    disk_map_in = "12345"

    actual = Day9.disk_map_input_to_blocks(disk_map_in)
    expected = "0..111....22222"

    assert actual == expected
  end

  # 2333133121414131402

  test "disk_map_input_to_blocks 2" do
    disk_map_in = "2333133121414131402"

    actual = Day9.disk_map_input_to_blocks(disk_map_in)

    expected = "00...111...2...333.44.5555.6666.777.888899"

    assert actual == expected
  end

  test "condense 1" do
    # Altering the value in the problem description for purpose of this test
    blocks = "0..111....22222"

    expected = "022111222......"
    actual = Day9.condense(blocks)

    assert actual == expected
  end

  test "condense 2" do
    # Altering the value in the problem description for purpose of this test
    blocks = "00...111...2...333.44.5555.6666.777.888899"

    expected = "0099811188827773336446555566.............."
    actual = Day9.condense(blocks)

    assert actual == expected
  end
end
