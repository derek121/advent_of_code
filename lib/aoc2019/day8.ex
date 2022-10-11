defmodule AOC2019.Day8 do
  @moduledoc """
  https://adventofcode.com/2019/day/1

  Each image actually consists of a series of identically-sized layers that are filled in
  this way. So, the first digit corresponds to the top-left pixel of the first layer, the
  second digit corresponds to the pixel to the right of that on the same layer, and so on
  until the last digit, which corresponds to the bottom-right pixel of the last layer.

  For example, given an image 3 pixels wide and 2 pixels tall, the image data 123456789012
  corresponds to the following image layers:

  Layer 1: 123
           456

  Layer 2: 789
           012

  The image you received is 25 pixels wide and 6 pixels tall.

  To make sure the image wasn't corrupted during transmission, the Elves would like you to
  find the layer that contains the fewest 0 digits. On that layer, what is the number of 1
  digits multiplied by the number of 2 digits?

  Return:
  Tuple of the form:
  {3, 12, [1, 2, 1, 1, 1, 0, 2, 1, 1, 0, 0, 4, 5, 6]}

  That is, for the layer with the fewest 0,
  {number_of_0, number_of_1 * number of 2, flattened_layer_with_fewest_0}

  Probably better to return the non-flattened version, but that's left as an exercise
  for the reader.
  """

  def find_layer_with_fewest_zero_digits(image, layer_width, layer_height) do
    image
    |> split_image_data(layer_width, layer_height)
    |> Enum.map(fn layer -> List.flatten(layer) end)
      # Now it's of the form [[1, 2, 3, 4, 5, 6], [7, 8, 9, 0, 1, 2]]
    |> Enum.map(fn flattened_layer ->
      num_zero_digits = Enum.count(flattened_layer, &(&1 == 0))
      num_one_digits = Enum.count(flattened_layer, &(&1 == 1))
      num_two_digits = Enum.count(flattened_layer, &(&1 == 2))

      {num_zero_digits, num_one_digits * num_two_digits, flattened_layer}
    end)
      # [
      #  {3, 12, [1, 2, 1, 1, 1, 0, 2, 1, 1, 0, 0, 4, 5, 6]},
      #  {4, 2, [2, 3, 4, 5, 7, 8, 9, 1, 0, 0, 0, 0, 7, 2]}
      #]
      #      |> IO.inspect(label: "layer counts")
    |> Enum.sort()
    |> List.first()
  end

  @doc """
  Input: String of image data

  Output:
  image: [layer_1, layer_2, ...]
  layer_n: [row_1, row_2...]
  row_n: [integer pixel value]

  E.g., [ [[1,2,3], [4,5,6]], [[7,8,9], [0,1,2]] ]
  """
  def split_image_data(image, layer_width, layer_height) do
    image
    |> String.split("", [trim: true])
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(layer_width * layer_height)
    |> Enum.map(&Enum.chunk_every(&1, layer_width))
  end

end
