extract_calibration_values = fn str ->
  vals = str
    |> String.graphemes()
    |> Enum.filter(fn g -> case Integer.parse(g) do
        {_, ""} -> true
        _  -> false
      end end)
  { val, "" } = Integer.parse(List.first(vals) <> List.last(vals))
  val
end

numbers = File.stream!("day01/input.txt") |> Stream.map(extract_calibration_values) |> Enum.sum()

IO.puts(numbers)
