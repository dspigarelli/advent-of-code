defmodule AdventOfCode.Aoc2022.Day10CathodeRayTube do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.reduce([1], &process/2)
    |> Enum.reverse()
    |> Enum.slice(19..-1)
    |> Enum.take_every(40)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {value, index}, total ->
      total + value * (index * 40 + 20)
    end)
  end

  defp process("noop", [x | _] = values), do: [x | values]

  defp process("addx " <> count, [x | _] = values),
    do: [x + String.to_integer(count), x | values]

  def part_2(input) do
    input
    |> parse
    |> Enum.reduce([1], &process/2)
    # do i still need to add an extra cycle? probably not
    |> then(fn x -> [1 | x] end)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn
      {x, pixel} when rem(pixel, 40) >= x-1 and rem(pixel, 40) <= x+1 -> "#"
      _ -> "."
    end)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join("\n")
  end

  defp parse(input) do
    input
    |> String.split("\n")
  end
end
