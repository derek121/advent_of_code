defmodule Day3 do

  @doc """
  https://adventofcode.com/2021/day/3

  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """
  def run(lst) do
    init = %{
      pos1_0: 0,
      pos1_1: 0,
      pos2_0: 0,
      pos2_1: 0,
      pos3_0: 0,
      pos3_1: 0,
      pos4_0: 0,
      pos4_1: 0,
      pos5_0: 0,
      pos5_1: 0
    }

    counts_map =
      lst
      |> Enum.reduce(
           init,
           fn line, acc ->
             [pos1, pos2, pos3, pos4, pos5] = String.split(line, "", trim: true)

             acc = calc(acc, pos1, :pos1_0, :pos1_1)
             acc = calc(acc, pos2, :pos2_0, :pos2_1)
             acc = calc(acc, pos3, :pos3_0, :pos3_1)
             acc = calc(acc, pos4, :pos4_0, :pos4_1)
             acc = calc(acc, pos5, :pos5_0, :pos5_1)

             acc
           end)

      IO.inspect(counts_map)

    gamma = compute_gamma(counts_map)
    epsilon = compute_epsilon(counts_map)

    {gamma, epsilon}
  end

  def compute_gamma(counts_map) do
    gamma_1 = if counts_map[:pos1_1] >= counts_map[:pos1_0], do: 1, else: 0
    IO.inspect(gamma_1, label: "gamma_1")

    gamma_2 = if counts_map[:pos2_1] >= counts_map[:pos2_0], do: 1, else: 0
    IO.inspect(gamma_2, label: "gamma_2")

    gamma_3 = if counts_map[:pos3_1] >= counts_map[:pos3_0], do: 1, else: 0
    IO.inspect(gamma_3, label: "gamma_3")

    gamma_4 = if counts_map[:pos4_1] >= counts_map[:pos4_0], do: 1, else: 0
    IO.inspect(gamma_4, label: "gamma_4")

    gamma_5 = if counts_map[:pos5_1] >= counts_map[:pos5_0], do: 1, else: 0
    IO.inspect(gamma_5, label: "gamma_5")

    "#{gamma_1}#{gamma_2}#{gamma_3}#{gamma_4}#{gamma_5}"
    |> String.to_integer(2)
  end

  def compute_epsilon(counts_map) do
    epsilon_1 = if counts_map[:pos1_1] <= counts_map[:pos1_0], do: 1, else: 0
    IO.inspect(epsilon_1, label: "epsilon_1")

    epsilon_2 = if counts_map[:pos2_1] <= counts_map[:pos2_0], do: 1, else: 0
    IO.inspect(epsilon_2, label: "epsilon_2")

    epsilon_3 = if counts_map[:pos3_1] <= counts_map[:pos3_0], do: 1, else: 0
    IO.inspect(epsilon_3, label: "epsilon_3")

    epsilon_4 = if counts_map[:pos4_1] <= counts_map[:pos4_0], do: 1, else: 0
    IO.inspect(epsilon_4, label: "epsilon_4")

    epsilon_5 = if counts_map[:pos5_1] <= counts_map[:pos5_0], do: 1, else: 0
    IO.inspect(epsilon_5, label: "epsilon_5")

    "#{epsilon_1}#{epsilon_2}#{epsilon_3}#{epsilon_4}#{epsilon_5}"
    |> String.to_integer(2)
  end

  def calc(acc, pos_val, pos_0, pos_1) do
    if pos_val == "0" do
      Map.update!(acc, pos_0, &(&1 + 1))
    else
      Map.update!(acc, pos_1, &(&1 + 1))
    end
  end

end
