defmodule AdventOfCode.Aoc2021.Day1SonarSweepTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2021.Day1SonarSweep

  @example_input """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  describe "part_1/1" do
    test "example input" do
      assert 7 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_527 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 5 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 1_575 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
