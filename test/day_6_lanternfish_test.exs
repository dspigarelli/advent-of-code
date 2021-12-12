defmodule AdventOfCode2021.Day6LanternfishTest do
  use ExUnit.Case

  import AdventOfCode2021.Day6Lanternfish

  @example_input """
  3,4,3,1,2
  """

  describe "part_1/1" do
    test "example input" do
      assert 5_934 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 390_923 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 26_984_457_539 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 1_749_945_484_935 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
