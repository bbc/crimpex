
defmodule NotationTest do
  use ExUnit.Case

  describe "notate" do
    test "when passed nil it returns an underscore" do
      assert Notation.notate(nil) == "_"
    end

    test "when passed a single string it returns the string with an S suffix" do
      assert Notation.notate("abc") == "abcS"
    end

    test "when passed a single number it returns the number with an N suffix" do
      assert Notation.notate(1) == "1N"
    end

    test "when passed a true boolean it returns the number with a B suffix" do
      assert Notation.notate(true) == "trueB"
    end

    test "when passed a false boolean it returns the number with a B suffix" do
      assert Notation.notate(false) == "falseB"
    end

    test "when passed a list it returns the number with an A suffix" do
      assert Notation.notate(["c", "b", "a"]) == "aSbScSA"
    end

    test "when passed a map it returns the number with an H suffix" do
      assert Notation.notate(%{a: 1}) == "1NaSAH"
    end

    test "when passed a nested list it will sort it" do
      assert Notation.notate([3, [4, 2], 1]) == "1N3N2N4NAA"
    end
  end
end