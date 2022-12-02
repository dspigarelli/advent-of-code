defmodule AdventOfCode.Aoc2021.Day10SyntaxScoring do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.map(&step(&1, []))
    |> Enum.filter(fn {x, _} -> x end)
    |> Enum.reduce(0, fn {x, _}, acc -> acc + x end)
  end

  def part_2(input) do
    input
    |> parse
    |> Enum.reduce([], fn x, acc ->
      step(x, [])
      |> case do
        {nil, stack} -> [count(0, stack) | acc]
        _ -> acc
      end
    end)
    |> Enum.sort()
    |> (fn list -> Enum.at(list, (length(list) - 1) |> div(2)) end).()
  end

  defp step(["(" = token | input], stack), do: step(input, [token | stack])
  defp step(["[" = token | input], stack), do: step(input, [token | stack])
  defp step(["{" = token | input], stack), do: step(input, [token | stack])
  defp step(["<" = token | input], stack), do: step(input, [token | stack])

  defp step([")" | input], ["(" | stack]), do: step(input, stack)
  defp step(["]" | input], ["[" | stack]), do: step(input, stack)
  defp step(["}" | input], ["{" | stack]), do: step(input, stack)
  defp step([">" | input], ["<" | stack]), do: step(input, stack)

  defp step([")" | _] = input, _), do: {3, input}
  defp step(["]" | _] = input, _), do: {57, input}
  defp step(["}" | _] = input, _), do: {1197, input}
  defp step([">" | _] = input, _), do: {25137, input}

  defp step(_, stack), do: {nil, stack}

  defp count(acc, []), do: acc
  defp count(acc, ["(" | stack]), do: count(acc * 5 + 1, stack)
  defp count(acc, ["[" | stack]), do: count(acc * 5 + 2, stack)
  defp count(acc, ["{" | stack]), do: count(acc * 5 + 3, stack)
  defp count(acc, ["<" | stack]), do: count(acc * 5 + 4, stack)

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end
end
