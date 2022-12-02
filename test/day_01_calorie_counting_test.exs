defmodule AdventOfCode2021.Day01CalorieCountingTest do
  use ExUnit.Case

  import AdventOfCode2021.Day01CalorieCounting

  @example_input """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  describe "part_1/1" do
    test "example input" do
      assert 24_000 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 71_124 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 45_000 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 204_639 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
