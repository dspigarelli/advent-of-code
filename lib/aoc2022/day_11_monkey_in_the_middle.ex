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
      source = Enum.find_index(monkeys, & &1.id == monkey.id)
      yes_index = Enum.find_index(monkeys, & &1.id == monkey.yes)
      no_index = Enum.find_index(monkeys, & &1.id == monkey.no)
      monkey = Enum.at(monkeys, source)

      {yes, no} = monkey.items
      |> Enum.map(fn item ->
        item
        |> monkey.op.()
        |> div(worry)
      end)
      |> Enum.split_with(&rem(&1, monkey.divisor) == 0)
      # |> IO.inspect(label: :split)
      # |> Enum.reduce(monkeys, fn item, monkeys ->

      #   item = item
      #   |> monkey.op.()
      #   # |> IO.inspect(label: :step1)
      #   |> div(worry)
      #   # |> IO.inspect(label: :step2)

      #   target = item
      #   |> rem(monkey.divisor)
      #   # |> IO.inspect(label: :step3)
      #   |> case do
      #     x when x == 0 ->
      #       Enum.find_index(monkeys, & &1.id == monkey.yes)
      #     _ ->
      #       Enum.find_index(monkeys, & &1.id == monkey.no)
      #   end

      #   monkeys
      #   |> List.update_at(target, &Map.update(&1, :items, [], fn items -> [item|items] end))
      #   # |> IO.inspect(label: :monkeys)
      # end)

      monkeys
      |> List.update_at(yes_index, fn monkey -> Map.update(monkey, :items, [], & &1 ++ yes) end)
      |> List.update_at(no_index, fn monkey -> Map.update(monkey, :items, [], & &1 ++ no) end)
      |> List.update_at(source, fn monkey ->
        monkey
        |> Map.put(:items, [])
        |> Map.update(:inspected, 0, & &1+length(monkey.items))
      end)
      # |> IO.inspect(label: :monkeys)
    end
  end

  def part_1(input) do
    input
    |> parse
    # |> IO.inspect(label: :monkey_start)
    |> Stream.iterate(fn monkeys -> Enum.reduce(monkeys, monkeys, &Monkey.process/2) end)
    |> Enum.take(21)
    |> Enum.reverse()
    |> hd()
    |> Enum.sort_by(& &1.inspected)
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.map(& &1.inspected)
    |> Enum.product()
    # |> IO.inspect(label: :monkeys)
  end

  def part_2(input) do
    monkeys = parse(input)

    0..19
    |> Enum.reduce(monkeys, fn _, monkeys ->
      Enum.reduce(monkeys, monkeys, &Monkey.process(&1, &2, 1))
    end)
    # |> parse
    # |> IO.inspect(label: :monkey_start)
    # |> Stream.iterate(fn monkeys -> Enum.reduce(monkeys, monkeys, &Monkey.process(&1, &2, 1)) end)
    # |> Enum.take(401)
    # |> Enum.reverse()
    # |> hd()
    # |> Enum.sort_by(& &1.inspected)
    # # |> Enum.reverse()
    # # |> Enum.take(2)
    |> Enum.map(& &1.inspected)
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&Monkey.new/1)
  end
end
