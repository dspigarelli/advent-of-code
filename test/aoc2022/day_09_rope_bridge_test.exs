defmodule AdventOfCode.Aoc2022.Day09RopeBridgeTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day09RopeBridge

  @example_input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  describe "part_1/1" do
    test "example input" do
      assert 13 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 6_212 = puzzle_input() |> String.trim() |> part_1()
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
