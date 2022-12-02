defmodule AdventOfCode.Aoc2022.Day02RockPaperScissors do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.map(&play_round/1)
    |> Enum.sum()
  end

  # rock, rock
  defp play_round(["A", "X"]), do: 1 + 3
  # rock, paper
  defp play_round(["A", "Y"]), do: 2 + 6
  # rock, scissors
  defp play_round(["A", "Z"]), do: 3
  # paper, rock
  defp play_round(["B", "X"]), do: 1
  # paper, paper
  defp play_round(["B", "Y"]), do: 2 + 3
  # paper, scissors
  defp play_round(["B", "Z"]), do: 3 + 6
  # scissors, rock
  defp play_round(["C", "X"]), do: 1 + 6
  # scissors, paper
  defp play_round(["C", "Y"]), do: 2
  # scissors, scissors
  defp play_round(["C", "Z"]), do: 3 + 3

  def part_2(input) do
    input
    |> parse
    |> Enum.map(&play_round_outcome/1)
    |> Enum.sum()
  end

  # rock, lose
  defp play_round_outcome(["A", "X"]), do: 3 + 0
  # rock, draw
  defp play_round_outcome(["A", "Y"]), do: 1 + 3
  # rock, win
  defp play_round_outcome(["A", "Z"]), do: 2 + 6
  # paper, lose
  defp play_round_outcome(["B", "X"]), do: 1 + 0
  # paper, draw
  defp play_round_outcome(["B", "Y"]), do: 2 + 3
  # paper, win
  defp play_round_outcome(["B", "Z"]), do: 3 + 6
  # scissors, lose
  defp play_round_outcome(["C", "X"]), do: 2 + 0
  # scissors, draw
  defp play_round_outcome(["C", "Y"]), do: 3 + 3
  # scissors, win
  defp play_round_outcome(["C", "Z"]), do: 1 + 6

  defp parse(input) do
    input
    |> String.split(~r{\n})
    |> Enum.map(&String.split(&1, ~r{ }))
  end
end
