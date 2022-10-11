defmodule AOC2019.Day8Test do
  use ExUnit.Case

  test "split_image_data" do
    image = "1211102110045623457891000072"

    expected = [ [[1,2,1,1,1,0,2], [1,1,0,0,4,5,6]], [[2,3,4,5,7,8,9], [1,0,0,0,0,7,2]] ]
    actual = AOC2019.Day8.split_image_data(image, 7, 2)

    assert actual == expected
  end

  test "test find_layer_with_fewest_zero_digits" do
    image = "1211102110045623457891000072"
    # For a layer width of 7, height of 2, that corresponds to
    # [ [[1,2,1,1,1,0,2], [1,1,0,0,4,5,6]], [[2,3,4,5,7,8,9], [1,0,0,0,0,7,2]] ]

    actual = AOC2019.Day8.find_layer_with_fewest_zero_digits(image, 7, 2)

    # For the layer with the fewest 0,
    # {number_of_0, number_of_1 * number of 2, flattened_layer_with_fewest_0}
    expected = {3, 12, [1, 2, 1, 1, 1, 0, 2, 1, 1, 0, 0, 4, 5, 6]}

    assert actual == expected
  end
end
