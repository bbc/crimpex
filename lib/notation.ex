defmodule Notation do
  def notate(:false), do: "falseB"

  def notate(:true), do: "trueB"

  def notate(nil), do: "_"

  def notate(data) when is_binary(data), do: data <> "S"

  def notate(data) when is_integer(data), do: Integer.to_string(data) <> "N"

  def notate(data) when is_float(data), do: Float.to_string(data) <> "N"

  def notate(data) when is_list(data), do: sort_list(data) <> "A"

  def notate(data) when is_map(data), do: sort_map(data) <> "H"

  defp sort_list(list) do
    list
    |> Enum.sort(&string_compare/2)
    |> Enum.map(&notate/1)
    |> to_string
  end
  
  defp sort_map(map) do
    map
    |> tuple()
    |> Enum.sort(&string_compare/2)
    |> Enum.map(&notate/1)
    |> to_string
  end

  defp tuple(map) do
    tuple = []
    for {k, v} <- map do
      tuple ++ [to_string(k), v]
    end
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

  defp string_compare(a, b) do
    compare_objects(a) <= compare_objects(b)
  end

  defp compare_objects(obj) when is_list(obj), do: Enum.sort(obj, &string_compare/2)

  defp compare_objects(obj) when is_map(obj), do: Enum.sort(tuple(obj), &string_compare/2)

  defp compare_objects(obj) when not is_list(obj) or is_map(obj), do: obj
end