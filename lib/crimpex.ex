defmodule Crimpex do
  @moduledoc """
  Documentation for Crimpex.
  """

  @doc """
  """
  def signature(data) do
    data
    |> Notation.notate()
    |> md5()
    |> Base.encode16(case: :lower)
  end

  defp md5(data) do
    :crypto.hash(:md5, data)
  end
end