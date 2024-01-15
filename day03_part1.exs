chars = for { line, row } <- Stream.with_index(File.stream!("day03/input.txt")),
            { char, column } <- Stream.with_index(String.graphemes(line)) do
  key = {row, column}
  case Integer.parse(char) do
    { digit, "" } -> { digit, key }
    _ -> { char, key }
  end
end

indexed_symbols = Enum.filter(chars, fn {item, _} -> is_binary(item) and Regex.match?(~r/[^\.\n]/, item) end)
  |> Enum.into(%{}, fn {item, key} -> {key, item} end)


chunk_fun = fn bla = { item, _ }, acc ->
  if (is_integer(item)) do
    {:cont, [bla | acc]}
  else
    {:cont, Enum.reverse(acc), []}
  end
end
after_fun = fn
  [] -> {:cont, []}
  acc -> {:cont, acc, []}
end

to_number_coordinates = fn row ->
  digits = Enum.map(row, &elem(&1, 0))
  coordinates = Enum.map(row, &elem(&1, 1))
  {Integer.undigits(digits), coordinates}
end

numbers = Enum.chunk_while(chars, [], chunk_fun, after_fun)
  |> Enum.filter(&(!Enum.empty?(&1)))
  |> Enum.map(to_number_coordinates)
  |> Enum.filter(fn {_, coords} ->
    adjacent_coords = Enum.flat_map(coords, fn {row, column} ->
      for row_diff <- -1..1,
        col_diff <- -1..1 do
          {row - row_diff, column - col_diff}
        end
    end)
    Enum.any?(adjacent_coords, fn coord -> Map.has_key?(indexed_symbols, coord) end)
  end)
  |> Enum.map(fn tuple -> elem(tuple, 0) end)
  |> Enum.sum()

IO.inspect(numbers)
