defmodule AdventOfCode.Aoc2022.Day03RucksackReorganisationTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day03RucksackReorganisation

  @example_input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  describe "part_1/1" do
    test "example input" do
      assert 157 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 7_793 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 70 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 2_499 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
