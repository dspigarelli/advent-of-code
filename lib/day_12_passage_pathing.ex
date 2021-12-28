defmodule AdventOfCode2021.Day12PassagePathing do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> traverse([{[:start], MapSet.new([:start])}], [])
    |> length()
  end

  # def part_2(input) do
  #   input
  #   |> parse
  # end

  defp traverse(_connections, [], solutions), do: solutions
  defp traverse(connections, [path | paths], solutions) do

    {fragments, more_solutions}
      = expand(connections, path)

    traverse(connections, fragments ++ paths, more_solutions ++ solutions)
  end

  def expand(connections, {[head | _] = path, visited}) do
    Map.get(connections, head, [])
    |> Enum.reduce([], fn
      {child, true}, acc ->
        [{[child | path], visited} | acc]

      {child, false}, acc ->
        visited
        |> MapSet.member?(child)
        |> case do
          false -> [{[child | path], MapSet.put(visited, child)} | acc]
          true -> acc
        end
    end)
    |> Enum.group_by(fn
      {[:end | _], _} -> true
      _ -> false
    end)
    |> case do
      %{false: fragments, true: solutions} -> {fragments, solutions}
      %{false: fragments} -> {fragments, []}
      %{true: solutions} -> {[], solutions}
      %{} -> {[], []}
    end
  end

  defp upcase?(x), do: x == String.upcase(x)

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.reduce(%{}, fn line, map ->
      [{a, _} = ap,{b,_} = bp] =
        line
        |> String.split("-")
        |> Enum.map(fn str -> {String.to_atom(str), upcase?(str)} end)

      map
      |> Map.update(a, [bp], &([bp | &1]))
      |> Map.update(b, [ap], &([ap | &1]))
    end)
  end
end
