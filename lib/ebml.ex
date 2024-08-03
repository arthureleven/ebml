defmodule EBML do
  @moduledoc """
  Functions to decode EBML elements

  RFC: https://datatracker.ietf.org/doc/html/rfc8794
  """

  import EBML.Spec
  import EBML.Parser
  import EBML.Vint

  @spec decode(binary, list) :: [{atom, binary}]
  def decode(bytes, acc \\ [])
  def decode(<<>>, acc), do: acc

  def decode(bytes, acc) do
    with {id, bytes} <- decode_name(bytes),
         {data_size, bytes} <- decode_vint(bytes),
         {data, bytes} <- bytes_part(bytes, data_size) do
      type = typeof(id)
      data = parse(type, data)

      decode(bytes, [{id, data} | acc])
    end
  end

  @spec decode_name(binary) :: {atom, binary}
  def decode_name(<<byte::unsigned-size(8), _::binary>> = bytes) do
    vint_width = get_vint_width(byte)

    <<vint::integer-size(vint_width)-unit(8), tail::binary>> = bytes

    {keyof(vint), tail}
  end

  defp bytes_part(bytes, data_size) do
    <<bytes::binary-size(data_size), tail::binary>> = bytes

    {bytes, tail}
  end
end
