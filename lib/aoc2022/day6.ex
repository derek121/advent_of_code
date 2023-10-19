defmodule Day6 do
  # https://adventofcode.com/2022/day/6

  @moduledoc """
  your subroutine needs to identify the first position where the four most recently
  received characters were all different. Specifically, it needs to report the number
  of characters from the beginning of the buffer to the end of the first such
  four-character marker.

  bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 5
  nppdvjthqldpwncqszvftbrmjlhg: first marker after character 6
  nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 10
  zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 11
  """

  def go() do
    signals = [
      "bvwbjplbgvbhsrlpgdmjqwftvncz",
      "nppdvjthqldpwncqszvftbrmjlhg",
      "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
      "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    ]

    Enum.map(signals, &process/1)
  end

  def process(signal) do
    # ["b", "v", "w", "b", "j", "p", "l", "b", "g", "v", "b", "h", "s", "r", "l", "p",
    # "g", "d", "m", "j", "q", "w", "f", "t", "v", "n", "c", "z"]
    split = String.split(signal, "", trim: true)

    # [
    # ["b", "v", "w", "b"],
    # ["v", "w", "b", "j"],
    # ["w", "b", "j", "p"],
    # ["b", "j", "p", "l"],
    # ["j", "p", "l", "b"],
    # ...
    # ]
    chunked = Enum.chunk_every(split, 4, 1, :discard)

    location =
      chunked
      |> Enum.reduce_while(1, fn chunk, acc ->
        deduped =
          Enum.sort(chunk)
          |> Enum.dedup()

        chunk = Enum.sort(chunk)

        if deduped == chunk do
          # No duplicates- found the spot
          {:halt, acc}
        else
          # Duplcates, ned to continue
          {:cont, acc + 1}
        end
      end)

    if location + 3 > String.length(signal) do
      :undefined
    else
      location + 3
    end
  end

end
