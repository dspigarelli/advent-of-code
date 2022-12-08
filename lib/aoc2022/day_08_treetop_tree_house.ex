defmodule AdventOfCode.Aoc2022.Day08TreetopTreeHouse do
  use AdventOfCode

  def part_1(input) do
    rows = parse(input)

    columns =
      rows
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    from_left = Enum.map(rows, &visible(&1, -1))

    # visible from sides
    rows =
      rows
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(&visible(&1, -1))
      |> Enum.map(&Enum.reverse/1)
      |> Enum.zip_with(from_left, &merge_visible/2)

    from_top = Enum.map(columns, &visible(&1, -1))

    # visible from top/bottom
    columns =
      columns
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(&visible(&1, -1))
      |> Enum.map(&Enum.reverse/1)
      |> Enum.zip_with(from_top, &merge_visible/2)

    for x <- 0..(length(columns) - 1), y <- 0..(length(rows) - 1) do
      max(rows |> Enum.at(y) |> Enum.at(x), columns |> Enum.at(x) |> Enum.at(y))
    end
    |> Enum.filter(&(&1 >= 0))
    |> Enum.count()
  end

  # def part_2(input) do
  #   input
  #   |> parse
  # end

  defp visible([], _max), do: []
  defp visible([tree | row], max) when max < tree, do: [tree | visible(row, tree)]
  defp visible([_tree | row], max), do: [-1 | visible(row, max)]

  defp merge_visible(left, right), do: Enum.zip_with(left, right, &max/2)

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(row) do
    row
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end
end
