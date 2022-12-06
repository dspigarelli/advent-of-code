defmodule AdventOfCode.Aoc2022.Day06TuningTrouble do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.reduce_while([], &sliding_window(&1, &2, 4))
    |> length()
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.reduce_while([], &sliding_window(&1, &2, 14))
    |> length()
  end

  defp sliding_window(item, window, count) do
    window
    |> Enum.reverse()
    |> Enum.take(count)
    |> Enum.reverse()
    |> Enum.uniq()
    |> length()
    |> case do
      ^count -> {:halt, window}
      _ -> {:cont, window ++ [item]}
    end
  end

  defp parse(input) do
    input
    |> String.codepoints()
  end
end
