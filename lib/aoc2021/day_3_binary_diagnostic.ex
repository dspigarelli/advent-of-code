defmodule AdventOfCode.Aoc2021.Day3BinaryDiagnostic do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip_with(
      &Enum.reduce(&1, {0, 0}, fn x, {ones, length} ->
        String.to_integer(x)
        |> case do
          0 -> {ones, length + 1}
          1 -> {ones + 1, length + 1}
        end
      end)
    )
    |> Enum.map(fn
      {ones, length} when ones > length / 2 -> 1
      _ -> 0
    end)
    |> (fn x -> {x, length(x)} end).()
    |> (fn {x, len} ->
          a = Enum.join(x) |> String.to_integer(2)
          a * Bitwise.bxor(a, (:math.pow(2, len) - 1) |> round)
        end).()
  end

  def part_2(input) do
    input
    |> parse
    |> (fn list ->
          {oxygen, _} =
            list
            |> oxygen([])
            |> Enum.join()
            |> Integer.parse(2)

          {co2, _} =
            list
            |> c02([])
            |> Enum.join()
            |> Integer.parse(2)

          oxygen * co2
        end).()
  end

  defp oxygen([""], acc), do: Enum.reverse(acc)

  defp oxygen(list, acc) do
    list
    |> Enum.group_by(&String.at(&1, 0))
    |> case do
      %{"0" => zeros, "1" => ones} when length(zeros) <= length(ones) ->
        oxygen(strip_first_char(ones), ["1" | acc])

      %{"0" => zeros, "1" => _ones} ->
        oxygen(strip_first_char(zeros), ["0" | acc])

      %{"1" => ones} ->
        oxygen(strip_first_char(ones), ["1" | acc])

      %{"0" => zeros} ->
        oxygen(strip_first_char(zeros), ["0" | acc])
    end
  end

  defp c02([""], acc), do: Enum.reverse(acc)
  defp c02([single], acc), do: Enum.reverse([single | acc])

  defp c02(list, acc) do
    list
    |> Enum.group_by(&String.at(&1, 0))
    |> case do
      %{"0" => zeros, "1" => ones} when length(zeros) <= length(ones) ->
        c02(strip_first_char(zeros), ["0" | acc])

      %{"0" => _zeros, "1" => ones} ->
        c02(strip_first_char(ones), ["1" | acc])

      %{"1" => _ones} ->
        c02([""], ["0" | acc])

      %{"0" => _zeros} ->
        c02([""], ["1" | acc])
    end
  end

  defp strip_first_char(list) do
    Enum.map(list, &String.slice(&1, 1..-1))
  end

  defp parse(input) do
    input
    |> String.split("\n")
  end
end
