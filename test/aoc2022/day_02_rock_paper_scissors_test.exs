defmodule AdventOfCode.Aoc2022.Day02RockPaperScissorsTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day02RockPaperScissors

  @example_input """
  A Y
  B X
  C Z
  """

  describe "part_1/1" do
    test "example input" do
      assert 15 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 9_651 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 12 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 10_560 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
