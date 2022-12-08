defmodule AdventOfCode.Aoc2022.Day08TreetopTreeHouseTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day08TreetopTreeHouse

  @example_input """
  30373
  25512
  65332
  33549
  35390
  """

  describe "part_1/1" do
    test "example input" do
      assert 21 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_711 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "example input" do
    #   assert 0 = @example_input |> String.trim() |> part_2()
    # end

    # test "with puzzle input" do
    #   assert 0 = puzzle_input() |> String.trim() |> part_2()
    # end
  end
end
