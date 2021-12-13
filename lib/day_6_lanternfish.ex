defmodule AdventOfCode2021.Day6Lanternfish do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> initialize_tank()
    |> generation(80)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse
    |> initialize_tank()
    |> generation(256)
    |> Enum.sum()
  end

  defp initialize_tank(fish) do
    Enum.reduce(
      fish,
      List.duplicate(0, 9),
      fn x, acc ->
        List.update_at(acc, x, &(&1 + 1))
      end)
  end

  defp generation(fish, 0), do: fish
  defp generation(fish, x) do
    [cnt | fish] = fish

    fish
    |> List.update_at(6, &(&1 + cnt))
    |> Enum.reverse()
    |> case do
      x -> [cnt | x]
    end
    |> Enum.reverse()
    |> generation(x - 1)
  end

  defp parse(input) do
    input
    |> String.split(~r/,/)
    |> Enum.map(&String.to_integer/1)
  end
end
