defmodule AdventOfCode2021.Day10SyntaxScoringTest do
  use ExUnit.Case

  import AdventOfCode2021.Day10SyntaxScoring

  @example_input """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  describe "part_1/1" do
    test "example input" do
      assert 26_397 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 390_993 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 288_957 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 2_391_385_187 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
