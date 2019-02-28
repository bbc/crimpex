defmodule Notation do
  def notate(:false) do
    "falseB"
  end

  def notate(:true) do
    "trueB"
  end

  def notate(nil) do
    "_"
  end

  def notate(data) do
    case Util.typeof(data) do
     "binary"  -> data <> "S"
     "integer" -> Integer.to_string(data) <> "N"
     "float"   -> Float.to_string(data) <> "N"
     "list"    -> sort_list(data) <> "A"
     "map"     -> sort_map(data) <> "H"
    end
  end

  defp sort_list(list) do
    list
    |> Enum.sort(&string_compare/2)
    |> IO.inspect()
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

  def string_compare(nil, _) do
    true
  end

  def string_compare(_, nil) do
    false
  end

  def string_compare(a, b) when is_number(a) and is_bitstring(b) do
    to_string(a) <= b
  end

  def string_compare(a, b) when is_bitstring(a) and is_number(b) do
    a <= to_string(b)
  end

  def string_compare(a, b) do
    compare_objects(a) <= compare_objects(b)
  end

  def compare_objects(obj) do
    case Util.typeof(obj) do
      "list" -> Enum.sort(obj, &string_compare/2)
      "map"  -> Enum.sort(tuple(obj), &string_compare/2)
      ""
      _      -> obj
    end
  end
end