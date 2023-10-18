defmodule Day2 do
  # https://adventofcode.com/2022/day/2

  @moduledoc """
  Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose
  the same shape, the round instead ends in a draw.

  The first column is what your opponent is going to play: A for Rock, B for Paper, and
  for Scissors.

  The second column, you reason, must be what you should play in response: X for Rock, Y for Paper,
  and Z for Scissors

  Your total score is the sum of your scores for each round. The score for a single round is the
  score for the shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score
  for the outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
  """

  @score_rock 1
  @score_paper 2
  @score_scissors 3

  @score_lost 0
  @score_draw 3
  @score_won 6

  def go() do
    input = "A B C"

    their_plays =
      String.split(input)
      |> Enum.map(&convert_play/1)

    my_plays = play(their_plays)

    both_plays = Enum.zip(their_plays, my_plays)

    score = do_scoring(both_plays)
            |> Enum.sum()

    IO.puts(score)
  end

  def convert_play(play) do
    case play do
      "A" -> :rock
      "B" -> :paper
      "C" -> :scissors
    end
  end

  def play(their_plays) do
    Enum.map(their_plays, fn play ->
      case play do
        :rock -> :paper
        :paper -> :rock
        :scissors -> :scissors
      end
    end)
  end

  def do_scoring(both_plays) do
    both_plays
    |> Enum.map(fn
      {:rock, :rock} -> @score_rock + @score_draw
      {:rock, :paper} -> @score_paper + @score_won
      {:rock, :scissors} -> @score_scissors + @score_lost

      {:paper, :rock} -> @score_rock + @score_lost
      {:paper, :paper} -> @score_paper + @score_draw
      {:paper, :scissors} -> @score_scissors + @score_won

      {:scissors, :rock} -> @score_rock + @score_won
      {:scissors, :paper} -> @score_paper + @score_lost
      {:scissors, :scissors} -> @score_scissors + @score_draw
    end)
  end

end
