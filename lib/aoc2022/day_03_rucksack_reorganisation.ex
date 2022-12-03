defmodule AdventOfCode.Aoc2022.Day03RucksackReorganisation do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.flat_map(fn list ->
      {first, second} = Enum.split(list, div(length(list), 2))
      [first, second] = [first, second] |> Enum.map(&MapSet.new/1)

      first
      |> MapSet.intersection(second)
      |> MapSet.to_list()
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.chunk_every(3)
    |> Enum.flat_map(fn sacks ->
      [first, second, third] = Enum.map(sacks, &MapSet.new/1)
      first
      |> MapSet.intersection(second)
      |> MapSet.intersection(third)
      |> MapSet.to_list()
    end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split(~r{\n})
    |> Enum.map(fn str ->
      str
      |> to_charlist()
      |> Enum.map(fn
        ch when ch >= 97 and ch <= 122 -> ch - 97 + 1
        ch -> ch - 65 + 27
      end)
    end)
  end
end
