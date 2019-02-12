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
     "list"    -> sort_list(data) <> "A"
     "map"     -> sort_map(data) <> "H"
    end
  end

  defp sort_list(list) do
    list
    |> Enum.sort()
    |> Enum.map(&notate/1)
    |> to_string
  end
  
  defp sort_map(map) do
    map
    |> Enum.sort()
    |> tuple()
    |> Enum.map(&notate/1)
    |> to_string
  end

  defp tuple(map) do
    tuple = []
    for {k, v} <- map do
      tuple ++ [to_string(k), v]
    end
  end
end