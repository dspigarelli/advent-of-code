defmodule AdventOfCode.Aoc2021.Day2DiveTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2021.Day2Dive

  @example_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  describe "part_1/1" do
    test "example input" do
      assert 150 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_840_243 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 900 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 1_727_785_422 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
