defmodule AdventOfCode.Aoc2022.Day05SupplyStacksTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day05SupplyStacks

  @example_input """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  @example_stacks [
    [:N, :Z],
    [:D, :C, :M],
    [:P]
  ]

  # To avoid writing a complicated parsing routine, and because the puzzle
  # input isn't long, I decided to manually encode my puzzle input
  @puzzle_stacks [
    [:T, :F, :V, :Z, :C, :W, :S, :Q],
    [:B, :R, :Q],
    [:S, :M, :P, :Q, :T, :Z, :B],
    [:H, :Q, :R, :F, :V, :D],
    [:P, :T, :S, :B, :D, :L, :G, :J],
    [:Z, :T, :R, :W],
    [:J, :R, :F, :S, :N, :M, :Q, :H],
    [:W, :H, :F, :N, :R],
    [:B, :R, :P, :Q, :T, :Z, :J]
  ]

  describe "part_1/1" do
    test "example input" do
      assert "CMZ" = @example_input |> String.trim() |> part_1(@example_stacks)
    end

    test "with puzzle input" do
      assert "BZLVHBWQF" = puzzle_input() |> String.trim() |> part_1(@puzzle_stacks)
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert "MCD" = @example_input |> String.trim() |> part_2(@example_stacks)
    end

    test "with puzzle input" do
      assert "TDGJQTZSL" = puzzle_input() |> String.trim() |> part_2(@puzzle_stacks)
    end
  end
end
