defmodule AdventOfCode2021.Day7TheTreacheryOfWhalesTest do
  use ExUnit.Case

  import AdventOfCode2021.Day7TheTreacheryOfWhales

  @example_input """
  16,1,2,0,4,2,7,1,2,14
  """

  describe "part_1/1" do
    test "example input" do
      assert 37 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 359_648 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 168 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 100_727_924 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
