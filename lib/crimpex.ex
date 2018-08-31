defmodule Crimpex do
  @moduledoc """
  Documentation for Crimpex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Crimpex.signature("a")
      "d132c0567a5964930f9ee5f14e779e32"

      iex> Crimpex.signature(1)
      "594170053719896a11eb08ee513813d5"

  """
  def signature(data) do
    # IO.inspect(stringify(process(input)))
    # IO.puts(process(Kernel.to_string(input)))
    :crypto.hash(:md5, notation(data)) |> Base.encode16() |> String.downcase
  end

  @doc """
  Returns string representation of the passed data structure

  ## Examples

      iex> Crimpex.notation("a")
      "aS"

      iex> Crimpex.notation(1)
      "1N"
  """
  def notation(data) do
    stringify(process(data))
  end

  defp stringify(coll) do
    coll
    |> List.flatten
    |> Enum.join("")
  end

  defp process(data) when is_number(data) do
    [data, "N"]
  end

  defp process(data) when is_binary(data) do
    [data, "S"]
  end

  defp process(data) when is_boolean(data) do
    [data, "B"]
  end

  defp process(nil) do
    ["_"]
  end

  defp process(data) when is_atom(data) do
    process(to_string(data))
  end

  defp process(coll) when is_list(coll) do
    # IO.inspect(coll)
    [coll
    # |> Enum.sort
    # |> Enum.sort(&(to_string(&1) <= to_string(&2)))
    |> Enum.sort(&sort(&1, &2))
    # |> Enum.sort(&(process(&1) <= process(&2)))
    |> Enum.map(&process(&1)) | ["A"]]
  end

  defp process(coll) when is_map(coll) do
    [coll
    |> Enum.map(&Tuple.to_list/1)
    # |> List.flatten
    # |> Enum.sort(&(to_string(&1) <= to_string(&2)))
    |> process
    | ["H"]]
  end

  defp sort(a, b) when is_map(a) or is_map(b) do
    true
  end

  defp sort(a, b) when is_list(a) or is_list(b) do
    true
  end

  defp sort(a, b) do
    to_string(a) <= to_string(b)
  end
end
