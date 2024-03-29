defmodule Mix.Tasks.Day.New do
  @moduledoc """
  Generate a new day. Inspired by https://github.com/scmx/advent-of-code-2020-elixir
  """

  @year 2022

  def run([name]) do
    module_name = Macro.camelize(name)

    create_input_file(name)
    create_lib_file(name, module_name)
    create_spec_file(name, module_name)
  end

  defp create_input_file(name) do
    File.write("input/aoc#{@year}/#{name}.txt", IO.read(:stdio, :all))
  end

  defp create_lib_file(name, module_name) do
    contents = generate_lib_file(name, module_name)
    File.write("lib/aoc#{@year}/#{name}.ex", contents)
  end

  defp create_spec_file(name, module_name) do
    contents = generate_spec_file(name, module_name)
    File.write("test/aoc#{@year}/#{name}_test.exs", contents)
  end

  defp generate_lib_file(_name, module_name) do
    """
    defmodule AdventOfCode.Aoc#{@year}.#{module_name} do
      use AdventOfCode

      def part_1(input) do
        input
        |> parse
      end

      # def part_2(input) do
      #   input
      #   |> parse
      # end

      defp parse(input) do
        input
      end
    end
    """
  end

  defp generate_spec_file(_name, module_name) do
    """
    defmodule AdventOfCode.Aoc#{@year}.#{module_name}Test do
      use ExUnit.Case

      import AdventOfCode.Aoc#{@year}.#{module_name}

      @example_input \"\"\"
      \"\"\"

      describe "part_1/1" do
        test "example input" do
          assert 0 = @example_input |> String.trim() |> part_1()
        end

        test "with puzzle input" do
          assert 0 = puzzle_input() |> String.trim() |> part_1()
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
    """
  end
end
