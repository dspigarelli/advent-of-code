defmodule AdventOfCode.Aoc2021.Day5HydrothermalVenture do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.filter(fn
      {[x, _], [x, _]} -> true
      {[_, y], [_, y]} -> true
      _ -> false
    end)
    |> count_overlaps()
  end

  def part_2(input) do
    input
    |> parse
    |> count_overlaps()
  end

  defp count_overlaps(list) do
    list
    |> Enum.map(fn
      {[x, y], [x2, y]} ->
        Enum.map(x..x2, fn x -> [x, y] end)

      {[x, y], [x, y2]} ->
        Enum.map(y..y2, fn y -> [x, y] end)

      {[x, y], [x2, y2]} ->
        [
          Enum.to_list(x..x2),
          Enum.to_list(y..y2)
        ]
        |> Enum.zip()
        |> Enum.map(&Tuple.to_list(&1))
    end)
    |> Enum.reduce([], fn x, acc -> x ++ acc end)
    |> Enum.group_by(fn x -> x end)
    |> Enum.filter(fn {_key, values} -> length(values) > 1 end)
    |> length()
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ~r/\s+->\s+/))
    |> Enum.map(fn [first, second] ->
      {
        parse_coordinate(first),
        parse_coordinate(second)
      }
    end)
  end

  defp parse_coordinate(coordinate) do
    coordinate
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end
end
