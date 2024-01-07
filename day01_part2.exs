defmodule AocDay1 do
  def get_leading_digit("one" <> _) do "1" end
  def get_leading_digit("two" <> _) do "2" end
  def get_leading_digit("three" <> _) do "3" end
  def get_leading_digit("four" <> _) do "4" end
  def get_leading_digit("five" <> _) do "5" end
  def get_leading_digit("six" <> _) do "6" end
  def get_leading_digit("seven" <> _) do "7" end
  def get_leading_digit("eight" <> _) do "8" end
  def get_leading_digit("nine" <> _) do "9" end
  def get_leading_digit(<<d::utf8, rest::binary>>) do
    case Integer.parse(<<d::utf8>>) do
      { _, "" } -> <<d::utf8>>
      _ -> get_leading_digit(rest)
    end
  end


  def get_trailing_digit_in_reversed("eno" <> _) do "1" end
  def get_trailing_digit_in_reversed("owt" <> _) do "2" end
  def get_trailing_digit_in_reversed("eerht" <> _) do "3" end
  def get_trailing_digit_in_reversed("ruof" <> _) do "4" end
  def get_trailing_digit_in_reversed("evif" <> _) do "5" end
  def get_trailing_digit_in_reversed("xis" <> _) do "6" end
  def get_trailing_digit_in_reversed("neves" <> _) do "7" end
  def get_trailing_digit_in_reversed("thgie" <> _) do "8" end
  def get_trailing_digit_in_reversed("enin" <> _) do "9" end
  def get_trailing_digit_in_reversed(<<d::utf8, rest::binary>>) do
    case Integer.parse(<<d::utf8>>) do
      { _, "" } -> <<d::utf8>>
      _ -> get_trailing_digit_in_reversed(rest)
    end
  end
end

extract_calibration_values = fn str ->
  leading = AocDay1.get_leading_digit(str)
  trailing = AocDay1.get_trailing_digit_in_reversed(String.reverse(str))
  { val, "" } = Integer.parse(leading <> trailing)
  val
end

result = File.stream!("day01/input.txt")
  |> Stream.map(extract_calibration_values)
  |> Enum.sum()

IO.puts(result)
