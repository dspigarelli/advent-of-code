defmodule AdventOfCode.Aoc2021.Day7TheTreacheryOfWhales do
  use AdventOfCode

  def part_1(input) do
    numbers = parse(input)

    Enum.min(numbers)..Enum.max(numbers)
    |> Enum.map(&count_fuel(&1, numbers))
    |> Enum.min()
  end

  def part_2(input) do
    numbers = parse(input)

    Enum.min(numbers)..Enum.max(numbers)
    |> Enum.map(&count_fuel_2(&1, numbers))
    |> Enum.min()
  end

  defp count_fuel(spot, numbers) do
    numbers
    |> Enum.map(&abs(&1 - spot))
    |> Enum.sum()
  end

  defp count_fuel_2(spot, numbers) do
    numbers
    |> Enum.map(&abs(&1 - spot))
    |> Enum.map(&((&1 * (&1 + 1) / 2) |> floor()))
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
