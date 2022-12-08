defmodule AdventOfCode.Aoc2022.Day07NoSpaceLeftOnDevice do
  use AdventOfCode

  def part_1(input) do
    input
    |> parse
    |> Enum.reduce({[], %{}}, &parse_command/2)
    |> then(&elem(&1, 1))
    |> size()
    |> elem(0)
    |> Enum.filter(& &1 < 100_000)
    |> Enum.sum()
  end

  def part_2(input) do
    dirs = input
    |> parse
    |> Enum.reduce({[], %{}}, &parse_command/2)
    # |> IO.inspect(label: :system)
    |> then(&elem(&1, 1))
    |> size()
    |> elem(0)

    free = 70_000_000 - Enum.max(dirs)
    need = 30_000_000 - free

    dirs
    |> Enum.filter(& &1 > need)
    |> Enum.min()
  end

  defp parse_command("$ cd /", {_cwd, fs}), do: {[], fs}
  defp parse_command("$ cd ..", {[_|cwd], fs}), do: {cwd, fs}
  defp parse_command("$ cd " <> dir, {cwd, fs}), do: {[dir|cwd], fs}
  defp parse_command("dir " <> _dir, acc), do: acc
  defp parse_command("$ ls", acc), do: acc

  defp parse_command(command, {cwd, fs}) do
    [_, size, file] = Regex.run(~r{(\d+) (.*)}, command)

    {cwd, put_file_size(fs, Enum.reverse(cwd), file, String.to_integer(size))}
  end

  defp put_file_size(fs, [dir|cwd], file, size) do
    u = fs
    |> Map.get(dir, %{})
    |> put_file_size(cwd, file, size)

    Map.put(fs, dir, u)
  end

  defp put_file_size(fs, [], file, size), do: Map.put(fs, file, size)

  defp size(fs) when is_map(fs) do
    {dirs, children} = Enum.reduce(fs, {[], []}, fn
      {_key, value}, {dirs, children} ->
        {x, y} = size(value)

        {x ++ dirs, children ++ y}
    end)

    {[Enum.sum(children)|dirs], children}
  end

  defp size(fs), do: {[], [fs]}

  defp parse(input) do
    input
    |> String.split("\n")
  end
end
