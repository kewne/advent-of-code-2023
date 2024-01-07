defmodule Game do
  defstruct [number: 0, sets: []]

  def parse_game_line(game_str) do
    captures = Regex.named_captures(~r/Game (?<number>\d+): (?<sets>.*)/u, game_str)
    IO.inspect(captures)
    { number, "" } = Integer.parse(captures["number"])
    sets = parse_sets(captures["sets"])
    game = %Game{number: number, sets: sets}
    IO.inspect(game)
    game
  end

  defp parse_sets(sets_str) do
    String.split(sets_str, ~r/\s*;\s*/, trim: true)
      |> Stream.map(&parse_set/1)
      |> Enum.to_list()
  end

  defp parse_set(set_str) do
    String.split(set_str, ~r/\s*,\s*/, trim: true)
    |> Enum.map(fn color_str ->
          cap = Regex.named_captures(~r/(?<count>\d+)\s+(?<color>\w+)/, color_str)
          { count, "" } = Integer.parse(cap["count"])
          {cap["color"], count}
        end)
    |> Enum.into(%{})
  end

  def possible_game?(game) do
    Enum.all?(game.sets, fn set ->
      Map.get(set, "blue", 0) <= 14
        and Map.get(set, "red", 0) <= 12
        and Map.get(set, "green", 0) <= 13
    end)
  end

end

numbers = File.stream!("day02/input.txt")
  |> Stream.map(&Game.parse_game_line/1)
  |> Stream.filter(&Game.possible_game?/1)
  |> Stream.map(fn game -> game.number end)
  |> Enum.sum()

IO.puts(numbers)
