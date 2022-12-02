defmodule AdventOfCode.Aoc2021.Day12PassagePathingTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2021.Day12PassagePathing

  @example_input """
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
  """

  @example_2_input """
  dc-end
  HN-start
  start-kj
  dc-start
  dc-HN
  LN-dc
  HN-end
  kj-sa
  kj-HN
  kj-dc
  """

  @example_3_input """
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
  """

  describe "part_1/1" do
    test "example input" do
      assert 10 = @example_input |> String.trim() |> part_1()
    end

    test "example input 2" do
      assert 19 = @example_2_input |> String.trim() |> part_1()
    end

    test "example input 3" do
      assert 226 = @example_3_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 3_000 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 36 = @example_input |> String.trim() |> part_2()
    end

    test "example input 2" do
      assert 103 = @example_2_input |> String.trim() |> part_2()
    end

    test "example input 3" do
      assert 3_509 = @example_3_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 74_222 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
