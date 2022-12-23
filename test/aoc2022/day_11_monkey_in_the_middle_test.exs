defmodule AdventOfCode.Aoc2022.Day11MonkeyInTheMiddleTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day11MonkeyInTheMiddle

  @example_input """
  Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
  """

  describe "part_1/1" do
    test "example input" do
      assert 10_605 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 78_960 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 0 = @example_input |> String.trim() |> part_2()
    end

    # test "with puzzle input" do
    #   assert 0 = puzzle_input() |> String.trim() |> part_2()
    # end
  end
end
