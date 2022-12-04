defmodule AdventOfCode.Aoc2022.Day04CampCleanupTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day04CampCleanup

  @example_input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  describe "part_1/1" do
    test "example input" do
      assert 2 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 507 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 4 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 897 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
