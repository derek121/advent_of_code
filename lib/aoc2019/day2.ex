defmodule AOC2019.Day2 do
  @moduledoc """
  https://adventofcode.com/2019/day/2

  An Intcode program is a list of integers separated by commas (like 1,0,0,3,99). To run one, start by looking at the
  first integer (called position 0). Here, you will find an opcode - either 1, 2, or 99. The opcode indicates what to
  do; for example, 99 means that the program is finished and should immediately halt. Encountering an unknown opcode
  means something went wrong.

  Opcode 1 adds together numbers read from two positions and stores the result in a third position. The three integers
  immediately after the opcode tell you these three positions - the first two indicate the positions from which you
  should read the input values, and the third indicates the position at which the output should be stored.

  For example, if your Intcode computer encounters 1,10,20,30, it should read the values at positions 10 and 20, add
  those values, and then overwrite the value at position 30 with their sum.

  Opcode 2 works exactly like opcode 1, except it multiplies the two inputs instead of adding them. Again, the three
  integers after the opcode indicate where the inputs and outputs are, not their values.
  """

  def go(program) do
    indices = Enum.take_every(0..(length(program) - 1), 4)

    _result_prog =
      indices
      |> Enum.reduce_while(program, fn idx, program ->
        op = Enum.at(program, idx)

        case op do
          99 ->
            {:halt, program}

          op when op == 1 or op == 2 ->
            arg1_idx = Enum.at(program, idx + 1)
            arg2_idx = Enum.at(program, idx + 2)
            dest_idx = Enum.at(program, idx + 3)

            arg1 = Enum.at(program, arg1_idx)
            arg2 = Enum.at(program, arg2_idx)

            result =
              case op do
                1 -> arg1 + arg2
                2 -> arg1 * arg2
              end

            new_prog = List.replace_at(program, dest_idx, result)

            {:cont, new_prog}
        end
      end)

  end

end
