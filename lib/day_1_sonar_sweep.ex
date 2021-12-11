defmodule AdventOfCode2021.Day1SonarSweep do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> get_lists(1)
    |> Enum.reduce(0, &compare(&1, &2))
  end

  def part_2(input) do
    input
    |> parse
    |> get_lists(3)
    |> Enum.reduce(0, &compare(&1, &2))
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  defp get_lists(list, window) do
    Enum.zip(
      Enum.slice(list, 0..(-window - 1)),
      list |> Enum.reverse() |> Enum.slice(0..(-window - 1)) |> Enum.reverse()
    )
  end

  defp compare({one, two}, acc) when one < two, do: acc + 1
  defp compare(_, acc), do: acc
end
