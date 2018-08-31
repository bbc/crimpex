defmodule CrimpexTest do
  use ExUnit.Case
  doctest Crimpex

  test "signature with string" do
    assert Crimpex.signature("a") == "d132c0567a5964930f9ee5f14e779e32"
  end

  test "signature with string abc" do
    assert Crimpex.signature("abc") == "c4449120506d97975c67be69719a78e2"
  end

  test "signature with an integer" do
    assert Crimpex.signature(1) == "594170053719896a11eb08ee513813d5"
  end

  test "signature with a float" do
    assert Crimpex.signature(1.2) == "f1ab6592886cd4b1b66ed55e73d9ab81"
  end

  test "signature with a true value" do
    assert Crimpex.signature(true) == "6413cfeb7a89f7e0a8872f82b919c0d9"
  end

  test "signature with a false value" do
    assert Crimpex.signature(false) == "fa39253035cfe44c8638b8f5d7a3402e"
  end

  test "signature with a null value" do
    assert Crimpex.signature(nil) == "b14a7b8059d9c055954c92674ce60032"
  end

  test "signature with an array" do
    assert Crimpex.signature([1, "a", 3]) == "cd1c43797d488d0f6c0d71537c64d30b"
  end

  test "signature with an unsorted array" do
    assert Crimpex.signature([3, nil, 1, "1"]) == "518e7bb17674f6acbb296845862a152d"
  end

  test "signature with an unsorted array of strings" do
    assert Crimpex.signature(["a", "A", "b", "B"]) == "f6692ab4bc94b35e61ec15c2d1891734"
  end

  test "signature with a hash" do
    assert Crimpex.signature(%{ "a" => 1}) == "8cb44d69badda0f34b0bab6bb3e7fdbf"
  end

  test "signature with nested hash" do
    assert Crimpex.signature(%{"a" => %{"c" => nil, "2" => 2 }}) == "bff3538075e4007c7679a7ba0d0a5f30"
  end

  test "notation with nested array" do
    assert Crimpex.notation(["a", 1, ["b", "2"]]) == "1NaS2SbSAA"
  end

  test "notation with simpler nested array" do
    assert Crimpex.notation([1, [3, 2]]) == "1N3N2NAA"
  end

  test "notation with hash" do
    assert Crimpex.notation(%{"a" => "b"}) == "aSbSAH"
  end

  test "notation with hash with keys as symbols" do
    assert Crimpex.notation(%{a: "b"}) == "aSbSAH"
  end

  test "notation with nested hash" do
    assert Crimpex.notation(%{"a" => %{"c" => nil, "2" => 2 }}) == "aS2S2NA_cSAHAH"
  end
end
