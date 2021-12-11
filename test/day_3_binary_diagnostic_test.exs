defmodule AdventOfCode2021.Day3BinaryDiagnosticTest do
  use ExUnit.Case

  import AdventOfCode2021.Day3BinaryDiagnostic

  @example_input """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  describe "part_1/1" do
    test "example input" do
      assert 198 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 2_261_546 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 230 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 6_775_520 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
