defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  defmacro __using__(options) do
    quote do
      import AdventOfCode

      @doc """
      Inspired by https://github.com/scmx/advent-of-code-2020-elixir
      """
      def puzzle_input do
        read_puzzle_input_for(__MODULE__, unquote(options))
      end
    end
  end

  @doc false
  def read_puzzle_input_for(module, options) when is_atom(module) do
    module
    |> input_filename
    |> read_puzzle_input_for(options)
  end

  def read_puzzle_input_for([year, filename], options) when is_binary(filename) do
    ["input", year, filename <> ".txt"]
    |> Path.join()
    |> File.read()
    |> case do
      {:ok, data} -> trim(data, Keyword.get(options, :trim))
      {:error, _} -> nil
    end
  end

  defp input_filename(module) do
    [year, day] =
      module
      |> to_string()
      |> String.split(".")
      |> Enum.drop(2)

    year
    |> String.downcase()

    [
      String.downcase(year),
      day
      |> Macro.underscore()
      |> String.replace(~r/(\w)(\d)/, "\\1_\\2")
    ]
  end

  defp trim(text, false), do: String.trim_trailing(text, "\n")
  defp trim(text, _), do: String.trim(text)
end
