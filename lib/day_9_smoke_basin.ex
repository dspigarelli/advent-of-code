defmodule AdventOfCode2021.Day9SmokeBasin do
  use AdventOfCode2021

  def part_1(input) do
    input = parse(input)

    matches =
      input
      |> find_smallest()
      |> Map.new()

    input
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> find_smallest()
    |> Enum.filter(fn {{r,c}, _} -> Map.has_key?(matches, {c,r}) end)
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v + 1 end)
  end

  def part_2(input) do
    input
    |> parse
  end

  defp find_smallest(lists) do
    lists
    |> duplicate_second()
    |> Enum.reverse()
    |> duplicate_second()
    |> Enum.reverse()
    |> Enum.chunk_every(3,1,:discard)
    |> Enum.with_index()
    |> Enum.flat_map(&find_smallest_by_column/1)
  end

  defp duplicate_second([_ | [second | _]] = list) do
    [second | list]
  end

  defp find_smallest_by_column({[[], a, b], idx}), do: find_smallest_by_column({[b,a,b], idx})
  defp find_smallest_by_column({[a, b, []], idx}), do: find_smallest_by_column({[a,b,a], idx})
  defp find_smallest_by_column({lists, idx}) do
    lists
    |> Enum.zip()
    |> Enum.with_index()
    |> Enum.reduce([], &smallest/2)
    |> Enum.map(fn {val, idx_y} -> {{idx, idx_y}, val} end)
  end

  def smallest({{x, y, z}, idx}, acc) when y < x and y < z, do: [{y, idx} | acc]
  def smallest(_, acc), do: acc

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
