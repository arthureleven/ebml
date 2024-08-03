defmodule EBML.Vint do
  @moduledoc false

  import Bitwise

  @spec get_vint_width(integer) :: 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
  def get_vint_width(byte),
    do:
      1..8
      |> Enum.find_value(fn bit ->
        if (byte &&& (1 <<< (8 - bit))) > 0, do: bit
      end)

  @spec get_vint_data(integer, 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8) :: non_neg_integer
  def get_vint_data(vint, vint_width), do: vint &&& (1 <<< (vint_width * 7)) - 1

  @spec decode_vint(binary) :: {non_neg_integer, binary}
  def decode_vint(<<byte::unsigned-size(8), _::binary>> = bytes) do
    vint_width = get_vint_width(byte)

    <<vint::integer-size(vint_width)-unit(8), tail::binary>> = bytes

    {get_vint_data(vint, vint_width), tail}
  end
end
