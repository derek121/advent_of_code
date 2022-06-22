defmodule AOC2021.Day14 do

  @moduledoc """
  https://adventofcode.com/2021/day/14

  Polymerization/inserting values.
  """

  @doc """
  template: E.g., "NNCB"

  Return:
  The quantity of the most common element and subtract the quantity of the least common element.
  """
  def run(num_iterations, template_in) do
    result = run2(num_iterations, template_in)

    {{_, min_count}, {_, max_count}} =
      result
      |> Enum.frequencies()
      |> Enum.min_max_by(&(elem(&1, 1)))

    max_count - min_count
  end

  def run2(num_iterations, template_in) do
    template = String.to_charlist(template_in)
    rules = insertion_rules()

    1..num_iterations
    |> Enum.reduce(template, fn _n, acc ->
      # E.g., ['NN', 'NC', 'CB']
      pairs = Enum.chunk_every(acc, 2, 1, :discard)

      do_insertions(pairs, rules)
    end)
  end

  def do_insertions([[first | _] | _] = pairs, rules) do
    # The second element of each pair is also the first of the next element, due to the
    # chunking. So don't include the first one, but use the identical value from the next
    # element. Then at the end, prepend the first.
    tail =
      pairs
      |> Enum.map(fn [_a, b] = pair ->
        to_insert = rules[pair]
        [to_insert, b]
      end)

    Enum.concat([[first] | tail])
  end

  def insertion_rules() do
    %{
      'CH' => ?B,
      'HH' => ?N,
      'CB' => ?H,
      'NH' => ?C,
      'HB' => ?C,
      'HC' => ?B,
      'HN' => ?C,
      'NN' => ?C,
      'BH' => ?H,
      'NC' => ?B,
      'NB' => ?B,
      'BN' => ?B,
      'BB' => ?N,
      'BC' => ?B,
      'CC' => ?N,
      'CN' => ?C
    }
  end

end
