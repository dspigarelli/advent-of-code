defmodule AdventOfCode2021.Day8SevenSegmentSearch do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> Enum.flat_map(fn [_first, second] -> second end)
    |> Enum.map(&String.length/1)
    |> Enum.count(&Enum.member?([2,3,4,7], &1))
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.map(fn [digits, display] -> {map_digits(digits), display} end)
    |> Enum.map(fn {map, display} ->
      display
      |> Enum.map(&Map.get(map, &1))
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()
      |> String.to_integer
    end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ~r/\s+\|\s+/, trim: true))
    |> Enum.map(&Enum.map(&1, fn s -> sort_strings(s) end))
  end

  defp map_digits(digits) do
    lookup = group_by_segment_count(digits)

    %{
      1 => Map.get(lookup, 2) |> List.first(),
      7 => Map.get(lookup, 3) |> List.first(),
      4 => Map.get(lookup, 4) |> List.first(),
      8 => Map.get(lookup, 7) |> List.first(),
    }
    |> assign_sixes(Map.get(lookup, 6))
    |> assign_fives(Map.get(lookup, 5))
    |> Enum.map(fn {key, value} -> {mapset_to_str(value), key} end)
    |> Map.new()
  end

  defp assign_sixes(%{4 => four, 7 => seven} = map, candidates) do
    nine = Enum.find(candidates, &MapSet.subset?(four, &1))

    candidates = List.delete(candidates, nine)
    zero = Enum.find(candidates, &MapSet.subset?(seven, &1))

    six = List.delete(candidates, zero) |> List.first()
    Map.merge(map, %{9 => nine, 0 => zero, 6 => six})
  end

  defp group_by_segment_count(digits) do
    digits
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&MapSet.new/1)
      |> Enum.group_by(&MapSet.size/1)
  end

  defp assign_fives(%{7 => seven, 6 => six} = map, candidates) do
    five = Enum.find(candidates, &MapSet.subset?(&1, six))

    candidates = List.delete(candidates, five)
    three = Enum.find(candidates, &MapSet.subset?(seven, &1))

    two = List.delete(candidates, three) |> List.first()
    Map.merge(map, %{2 => two, 3 => three, 5 => five})
  end

  defp str_to_mapset(str), do: str |> String.graphemes |> MapSet.new
  defp mapset_to_str(mapset), do: mapset |> MapSet.to_list |> Enum.join("")

  defp sort_strings(strings) do
    strings
    |> String.split(" ", trim: true)
    |> Enum.map(&sort_string/1)
  end

  defp sort_string(str) do
    str
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join("")
  end
end
