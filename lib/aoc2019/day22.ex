defmodule AOC2019.Day22 do
  @moduledoc """
  https://adventofcode.com/2019/day/22

  To deal into new stack, create a new stack of cards by dealing the top card of the deck
  onto the top of the new stack repeatedly until you run out of cards. (This just reverses
  the deck).

  To cut N cards, take the top N cards off the top of the deck and move them as a single
  unit to the bottom of the deck, retaining their order. If N is negative, cut (the
  absolute value of) N cards from the bottom of the deck onto the top.

  To deal with increment N, start by clearing enough space on your table to lay out all
  of the cards individually in a long line. Deal the top card into the leftmost position.
  Then, move N positions to the right and deal the next card there. If you would move into
  a position past the end of the space on your table, wrap around and keep counting from
  the leftmost card again. Continue this process until you run out of cards.
  """

  @doc """
  num_cards: number of cards in the deck
  ops: List of any combination of the following operations:
    :deal_into_new_stack
    {:cut_cards, n}
    {:deal_with_increment, n}
  """
  def shuffle(num_cards, ops) do
    deck = for n <- 0..(num_cards - 1), do: n

    ops
    |> Enum.reduce(deck, fn op, deck ->
      operate(op, deck)
    end)
  end

  @doc """
  op: One of the following:
    :deal_into_new_stack
    {:cut_cards, n}
    {:deal_with_increment, n}
  deck: list of cards (integers)

  Return:
  The modified deck
  """
  def operate(:deal_into_new_stack, deck) do
    Enum.reverse(deck)
  end

  def operate({:cut_cards, n}, deck) do
    # Enum.split/2 operates for negative value as we want- taking n from the end,
    # so we can use the same call here regardless.
    {first, second} = Enum.split(deck, n)

    second ++ first
  end

  def operate({:deal_with_increment, inc}, deck) do
    size = length(deck)

    # We'll overwrite the deck param, since it's immutable, won't affect the deck input
    {out_deck, _end_idx} =
      deck
      |> Enum.reduce({deck, 0}, fn card, {out, out_idx} ->
        out = List.replace_at(out, out_idx, card)
        {out, rem(out_idx + inc, size)}
      end)

    out_deck
  end
end
