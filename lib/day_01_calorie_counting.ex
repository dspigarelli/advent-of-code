defmodule AdventOfCode2021.Day01CalorieCounting do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split(~r{\n\n})
    |> Enum.map(&parse_elf/1)
  end

  defp parse_elf(input) do
    input
    |> String.split(~r{\n})
    |> Enum.map(&String.to_integer/1)
  end
end
