defmodule AdventOfCode2021.Day11DumboOctopusTest do
  use ExUnit.Case

  import AdventOfCode2021.Day11DumboOctopus

  @example_input """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  describe "part_1/1" do
    test "example input" do
      assert 1_656 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_608 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 195 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 214 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
