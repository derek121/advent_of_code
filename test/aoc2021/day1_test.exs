defmodule Day1Test do
  use ExUnit.Case


  @doc """
    199 (N/A - no previous measurement)
    200 (increased)
    208 (increased)
    210 (increased)
    200 (decreased)
    207 (increased)
    240 (increased)
    269 (increased)
    260 (decreased)
    263 (increased)

  """
  test "test it" do
    lst =
      [
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263
      ]

    expected = 7
    actual = Day1.run(lst)

    assert actual == expected
end

end
