defmodule EBML.Parser do
  @moduledoc false

  @spec parse(:binary | :date | :float | :integer | :master | :string | :uint | :utf_8, binary) ::
          binary
          | list
          | non_neg_integer
          | float
          | {non_neg_integer, non_neg_integer, non_neg_integer}
  def parse(:master, bytes), do: EBML.decode(bytes)

  def parse(:integer, bytes) do
    bits = byte_size(bytes)
    <<n::signed-size(bits)-unit(8)>> = bytes
    n
  end

  def parse(:uint, bytes) do
    bits = byte_size(bytes)
    <<n::unsigned-size(bits)-unit(8)>> = bytes
    n
  end

  def parse(:float, <<n::float-32>>), do: n
  def parse(:float, <<n::float-64>>), do: n

  def parse(:string, bytes), do: String.trim(bytes, "\0")
  def parse(:utf_8, bytes), do: String.trim(bytes, "\0")

  def parse(:binary, bytes), do: bytes
  def parse(:date, bytes), do: bytes
  def parse(:crc_32, bytes), do: bytes
end
