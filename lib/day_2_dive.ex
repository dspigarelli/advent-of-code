defmodule AdventOfCode2021.Day2Dive do
    use AdventOfCode2021

    def part_1(input) do
        input
        |> parse
        |> Enum.reduce({0, 0}, &move(&1, &2))
        |> (fn {horizontal, depth} -> horizontal * depth end).()
    end

    def part_2(input) do
        input
        |> parse
        |> Enum.reduce({0, 0, 0}, &move_with_aim(&1, &2))
        |> (fn {horizontal, depth, _aim} -> horizontal * depth end).()
    end

    defp move({:forward, amount}, {horizontal, depth}), do: {horizontal + amount, depth}
    defp move({:up, amount}, {horizontal, depth}), do: {horizontal, depth - amount}
    defp move({:down, amount}, {horizontal, depth}), do: {horizontal, depth + amount}

    defp move_with_aim({:forward, amount}, {horizontal, depth, aim}) do
        {horizontal + amount, depth + aim * amount, aim}
    end

    defp move_with_aim({:up, amount}, {horizontal, depth, aim}) do
        {horizontal, depth, aim - amount}
    end

    defp move_with_aim({:down, amount}, {horizontal, depth, aim}) do
        {horizontal, depth, aim + amount}
    end

    defp parse(input) do
        input
        |> String.split("\n")
        |> Enum.map(&String.split(&1))
        |> Enum.map(fn [direction, amount] ->
           {amount, ""} = Integer.parse(amount)
           {String.to_atom(direction), amount}
        end)
    end
end
