defmodule Notation do
  def notate(:false), do: "falseB"

  def notate(:true), do: "trueB"

  def notate(nil), do: "_"

  def notate(data) when is_binary(data), do: data <> "S"

  def notate(data) when is_integer(data), do: Integer.to_string(data) <> "N"

  def notate(data) when is_float(data), do: Float.to_string(data) <> "N"

  def notate(data) when is_list(data), do: sort_list(data) <> "A"

  def notate(data) when is_map(data) do
    [
      :maps.to_list(data)
      |> Enum.sort()
      |> Enum.map(&notate/1)
      | "H"
    ]
    |> IO.iodata_to_binary()
  end

  def notate({k, v}) when is_map(v), do: [notate(k), notate(v), "A"]
  def notate({k, v}), do: notate([k, v])

  def notate(data) when is_atom(data), do: Atom.to_string(data) |> notate()

  defp sort_list(list) do
    list
    |> Enum.sort(&string_compare/2)
    |> Enum.map(&notate/1)
    |> :erlang.list_to_binary()
  end

  defp string_compare(nil, _) do
    true
  end

  defp string_compare(_, nil) do
    false
  end

  defp string_compare(a, b) when is_number(a) and is_bitstring(b) do
    to_string(a) <= b
  end

  defp string_compare(a, b) when is_bitstring(a) and is_number(b) do
    a <= to_string(b)
  end

  defp string_compare(a, b) when is_atom(a) do
    to_string(a) <= b
  end

  defp string_compare(a, b), do: a < b
end
