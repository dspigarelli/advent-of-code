defmodule AdventOfCode.Aoc2021.Day9SmokeBasinTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2021.Day9SmokeBasin

  @example_input """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  describe "part_1/1" do
    test "example input" do
      assert 15 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 494 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 1_134 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 1_048_128 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
