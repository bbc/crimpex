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

    test "when passed an erlang binary in a list" do
                                                     # a   S   b   S   �    S   A
      assert Notation.notate(["a", "b", <<179>>]) == <<97, 83, 98, 83, 179, 83, 65>>
    end

    test "when passed a map it returns the number with an H suffix" do
      assert Notation.notate(%{a: 1}) == "1NaSAH"
    end

    test "when passed a map with multiple unsorted keys it returns with an H suffix and sorted" do
      assert Notation.notate(%{a: 1, d: 3, b: 2}) == "1NaSA2NbSA3NdSAH"
    end

    test "when passed a nested map with multiple unsorted keys it returns with an H suffix and sorted for all levels" do
      assert Notation.notate(%{a: 1, d: %{e: 1, g: 2, f: 3}, b: 2}) == "1NaSA2NbSAdS1NeSA3NfSA2NgSAHAH"
    end

    test "when passed a map with nested lists and maps" do
      assert Notation.notate(%{a: [1, 2], b: %{c: "d"}}) == "1N2NAaSAbScSdSAHAH"
    end

    test "when passed a map with a non-list value for atom keys" do
      assert Notation.notate(%{c?: false, method: "GET", path: "/"}) == "c?SfalseBAmethodSGETSApathS/SAH"
    end

    test "when passed a list of maps" do
      assert Notation.notate([%{a: 1}, %{b: 2}]) == "1NaSAH2NbSAHA"
    end

    test "when passed a nested list it will sort it" do
      assert Notation.notate([3, [4, 2], 1]) == "1N3N2N4NAA"
    end

    test "atoms are treated as strings" do
      assert Notation.notate(:a) == Notation.notate("a")
    end

    test "atoms are case sensitive" do
      refute Notation.notate(:A) == Notation.notate("a")
    end
  end

  describe "acceptance tests" do
    test "verify String handling" do
      assert Notation.notate("abc") == "abcS"
    end

    test "verify integers handling" do
      assert Notation.notate(1) == "1N"
    end

    test "verify floats handling" do
      assert Notation.notate(1.2) == "1.2N"
    end
    test "verify Array handling" do
      assert Notation.notate([1, "a", 3]) == "1N3NaSA"
    end

    test "verify Array sorting" do
      assert Notation.notate([3, nil, 1, "1"]) == "_1N1S3NA"
    end

    test "verify Array sorting with capital letters" do
      assert Notation.notate(["a", "A", "b", "B"]) == "ASBSaSbSA"
    end

    test "verify nested Arrays" do
      assert Notation.notate(["a", 1, ["b", "2"]]) == "1N2SbSAaSA"
    end

    test "verify nested Arrays in another order" do
      assert Notation.notate([["b", "2"], "a", 1]) == "1N2SbSAaSA"
    end

    test "verify hash like data structures" do
      assert Notation.notate(%{"a" => 1}) == "1NaSAH"
    end

    test "verify nested hash" do
     assert Notation.notate(%{"a" => %{"c" => nil, "2" => 2 }}) == "aS2S2NA_cSAHAH"
    end

    test "verify null values" do
      assert Notation.notate(nil) == "_"
    end

    test "verify true boolean values" do
      assert Notation.notate(true) == "trueB"
    end

    test "verify false boolean values" do
      assert Notation.notate(false) == "falseB"
    end
  end
end
