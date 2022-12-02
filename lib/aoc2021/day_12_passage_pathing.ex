defmodule AdventOfCode.Aoc2021.Day12PassagePathing do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> traverse([{[:start], MapSet.new([:start]), nil}], [], part: :part_1)
    |> length()
  end

  def part_2(input) do
    input
    |> parse
    |> traverse([{[:start], MapSet.new([:start]), nil}], [], part: :part_2)
    # |> IO.inspect(label: "final")
    |> length()
  end

  defp traverse(_connections, [], solutions, _opts), do: solutions

  defp traverse(connections, [path | paths], solutions, opts) do
    {fragments, more_solutions} =
      expand(connections, path, opts)

    traverse(connections, fragments ++ paths, more_solutions ++ solutions, opts)
  end

  def expand(connections, {[head | _] = path, visited, single}, opts) do
    allow_single? = Keyword.get(opts, :part, false) == :part_2

    Map.get(connections, head, [])
    |> Enum.reduce([], fn
      {child, true}, acc ->
        [{[child | path], visited, single} | acc]

      {child, false}, acc ->
        visited
        |> MapSet.member?(child)
        |> case do
          false ->
            [{[child | path], MapSet.put(visited, child), single} | acc]

          true when allow_single? and is_nil(single) and child != :start and child != :end ->
            [{[child | path], MapSet.put(visited, child), child} | acc]

          true ->
            acc
        end
    end)
    |> Enum.group_by(fn
      {[:end | _], _, _} -> true
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
      [{a, _} = ap, {b, _} = bp] =
        line
        |> String.split("-")
        |> Enum.map(fn str -> {String.to_atom(str), upcase?(str)} end)

      map
      |> Map.update(a, [bp], &[bp | &1])
      |> Map.update(b, [ap], &[ap | &1])
    end)
  end
end
