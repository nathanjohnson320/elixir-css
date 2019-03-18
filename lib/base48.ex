defmodule Base49 do
  @base 49
  @alphabet 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

  def encode(data, hash \\ "")

  def encode(data, hash) when is_binary(data) do
    encode_zeros(data) <> encode(:binary.decode_unsigned(data), hash)
  end

  def encode(0, hash), do: hash

  def encode(data, hash) do
    character = <<Enum.at(@alphabet, rem(data, @base))>>
    encode(div(data, @base), character <> hash)
  end

  defp encode_zeros(data) do
    <<Enum.at(@alphabet, 0)>>
    |> String.duplicate(leading_zeros(data))
  end

  defp leading_zeros(data) do
    :binary.bin_to_list(data)
    |> Enum.find_index(&(&1 != 0))
  end
end
