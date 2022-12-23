defmodule AdventOfCode.Aoc2022.Day11MonkeyInTheMiddle do
  use AdventOfCode

  defmodule Monkey do
    defstruct [:id, :items, :op, :op_str, :divisor, :yes, :no, inspected: 0]

    def new(input) do
      input
      |> String.split("\n")
      |> Enum.reduce(%Monkey{}, &parse/2)
    end

    defp parse("Monkey " <> id, monkey),
      do: Map.put(monkey, :id, id |> Integer.parse() |> elem(0))

    defp parse("Starting items: " <> items, monkey) do
      items =
        items
        |> String.split(", ")
        |> Enum.map(&String.to_integer/1)

      # |> Enum.reverse()

      Map.put(monkey, :items, items)
    end

    defp parse("Operation: new = " <> op, monkey), do: parse_operation(op, monkey)

    defp parse("Test: divisible by " <> divisor, monkey),
      do: Map.put(monkey, :divisor, String.to_integer(divisor))

    defp parse("If true: throw to monkey " <> id, monkey),
      do: Map.put(monkey, :yes, String.to_integer(id))

    defp parse("If false: throw to monkey " <> id, monkey),
      do: Map.put(monkey, :no, String.to_integer(id))

    defp parse("If false: " <> _divisor, monkey), do: monkey
    defp parse(" " <> rest, monkey), do: parse(rest, monkey)

    defp parse_operation("old * old" = op, monkey),
      do: monkey |> Map.put(:op_str, op) |> Map.put(:op, &(&1 * &1))

    defp parse_operation("old * " <> id = op, monkey),
      do: monkey |> Map.put(:op_str, op) |> Map.put(:op, &(&1 * String.to_integer(id)))

    defp parse_operation("old + " <> id = op, monkey),
      do: monkey |> Map.put(:op_str, op) |> Map.put(:op, &(&1 + String.to_integer(id)))

    def process(monkey, monkeys, worry \\ 3) do
      source = Enum.find_index(monkeys, &(&1.id == monkey.id))

      yes_index = Enum.find_index(monkeys, &(&1.id == monkey.yes))
      yes_monkey = Enum.at(monkeys, yes_index)

      no_index = Enum.find_index(monkeys, &(&1.id == monkey.no))
      no_monkey = Enum.at(monkeys, no_index)

      monkey = Enum.at(monkeys, source)

      {yes, no} =
        monkey.items
        |> Enum.reduce({yes_monkey.items, no_monkey.items}, fn item, {yes, no} ->
          item =
            item
            |> monkey.op.()
            |> div(worry)

          item
          |> rem(monkey.divisor)
          |> case do
            x when x == 0 -> {[item | yes], no}
            _ -> {yes, [item | no]}
          end
        end)

      # |> Enum.split_with(&(rem(&1, monkey.divisor) == 0))

      monkeys
      |> List.update_at(yes_index, &Map.put(&1, :items, yes))
      |> List.update_at(no_index, &Map.put(&1, :items, no))
      |> List.update_at(source, fn monkey ->
        monkey
        |> Map.put(:items, [])
        |> Map.update(:inspected, 0, &(&1 + length(monkey.items)))
      end)
    end
  end

  def part_1(input) do
    monkeys = parse(input)

    1..20
    |> Enum.reduce(monkeys, fn _, monkeys ->
      Enum.reduce(monkeys, monkeys, &Monkey.process/2)
    end)
    |> Enum.map(& &1.inspected)
    # |> IO.inspect(label: :monkeys, charlists: :as_lists)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.product()
  end

  def part_2(input) do
    monkeys = parse(input)

    1..20
    |> Enum.reduce(monkeys, fn _, monkeys ->
      IO.write(".")
      Enum.reduce(monkeys, monkeys, &Monkey.process(&1, &2, 1))
    end)
    |> Enum.map(& &1.inspected)
    |> IO.inspect(label: :monkeys, charlists: :as_lists)
    |> Enum.sort()

    # |> Enum.reverse()
    # |> Enum.take(2)
    # |> Enum.product()
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&Monkey.new/1)
  end
end
