defmodule AdventOfCode2021.Day11DumboOctopus do
  use AdventOfCode2021

  def part_1(input) do
    { map, {_length, _height } = dimensions, neighbors} = parse(input)

    iterate(map, {99, 0, dimensions, neighbors})
  end

  def part_2(input) do
    { map, {_length, _height } = dimensions, neighbors} = parse(input)

    iterate2(map, {0, 0, dimensions, neighbors})
  end

  defp build_neighbors(map, {x, y} = point, {length, height}) do
    Map.put(map, point, [
      {x-1, y-1},
      {x-1, y},
      {x-1, y+1},
      {x, y-1},
      {x, y+1},
      {x+1, y-1},
      {x+1, y},
      {x+1, y+1},
    ]
    |> Enum.filter(fn
      {x, _} when x < 0 or x >= length -> false
      {_, y} when y < 0 or y >= height -> false
      _ -> true
    end))
  end

  defp iterate(_map, {-1, flashes, _, _}), do: flashes
  defp iterate(map, {count, flashes, dimensions, neighbors}) do
    # IO.puts("")
    # print(map, dimensions)

    # increment everything by 1;
    map = advance(map, dimensions)

    {map, flashes} =
      calculate_flashes(map, flashes, dimensions, neighbors)

    iterate(map, {count - 1, flashes, dimensions, neighbors})
  end

  # defp iterate2(_map, {-1, flashes, _, _}), do: flashes
  defp iterate2(map, {count, flashes, dimensions, neighbors}) do
    # IO.puts("")
    # print(map, dimensions)

    # increment everything by 1;
    map = advance(map, dimensions)

    {map, flashes} =
      calculate_flashes(map, flashes, dimensions, neighbors)

    map_sum(map, dimensions)
    |> case do
      0 ->
        IO.puts("Count: #{count+1}")
        count+1
      _ -> iterate2(map, {count + 1, flashes, dimensions, neighbors})
    end
  end

  defp map_sum(map, dimensions) do
    all_points(dimensions)
    |> Enum.map(&Map.get(map, &1))
    |> Enum.sum()
  end

  defp advance(map, dimensions) do
    all_points(dimensions)
    |> Enum.reduce(map, fn point, map -> Map.update!(map, point, &(&1 + 1)) end)
  end

  defp calculate_flashes(map, flashes, dimensions, neighbors) do
    all_points(dimensions)
    |> Enum.reduce({map, 0}, fn point, acc -> maybe_flashes(point, acc, neighbors) end)
    |> case do
      {map, 0} -> {map, flashes}
      {map, new_flashes} -> calculate_flashes(map, flashes+new_flashes, dimensions, neighbors)
    end
  end

  defp maybe_flashes(point, {map, flashes}, neighbors) do

    Map.get(map, point)
    |> case do
      x when x >= 10 -> { flash_point_and_neighbors(map, point, neighbors), flashes+1 }
      _ -> {map, flashes}
    end
  end

  defp flash_point_and_neighbors(map, point, neighbors) do
    neighbors
    |> Map.get(point)
    |> Enum.reduce(map, fn point, map -> increment_neighbor(map, point) end)
    |> flash_point(point)
  end

  defp flash_point(map, point), do: Map.put(map, point, 0)

  defp increment_neighbor(map, point) do
    Map.get(map, point)
    |> case do
      0 -> map
      _ -> Map.update!(map, point, &(&1 + 1))
    end
  end

  defp all_points({length, height}), do: (for y <- 0..(height-1), x <- 0..(length-1), do: {x,y})

  defp print(map, {length, height}) do
    for y <- 0..(height-1) do
      for x <- 0..(length-1) do
        Map.get(map, {x,y})
        |> case do
          0 -> "."
          x -> x
        end
      end
      |> Enum.join()
      |> IO.puts()
    end
  end

  defp parse(input) do
    rows =
      input
      |> String.split("\n")
      |> Enum.with_index()

    width = length(rows)

    map =
      rows
      |> Enum.reduce(%{}, fn {row, row_index}, map ->
        row
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {col, col_index}, map ->
          Map.put(map, {col_index, row_index}, String.to_integer(col))
        end)
        |> Map.merge(map)
      end)

    dimensions = {width, Map.keys(map) |> length |> div(width)}

    neighbors =
      dimensions
      |> all_points()
      |> Enum.reduce(%{}, fn point, map -> build_neighbors(map, point, dimensions) end)

    { map, dimensions, neighbors}
  end
end
