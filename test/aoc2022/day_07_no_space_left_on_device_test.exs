defmodule AdventOfCode.Aoc2022.Day07NoSpaceLeftOnDeviceTest do
  use ExUnit.Case

  import AdventOfCode.Aoc2022.Day07NoSpaceLeftOnDevice

  @example_input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  describe "part_1/1" do
    test "example input" do
      assert 95_437 = @example_input |> String.trim() |> part_1()
    end

    test "with puzzle input" do
      assert 1_844_187 = puzzle_input() |> String.trim() |> part_1()
    end
  end

  describe "part_2/1" do
    test "example input" do
      assert 24_933_642 = @example_input |> String.trim() |> part_2()
    end

    test "with puzzle input" do
      assert 4_978_279 = puzzle_input() |> String.trim() |> part_2()
    end
  end
end
