defmodule AdventOfCode2021.Day4GiantSquid do
  use AdventOfCode2021

  def part_1(input) do
    input
    |> parse
    |> solve
    |> Enum.reduce(fn
      {x, _} = new , {y, _} when x > y -> new
      _, acc -> acc
    end)
    |> case do
      {_, answer} -> answer
    end
  end

  def part_2(input) do
    input
    |> parse
    |> solve()
    |> Enum.reduce(fn
      {x, _} = new , {y, _} when x < y -> new
      _, acc -> acc
    end)
    |> case do
      {_, answer} -> answer
    end
  end

  defp parse(input) do
    [answers | boards] = String.split(input, "\n\n")

    answers =
      answers
      |> String.split(",")
      |> array_to_int()

    boards =
      boards
      |> Enum.map(&parse_board/1)

    { answers, boards}
  end

  defp solve({answers, boards}) do
    boards
    |> Enum.map(&add_columns/1)
    |> Enum.map(&iterate_board(&1, answers))
  end

  defp iterate_board(board, []), do: board
  defp iterate_board(board, answers) do
    [value | rest] = answers

    board = remove(value, board)

    board
    |> any_empty_rows?()
    |> case do
      true -> { length(answers), value * sum_board(board) / 2 |> round() }
      false -> iterate_board(board, rest)
    end
  end

  defp remove(value, board) do
    Enum.map(board, &List.delete(&1, value))
  end

  defp sum_board(board) do
    board
    |> Enum.map(fn
      [] -> 0
      array -> Enum.sum(array)
    end)
    |> Enum.sum()
  end

  defp any_empty_rows?(board) do
    Enum.any?(board, fn
      [] -> true
      _ -> false
    end)
  end

  defp parse_board(board) do
    board
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, ~r/\s+/))
    |> Enum.map(&array_to_int/1)
  end

  defp add_columns(board) do
    as_columns =
      board
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    board ++ as_columns
  end

  defp array_to_int(list) when is_list(list) do
    list
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {int, ""} -> int end)
  end
end
