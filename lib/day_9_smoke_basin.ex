defmodule AdventOfCode2021.Day9SmokeBasin do
  use AdventOfCode2021

  def part_1(input) do
    lists = parse(input)

    build_neighbors(lists)
    |> get_smallest_neighbor(lists)
    |> Enum.filter(fn {{_, v1}, {_, v2}} -> v1 < v2 end)
    |> find_lowpoints()
    |> Enum.reduce(0, fn {_, val}, acc -> acc + val + 1 end)
  end

  def part_2(input) do
    lists = parse(input)

    build_neighbors(lists)
    |> get_smallest_neighbor(lists)
    |> Enum.filter(fn {{_, x}, _} -> x != 9 end)
    |> find_trees()
  end

  defp find_trees(forest) do
    trees =
      forest
      |> find_lowpoints()
      |> Enum.map(fn {x, _} -> x end)

    map =
      forest
      |> Enum.map(fn {{x, _}, {y, _}} ->
        {x, y}
      end)
      |> Map.new()
      |> Enum.group_by(fn {_, y} -> y end)
      |> Enum.map(fn {x, y} ->
        {
          x,
          Enum.map(y, &elem(&1, 0)) |> MapSet.new()
        }
      end)
      |> Map.new()

    trees
    |> Enum.map(&find_tree(MapSet.new([&1]), map))
    |> Enum.map(fn {map, _} -> MapSet.size(map) end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end

  defp find_tree(nodes, map) do
    Enum.reduce(nodes, {nodes, map}, fn node, {nodes, map} ->
      Map.pop(map, node)
      |> case do
        {nil, map} -> {nodes, map}
        {n2, map} -> find_tree(MapSet.union(nodes, n2), map)
      end
    end)
  end

  defp find_lowpoints(forest) do
    forest
    |> Enum.reduce([], fn
      {{_, v1} = smallest, {_, v2}}, acc when v1 < v2 -> [smallest | acc]
      _, acc -> acc
    end)
  end

  defp get_smallest_neighbor(neighbors, lists) do
    Enum.map(neighbors, fn {coordinate, neighbors} ->
      smallest_neighbor =
        neighbors
        |> Enum.reduce(
          nil,
          fn
            x, nil ->
              {x, get_value(x, lists)}

            neighbor, {_, val} = acc ->
              {neighbor, get_value(neighbor, lists)}
              |> case do
                {_, val2} = smallest when val2 < val -> smallest
                _ -> acc
              end
          end
        )

      {{coordinate, get_value(coordinate, lists)}, smallest_neighbor}
    end)
  end

  defp get_value({x, y}, lists), do: Enum.at(lists, x) |> Enum.at(y)

  defp build_neighbors([first | _] = lists) do
    rows = length(lists) - 1
    columns = length(first) - 1

    for row <- 0..rows,
        col <- 0..columns do
      {{row, col}, neighbors({row, col}, {rows, columns})}
    end
  end

  defp neighbors({row, col}, {rows, columns}) do
    [
      {row + 1, col},
      {row - 1, col},
      {row, col + 1},
      {row, col - 1}
    ]
    |> Enum.filter(fn
      {x, _} when x < 0 or x > rows -> false
      {_, y} when y < 0 or y > columns -> false
      _ -> true
    end)
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
