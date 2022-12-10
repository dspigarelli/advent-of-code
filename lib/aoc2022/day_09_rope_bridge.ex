defmodule AdventOfCode.Aoc2022.Day09RopeBridge do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.reduce({{0, 0}, {0, 0}, []}, &move/2)
    |> then(&elem(&1, 2))
    |> Enum.reverse()
    |> Enum.uniq()
    |> Enum.count()
  end

  # def part_2(input) do
  #   input
  #   |> parse
  # end

  defp move({_direction, 0}, result), do: result

  defp move({:R, count}, {{x, y}, {x2, _y}, positions}) when x > x2,
    do: move({:R, count - 1}, {{x + 1, y}, {x, y}, [{x, y} | positions]})

  defp move({:R, count}, {{x, y}, tail, positions}),
    do: move({:R, count - 1}, {{x + 1, y}, tail, [tail | positions]})

  defp move({:U, count}, {{x, y}, {_x, y2}, positions}) when y > y2,
    do: move({:U, count - 1}, {{x, y + 1}, {x, y}, [{x, y} | positions]})

  defp move({:U, count}, {{x, y}, tail, positions}),
    do: move({:U, count - 1}, {{x, y + 1}, tail, [tail | positions]})

  defp move({:L, count}, {{x, y}, {x2, _y}, positions}) when x < x2,
    do: move({:L, count - 1}, {{x - 1, y}, {x, y}, [{x, y} | positions]})

  defp move({:L, count}, {{x, y}, tail, positions}),
    do: move({:L, count - 1}, {{x - 1, y}, tail, [tail | positions]})

  defp move({:D, count}, {{x, y}, {_x, y2}, positions}) when y < y2,
    do: move({:D, count - 1}, {{x, y - 1}, {x, y}, [{x, y} | positions]})

  defp move({:D, count}, {{x, y}, tail, positions}),
    do: move({:D, count - 1}, {{x, y - 1}, tail, [tail | positions]})

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(" ", parts: 2)
    |> then(fn [direction, count] ->
      {String.to_atom(direction), String.to_integer(count)}
    end)
  end
end
