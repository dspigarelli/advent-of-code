defmodule AdventOfCode.Aoc2022.Day04CampCleanup do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.filter(fn {first, second} ->
      first = MapSet.new(first)
      second = MapSet.new(second)
      MapSet.subset?(first, second) or MapSet.subset?(second, first)
    end)
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.reject(fn {first, second} -> Range.disjoint?(first, second) end)
    |> Enum.count()
  end

  defp parse(input) do
    input
    |> String.split(~r{\n})
    |> Enum.flat_map(&Regex.scan(~r{(\d+)-(\d+),(\d+)-(\d+)}, &1))
    |> Enum.map(fn [_ | rest] -> Enum.map(rest, &String.to_integer/1) end)
    |> Enum.map(fn [first, second, third, fourth] -> {first..second, third..fourth} end)
  end
end
