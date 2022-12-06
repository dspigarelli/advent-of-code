defmodule AdventOfCode.Aoc2022.Day05SupplyStacks do
  use AdventOfCode

  def part_1(input, stacks) do
    input
    |> parse()
    |> Enum.reduce(stacks, fn
      %{count: count, from: from_index, to: to_index}, stacks ->
        {moving, from} =
          stacks
          |> Enum.at(from_index - 1)
          |> Enum.split(count)

        to = Enum.reverse(moving) ++ Enum.at(stacks, to_index - 1)

        stacks
        |> List.replace_at(from_index - 1, from)
        |> List.replace_at(to_index - 1, to)
    end)
    |> Enum.map(&List.first/1)
    |> Enum.map(&Atom.to_string/1)
    |> Enum.join("")
  end

  def part_2(input, stacks) do
    input
    |> parse()
    |> Enum.reduce(stacks, fn
      %{count: count, from: from_index, to: to_index}, stacks ->
        {moving, from} =
          stacks
          |> Enum.at(from_index - 1)
          |> Enum.split(count)

        to = moving ++ Enum.at(stacks, to_index - 1)

        stacks
        |> List.replace_at(from_index - 1, from)
        |> List.replace_at(to_index - 1, to)
    end)
    |> Enum.map(&List.first/1)
    |> Enum.map(&Atom.to_string/1)
    |> Enum.join("")
  end

  defp parse(input) do
    input
    |> String.split(~r{\n\n})
    |> (fn [_stacks, moves] ->
          parse_moves(moves)
        end).()
  end

  defp parse_moves(input) do
    input
    |> String.split(~r{\n})
    |> Enum.map(fn input ->
      move = Regex.named_captures(~r{move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)}, input)

      %{
        count: String.to_integer(move["count"]),
        from: String.to_integer(move["from"]),
        to: String.to_integer(move["to"])
      }
    end)
  end
end
