defmodule AdventOfCode.Aoc2022.Day06TuningTroubleTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day06TuningTrouble

  @example_input """
  mjqjpqmgbljsphdztnvjfqwrcgsmlb
  """

  describe "part_1/1" do
    test "example input" do
      assert 7 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_155 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 19 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 2_789 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
