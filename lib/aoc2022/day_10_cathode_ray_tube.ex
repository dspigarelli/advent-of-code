defmodule AdventOfCode.Aoc2022.Day10CathodeRayTube do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.reduce([1], &process/2)
    |> Enum.reverse()
    # not sure why I had to add an extra cycle...
    |> then(fn tail -> [1 | tail] end)
    |> Enum.slice(20..-1)
    |> Enum.take_every(40)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {value, index}, total ->
      total + value * (index * 40 + 20)
    end)
  end

  defp process("noop", [x | _] = values), do: [x | values]

  defp process("addx " <> count, [x | _] = values),
    do: [x + String.to_integer(count), x | values]

  # def part_2(input) do
  #   input
  #   |> parse
  # end

  defp parse(input) do
    input
    |> String.split("\n")
  end
end
