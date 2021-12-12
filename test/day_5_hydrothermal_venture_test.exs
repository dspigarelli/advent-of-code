defmodule AdventOfCode2021.Day5HydrothermalVentureTest do
  use ExUnit.Case

  import AdventOfCode2021.Day5HydrothermalVenture

  @example_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "part_1/1" do
    # test "example input" do
    #   assert 5 = @example_input |> String.trim() |> part_1()
    # end

    # test "with puzzle input" do
    #   assert 5_306 = puzzle_input() |> String.trim() |> part_1()
    # end
  end

  describe "part_2/1" do
    test "example input" do
      assert 12 = @example_input |> String.trim() |> part_2()
    end

    # test "with puzzle input" do
    #   assert 17_787 = puzzle_input() |> String.trim() |> part_2()
    # end
  end
end
